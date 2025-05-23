# templates/Dockerfile.builder.j2

# ─── Builder Stage ────────────────────────────────────────────────────────────
FROM docker.io/dragomirxyz/robocore_humble_arm64:latest AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble
ENV ROS_WS=/ros_ws

# Install core build tools
RUN apt-get update && apt-get install -y \
    git \
    python3-colcon-common-extensions \
    sudo \
    curl \
    gnupg2 \
    lsb-release \
    udev \
    cmake \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Copy in source tree
WORKDIR /
COPY ros_ws/src /ros_ws/src


# … previous steps …



# Install ROS deps
WORKDIR /ros_ws
RUN bash -lc "\
  source /opt/ros/${ROS_DISTRO}/setup.bash && \
  rosdep update && \
  rosdep install --from-paths src --ignore-src -r -y\
"
