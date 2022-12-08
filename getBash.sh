#!/bin/bash

# Pull the Docker image
docker pull neferin12/z3sec

# Create a Docker container from the image
docker create --name z3sec neferin12/z3sec

# Open a bash shell in the container
docker exec -it z3sec bash