{ config, pkgs, ... }: let
  ar = "${config.home.homeDirectory}/ar";
  hq = "${config.home.homeDirectory}/hq";
  ibms = "${config.home.homeDirectory}/ibms";
  sys = "${config.home.homeDirectory}/sys";

  denvx = "direnv exec . ";

  lazy = pkgs.writeShellScript "lazy" ''
    sleep 1

    PROMPT="Enter to run command, CTRL-C to quit: "
    PAD_X=$(( ( $COLUMNS - $( echo -n $PROMPT | wc -c ) ) / 2 ))
    PAD_Y=$(( ( $LINES / 2 ) - 2 ))

    clear

    tput cup $PAD_Y $PAD_X
    read -p "$PROMPT" || break

    clear

    $@
  '';

  repeatedly = pkgs.writeShellScript "repeatedly" ''
    while true ; do
      $@

      read -p "Enter to reload, CTRL-C to quit: " || break
    done
  '';

  default-session = cwd: let
    launch = "launch --cwd=${cwd}";
  in ''
    new_tab 
    ${launch}

    new_tab 
    ${launch} ${denvx} lazygit

    new_os_window editor
    ${launch} ${denvx} nvim
  '';

  rails-session = cwd: let
    launch = "launch --cwd=${cwd}";
  in ''
    new_tab 
    ${launch}

    new_tab 
    ${launch} ${denvx} lazygit

    new_tab   dev
    ${launch} ${lazy} ${repeatedly} ${denvx} rails console

    new_os_window editor
    ${launch} ${denvx} nvim
  '';

  phx-session = cwd: let
    launch = "launch --cwd=${cwd}";
  in ''
    new_tab 
    ${launch}

    new_tab 
    ${launch} ${denvx} lazygit

    new_tab 󰲌
    ${launch} ${repeatedly} ${denvx} iex -S mix phx.server

    new_tab 
    ${launch} ${repeatedly} ${denvx} postgres -D ../../data/postgres -k ../../tmp
  '';
in {
  home = {
    file."${ar}/session.conf".text = rails-session "${ar}/trees/current";
    file."${hq}/session.conf".text = phx-session "${hq}/trees/current";
    file."${ibms}/session.conf".text = phx-session "${ibms}/trees/current";
    file."${sys}/session.conf".text = default-session sys;
  };

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
      "super+comma" = "previous_tab";
      "super+period" = "next_tab";
      "super+shift+q" = "toggle_layout stack";
      "super+j" = "neighboring_window down";
      "super+k" = "neighboring_window up";
      "super+n" = "launch --type=tab --cwd=current";
      "super+o" = "load_config_file";
      "super+q" = "combine / next_window / goto_layout stack";
      "super+r" = "launch --allow-remote-control";
    };

    settings = {
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      enabled_layouts = "stack, fat:bias=60";
      forward_stdio = true;
      hide_window_decorations = true;
      inactive_text_alpha = "0.25";
      initial_window_height = "50c";
      initial_window_width = "117c";
      narrow_symbols = symbols;
      remember_window_size = false;
      scrollback_lines = 8192;
      scrollback_pager_history_size = 256;
      shell = "fish --login";
      symbol_map = symbols + " Symbols Nerd Font Mono";
      tab_bar_align = "left";
      tab_bar_edge = "top";
      tab_bar_margin_width = "4.0";
      tab_bar_margin_height = "4.0 0";
      tab_fade = "1";
      tab_title_template = "\"{title} \"";
      visual_bell_duration = "0.25";
      window_padding_width = "4";
    };

    extraConfig = ''
      active_tab_background #bdae93
      active_tab_foreground #1d2021
      inactive_tab_background #1d2021
      inactive_tab_foreground #504945
      symbol_map U+26A1 Noto Color Emoji
      tab_bar_background none
    '';
  };

  xdg.desktopEntries = {
    ar = {
      name = "AR";
      exec = "kitty --class ar --session ${ar}/session.conf";
    };

    ibms = {
      name = "IBMS";
      exec = "kitty --class ibms --session ${ibms}/session.conf";
    };

    hq = {
      name = "HQ";
      exec = "kitty --class hq --session ${hq}/session.conf";
    };

    sys = {
      name = "SYS";
      exec = "kitty --class sys --session ${sys}/session.conf";
    };
  };
}
