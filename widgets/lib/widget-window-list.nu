#!/usr/bin/env nu

use strx.nu
use widget.nu
use wm.nu

const PADX_SIZE = 1;
const SHORTCUT_SIZE = 3;
const SPACE_BTWN = 1;

def main [] {
  render

  wm events | where $it =~ activewindowv2 | each { render }
}

def render [] {
  print --no-newline (ansi cursor_off)

  let list = (wm win ls)

  window | widget resize --rows ($list | length)

  let ncols = (term size | get columns)
  let padx = ("" | fill --width $PADX_SIZE)
  let max_width = $ncols - ($PADX_SIZE * 2) - $SPACE_BTWN - $SHORTCUT_SIZE

  let active = (wm win)

  print --no-newline (tput cup 0 0)

  let out = (
    $list
    | insert group { |e| $e.grouped | str join "," }
    | group-by group
    | values
    | each { |g|
      if ($g | is-not-empty) {
        $g | first | get grouped | enumerate | each { |e|
          let win = ($list | where id == $e.item | first)

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

            let accel = if $e.index < 10 {
              $"[($e.index)]"
            } else {
              "   "
            }

            let str = if $active != null and $win.id == $active.id {
              $"(ansi default_reverse)($padx)($title) ($accel)($padx)(ansi reset)"
            } else {
              $"($padx)(ansi $meta.fg)($title) ($accel)(ansi reset)($padx)"
            }

            $"(ansi erase_line)($str)"
          }
        }
      }
    }
    | flatten
    | str join "\n"
  )

  print --no-newline $"($out)(ansi clear_screen_from_cursor_to_end)"
}

def window [] {
  widget window window-list
}
