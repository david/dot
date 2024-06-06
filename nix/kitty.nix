{ ... }: {
  programs.kitty = {
    enable = true;

    keybindings = {
      "super+o" = "load_config_file";
      "super+equal" = "change_font_size all +1.0";
      "super+minus" = "change_font_size all -1.0";
      "ctrl+shift+f" = "kitten hints --type=linenum --linenum-action=os_window nvim {path} +{line}";
    };

    settings = {
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      forward_stdio = true;
      hide_window_decorations = true;
      remember_window_size = false;
      scrollback_lines = 8192;
      scrollback_pager_history_size = 256;
      shell_integration = "no-title";

      symbol_map = (
        builtins.concatStringsSep "," [
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
        ]
      ) + " Symbols Nerd Font Mono";

      visual_bell_duration = "0.25";
      window_padding_width = "4";
    };

    extraConfig = ''
      symbol_map U+26A1 Noto Color Emoji
      background #101010
    '';
  };
}
