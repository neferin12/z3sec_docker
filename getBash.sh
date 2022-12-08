#!/bin/bash

docker rm -f z3sec

# Pull the Docker image
docker pull ghcr.io/neferin12/z3sec:latest

# Create a Docker container from the image
docker create --name z3sec ghcr.io/neferin12/z3sec

# Run the Docker container
docker run -it z3sec /bin/bash