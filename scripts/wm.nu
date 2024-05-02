#!/usr/bin/env nu

export def main [] {}

export def --wrapped "main run-if-empty" [...command: string] {
  ws | ws if-empty { run-external ($command | first) ...($command | skip 1) }
}

export def events [] {
  nc -U $"/run/user/(id -u)/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock"
  | lines
  | split column >> name payload
}

export def focus [window: record] {
  hyprctl dispatch focuswindow $"address:($window.id)"
}

export def monitors [] {
  hyprctl monitors -j | from json
}

export def --wrapped run [
  --geometry: record<x: int, y: int, width: int, height: int>
  ...command
] {
  let rules = []
  | append [
    $"size ($geometry.width) ($geometry.height)"
    $"move ($geometry.x) ($geometry.y)"
  ]
  | str join ";"

  hyprctl dispatch exec $"[($rules)] ($command | str join ' ')"
}

export def win [--class: string] {
  if $class != null {
    ws | win list | where class == $class | append [null] | first
  } else {
    let id = (hyprctl activewindow -j | from json | default {} | get --ignore-errors address)

    if $id != null {
      ws | win list | where id == $id | append [null] | first
    }
  }
}

export def "win list" [] {
  let ws = $in
  let windows = hyprctl clients -j | from json

  if $ws != null {
    $windows | where workspace.id == $ws.id and pinned == false
  } else {
    $windows
  }
  | rename --column { address: "id" }
  | insert x { |e| $e.at | first }
  | insert y { |e| $e.at | last }
  | insert width { |e| $e.size | first }
  | insert height { |e| $e.size | last }
}

export def open [--above, block: closure] {
  let direction = if $above {
    "u"
  }

  hyprctl dispatch layoutmsg preselect $direction

  do $block
}

export def "win resize" [--height: int] {
  let window = $in

  hyprctl dispatch resizewindowpixel $"exact ($window.width) ($height),address:($window.id)" o> /dev/null
}

export def "win switch" [] {
  let window = $in

  hyprctl dispatch focuswindow $"address:($window.id)"
}

export def ws [--id (-i): string, --name (-n): string] {
  if $name != null {
    hyprctl workspaces -j
    | from json
    | where name == $name
    | append [{ name: $name, windows: 0 }]
    | first
  } else if $id != null {
    hyprctl workspaces -j
    | from json
    | where id == $id
    | append [{ name: $name, windows: 0 }]
    | first
  } else {
    hyprctl activeworkspace -j | from json
  }
}

export def "ws configure" [--gapsout (-g): any] {
  let ws = $in

  if $gapsout != null {
    let go = (
      match ($gapsout | describe) {
        "int" => $gapsout
        _ => { $gapsout | str join " " }
      }
    )

    hyprctl keyword workspace $"($ws.name), gapsout:($go)"
  }

  $ws
}

export def "ws list" [] {
  hyprctl workspaces -j | from json
}

export def "ws switch" [--name: string] {
  let ws = $in

  let ref = if $ws != null {
    $ws.id
  } else if $name != null {
    $"name:($name)"
  }

  hyprctl dispatch workspace $ref

  ws
}

export def "ws rename" [name: string] {
  let ws = $in;

  hyprctl dispatch renameworkspace $ws.id $name

  ws
}

export def "ws toggle" [] {
  let ws = $in

  hyprctl dispatch togglespecialworkspace ($ws | get name | str replace "special:" "")

  $ws
}

export def "ws if-empty" [command] {
  let ws = $in

  if ($ws | win list | is-empty) {
    do $command $ws
  }

  $ws
}

