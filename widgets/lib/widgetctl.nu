#!/usr/bin/env nu

use wm.nu

def main [] {}

export def start [widget] {
  term widget $widget.name
}

export def stop [widget] {
  kill $widget.pid
}

export def "list running" [] {
  wm win list
  | where class starts-with "widget."
  | insert name { |w| $w.class | str replace "widget." "" }
}

export def "list available" [] {
  # TODO: stop hardcoding the path here
  glob $"($env.HOME)/.local/share/widgets/widget-*.nu"
  | wrap path
  | insert name { |w| $w.path | path basename }
  | str replace --all --regex "(widget-|\\.nu)" "" name
}

export def "filter names" [names: list<string>] {
  filter { |w|
    if ($names | is-empty) {
      true
    } else {
      $names | any { |n| $n == $w.name }
    }
  }
}
