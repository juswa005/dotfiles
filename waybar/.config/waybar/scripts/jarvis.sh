#!/usr/bin/env bash

# File: ~/.config/waybar/scripts/jarvis.sh
JARVIS_CMD="./jarvis chat --voice"
JARVIS_DIR="$HOME/Projects/Ollama_Jarvis"

case "$1" in
    status)
        if systemctl --user is-active --quiet jarvis-voice.service; then
            echo '{"text": "🤖 ON", "tooltip": "JARVIS is Listening...", "class": "active"}'
        else
            echo '{"text": "🤖 JARVIS", "tooltip": "Click to start JARVIS", "class": "inactive"}'
        fi
        ;;
    toggle)
        if systemctl --user is-active --quiet jarvis-voice.service; then
            systemctl --user stop jarvis-voice.service
        else
            systemd-run --user --unit=jarvis-voice --working-directory="$JARVIS_DIR" nix develop --command bash -c "$JARVIS_CMD"
        fi
        ;;
esac
