#!/usr/bin/env nu

export def --wrapped main [...rest] {
  new ...$rest
}

export def --wrapped new [
  --cell-size: string
  --font-size: float
  --group: string
  --opacity: float
  --padding: int
  --remote
  ...rest
] {
  (
    kitty
      --override $"window_padding_width=($padding | default 0)"
      ...(
        if $opacity != null {
          [ --override dynamic_background_opacity=true --override $"background_opacity=($opacity)" ]
        } else {
          []
        }
      )
      ...(if $font_size != null { [ --override $"font_size=($font_size)" ] } else { [] })
      ...(if $cell_size != null { [--override $"modify_font cell_height ($cell_size)"] } else { [] })
      ...(if $group != null { [--instance-group $group --single-instance] } else { [] })
      ...(if $remote { [--override allow_remote_control=true] } else { [] })
      ...$rest
  )
}

export def fz [] {
  # TODO: remove full path to fz.nu
  new --class "filter" --font-size 18 --padding 8 bash -c $"exec ~/sys/scripts/fz.nu filter >&3 <&2"
}

export def widget [name: string] {
  (
    new
      # TODO: this should be close to the rest of the configuration in Nix
      --cell-size 140%
      --class $"widget.($name)"
      --detach
      --font-size 16
      --hold
      --padding 0
      --title $"widget.($name)"
      # TODO: remove full path to widget
      nu $"($env.HOME)/sys/scripts/widget-($name).nu"
  )
}

