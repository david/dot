{ config, pkgs, ... }: let
  ar = "${config.home.homeDirectory}/ar";
  hq = "${config.home.homeDirectory}/hq";
  ibms = "${config.home.homeDirectory}/ibms";
  sys = "${config.home.homeDirectory}/sys";

  denvx = "direnv exec . ";

  repeatedly = pkgs.writeShellScript "repeatedly" ''
    while true ; do
      $@

      read -p "Enter to reload, CTRL-C to quit: " || break
    done
  '';

  lazy = pkgs.writeShellScript "lazy" ''
    COMMAND_COLOR="\033[1;32m"
    PROMPT_COLOR="\033[0;37m"
    NC="\033[0m"

    sleep 1

    COMMAND=$(echo "$*" | sed 's|${repeatedly} ||')
    COMMAND_PAD_X=$(( ( $COLUMNS - $( echo -n "$COMMAND" | wc -c ) ) / 2 ))
    COMMAND_PAD_Y=$(( ( $LINES / 2 ) - 3 ))

    PROMPT="Enter to run, CTRL-C to quit: "
    PROMPT_PAD_X=$(( ( $COLUMNS - $( echo -n "$PROMPT" | wc -c ) ) / 2 ))
    PROMPT_PAD_Y=$(( ( $LINES / 2 ) - 2 ))

    clear

    tput cup $COMMAND_PAD_Y $COMMAND_PAD_X
    echo -e "$COMMAND_COLOR$COMMAND"
    tput cup $PROMPT_PAD_Y $PROMPT_PAD_X
    echo -en "$PROMPT_COLOR$PROMPT$NC"
    read || break

    clear

    $@
  '';

  default-session = cwd: let
    launch = "launch --cwd=${cwd}";
  in ''
    new_tab 
    ${launch} ${repeatedly} ${denvx} lazygit

    new_tab
    ${launch} --title=󱃖  ${repeatedly} ${denvx} nvim
    focus
  '';

  rails-session = cwd: let
    launch = "launch --cwd=${cwd}";
  in ''
    ${default-session cwd}

    ${launch} --title=

    new_tab
    ${launch} --title=󰣆  ${repeatedly} ${denvx} rails server
    ${launch} --title=󰒋  ${repeatedly} ${denvx} nix run path:.#srv
  '';

  phx-session = cwd: let
    launch = "launch --cwd=${cwd}";
  in ''
  ${default-session cwd}

    ${launch} --title=󰢩  ${repeatedly} ${denvx} iex -S mix phx.server

    new_tab
    ${launch} --title=󰒋  ${repeatedly} ${denvx} nix run .#srv
  '';
in {
  home = {
    file."${ar}/session.conf".text = rails-session "${ar}/trees/current";
    file."${hq}/session.conf".text = phx-session "${hq}/trees/current";
    file."${ibms}/session.conf".text = phx-session "${ibms}/trees/current";
    file."${sys}/session.conf".text = ''
      ${default-session sys}

      launch --cwd=${sys} --title=
    '';
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
      "control+alt+shift+h" = "neighboring_window left";
      "control+alt+shift+j" = "neighboring_window down";
      "control+alt+shift+k" = "neighboring_window up";
      "control+alt+shift+l" = "neighboring_window right";
      "super+comma" = "previous_tab";
      "super+period" = "next_tab";
      "super+shift+q" = "toggle_layout stack";
      "super+a" = "remote_control focus-window --match 'title:^󰣆 '";
      "super+e" = "remote_control focus-window --match 'title:^󱃖 '";
      "super+g" = "remote_control focus-tab --match 'title:^ '";
      "super+h" = "neighboring_window left";
      "super+j" = "neighboring_window down";
      "super+k" = "neighboring_window up";
      "super+l" = "neighboring_window right";
      "super+n" = "launch --cwd=current";
      "super+s" = "remote_control focus-window --match 'title:^ '";
    };

    settings = {
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      draw_minimal_borders = true;
      enable_audio_bell = false;
      enabled_layouts = "tall:mirrored=true";
      forward_stdio = true;
      hide_window_decorations = true;
      inactive_text_alpha = "0.25";
      initial_window_height = "48c";
      initial_window_width = "230c";
      remember_window_size = false;
      scrollback_lines = 8192;
      scrollback_pager_history_size = 256;
      shell = "fish --login";
      symbol_map = symbols + " Symbols Nerd Font Mono";
      tab_bar_align = "center";
      tab_bar_edge = "top";
      tab_bar_margin_height = "6.0 6.0";
      tab_fade = "1";
      tab_title_template = "\"{title} \"";
      visual_bell_duration = "0.25";
      window_border_width = "2";
      window_padding_width = "4 6";
    };

    extraConfig = ''
      active_border_color #bdae93
      inactive_border_color #504945
      active_tab_background #1d2021
      active_tab_foreground #bdae93
      inactive_tab_background #1d2021
      inactive_tab_foreground #504945
      symbol_map U+26A1 Noto Color Emoji
      tab_bar_background none
    '';
  };

  xdg.desktopEntries = let
    kitty = name: dir:
      "kitty --class ${name} --single-instance --instance-group ${name} --session ${dir}/session.conf";
  in {
    ar = {
      name = "AR";
      exec = kitty "ar" ar;
    };

    ibms = {
      name = "IBMS";
      exec = kitty "ibms" ibms;
    };

    hq = {
      name = "HQ";
      exec = kitty "hq" hq;
    };

    sys = {
      name = "SYS";
      exec = kitty "sys" sys;
    };
  };
}
