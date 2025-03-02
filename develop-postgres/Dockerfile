FROM ghcr.io/seantallen/dev-environment-develop-with-pony:latest

LABEL org.opencontainers.image.source="https://github.com/seantallen/dev-environments"

RUN apk add --update --no-cache \
  docker

# Set the postgres host to the host machine
ENV POSTGRES_HOST=172.17.0.1
