#!/bin/bash

# This script handles running NASM code inside a Docker+QEMU x86_64 setup on ARM (e.g., Asahi Linux)
# If you're on x86_64 natively, just use 'make'

set -e

DOCKER_IMAGE="libasm-alpine"
DOCKERFILE_PATH="run/Dockerfile"
PROJECT_DIR="$PWD"

# Default make command
equals='===================================\n'
command="echo -ne '$equals' && make && echo -e '$equals' && ./libasm"

# Show help
show_help() {
	cat << EOF
Usage: ./run.sh [options]

Options:
  -c        Run 'make fclean'
  -r        Run 'make re'
  -b        Rebuild the Docker image for libasm (forces update)
  -h        Show this help message

Examples:
  ./run.sh             # Default: make && ./libasm
  ./run.sh -r          # Run make re
  ./run.sh -cb         # Clean and rebuild image
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

# Parse flags
while getopts "crbh" opt; do
	case $opt in
		c)
			command="make fclean"
			;;
		r)
			command="make re"
			;;
		b)
			build_images
			;;
		h)
			show_help
			exit 0
			;;
	esac
done

run_image
