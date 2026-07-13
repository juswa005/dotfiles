#!/usr/bin/env bash
if pgrep -x "hypridle" > /dev/null; then
    killall hypridle
    notify-send "Hypridle" "Auto-lock disabled"
else
    hypridle &
    notify-send "Hypridle" "Auto-lock enabled"
fi
