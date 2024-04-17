#!/usr/bin/env nu

export def main [] {}

export def --wrapped "main run-if-empty" [...command: string] {
  ws | ws if-empty { run-external ($command | first) ...($command | skip 1) }
}

export def events [] {
  nc -U $"/tmp/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock" | lines | split column >> name payload
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
    win ls | where class == $class | append [null] | first
  } else {
    let id = (hyprctl activewindow -j | from json | default {} | get --ignore-errors address)

    if $id != null {
      win ls | where id == $id | append [null] | first
    }
  }
}

export def "win list" [] {
  let ws = $in

  hyprctl clients -j
  | from json
  | where workspace.id == $ws.id and pinned == false
}

export def "win ls" [--all] {
  let ws = $in | default (ws)

  hyprctl clients -j
  | from json
  | where $all or ($it.workspace != null and $it.workspace.id == $ws.id and $it.pinned == false)
  | rename --column { address: "id" }
  | insert x { |e| $e.at | first }
  | insert y { |e| $e.at | last }
  | insert width { |e| $e.size | first }
  | insert height { |e| $e.size | last }
  | select id class title workspace x y width height grouped pid
}

export def "win open" [--above, block: closure] {
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

export def "ws switch" [] {
  let ws = $in
  let id = ($ws | get --ignore-errors id)

  if $id == null or $id < 0 {
    hyprctl dispatch workspace $"name:($ws.name)"
  } else {
    hyprctl dispatch workspace $id
  }

  ws --name $ws.name
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

