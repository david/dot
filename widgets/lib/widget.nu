use widgetctl.nu
use wm.nu

export def render [] {
  let $out = $in

  print --no-newline $"(ansi cursor_off)(tput cup 0 0)($out)(ansi erase_line_from_cursor_to_end)"
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

export def resize [--rows: int] {
  $in | wm win resize --height (if $rows == 1 { 40 } else { 38 * $rows })
}

export def yell [] {
  let text: string = $in

  $"(ansi red)($text)(ansi reset)"
}

export def warn [] {
  let text: string = $in

  $"(ansi yellow)($text)(ansi reset)"
}

export def window [name: string] {
  widgetctl list running | widgetctl filter names [$name] | first
}
