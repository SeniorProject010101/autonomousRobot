# Tiny ROS 2 image — same image runs on Apple Silicon Mac and Raspberry Pi 4B

FROM ros:jazzy-ros-core

ENV DEBIAN_FRONTEND=noninteractive \
    RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
    ROS_DOMAIN_ID=0

# Only what's needed to build the C++ code.
RUN apt-get update \
 && apt-get install -y --no-install-recommends g++ cmake make \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /robot

RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc

CMD ["bash"]
