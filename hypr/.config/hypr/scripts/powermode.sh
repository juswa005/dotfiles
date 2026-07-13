#!/usr/bin/env fish

if pkill wofi
    exit 0
end

# Get current profile
set current (powerprofilesctl get)

# Show Walker menu with current profile in the prompt
set choice (printf "performance\nbalanced\npower-saver\n" | wofi --dmenu --prompt "Power Mode: ( $current) " --lines 4 --width 350 --location center)

# Apply selection if a choice was made
if set -q choice[1]; and test -n "$choice"
    powerprofilesctl set "$choice"
    notify-send "Power Mode" "Switched to $choice"
end
