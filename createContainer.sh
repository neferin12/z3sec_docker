#!/bin/bash

# Select Image
#IMAGE=ghcr.io/neferin12/z3sec:latest
IMAGE=z3sec

# Update image
docker pull ghcr.io/neferin12/z3sec:latest

# Create data folder
DATADIR="$(pwd)"/data

mkdir -p "$DATADIR"

# Create container
docker create --name z3sec \
--hostname z3sec `# set Hostname` \
--interactive --tty `# make container interactive` \
--privileged -v /dev/bus/usb:/dev/bus/usb `# connect USB` \
--mount type=bind,source="$DATADIR",target=/root/data `# mount data folder` \
"$IMAGE"