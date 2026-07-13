-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    -- Enforce System Dark Theme
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' &")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' &")

    -- Daemons and Status Bar
    hl.exec_cmd("swaybg -i /home/amiel/.config/hypr/wallpapers/wallp.jpg -m fill &")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("hypridle &")
    hl.exec_cmd("dunst &")
    hl.exec_cmd("hyprsunset &")
    hl.exec_cmd("systemctl --user start hyprpolkitagent &")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("blueman-applet &")
    hl.exec_cmd("docker start oracle-xe &")

    -- Clipboard management
    hl.exec_cmd("wl-paste --type text --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store &")
end)
