# Always get the latest one to ensure we are up to date security patches
FROM alpine:latest

# Increment to force all layers to be rebuilt
ENV INVALIDATE_DOCKER_LAYER_CACHE=1

RUN apk add --no-cache bash

COPY bin/bootstrap/get-terragrunt /app/bin/bootstrap/
RUN /app/bin/bootstrap/get-terragrunt
COPY bin/bootstrap/get-terraform /app/bin/bootstrap/
RUN /app/bin/bootstrap/get-terraform

RUN apk add --no-cache \
    git \
    openssh-client

USER 1000

WORKDIR /app

COPY . ./
