local wt = require("wezterm")
local config = {}

config.window_background_opacity = 0.9
config.color_scheme = "GruvboxDarkHard"

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#d5c4a1",
      fg_color = "#3c3836",
    },

    background = "#1d2021"
  }
}

config.font = wt.font("Iosevka Timbuktu")
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"

config.window_frame = {
  inactive_titlebar_bg = "#1d2021",
  active_titlebar_bg = "#1d2021",
  font = wt.font("Iosevka Timbuktu", { stretch = "Condensed", weight = "Regular" }),
  font_size = 10.0
}

return config
