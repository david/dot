#!/usr/bin/env nu

for b in (ls ~/sys/backgrounds) {
  hyprctl hyprpaper preload $b.name
  hyprctl hyprpaper wallpaper $"eDP-1,($b.name)"

  print $b.name

  kitten icat $b.name

  let keep = (input --numchar 1 "Keep? (y/N) ")

  if ($keep | str trim) != "y" {
    rm $b.name
    echo deleted
  }
}
