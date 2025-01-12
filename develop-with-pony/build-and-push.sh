#!/bin/bash

set -o errexit
set -o nounset

DOCKERFILE_DIR="$(dirname "$0")"
NAME="ghcr.io/seantallen/dev-environment-develop-with-pony"

# with date as tag
TAG_AS=$(date +%Y%m%d)
docker build -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# with latest as tag
TAG_AS="latest"
docker build -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"
