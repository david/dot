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
  let root = ($ws | ws meta | get --ignore-errors root)
  let wsid = $" ('󰕮 ' | fade) ($ws | ws meta | get name) "

  if $root != null {
    cd $root

    let wsnlen = 1 + 2 + 1 + ($ws | ws meta | get name | str length) + 1 # space, icon, space, id len, space
    let cols = (term size | get columns)
    let wsrlen = $cols - $wsnlen

    let wsroot = (
      $" (' ' | fade) ($root | str replace $"($env.HOME)/" "")"
      | strx truncate $wsrlen
      | fill --width $wsrlen
    )

    print $"($wsroot)($wsid)"
  } else {
    print $"($wsid)(ansi erase_line_from_cursor_to_end)"
  }

  let branch = (git branch --show-current e> /dev/null | str trim)

  if ($branch | is-not-empty) {
    print --no-newline $" (' ' | fade) ($branch | str trim)(ansi erase_line_from_cursor_to_end)"
  }

  print --no-newline (ansi clear_screen_from_cursor_to_end)
}
