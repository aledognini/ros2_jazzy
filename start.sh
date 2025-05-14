#!/bin/bash

# Specify the container name and image
CONTAINER_NAME="ros2_ez10"
IMAGE_NAME="ros2-jazzy-ez10"

echo "Pulling the latest image: $IMAGE_NAME..."
# docker pull $IMAGE_NAME

# Allow GUI access
xhost +local:root

# Check if the container exists
if docker ps -a | grep -q $CONTAINER_NAME; then
    echo "Container $CONTAINER_NAME exists."

    # Check if the container is running
    if [ "$(docker inspect -f {{.State.Running}} $CONTAINER_NAME)" == "true" ]; then
        echo "Container $CONTAINER_NAME is running. Stopping it now..."
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
    else
        echo "Container $CONTAINER_NAME is not running."
        docker rm $CONTAINER_NAME
    fi
else
    echo "Container $CONTAINER_NAME does not exist."
fi

# Ensure the local 'data' folder exists
mkdir -p "$(pwd)/data"
mkdir -p "$(pwd)/ros2_ws"

# Run the container
docker run -it \
    --user ez10 \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env LIBGL_ALWAYS_SOFTWARE=1 \
    --net=host \
    --rm \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$(pwd)/data:/home/ez10/data" \
    --volume="$(pwd)/ros2_ws:/home/ez10/ros2_ws" \
    --name $CONTAINER_NAME \
    -w /home/ez10 \
    $IMAGE_NAME
