FROM ros:jazzy

# Set the environment variable to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt update && apt install -y \
    build-essential \
    nano \
    tmux \
    gedit \
    wget \
    iputils-ping \
    net-tools \
    iproute2 \
    python3-colcon-common-extensions \
    ros-jazzy-desktop-full \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user named 'ez10' with home directory
RUN useradd -m -s /bin/bash ez10 && \
    mkdir -p /home/ez10/data && \
    mkdir -p /home/ez10/ros2_ws/src && \
    chown -R ez10:ez10 /home/ez10

# Switch to the ez10 user
USER ez10
WORKDIR /home/ez10

# Source ROS2 environment for the user
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc && echo "source /home/ros2_jazzy/ros2_ws/install/setup.bash" >> ~/.bashrc

# Default command
CMD ["bash"]
