#!/bin/bash


ISAAC_SIM_PATH="/home/redbackbots/Workspace/booster/redbackbots-IsaacSim/Dockerfiles/IssacSim-Headless/start_ros2_local_isaac_sim.sh"
BOOSTER_PATH="/home/redbackbots/booster-runner-full-0.0.11.run"
ISAAC_SIM_DIR="$(dirname "$ISAAC_SIM_PATH")"
CUR_DIR="$(pwd)"

# Start tmux session for Isaac Sim and Booster
SESSION="sim"
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
	tmux new-session -d -s $SESSION -c "$ISAAC_SIM_DIR" -n isaac_sim
	tmux send-keys -t $SESSION:isaac_sim "$ISAAC_SIM_PATH" C-m
	tmux new-window -t $SESSION -n booster -c "$CUR_DIR"
	tmux send-keys -t $SESSION:booster "sudo $BOOSTER_PATH" C-m
else
	echo "tmux session '$SESSION' already exists. Skipping tmux setup."
fi

echo Starting robocup

# Start the robocup code in the main terminal
bash ./scripts/sim_start.sh
