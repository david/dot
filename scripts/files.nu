#!/usr/bin/env nu

use wm.nu

export def main [file?: path, ...rest] {
  let choice = (
    if $file == null {
      wm win open --above { term fz files csv }
    } else {
      $file
    }
  )

  if ($choice | str trim | is-not-empty)  {
    term --class nvim nvim $choice ...$rest
  }
}

export def "main csv" [] {
  fd --type f .
}
