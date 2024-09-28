local wt = require("wezterm")
local act = wt.action

local function shell(cmd)
  if cmd then
    return { "/home/linuxbrew/.linuxbrew/bin/fish", "-c", wt.shell_join_args(cmd) }
  else
    return { "/home/linuxbrew/.linuxbrew/bin/fish" }
  end
end

local function direnv(cmd)
  return shell({ "direnv", "exec", ".", table.unpack(cmd) })
end

local config = {}

config.color_scheme = "GruvboxDarkHard"

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#d5c4a1",
      fg_color = "#3c3836",
    },

    background = "#1d2021",
  },
}

config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.4,
}

config.default_prog = shell()

config.freetype_load_target = "HorizontalLcd"

config.font = wt.font("JetBrains Mono")
config.font_size = 11.0
config.warn_about_missing_glyphs = false

config.initial_cols = 120

config.keys = {
  {
    key = "e",
    mods = "SUPER",
    action = act.SpawnCommandInNewTab({ args = direnv({ "nvim" }) }),
  },
  {
    key = "e",
    mods = "SUPER|CTRL",
    action = act.SpawnCommandInNewWindow({ args = direnv({ "nvim" }) }),
  },
  { key = "g", mods = "SUPER", action = act.SpawnCommandInNewWindow({
    args = shell({ "lazygit" }),
  }) },

  { key = "q", mods = "SUPER", action = act.CloseCurrentPane({ confirm = false }) },

  { key = ",", mods = "SUPER", action = act.ActivateTabRelative(-1) },
  { key = ",", mods = "SUPER|CTRL", action = act.MoveTabRelative(-1) },
  { key = ".", mods = "SUPER", action = act.ActivateTabRelative(1) },
  { key = ".", mods = "SUPER|CTRL", action = act.MoveTabRelative(1) },
  { key = "s", mods = "SUPER", action = act.SpawnCommandInNewTab({ args = shell() }) },
  {
    key = "u",
    mods = "SUPER|CTRL",
    action = wt.action.CharSelect({
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    }),
  },

  {
    key = "x",
    mods = "CTRL|SHIFT",
    action = act.PromptInputLine({
      description = wt.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
      }),
      action = wt.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace({
              name = line,
            }),
            pane
          )
        end
      end),
    }),
  },
}

config.line_height = 1.05

config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 64
config.use_fancy_tab_bar = false

config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"

config.window_frame = {
  inactive_titlebar_bg = "#1d2021",
  active_titlebar_bg = "#1d2021",
  font = wt.font("JetBrains Mono", { stretch = "Condensed", weight = "Regular" }),
  font_size = 10.0,
}

config.window_padding = { top = 8, right = 8, bottom = 8, left = 12 }

return config
