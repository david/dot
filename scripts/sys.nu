#!/usr/bin/env nu

export-env {
  $env.SYS_PATH = $"($env.HOME)/sys"
}

export def prune [] {
  sudo nix-collect-garbage --delete-older-than 1d
  nix-collect-garbage --delete-older-than 1d
}

export def reboot [] {
  systemctl reboot
}

export def rebuild [] {
  sudo nixos-rebuild --flake $"path:($env.SYS_PATH)" switch
}

export def update [] {
  nix flake update $"path:($env.SYS_PATH)"
}

export def upgrade [] {
  update
  rebuild
}

export def "glasses mode" [] {
  hyprctl keyword monitor "eDP-1, disabled"
}

export def "builtin mode" [] {
  hyprctl keyword monitor "eDP-1, 2880x1800, 0x0, 1"
}
