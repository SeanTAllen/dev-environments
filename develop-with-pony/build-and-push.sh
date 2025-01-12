#!/bin/bash

set -o errexit
set -o nounset

DOCKERFILE_DIR="$(dirname "$0")"

NAME="ghcr.io/seantallen/dev-environment-develop-with-pony"
TODAY=$(date +%Y%m%d)
TAG_AS=${TODAY}

docker build -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"
