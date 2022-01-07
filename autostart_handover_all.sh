#!/bin/bash
# docker exec framos /home/robot/franka/framos_ws/autostart.sh&

# sleep 10

docker exec -d realsense /home/robot/franka/realsense_ws/autostart.sh&

docker exec -d frankaHW /home/robot/franka/panda_controller_ws/autostart.sh&

docker exec -d handtracking /hand_tracking/autostart.sh
#&

#docker exec -it handoverDemo /home/robot/franka/handover_demo_ws/autostart.sh



