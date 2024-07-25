local wt = require("wezterm")
local config = {}

config.window_background_opacity = 0.9
config.color_scheme = "GruvboxDarkHard"
config.font = wt.font("Iosevka Timbuktu")
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"

return config
