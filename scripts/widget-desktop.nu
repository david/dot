#!/usr/bin/env nu

use strx.nu
use widget.nu fade
use wm.nu
use ws.nu

def main [] {
  print --no-newline (ansi cursor_off)

  render

  wm events | where name == "workspace" | each { |e| render }
}

def render [] {
  print --no-newline (tput cup 0 0)

  let ws = (wm ws)
  let root = ($ws | ws root)

  cd $root

  let wsid = $" ('󰕮 ' | fade) ($ws | get name) "
  let wsnlen = 1 + 2 + 1 + ($ws | get name | into string | str length) + 1 # space, icon, space, id len, space

  let cols = (term size | get columns)
  let wsrlen = $cols - $wsnlen
  let wsroot = (
    $" (' ' | fade) ($root | str replace $"($env.HOME)/" "")"
    | strx truncate $wsrlen
    | fill --width $wsrlen
  )

  print $"($wsroot)($wsid)"

  let branch = (git branch --show-current e> /dev/null | str trim)

  if ($branch | is-not-empty) {
    print --no-newline $" (' ' | fade) ($branch | str trim)(ansi erase_line_from_cursor_to_end)"
  }

  print --no-newline (ansi clear_screen_from_cursor_to_end)
}
