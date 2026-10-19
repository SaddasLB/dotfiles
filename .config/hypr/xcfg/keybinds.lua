
---------------------
---- KEYBINDINGS ----
---------------------

-- Variables
local terminal = "kitty"
local fileManager = "thunar"
local menu = "~/.config/scripts/wofi-superkey.sh"
local powerMenu = "~/.config/scripts/wofi-power-menu.sh"
local resourceMonitor = "/usr/bin/btop"

-- Sets "Windows" key as main modifier
local mainMod = "SUPER"

-- Opens menu
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd(menu))

-- Opens Power Menu
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(powerMenu))

-- Open resource monitor
hl.bind(mainMod .. " + ALT + DELETE", hl.dsp.exec_cmd(terminal .." -e " .. resourceMonitor))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("~/.config/scripts/screenshot.sh"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/scripts/screenshot.sh mono"))

-- Hyprpicker
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprpicker -a | --autocopy"))

-- Set wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(terminal .. " -e ~/.config/scripts/wallpaper-setter_kitty.sh"))

-- Gamemode / High Performance
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/scripts/gamemode.sh"))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle"}))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle"}))

-- Basics
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Layout
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + movement keys
for direction, keys in pairs({
    left  = { "left", "H" },
    right = { "right", "L" },
    up    = { "up", "K" },
    down  = { "down", "J" },
}) do
    for _, key in ipairs(keys) do
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    end
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Resize window with mainMod + movement keys
for _, bind in ipairs({
    { keys = { "right", "L" }, x =  10, y =   0 },
    { keys = { "left",  "H" }, x = -10, y =   0 },
    { keys = { "up",    "K" }, x =   0, y =  10 },
    { keys = { "down",  "J" }, x =   0, y = -10 },
}) do
    for _, key in ipairs(bind.keys) do
        hl.bind(
            mainMod .. " + CTRL + " .. key,
            hl.dsp.window.resize({
                x = bind.x,
                y = bind.y,
                relative = true
            }),
            { repeating = true }
        )
    end
end

-- ALT TAB between worksapaces ROTTO
-- hl.bind(mainMod .. " + TAB", hl.dsp.workspace("previous"))
-- binds{ allow_workspace_cycles = true}


-- ALT TAB between windows
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
