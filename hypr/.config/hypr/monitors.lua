------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60.0",
    position = "735x534",
    scale    = 1.25,
    bitdepth = 10,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144.0",
    position = "2271x423",
    scale    = 1.0,
    bitdepth = 10,
})

-- Fallback for others
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
