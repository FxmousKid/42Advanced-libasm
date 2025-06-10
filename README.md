# 42Advanced-libasm

This project is about coding some utility functions in assembly, more precisely following
the Intel dialect in NASM.

</br>

## Running on ARM

The thing is, NASM doesn't support ARM CPUs, so we have to go through some hoops to run the project
on ARM, which I have to do, since i work on a Apple Silicon machine.

</br>

>[!TIP]
> We will achieve this using docker and a image set up with QEMU

### Building the QEMU docker image
```bash
docker run --rm --privileged tonistiigi/binfmt --install all
```

### Building our own image
```bash
docker buildx build --platform linux/amd64 -t libasm-dev .
```

</br>

> [!NOTE]
> We're using the Dockerfile included at the root of the project, which uses alpine:latest

### Running the docker image
```bash
docker run --rm -it --platform linux/amd64 -v "$PWD:/app" -w /app --network="host" libasm-alpine zsh
```
