#!/bin/bash

# Get a list of running container IDs
container_ids=$(docker ps -q)

# Loop through each container ID and reload it
for container_id in $container_ids; do
    echo "Reloading container: $container_id"
    docker container kill -s HUP $container_id
done
~         