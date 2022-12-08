#!/bin/bash

# Update image
docker pull ghcr.io/neferin12/z3sec:latest

# Run the Docker container
docker run -it ghcr.io/neferin12/z3sec /bin/bash
