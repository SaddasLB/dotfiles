-- Refer to https://wiki.hypr.land/configuring/core/config-options/

-----------------------
---- LOOK AND FEEL ----
-----------------------

local pilors = dofile(
    os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua"
)

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 2,

        col = {
            active_border   = { colors = {pilors.color1, pilors.color6}, angle = 45 },
            inactive_border = pilors.background,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.85,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = pilors.background,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
    
    
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05}} })
hl.animation({ leaf = "windows", enabled = true,  speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "default", style = "popin 80%"})
hl.animation({ leaf = "border", enabled = true,  speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true,  speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true,  speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true,  speed = 6, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true,  speed = 6, bezier = "default", style = "slidevert"})

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
