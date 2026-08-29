#!/usr/bin/env bash
art_path=$(cat /tmp/waybar-mpris-art-path 2>/dev/null)
if [[ -n "$art_path" && -f "$art_path" ]]; then
    echo "$art_path"
fi
