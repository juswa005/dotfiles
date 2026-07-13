#!/usr/bin/env fish

if pkill wofi
    exit 0
end

set CHOICE (printf "Shutdown\nReboot" | wofi --dmenu --prompt "Power Options" --lines 3 --width 200 --location center)

switch "$CHOICE"
    case Shutdown
        systemctl poweroff
    case Reboot
        systemctl reboot
end
