#!/usr/bin/env nu

use strx.nu
use wm.nu
use ws.nu

const PADX_SIZE = 1;
const SHORTCUT_SIZE = 3;
const SPACE_BTWN = 1;

def "main ui" [] {
  (
    kitty
      +kitten panel
      --class "widget-bar"
      --override "background_opacity=0.48"
      --override "font_size=16"
      --override "modify_font cell_height 140%"
      --override "window_padding_width=8"
      --edge "left"
      --columns 43
      $env.PROCESS_PATH
  )
}

def --env main [] {
  sleep 0.1sec

  print -n (ansi cursor_off)

  [
    { time loop }
    { event loop }
  ] | par-each { |block| do $block }
}

def --env render [data] {
  let date = ($data | get -i date | default "")
  let battery = ($data | get -i battery | default "")
  let cpu = ($data | get -i cpu | default "")
  let temp = ($data | get -i temp | default "")
  let wifi = ($data | get -i wifi | default "")
  let wnd_list = ($data | get -i window-list | default "")
  let ws_branch = ($data | get -i workspace-branch | default "")
  let ws_name = ($data | get -i workspace-name | default "")
  let ws_root = ($data | get -i workspace-root | default "")

  if ($date | is-not-empty) { 
    print -n (tput cup 0 0) ($date | center) 
  }

  if ($battery | is-not-empty) {
    print -n (tput cup 1 0) ([$battery, $cpu, $wifi, $temp] | spread)
  }
  
  print -n (tput cup 2 0) (ansi erase_line_from_cursor_to_end)

  if ($ws_branch | is-not-empty) {
    print -n (tput cup 3 0) ([$ws_root, $ws_name] | spread)
    print -n (tput cup 4 0) ([$ws_branch, ""] | spread)
  }

  print -n (tput cup 5 0) (ansi erase_line_from_cursor_to_end)

  if ($wnd_list | is-not-empty) {
    print -n (tput cup 6 0) $wnd_list

    print -n (ansi clear_screen_from_cursor_to_end)
  }
}

def --env "event loop" [] {
  render {
    window-list: (window-list render)
    workspace-branch: (workspace branch render)
    workspace-name: (workspace name render)
    workspace-root: (workspace root render)
  }

  wm events | each { |e|
    match $e.name {
      "workspace" => {
        render {
          workspace-branch: (workspace branch render)
          workspace-name: (workspace name render)
          workspace-root: (workspace root render)
        }
      }
      "activewindowv2" => { 
        render { window-list: (window-list render) } 
      }
    } 
  }
}

def --env "time loop" [] {
  mut i = 0
  mut sensors = {}

  loop {
    render { date: (date render) }

    if ($i mod 2) == 0 {
      $sensors = ($sensors | merge { cpu: (cpu render) })
    }

    if ($i mod 5) == 0 {
      $sensors = ($sensors | merge { 
        battery: (battery render) 
        temp: (temp render) 
        wifi: (wifi render)
      })
    }

    render $sensors

    sleep 1sec
  }
}

def "battery render" [] {
  let charge = (
    dbus-send
      --system
      --print-reply=literal
      --dest=org.freedesktop.UPower
      /org/freedesktop/UPower/devices/battery_BAT0
      org.freedesktop.DBus.Properties.Get string:org.freedesktop.UPower.Device string:Percentage
      | str trim
        | split column --regex "\\s+"
        | get column3
        | first
        | into int
  )

  let state = (
    dbus-send
      --system
      --print-reply=literal
      --dest=org.freedesktop.UPower
      /org/freedesktop/UPower/devices/battery_BAT0
      org.freedesktop.DBus.Properties.Get string:org.freedesktop.UPower.Device string:State
      | str trim
        | split column --regex "\\s+"
        | get column3
        | first
        | into int
  )

  let icon = match $state {
    1 => "󱐋 "
    2 => "󰁹 "
    4 => "󰛨 "
    _ => $state
  }

  let pct = ($"($charge)" | fill --width 4 --character " ")

  if $charge < 25 {
    $"($icon) ($pct)" | yell
  } else if $charge < 50 {
    $"($icon) ($pct)" | warn
  } else {
    $"($icon | fade) ($pct | str replace '' ('' | fade))"
  }
}

def "cpu render" [] {
  let val = (sys | get cpu.cpu_usage | into int | math max)
  let pct = $"($val)" | fill --width 4 --character " "

  if $val > 90 {
    $"  ($pct)" | yell
  } else if $val > 50 {
      $"  ($pct)" | warn
  } else {
    $"(' ' | fade) ($pct | str replace "" ('' | fade))"
  }
}

def "date render" [] {
  date now | format date $"%a, %b %-e ("//" | fade) %H:%M"
}

def "temp render" [] {
  let val = (sys | get temp | where unit starts-with coretemp | get temp | into int | math max)

  $"('󰔏 ' | fade) ($val)('󰔄' | fade)"
}

