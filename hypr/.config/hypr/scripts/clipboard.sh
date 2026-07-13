#!/usr/bin/env fish
# Clipboard manager script using cliphist and wofi

if pkill wofi
    exit 0
end

cliphist list | wofi --dmenu --prompt "Clipboard" | cliphist decode | wl-copy
