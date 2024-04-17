#!/usr/bin/env nu

use wm.nu

const SEP = "%%"

export def main [] {}

export def "main find file" [] {
  let file = (run fz file)

  if $file != null { run nvim }
}

export def --wrapped "main run" [...command] {
  run ...$command
}

export def meta [] {
  let ws = $in

  $ws | get name | split column $SEP name root | first
}

export def --wrapped run [...command] {
  let root = (wm ws | meta | get --ignore-errors root)

  if $root != null { cd $root }

  # `run-external ...$command` doesn't work, but this does
  run-external ($command | first) ...($command | skip 1)
}
