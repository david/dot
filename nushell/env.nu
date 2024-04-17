# Nushell Environment Config File
#
# version = "0.88.1"

def create_left_prompt [] {
  let home =  $nu.home-path

  let dir = (
    if ($env.PWD | path split | zip ($home | path split) | all { $in.0 == $in.1 }) {
      ($env.PWD | str replace $home "~")
    } else {
      $env.PWD
    }
  )

  let path_color = (if (is-admin) { ansi red_bold } else { ansi yellow_bold })
  let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi yellow_bold })
  let path_segment = $"($path_color)  ($dir)" |
    str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
  let no_width = "​"

  $" ($path_segment) (ansi black_dimmed)" |
    fill --alignment center --character $"─" --width ((term size | get columns) - 1) |
    $"(ansi black_dimmed)($in)(char newline)($no_width)"
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| "" }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "⚡ " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "🌀 " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "  " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

$env.NU_LIB_DIRS = [
  ($nu.default-config-dir | path join "scripts")
]

$env.NU_PLUGIN_DIRS = [
  ($nu.default-config-dir | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
