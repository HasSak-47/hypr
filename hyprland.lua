hl.monitor({ output = "DP-1", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto-left", scale = 1 })

hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true, persistent = true })

for i = 2, 9 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", persistent = true })
end

local browser = "zen-browser"
local terminal = "env GTK_IM_MODULE=simple ghostty --gtk-single-instance=false"
local menu = "wofi --show drun"

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("[workspace 1 silent] " .. terminal)
  hl.exec_cmd("[workspace 2 silent] " .. browser)
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

local sumiInk0 = "rgba(16161dee)"
local autumnRed = "rgba(c34043ee)"
local lotusRed3 = "rgba(e82424ee)"
local sumiInk3 = "rgba(1f1f28ee)"

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = { colors = { autumnRed, lotusRed3 }, angle = 45 },
      inactive_border = sumiInk0,
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 4,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = sumiInk3,
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

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    vrr = false,
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },

  input = {
    kb_layout = "latam",
    kb_variant = "",
    kb_model = "",
    kb_options = "caps:escape",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 0,

    touchpad = {
      natural_scroll = false,
    },

    tablet = {
      region_position = "0, 0",
      region_size = "1920, 1080",
      active_area_size = "216, 121.5",
    },
  },

  xwayland = {
    force_zero_scaling = true,
  },

  render = {
    direct_scanout = false,
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = false, speed = 1, bezier = "quick" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2.0, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

local mainMod = "SUPER"
local LEFT, DOWN, UP, RIGHT = "H", "J", "K", "L"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + " .. LEFT, hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. RIGHT, hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. UP, hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. DOWN, hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + " .. LEFT, hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + " .. RIGHT, hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + " .. UP, hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + " .. DOWN, hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + O", hl.dsp.window.fullscreen({ mode = 0 }))

hl.bind(mainMod .. " + CTRL + SHIFT + " .. RIGHT, hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + CTRL + SHIFT + " .. UP, hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + CTRL + SHIFT + " .. LEFT, hl.dsp.exec_cmd("playerctl previous"))

hl.bind(mainMod .. " + ALT + " .. UP, hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(mainMod .. " + ALT + " .. DOWN, hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))

hl.bind("CTRL + SHIFT + N", hl.dsp.exec_cmd("true"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region"))

hl.window_rule({
  name = "terminals-to-1",
  match = { class = "^.*tty$" },
  workspace = "1",
})

hl.window_rule({
  name = "browser-to-2",
  match = { class = "zen|firefox|chromium|google-chrome|brave" },
  workspace = "2",
})

hl.window_rule({
  name = "music-to-7",
  match = { class = "^.*((S|s)potify).*$" },
  workspace = "7",
})

hl.window_rule({
  name = "steam-to-8",
  match = { class = "^.*((S|s)team).*$" },
  workspace = "8",
})

hl.window_rule({
  name = "discord-to-9",
  match = { class = "((D|d)iscord)" },
  workspace = "9",
})
