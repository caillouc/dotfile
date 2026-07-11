-- Hyprland Lua Configuration
-- Properly formatted using hl.* API
-- Refer to https://wiki.hyprland.org/Configuring/Start/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
    -- Disable vrr, to avoid mouse lag (due not not compatible nvidia driver yet)
    vrr      = 0,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "nautilus"
local menu        = "fuzzel"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()

    -- Import environment and activate the graphical session target
    -- `systemctl --user status xdg-desktop-portal-hyprland` fix

    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE")
    hl.exec_cmd("systemd-run --user --unit=graphical-session-bootstrap --property=Type=oneshot --property=RemainAfterExit=yes --property=Wants=graphical-session.target /usr/bin/true")
    hl.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland.service xdg-desktop-portal.service")

    -- Then start applications
    hl.exec_cmd("hyprpaper &")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("hypridle &")
    hl.exec_cmd("lxpolkit &")

    -- Terminal last
    hl.exec_cmd(terminal .. " --class fullscreen-term")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GDK_BACKEND", "wayland,x11")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "default")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Prefer dark theme for GTK/Qt apps launched by Hyprland
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,
        border_size = 2,

        col = {
            active_border   = "rgba(f4b8e4ff)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    -- To fix a ghost cursor bug
    cursor = {
        no_hardware_cursors = true,
    },
})

-- Animation curves
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Animations configuration
hl.animation({ leaf = "windows",       enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle",   enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",          enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 6,  bezier = "default" })

-- Dwindle layout
hl.config({
    dwindle = {
        preserve_split = true,
        force_split = 2,
    },
})

-- Master layout
hl.config({
    master = {
        new_status = "master",
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "compose:ralt",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Gesture support (3-finger horizontal swipe for workspace switching)
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Per-device configuration
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Basic window controls
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("brave-browser"))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + X",      hl.dsp.exit())
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space",  hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + S",      hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + BackSpace", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + O", hl.dsp.focus({ urgent_or_last = true }))

-- Move focus with vim keybinds
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad) - uncomment if you want to use
-- hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Print Screen
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

-- Resize mode
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit"))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media player controls
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Suppress maximize requests from all apps
local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland dragging issues
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

-- Window rules for specific applications
hl.window_rule({
    name  = "brave-workspace-2",
    match = { class = "brave-browser" },
    workspace = 2,
})

hl.window_rule({
    name  = "steam-workspace-4",
    match = { class = "steam" },
    workspace = 4,
})

hl.window_rule({
    name  = "discord-workspace-4",
    match = { class = "discord" },
    workspace = 4,
})

hl.window_rule({
    name  = "proton-workspace-4",
    match = { class = "Proton Mail" },
    workspace = 3,
})

hl.window_rule({
    name  = "fullscreen-term",
    match = { class = "fullscreen-term" },
    fullscreen = true,
})
