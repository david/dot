#!/usr/bin/env nu

use wm.nu

export-env {
  $env.WS_STATE_FILE = $"($env.HOME)/.local/state/root-mappings.nuon"

  if not ($env.WS_STATE_FILE | path exists) {
    {} | save --force $env.WS_STATE_FILE
  }
}

export def main [] {}

export def "main chdir" [] {
  let dir = (wm win open --above { term fz ws roots csv })

  wm ws | root set ($dir | str trim)
}

export def --env "main roots csv" [] {
  [
    [name];
    [$"($env.HOME)/sys"]
  ]
  | append (glob $"($env.HOME)/work/*/trees/*" | each { |e| [ $e ] })
  | to csv --noheaders
}

export def --wrapped "main run" [...command] {
  run ...$command
}

export def id [] {
  (wm ws | get id) / 100 | into int
}

export def root [] {
  let ws = $in

  open $env.WS_STATE_FILE | get --ignore-errors $"($ws.id)" | default $env.HOME | path expand
}

export def "root set" [dir: path] {
  let ws = $in

  open $env.WS_STATE_FILE | merge { $"($ws.id)": $dir } | save --force $env.WS_STATE_FILE

  $ws
}

export def --wrapped run [...command] {
  cd (wm ws | root)

  # `run-external ...$command` doesn't work, but this does
  run-external ($command | first) ...($command | skip 1)
}
