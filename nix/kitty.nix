{ config, ... }: {
  home.file."${config.xdg.configHome}/kitty/default-session.conf".text = ''
    launch --title=shell

    new_tab git
    launch direnv exec . lazygit

    new_os_window editor
    launch nvim
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

    keybindings = let
      focusWindow = title: "focus-window --match 'title:${title} and state:parent_active'";
      launch = title: command: "launch --title=${title} ${command}";
      remote = command: "launch --allow-remote-control sh -c \"${command}\"";
      editor = focusWindow "editor";
      shell = remote "kitten @ ${focusWindow "shell"} || kitten @ ${launch "shell" ""}";
    in {
      "super+comma" = "previous_tab";
      "super+period" = "next_tab";
      "super+shift+q" = "toggle_layout stack";
      "super+e" = "combine / goto_layout fat / ${editor}";
      "super+j" = "neighboring_window down";
      "super+k" = "neighboring_window up";
      "super+n" = "launch --type=tab --cwd=current";
      "super+o" = "load_config_file";
      "super+q" = "combine / next_window / goto_layout stack";
      "super+r" = "launch --allow-remote-control";
      "super+s" = "combine / goto_layout fat / ${shell}";
    };

    settings = {
      cursor_blink_interval = 0;
      startup_session = "default-session.conf";
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      enabled_layouts = "stack, fat:bias=60";
      forward_stdio = true;
      hide_window_decorations = true;
      inactive_text_alpha = "0.25";
      initial_window_height = "50c";
      initial_window_width = "166c";
      narrow_symbols = symbols;
      remember_window_size = false;
      scrollback_lines = 8192;
      scrollback_pager_history_size = 256;
      shell = "fish --login";
      symbol_map = symbols + " Symbols Nerd Font Mono";
      tab_bar_align = "center";
      tab_bar_edge = "top";
      tab_bar_margin_width = "0";
      tab_bar_margin_height = "4.0 0";
      tab_fade = "1";
      visual_bell_duration = "0.25";
      window_padding_width = "0";
    };

    extraConfig = ''
      symbol_map U+26A1 Noto Color Emoji
    '';
  };
}
