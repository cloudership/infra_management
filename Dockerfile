# Always get the latest one to ensure we are up to date security patches
FROM alpine:latest

# Increment to force all layers to be rebuilt
ENV INVALIDATE_DOCKER_LAYER_CACHE=1

WORKDIR /app

RUN apk add --no-cache bash  \
    git  \
    openssh-client

COPY bin/bootstrap/* bin/bootstrap/
RUN bin/bootstrap/get-terragrunt && bin/bootstrap/get-tofu

RUN chown 1000 bin/bootstrap/*

USER 1000

COPY . ./
