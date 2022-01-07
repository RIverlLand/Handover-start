#!/bin/bash
xhost +local:root

. ~/auto_config_ROS_MASTER.sh

docker container stop realsense
docker container stop handtracking
docker container stop frankaHW
docker container stop handoverDemo

docker container rm handtracking

docker run -it --rm --hostname=realsense --add-host=realsense:127.0.0.1 --name=realsense --privileged --env=XAUTHORITY=/tmp/.docker-realsense.xauth --env=DISPLAY=:1 --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --volume=/tmp/.docker-realsense.xauth:/tmp/.docker-realsense.xauth:rw --cap-add SYS_NICE --security-opt seccomp=unconfined --ulimit rtprio=99 --volume=/home/gami-aiif/Handover_project/slamdog_docker/franka_home:/home/robot:rw --volume=/home/gami-aiif/Handover_project/slamdog_docker/../franka:/home/robot/franka:rw --gpus all --network host realsense:latest


docker run -it --rm --hostname=frankaHW --add-host=frankaHW:127.0.0.1 --name=frankaHW --privileged --env=XAUTHORITY=/tmp/.docker-frankaHW.xauth --env=DISPLAY=:0 --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --volume=/tmp/.docker-frankaHW.xauth:/tmp/.docker-frankaHW.xauth:rw --cap-add SYS_NICE --security-opt seccomp=unconfined --ulimit rtprio=99 --volume=/home/gami-aiif/Handover_project/slamdog_docker/franka_home:/home/robot:rw --volume=/home/gami-aiif/Handover_project/slamdog_docker/../franka:/home/robot/franka:rw --gpus all --network host frankahw:latest


docker run -it --name=handtracking -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/gami-aiif/Docker/handtracking:/hand_tracking -e DISPLAY -e QT_X11_NO_MITSHM=1 --env="QT_X11_NO_MITSHM=1" --privileged --gpus all --network="host" hand_tracking:latest

# GLOG_logtostderr=1 bazel-bin/src/publish_landmarks

# docker run -it --rm --hostname=handoverDemo --add-host=handoverDemo:127.0.0.1 --name=handoverDemo --privileged --env=XAUTHORITY=/tmp/.docker-handoverDemo.xauth --env=DISPLAY=:0 --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --volume=/tmp/.docker-handoverDemo.xauth:/tmp/.docker-handoverDemo.xauth:rw --cap-add SYS_NICE --security-opt seccomp=unconfined --ulimit rtprio=99 --volume=/home/gami-aiif/Handover_project/slamdog_docker/franka_home:/home/robot:rw --volume=/home/gami-aiif/Handover_project/slamdog_docker/../franka:/home/robot/franka:rw --gpus all --network host handoverdemo:built
