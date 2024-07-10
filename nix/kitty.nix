{ config, ... }: let
  denvx = "direnv exec .";

  nvimWindow = ''
    new_os_window
    os_window_class editor
    launch --cwd=current ${denvx} nvim '+Telescope find_files'
  '';

  phxServerWindow = ''
    new_os_window
    os_window_class shell
    launch --cwd=current ${denvx} nix run path:.#srv
  '';

  serversWindow = ''
    new_os_window
    os_window_class shell
    launch --cwd=current ${denvx} nix run path:.#srv
  '';

  shellWindow = ''
    os_window_class shell
    launch --cwd=current
  '';
in {
  home.file."${config.xdg.configHome}/kitty/sessions/sys.conf".text = ''
    ${shellWindow}
    ${nvimWindow}
  '';

  home.file."${config.xdg.configHome}/kitty/sessions/rails.conf".text = ''
    ${shellWindow}
    ${serversWindow}

    new_os_window
    os_window_class shell
    launch --cwd=current ${denvx} rails s

    ${nvimWindow}
  '';

  home.file."${config.xdg.configHome}/kitty/sessions/phx.conf".text = ''
    ${shellWindow}
    ${phxServerWindow}
    ${serversWindow}
    ${nvimWindow}
  '';

  programs.kitty = let
    symbols = builtins.concatStringsSep "," [
      "U+23FB-U+23FE"
      "U+2500-U+259F"
      "U+2665"
      "U+26A1"
      "U+2B58"
      "U+E000-U+E00A"
      "U+E0A0-U+E0A2"
      "U+E0A3"
      "U+E0B0-U+E0B3"
      "U+E0B4-U+E0C8"
      "U+E0CA"
      "U+E0CC-U+E0D4"
      "U+E200-U+E2A9"
      "U+E300-U+E3E3"
      "U+E5FA-U+E6B1"
      "U+E700-U+E7C5"
      "U+EA60-U+EBEB"
      "U+F000-U+F2E0"
      "U+F300-U+F372"
      "U+F400-U+F532"
      "U+F500-U+FD46"
      "U+E276C-U+E2771"
      "U+F0001-U+F1AF0"
    ];
  in {
    enable = true;

    keybindings = {
      "super+s" = "launch --cwd=current --type os-window --os-window-class shell";
    };

    settings = {
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      forward_stdio = true;
      hide_window_decorations = true;
      scrollback_lines = 8192;
      scrollback_pager_history_size = 256;
      shell = "fish --login";
      symbol_map = symbols + " Symbols Nerd Font Mono";
      visual_bell_duration = "0.25";
      window_padding_width = "4 6";
    };
  };

  stylix.targets.kitty.variant256Colors = true;
}
