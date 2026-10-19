
--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example window rules that are useful

hl.window_rule({
  float = true,
  match = { class = "^(org.keepassxc.KeePassXC)$"},
})

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


hl.workspace_rule({
  workspace = 5,
  monitor = "DP-1"
})
hl.workspace_rule({
  workspace = 6,
  monitor = "DP-1"
})
hl.workspace_rule({
  workspace = 7,
  monitor = "DP-1"
})
hl.workspace_rule({
  workspace = 8,
  monitor = "DP-1"
})
hl.workspace_rule({
  workspace = 9,
  monitor = "DP-1"
})
hl.workspace_rule({
  workspace = 10,
  monitor = "DP-1"
})
