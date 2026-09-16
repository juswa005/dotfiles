#!/usr/bin/env bash

# Toggle logic
if [ "$1" = "toggle" ]; then
    if pgrep -x "lowfi" > /dev/null; then
        killall lowfi
        # Ensure tmux session is also gone just in case
        tmux kill-session -t lowfi_session 2>/dev/null
    else
        # Start in tmux to give it a proper PTY so it doesn't hang on loading
        tmux new-session -d -s lowfi_session "lowfi"
    fi
    # Wait a tiny bit for the process state to update
    sleep 0.1
    pkill -RTMIN+8 waybar
    exit 0
fi

# Status logic for waybar
if pgrep -x "lowfi" > /dev/null; then
    # Running
    echo '{"text": "d[-_-]b", "class": "active", "tooltip": "lowfi is playing"}'
else
    # Not running
    echo '{"text": "d[-_-]b", "class": "inactive", "tooltip": "lowfi is stopped"}'
fi
