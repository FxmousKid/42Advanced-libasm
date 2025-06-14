FROM python:3-alpine

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
	python3 \
    ca-certificates && \
	rm -rf /var/cache/apk/* && \
	pip install compiledb
	

WORKDIR /app
