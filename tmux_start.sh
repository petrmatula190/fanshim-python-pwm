#!/bin/bash
cd /home/pi/fanshim
echo looking to kill any existing fanshim session
tmux kill-session -t fanshim
echo now new tmux fanshim session
tmux new-session -d -s fanshim 'python3 examples/automatic.py --off-threshold 54 --on-threshold 55 --verbose'
