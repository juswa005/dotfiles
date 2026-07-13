--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Migrated rules
hl.window_rule({
	name = "wofi-rules",
	match = { class = "^wofi$" },
	float = true,
	center = true,
	size = "500 400",
})

hl.window_rule({
	name = "gnome-calculator",
	match = { class = "^(org\\.gnome\\.Calculator)$" },
	float = true,
	size = "360 630",
	center = true,
})

hl.window_rule({
	name = "overskride",
	match = { class = "^io\\.github\\.kaii_lb\\.Overskride$" },
	float = true,
	center = true,
	size = "700 600",
})

hl.window_rule({
	name = "clipmgr-float",
	match = { class = "^clipmgr$" },
	float = true,
	center = true,
	size = "800 600",
})

hl.window_rule({
	name = "waybar-kitty",
	match = { class = "^waybar-kitty$" },
	float = true,
	center = true,
	size = "800 600",
})

hl.config({
	layerrule = {
		"blur, wofi",
		"ignorealpha 0.1, wofi",
	},
})

-- Workspace monitor assignments
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1", default = true })

-- Persistent workspaces
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
