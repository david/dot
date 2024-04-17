#!/usr/bin/env nu

use strx.nu
use wm.nu

const padx_size = 1;

def main [] {
  render

  wm events | where $it =~ activewindowv2 | each { render }
}

def render [] {
  print --no-newline (ansi cursor_off)
  print --no-newline (tput cup 0 0)

  let ncols = (term size | get columns)
  let padx = ("" | fill --width $padx_size)
  let max_width = $ncols - ($padx_size * 2)

  let active = (wm win)
  let list = (wm win ls)

  let out = (
    $list
    | insert group { |e| $e.grouped | str join "," }
    | group-by group
    | values
    | each { |g|
      if ($g | is-not-empty) {
        $g | first | get grouped | each { |e|
          let win = ($list | where id == $e | first)

          if $win != null {
            let meta = match [$win.class, $win.title] {
              [_, $file] if ($file ends-with ".conf") => { icon: " ", fg: "yellow" }
              [_, $file] if ($file ends-with ".erb") => { icon: "󰗀 ", fg: "light_green" }
              [_, $file] if ($file ends-with ".js") => { icon: " ", fg: "yellow" }
              [_, $file] if ($file ends-with ".nix") => { icon: "󱄅 ", fg: "light_blue" }
              [_, $file] if ($file ends-with ".nu") => { icon: "nu", fg: "light_green" }
              [_, $file] if ($file ends-with ".rb") => { icon: " ", fg: "light_magenta" }
              ["kitty", _] => { icon: " ", fg: "default" }
              ["nvim", _]  => { icon: "󱃖 ", fg: "default" }
              _            => { icon: "  ", fg: "default" }
            }

            let title = [$meta.icon, $win.title]
            | str join " "
            | strx truncate $max_width
            | fill --width $max_width

            $"(ansi erase_line)(
              if $active != null and $win.id == $active.id {
                $"(ansi default_reverse)($padx)($title)($padx)(ansi reset)"
              } else {
                $"($padx)(ansi $meta.fg)($title)(ansi reset)($padx)"
              }
            )"
          }
        }
      }
    }
    | flatten
    | str join "\n"
  )

  print --no-newline $"($out)(ansi clear_screen_from_cursor_to_end)"
}
