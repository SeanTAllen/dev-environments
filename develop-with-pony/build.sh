#!/bin/bash

set -o errexit
set -o nounset

TODAY=$(date +%Y%m%d)
DOCKERFILE_DIR="$(dirname "$0")"

docker build -t "develop-with-pony:${TODAY}" "${DOCKERFILE_DIR}"
