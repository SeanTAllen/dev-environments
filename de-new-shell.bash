#!/bin/bash

set -o errexit

unset NAME

while getopts ":n:" opt; do
  case $opt in
    n) NAME="$OPTARG"
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

docker exec -it ${NAME} fish
