#!/bin/bash

# check if docker is installed
if ! command -v docker &> /dev/null
then
    echo "docker could not be found, please install it"
    exit
fi


# Make sure the Docker container exists
if [ ! "$(docker ps -aq -f name=z3sec)" ]; then
    ./createContainer.sh
fi

xhost +

# Start the Docker container
docker start z3sec

# Clear the terminal
printf '\33[H\33[2J'

# Run the Docker container
docker attach z3sec

# Stop the Docker container
docker stop z3sec

xhost -

# Clear the terminal
printf '\33[H\33[2J'
