#!/bin/bash

# Make sure the Docker container exists
if [ ! "$(docker ps -aq -f name=z3sec)" ]; then
    ./createContainer.sh
fi

# Start the Docker container
docker start z3sec

# Clear the terminal
clear

# Run the Docker container
docker attach z3sec

# Stop the Docker container
docker stop z3sec