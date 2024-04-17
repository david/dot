use widgetctl.nu
use wm.nu

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
