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
