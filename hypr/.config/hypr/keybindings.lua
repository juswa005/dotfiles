---------------------
---- KEYBINDINGS ----
---------------------

local programs = require("programs")

local terminal    = programs.terminal
local fileManager = programs.fileManager
local menu        = programs.menu
local applauncher = programs.applauncher

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(applauncher))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('helium --profile-directory="Default"'))
hl.bind(mainMod .. " + CONTROL + V", hl.dsp.exec_cmd("/home/amiel/.config/hypr/scripts/clipboard.sh"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("/home/amiel/.config/hypr/scripts/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exec_cmd("/home/amiel/.config/hypr/scripts/powermode.sh"))
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.exec_cmd("/home/amiel/.config/hypr/scripts/toggle-hypridle.sh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- WebApps
local webapp = "/home/amiel/.config/hypr/scripts/launch-webapp.sh"
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(webapp .. ' "https://www.instagram.com/"'))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(webapp .. ' "https://calendar.google.com/"'))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(webapp .. ' "https://www.facebook.com/"'))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(webapp .. ' "https://chatgpt.com"'))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(webapp .. ' "https://mail.google.com"'))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(webapp .. ' "https://youtube.com/"'))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(webapp .. ' "https://facebook.com/messages/"'))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(webapp .. ' "https://github.com/juswa005"'))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(webapp .. ' "https://gemini.google.com/app"'))

-- Alt tab to change focus
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ direction = "prev" }))

-- Volume (secondary controls)
hl.bind(mainMod .. " + up", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(mainMod .. " + down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind(mainMod .. " + right", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Brightness (secondary controls)
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("brightnessctl set 10%-"))

hl.bind(mainMod .. " + CONTROL + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + CONTROL + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + CONTROL + UP", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + CONTROL + DOWN", hl.dsp.focus({ direction = "down" }))

-- Swap tiled windows
hl.bind(mainMod .. " + CONTROL + SHIFT + LEFT", hl.dsp.exec_cmd("hyprctl dispatch swapwindow l"))
hl.bind(mainMod .. " + CONTROL + SHIFT + RIGHT", hl.dsp.exec_cmd("hyprctl dispatch swapwindow r"))
hl.bind(mainMod .. " + CONTROL + SHIFT + UP", hl.dsp.exec_cmd("hyprctl dispatch swapwindow u"))
hl.bind(mainMod .. " + CONTROL + SHIFT + DOWN", hl.dsp.exec_cmd("hyprctl dispatch swapwindow d"))

-- Move floating window
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.exec_cmd("hyprctl dispatch moveactive -20 0"))
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.exec_cmd("hyprctl dispatch moveactive 20 0"))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.exec_cmd("hyprctl dispatch moveactive 0 -20"))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.exec_cmd("hyprctl dispatch moveactive 0 20"))

-- Resize floating window
hl.bind(mainMod .. " + ALT + LEFT", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -20 0"))
hl.bind(mainMod .. " + ALT + RIGHT", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 20 0"))
hl.bind(mainMod .. " + ALT + UP", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -20"))
hl.bind(mainMod .. " + ALT + DOWN", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 20"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --output-folder ~/Pictures/Screenshots"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output --output-folder ~/Pictures/Screenshots"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window --output-folder ~/Pictures/Screenshots"))

-- Dark mode and light mode toggle
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("/home/amiel/.config/hypr/scripts/toggle-theme.sh"))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl set +10%"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl set 10%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