def "wifi render" [] {
  let conn = (
    nmcli -g IN-USE,SIGNAL d wifi
    | lines
    | split column : in-use signal
    | where in-use == "*"

  )

  let val = if ($conn | is-not-empty) {
    $conn | first | get signal | into int
  }

  let pct = $"($val)" | fill --width 4 --character " "

  if ($val | is-empty) {
    "󱜡      "
  } else if $val < 25 {
    $"󱜠  ($pct)" | yell
  } else if $val < 50 {
    $"󱜠  ($pct)" | warn
  } else if $val < 75 {
    $"󱜠  ($pct)" | nudge
  } else {
    $"('󱜠 ' | fade) ($pct | str replace '' ('' | fade))"
  }
}

def "window-list render" [] {
  let list = (wm ws | wm win list)
  let root = (wm ws | ws meta | get -i root | default . | path expand | str replace $env.HOME ~)

  let ncols = (term size | get columns)
  let padx = ("" | fill --width $PADX_SIZE)
  let max_width = $ncols - ($PADX_SIZE * 2) - $SPACE_BTWN - $SHORTCUT_SIZE

  let active = (wm win)

  let out = (
    $list
    | insert group { |e| $e.grouped | str join "," }
    | group-by group
    | values
    | each { |g|
      if ($g | is-not-empty) {
        $g | first | get grouped | enumerate | each { |e|
          let win = ($list | where id == $e.item | first)

          mut title = ($win.title | str replace $"($root)/" "")

          $title = ($title | str replace $"($root)" ".")

          if $title != $win.title {
            let segments = $title | split row / | reverse

            if ($segments | length) > 1 {
              $title = $"($segments | first) ◀◀ ($segments | skip 1 | str join ' ◀ ')"
            }
          }

          if $win != null {
            let style = (style $win)
            let title_str = [$style.icon, $title]
            | str join " "
            | strx truncate $max_width
            | fill --width $max_width

            let accel = if $e.index < 10 {
              $"[($e.index)]"
            } else {
              "   "
            }

            let str = if $active != null and $win.id == $active.id {
              $"(ansi default_reverse)($padx)($title_str) ($accel)($padx)(ansi reset)"
            } else {
              $"($padx)(ansi $style.fg)($title_str) ($accel)(ansi reset)($padx)"
            }

            $"(ansi erase_line)($str)"
          }
        }
      }
    }
    | flatten
    | str join "\n"
  )

  if ($out | str trim | is-empty) {
    (" " | center)
  } else {
    $out  
  }
}

def "workspace branch render" [] {
  let ws = (wm ws)
  let root = ($ws | ws meta | get --ignore-errors root)

  if $root != null {
    cd $root

    let branch = (git branch --show-current e> /dev/null | str trim)

    if ($branch | is-not-empty) {
      $"(' ' | fade) ($branch | str trim)"
    } else {
      ""
    }
  }
}

def "workspace name render" [] {
  $"('󰕮 ' | fade) (wm ws | ws meta | get name)"
}

def "workspace root render" [] {
  let ws = (wm ws)
  let root = ($ws | ws meta | get --ignore-errors root)

  $"(' ' | fade) ($root | str replace $"($env.HOME)/" "")"
}

def style [window: record] {
  match [$window.class, $window.title] {
    [_, $file] if $file ends-with ".conf" => { icon: " ", fg: "yellow" }
    [_, $file] if $file ends-with ".erb"  => { icon: "󰗀 ", fg: "light_green" }
    [_, $file] if $file ends-with ".js"   => { icon: " ", fg: "yellow" }
    [_, $file] if $file ends-with ".nix"  => { icon: "󱄅 ", fg: "light_blue" }
    [_, $file] if $file ends-with ".nu"   => { icon: "nu", fg: "light_green" }
    [_, $file] if $file ends-with ".rb"   => { icon: " ", fg: "light_magenta" }
    ["kitty", _]                          => { icon: " ", fg: "default" }
    ["nvim", _]                           => { icon: "󱃖 ", fg: "default" }
    _                                     => { icon: "  ", fg: "default" }
  }
}

export def center [] {
  let text = $in
  let cols = term size | get columns

  $text | fill --alignment center --width $cols --character " "
}

export def spread [] {
  let strings: list<string> = $in

  let padding = 1;
  let cols = term size | get columns

  let used_space = ($padding * 2) + (
    $strings
    | each { |e| $e | ansi strip | str trim | str length --grapheme-clusters }
    | math sum
  )

  let pad = "" | fill --width $padding --character " "
  let gap_count = ($strings | length) - 1
  let free_space = $cols - $used_space
  let gap_size = $free_space / $gap_count | math floor
  let gap_offset = $free_space - ($gap_size * $gap_count)
  let content = (
    $strings
    | drop
    | each { |e| $"($e)('' | fill --width $gap_size --character ' ')" }
    | append [ ("" | fill --width $gap_offset --character " ") ($strings | last) ]
    | str join ""
  )

  $"($pad)($content)($pad)"
}

export def fade [] {
  let text: string = $in

  $"(ansi grey)($text)(ansi reset)"
}

export def nudge [] {
  let text: string = $in

  $"(ansi light_yellow)($text)(ansi reset)"
}

export def yell [] {
  let text: string = $in

  $"(ansi red)($text)(ansi reset)"
}

export def warn [] {
  let text: string = $in

  $"(ansi yellow)($text)(ansi reset)"
}
