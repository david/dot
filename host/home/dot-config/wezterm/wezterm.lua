local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "GruvboxDarkHard"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.9

config.keys = {
  {
    key = "e",
    mods = "SUPER|CTRL",
    action = act.SpawnCommandInNewWindow({
      args = { "devenv", "run", "nvim" },
    }),
  },
  {
    key = "s",
    mods = "SUPER",
    action = act.SpawnCommandInNewTab({
      args = { "devenv", "run" },
    }),
  },
}

return config
