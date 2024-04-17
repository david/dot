#!/usr/bin/env nu

use wm.nu

export def main [] {
  next
}

export def next [] {
  let wp = (
    # TODO: replace with $XDG_DATA_HOME when I figure out how to make environment variables
    # defined in the configuration work with nushell
    ls ($env.HOME | path join .local share backgrounds)
    | shuffle
    | first
    | get name
    | path expand
  )

  hyprctl hyprpaper preload $wp

  wm monitors | each { |m|
    hyprctl hyprpaper wallpaper $"($m.name),($wp)"
  }
}
