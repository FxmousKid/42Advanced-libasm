#!/bin/bash

# This script handles running NASM code inside a Docker+QEMU x86_64 setup on ARM
# If you're already on x86_64, just use 'make'

set -e

DOCKER_IMAGE="libasm-alpine"
DOCKERFILE_PATH="run/Dockerfile"
PROJECT_DIR="$PWD"
TESTER_NAME="libasm_tester"

# Default make command
equals='===================================\n'
command="echo -ne '$equals' && make && echo -e '$equals' && ./libasm_tester"

# Show help
show_help() {
	cat << EOF
Usage: ./run.sh [options]

Options:
  -c        Run 'make fclean'
  -r        Run 'make re'
  -b        Rebuilds the Docker images (forces update) and runs 
            the code (! building is Needed on 1st run)
  -B        Same as -b, but exits after rebuilding
  -h        Show this help message
  -d        Re links the test executable with -static, then 
            Debug with QEMU's GDB stub outside of the docker
  -D        Same as -d, but re builds instead of only relink


Examples:
  ./run.sh             # Default: make && ./libasm
  ./run.sh -r          # Run make re
  ./run.sh -cb         # Clean and rebuild image
  ./run.sh -D          # rebuilds and enters gdb
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
		--name libasm \
		-v "$PROJECT_DIR:/app" \
		-w /app \
		--network="host" \
		"$DOCKER_IMAGE" \
		zsh -c "$command"
}

debug_elf() {
	if [[ "$1" == "build" ]]
	then
		command="make re CC_LFLAGS+='-static'"
	elif [[ "$1" == "link" ]]
	then
		command="make link CC_LFLAGS+='-static'"
	fi
	run_image
	exec qemu-x86_64 -g 12345 ./$TESTER_NAME &
	gdb ./$TESTER_NAME --ex 'target remote :12345'
}

# Parse flags
while getopts "crbBhdD" opt; do
	case $opt in
		c)
			command="make fclean"
			;;
		r)
			command="compiledb make re"
			;;
		b)
			build_images
			;;
		B)
			build_images
			exit 0
			;;
		d)
			debug_elf "link"
			exit 0
			;;
		D)
			debug_elf "build"
			exit 0
			;;
		h)
			show_help
			exit 0
			;;
	esac
done

run_image
