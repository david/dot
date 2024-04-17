#!/usr/bin/env nu

export-env {
  $env.SYS_PATH = $"($env.HOME)/sys"
}

export def prune [] {
  sudo nix-collect-garbage --delete-older-than 1d
  nix-collect-garbage --delete-older-than 1d
}

export def rebuild [] {
  sudo nixos-rebuild --flake $"path:($env.SYS_PATH)" switch
  widgetctl restart
}

export def update [] {
  nix flake update $"path:($env.SYS_PATH)"
}

export def upgrade [] {
  update
  rebuild
}
