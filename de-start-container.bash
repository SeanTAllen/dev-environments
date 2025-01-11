#!/bin/bash

set -e

unset NAME
unset WORKSPACE

while getopts ":n:w:" opt; do
  case $opt in
    n) NAME="$OPTARG"
    ;;
    w) WORKSPACE="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

if [[ -z "${NAME}" ]]; then
  echo -e "\e[31mContainer name needs to be set via -n."
  echo -e "Exiting.\e[0m"
  exit 1
fi

if [[ -z "${WORKSPACE}" ]]; then
  echo -e "\e[31mWorkspace to mount into container needs to be set via -w."
  echo -e "Exiting.\e[0m"
  exit 1
fi

docker run --user sean --name ${NAME} --mount src=${WORKSPACE},target=/workspace,type=bind -w /workspace --mount src=/home/sean/.ssh,target=/home/sean/.ssh,type=bind --mount src=/home/sean/.gitconfig,target=/home/sean/.gitconfig,type=bind --mount src=/home/sean/.gitconfig.local,target=/home/sean/.gitconfig.local,type=bind --mount src=/home/sean/.gnupg,target=/home/sean/.gnupg,type=bind --mount src=/home/sean/.config,target=/home/sean/.config,type=bind --mount src=/home/sean/.vim,target=/home/sean/.vim,type=bind --mount src=/home/sean/.vimrc,target=/home/sean/.vimrc,type=bind --mount src=/var/run/docker.sock,target=/var/run/docker.sock,type=bind --rm -i -t develop-with-pony:20250111 fish