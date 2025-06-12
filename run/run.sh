# This script handles running the nasm code inside of a dockere'd QEMU
# If you're not running this project on ARM, just use 'make'

# Running the dockere'd QEMU
docker run --rm --privileged tonistiigi/binfmt --install all 1> /dev/null

# Building our own docker image
docker buildx build --platform linux/amd64 -t libasm-alpine "$PWD/run/Dockerfile" 1> /dev/null

# Running the image
docker run --rm -it --platform linux/amd64 --name libasm -v "$PWD:/app" -w /app --network="host" libasm-alpine zsh -c "make && ./libasm"
