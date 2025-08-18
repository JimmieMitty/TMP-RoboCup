#!/bin/bash

cd "$(dirname "$0")"
cd ..

./scripts/sim_stop.sh

source ./install/setup.bash
export FASTRTPS_DEFAULT_PROFILES_FILE=./configs/fastdds.xml

SESSION=robocup_sim

tmux new-session -d -s $SESSION

tmux send-keys -t $SESSION "ros2 run joy joy_node --ros-args -p autorepeat_rate:=0.0 | tee joystick.log" C-m
tmux split-window -v -t $SESSION

tmux send-keys -t $SESSION "ros2 launch game_controller launch.py | tee game_controller.log" C-m
tmux split-window -h -t $SESSION:0.1

tmux send-keys -t $SESSION "ros2 launch vision launch.py sim:=true | tee vision.log" C-m
tmux split-window -h -t $SESSION:0.2

tmux send-keys -t $SESSION "ros2 launch brain launch.py sim:=true | tee brain.log" C-m

tmux select-layout -t $SESSION tiled

echo "Started tmux session '$SESSION'. Attaching now..."
sleep 1
tmux attach -t $SESSION