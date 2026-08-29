#!/usr/bin/env bash

# Define the options
OPTIONS="Local Navidrome\nServer Navidrome"

# Show the menu using wofi and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Select Music Server:" -i --width 350 --height 150)

# Launch supersonic based on the choice, isolating the data/config folders
case "$CHOICE" in
    "Local Navidrome")
        # Define isolated environments for local
        export XDG_CONFIG_HOME="$HOME/.config/supersonic-local"
        export XDG_DATA_HOME="$HOME/.local/share/supersonic-local"
        export XDG_CACHE_HOME="$HOME/.cache/supersonic-local"
        
        # Ensure directories exist
        mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME"
        
        # Launch
        supersonic &
        ;;
    "Server Navidrome")
        # Define isolated environments for server
        export XDG_CONFIG_HOME="$HOME/.config/supersonic-server"
        export XDG_DATA_HOME="$HOME/.local/share/supersonic-server"
        export XDG_CACHE_HOME="$HOME/.cache/supersonic-server"
        
        # Ensure directories exist
        mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME"
        
        # Launch
        supersonic &
        ;;
    *)
        # Exit silently if the user closes wofi without selecting
        exit 0
        ;;
esac
