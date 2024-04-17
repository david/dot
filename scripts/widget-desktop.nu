#!/usr/bin/env nu

use widget.nu icon
use wm.nu
use ws.nu

def main [] {
  print --no-newline (ansi cursor_off)

  render

  wm events | where name == "workspace" | each { run-external $env.PROCESS_PATH render }
}

def "main render" [] {
  render
}

def render [] {
  print --no-newline (tput cup 0 0)

  let ws = (wm ws)
  let root = ($ws | ws root | str replace $"($env.HOME)/" "")

  print $" (icon ' ') ($root)(ansi erase_line_from_cursor_to_end)"

  let branch = (git branch --show-current e> /dev/null | str trim)

  if ($branch | is-not-empty) {
    print $" (icon ' ') ($branch | str trim)(ansi erase_line_from_cursor_to_end)" 
  } 

  print --no-newline $" (icon '󰕮 ') ($ws | get name)(ansi erase_line_from_cursor_to_end)"
  print --no-newline (ansi clear_screen_from_cursor_to_end)
}
