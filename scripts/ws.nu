#!/usr/bin/env nu

use wm.nu

const SEP = "%%"

export def main [] {}

export def "main gitui" [] {
  let ws = wm ws
  let instance = (wm win list | where title == gitui and workspace.id == $ws.id)

  if ($instance | length) > 0 {
    wm focus ($instance | first)
  } else {
    run term --class gitui --title gitui lazygit
  }
}

export def "main grep" [] {
  run fz grep
}

export def "main switch" [name: string] {
  let root = (wm ws | meta | get --ignore-errors root)

  if $root != null {
    wm ws switch --name $"({ root: $root, name: $name } | into wm-name)"
  }
}

export def --wrapped "main run" [...command] {
  run ...$command
}

export def "main services" [] {
  run direnv exec . services
}

export def --wrapped "main term" [--class: string, ...command] {
  if ($command | is-empty) {
    term ...(if $class != null { [--class $class] } else { [] }) ws run nu
  } else {
    term ...(if $class != null { [--class $class] } else { [] }) ws run ...$command
  }
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

def "into wm-name" [] {
  let meta = $in

  $"($meta.name)($SEP)($meta.root)"
}
