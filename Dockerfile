# Always get the latest one to ensure we are up to date security patches
FROM alpine:latest

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
