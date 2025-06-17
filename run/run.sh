#!/bin/bash

# This script handles running NASM code inside a Docker+QEMU x86_64 setup on ARM
# If you're already on x86_64, just use 'make'

set -e

CONTAINER_NAME="libasm"
DOCKER_IMAGE="libasm-alpine"
DOCKERFILE_PATH="run/Dockerfile"
PROJECT_DIR="$PWD"
TESTER_NAME="libasm_tester"
TESTER_BONUS_NAME="libasm_bonus_tester"
EXECUTABLE_NAME="$TESTER_NAME"
DEBUG_PORT=12345

# Default make command
equals='=====================================\n'
command="echo -ne '$equals' && make && echo -e '$equals' && ./$EXECUTABLE_NAME"
command_bonus="echo -ne '$equals' && make bonus && echo -e '$equals' && ./$TESTER_BONUS_NAME"

# Show help
show_help() {
	cat << EOF
Usage: ./$0 [options]

Options:
  -b        Rebuilds the Docker images (forces update) and runs 
            the code (! building is Needed on 1st run)
  -B        Same as -b, but exits after rebuilding
  -c        Run 'make fclean'
  -d        Re links the test executable with -static, then 
            Debug with QEMU's GDB stub outside of the docker
  -D        Same as -d, but re builds instead of only relink
  -e        same as -d but for bonus executable
  -E        same as -D but for bonus executable
  -h        Show this help message
  -k        Kill the $CONTAINER_NAME container
  -n        Run 'make bonus'
  -r        Run 'make re'
  -R        Run 'make re_bonus'


Examples:
  $0             # Default: make && ./$EXECUTABLE_NAME
  $0 -r          # Run make re
  $0 -cb         # Clean and rebuild image
  $0 -D          # rebuilds and enters gdb
EOF
}

# Build Docker image with QEMU emulation
build_images() {
	echo "[*] Enabling QEMU binfmt emulation..."
	docker run --rm --privileged tonistiigi/binfmt --install all

	echo "[*] Building Docker image ($DOCKER_IMAGE)..."
	docker buildx build --platform linux/amd64 \
		-t "$DOCKER_IMAGE" \
		-f "$DOCKERFILE_PATH" \
		"$PROJECT_DIR"
}

# Run the built Docker image
run_image() {
	docker run --rm -it \
		--platform linux/amd64 \
		--name "$CONTAINER_NAME" \
		-v "$PROJECT_DIR:/app" \
		-w /app \
		--network="host" \
		"$DOCKER_IMAGE" \
		zsh -c "$command"
}

debug_elf() {
	
	# For standard
	if [[ "$1" == "build" && "$#" -eq 1 ]]
	then
		command="make re CC_LFLAGS+='-static'"
	elif [[ "$1" == "link" && "$#" -eq 1 ]]
	then
		command="make link CC_LFLAGS+='-static'"
	fi

	# For bonus
	if [[ "$1" == "link" && "$2" == "bonus" ]]
	then
		command="make link_bonus CC_LFLAGS+='-static'"
		EXECUTABLE_NAME="$TESTER_BONUS_NAME"
	elif [[ "$1" == "build" && "$2" == "bonus" ]]
	then
		command="make re_bonus CC_LFLAGS+='-static'"
		EXECUTABLE_NAME="$TESTER_BONUS_NAME"
	fi

	run_image
	exec qemu-x86_64 -g "$DEBUG_PORT" ./"$EXECUTABLE_NAME" &
	gdb ./$EXECUTABLE_NAME --ex "target remote :$DEBUG_PORT"
}

# Parse flags
while getopts ":cbBdDeEhknrR" opt; do
	case $opt in
		b)
			build_images
			;;
		B)
			build_images
			exit 0
			;;
		c)
			command="make fclean"
			;;
		d)
			debug_elf "link"
			exit 0
			;;
		D)
			debug_elf "build"
			exit 0
			;;
		e)
			debug_elf "link" "bonus"
			exit 0
			;;
		E)
			debug_elf "build" "bonus"
			exit 0
			;;
		h)
			show_help
			exit 0
			;;
		k)
			docker stop $CONTAINER_NAME
			exit 0
			;;
		n)
			command="$command_bonus"
			EXECUTABLE_NAME="$TESTER_BONUS_NAME"
			;;
		r)
			command="compiledb make re"
			;;
		R)
			command="compiledb make re_bonus"
			;;
		\?)
			echo "$0: invalid option -- '$OPTARG'"
			echo "Try '$0 -h' for more information."
			exit 0
			;;
	esac
done
shift $((OPTIND - 1))

run_image
