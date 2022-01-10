Open github page:

https://github.com/RIverlLand/Handover-start

Steps to open handover
===

## Step 1: Turn on Framos

Open a new terminal,

```roslaunch realsense2_camera rs_camera.launch align_depth:=true```
---

## Step 2: Open dockers

Each step requires a new terminal.

### First: FrankaHW

```docker run -it --rm --hostname=frankaHW --add-host=frankaHW:127.0.0.1 --name=frankaHW --privileged --env=XAUTHORITY=/tmp/.docker-frankaHW.xauth --env=DISPLAY=:0 --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --volume=/tmp/.docker-frankaHW.xauth:/tmp/.docker-frankaHW.xauth:rw --cap-add SYS_NICE --security-opt seccomp=unconfined --ulimit rtprio=99 --volume=/home/gami-aiif/Handover_project/slamdog_docker/franka_home:/home/robot:rw --volume=/home/gami-aiif/Handover_project/slamdog_docker/../franka:/home/robot/franka:rw --gpus all --network host frankahw:latest```

- Inside docker frankahw, run command
  - ```cd franka/panda_controller_ws/```
  - ```./autostart.sh```
    - This will publish codes on terminal. Otherwise restart franka lock or the user bottom.

---

### Second: Realsense

```docker run -it --rm --hostname=realsense --add-host=realsense:127.0.0.1 --name=realsense --privileged --env=XAUTHORITY=/tmp/.docker-realsense.xauth --env=DISPLAY=:1 --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --volume=/tmp/.docker-realsense.xauth:/tmp/.docker-realsense.xauth:rw --cap-add SYS_NICE --security-opt seccomp=unconfined --ulimit rtprio=99 --volume=/home/gami-aiif/Handover_project/slamdog_docker/franka_home:/home/robot:rw --volume=/home/gami-aiif/Handover_project/slamdog_docker/../franka:/home/robot/franka:rw --gpus all --network host realsense:latest```

- Inside docker realsense, run command
  - ```cd franka/realsense_ws/```
  - ```./autostart.sh```
    - This will have no output in terminal. Bu hui yi zhi shua xin


---

### Third: Handtracking

```xhost +local:root```
```docker container stop handtracking```
```docker container rm handtracking```
```docker run -it --name=handtracking -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/gami-aiif/Docker/handtracking:/hand_tracking -e DISPLAY -e QT_X11_NO_MITSHM=1 --env="QT_X11_NO_MITSHM=1" --privileged --gpus all --network="host" hand_tracking:latest```


- Inside handtracking docker, run
  - ```GLOG_logtostderr=1 bazel-bin/src/publish_landmarks```
    - This will pop out a window with image if Framos is running.

---

### Forth: Handoverdemo

```docker run -it --rm --hostname=handoverDemo --add-host=handoverDemo:127.0.0.1 --name=handoverDemo --privileged --env=XAUTHORITY=/tmp/.docker-handoverDemo.xauth --env=DISPLAY=:0 --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --volume=/tmp/.docker-handoverDemo.xauth:/tmp/.docker-handoverDemo.xauth:rw --cap-add SYS_NICE --security-opt seccomp=unconfined --ulimit rtprio=99 --volume=/home/gami-aiif/Handover_project/slamdog_docker/franka_home:/home/robot:rw --volume=/home/gami-aiif/Handover_project/slamdog_docker/../franka:/home/robot/franka:rw --gpus all --network host handoverdemo:built```

- Inside handoverdemo docker, run
  - ```cd franka/handover_demo_ws```
  - ```./autostart.sh```
    - Click enter as the tips in terminal, Franka will start moving.

---


# Other useful commands

## Move to start position of Franka

- Start a new terminal, run the command blow:

```roslaunch franka_example_controllers move_to_start.launch robot_ip:=192.168.1.100```
