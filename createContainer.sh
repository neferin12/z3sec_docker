#!/bin/bash

# check if docker is installed
if ! command -v docker &> /dev/null
then
    echo "docker could not be found, please install it"
    exit
fi

# make sure docker container does not exist
if [ "$(docker ps -aq -f name=z3sec)" ]; then
    exit 0
fi

# Select Image
if [ "$LOCAL" = true ] ; then
    echo "Using local image"
    IMAGE=z3sec:local
else
    IMAGE=ghcr.io/neferin12/z3sec:latest
    # Update image
    docker pull $IMAGE
fi

# Create data folder
DATADIR="$(pwd)"/data

mkdir -p "$DATADIR"

# Create container
docker create --name z3sec \
--hostname z3sec `# set Hostname` \
--interactive --tty `# make container interactive` \
--privileged -v /dev/bus/usb:/dev/bus/usb `# connect USB` \
--mount type=bind,source="$DATADIR",target=/root/data `# mount data folder` \
-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix `# display` \
"$IMAGE"
