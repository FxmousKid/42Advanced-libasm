FROM alpine:latest

# Prevent interactive prompts
ENV TZ=UTC \
    LANG=C

# Install necessary packages
RUN apk update && apk add \
    build-base \
    nasm \
    zsh \
    curl \
    vim \
    gdb \
    git \
    bash \
    ca-certificates \
    && rm -rf /var/cache/apk/* && \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

WORKDIR /app

