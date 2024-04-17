export def fade [] {
  let text: string = $in

  $"(ansi grey)($text)(ansi reset)"
}
