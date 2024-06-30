{ lib, pkgs, ... }: {
  home.packages = with pkgs.gnome; [ gnome-tweaks ];

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super><Control><Alt><Shift>q" ];
      minimize = [ "<Control><Alt><Shift>q" ];
      move-to-workspace-left = [ "<Super><Control><Alt><Shift>h" ];
      move-to-workspace-right = [ "<Super><Control><Alt><Shift>l" ];
      switch-to-workspace-left = [ "<Control><Alt><Shift>comma" ];
      switch-to-workspace-right = [ "<Control><Alt><Shift>period" ];
      cycle-windows = [ "<Control><Alt><Shift>apostrophe" ];
      cycle-windows-backward = [ "<Control><Alt>apostrophe" ];

      switch-input-source = [ "<Control><Alt><Shift>space" ];
      switch-input-source-backward = [ "<Control><Alt>space" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
      workspace-names = [ "chat" "net" "ar" "sys" "ibms" "hq" ];
    };

    "org/gnome/mutter" = {
      center-new-windows = true;
      dynamic-workspaces = false;
      overlay-key = [];
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "arcmenu@arcmenu.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
        "forge@jmmaranan.com"
        "gsconnect@andyholmes.github.io"
        "gTile@vibou"
        "Vitals@CoreCoding.com"
      ];

      favorite-apps = [
        "slack.desktop"
        "discord.desktop"
        "vivaldi-stable.desktop"
        "org.gnome.Geary.desktop"
        "ar.desktop"
        "sys.desktop"
        "ibms.desktop"
        "hq.desktop"
        "vivaldi-agimnkijcaahngcdmfeangaknmldooml-Default.desktop"
      ];
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [];
      menu-button-appearance = "None";
      runner-hotkey = [ "<Shift><Control><Alt>a" ];
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "discord.desktop:1"
        "slack.desktop:1"
        "vivaldi-stable.desktop:2"
        "org.gnome.Geary.desktop:2"
        "ar.desktop:3"
        "sys.desktop:4"
        "ibms.desktop:5"
        "hq.desktop:6"
      ];
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-positions = builtins.toJSON { "0" = "TOP"; };

      panel-element-positions = builtins.toJSON {
        "0" = [
          { element = "showAppsButton";   visible = false; position = "stackedTL"; }
          { element = "activitiesButton"; visible = false; position = "stackedTL"; }
          { element = "leftBox";          visible = true;  position = "stackedTL"; }
          { element = "taskbar";          visible = false; position = "stackedTL"; }
          { element = "dateMenu";         visible = true;  position = "centerMonitor"; }
          { element = "centerBox";        visible = true;  position = "stackedBR"; }
          { element = "rightBox";         visible = true;  position = "stackedBR"; }
          { element = "systemMenu";       visible = true;  position = "stackedBR"; }
          { element = "desktopButton";    visible = false; position = "stackedBR"; }
        ];
      };

      stockgs-keep-dash = true;

      trans-panel-opacity = "0.75";
      trans-use-custom-opacity = true;
    };

    "org/gnome/shell/extensions/forge" = {
      auto-split-enabled = false;
      float-always-on-top-enabled = false;
      focus-border-toggle = true;
      move-pointer-focus-enabled = true;
      preview-hint-enabled = false;
      quick-settings-enabled = true;
      showtab-decoration-enabled = true;
      stacked-tiling-mode-enabled = true;
      tabbed-tiling-mode-enabled = true;
      tiling-mode-enabled = true;
      window-gap-hidden-on-single = false;
      window-gap-size = lib.hm.gvariant.mkUint32 4;
      window-gap-size-increment = lib.hm.gvariant.mkUint32 2;
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = [];
      con-split-layout-toggle = [ "<Shift><Control><Alt>w" ];
      con-split-vertical = [];
      con-stacked-layout-toggle = [ "<Shift><Control><Alt>s" ];
      con-tabbed-layout-toggle = [ "<Shift><Control><Alt>t" ];
      con-tabbed-showtab-decoration-toggle = [];
      focus-border-toggle = [];
      prefs-open = [];
      prefs-tiling-toggle = [];
      window-focus-down = [ "<Shift><Control><Alt>j" ];
      window-focus-left = [ "<Shift><Control><Alt>h" ];
      window-focus-right = [ "<Shift><Control><Alt>l" ];
      window-focus-up = [ "<Shift><Control><Alt>k" ];
      window-gap-size-decrease = [];
      window-gap-size-increase = [];
      window-move-down = [];
      window-move-left = [];
      window-move-right = [];
      window-move-up = [];
      window-resize-bottom-decrease = [];
      window-resize-bottom-increase = [];
      window-resize-left-decrease = [];
      window-resize-left-increase = [];
      window-resize-right-decrease = [];
      window-resize-right-increase = [];
      window-resize-top-decrease = [];
      window-resize-top-increase = [];
      window-snap-center = [];
      window-snap-one-third-left = [];
      window-snap-one-third-right = [];
      window-snap-two-third-left = [];
      window-snap-two-third-right = [];
      window-swap-down = [ "<Super><Shift><Control><Alt>j" ];
      window-swap-left = [ "<Super><Shift><Control><Alt>h" ];
      window-swap-right = [ "<Super><Shift><Control><Alt>l" ];
      window-swap-up = [ "<Super><Shift><Control><Alt>k" ];
      window-swap-last-active = [];
      window-toggle-always-float = [];
      window-toggle-float = [];
      workspace-active-tile-toggle = [];
    };

    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = false;
      hot-sensors = ["_system_load_1m_" "__temperature_max__" "_memory_usage_" "_processor_usage_"];
      show-memory = true;
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Control><Alt><Shift>c" ]; # Slack
      switch-to-application-2 = [ "<Control><Alt><Shift>d" ]; # Discord
      switch-to-application-3 = [ "<Control><Alt><Shift>y" ]; # Browser
      switch-to-application-4 = [ "<Control><Alt><Shift>m" ]; # Mail
      switch-to-application-5 = [ "<Control><Alt><Shift>u" ]; # AR
      switch-to-application-6 = [ "<Control><Alt><Shift>i" ]; # SYS
      switch-to-application-7 = [ "<Control><Alt><Shift>o" ]; # IBMS
      switch-to-application-8 = [ "<Control><Alt><Shift>p" ]; # HQ
      switch-to-application-9 = [ "<Control><Alt><Shift>v" ]; # Video
      toggle-application-view = [];
    };
  };

  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs; [
      { package = gnomeExtensions.arcmenu; }
      { package = gnomeExtensions.dash-to-panel; }
      { package = gnomeExtensions.forge; }
      { package = gnomeExtensions.gsconnect; }
      { package = gnomeExtensions.vitals; }
    ];
  };

  stylix.targets.gnome.enable = true;

  systemd.user = let
    changeBackground = pkgs.writeShellScript "change-background" ''
      set -eo pipefail

      DCONF=${pkgs.dconf}/bin/dconf
      BASE=/org/gnome/desktop/background
      FILE="'file://$(fd . ${../backgrounds} | shuf --head-count 1)'"

      $DCONF write $BASE/picture-uri $FILE
      $DCONF write $BASE/picture-uri-dark $FILE
    '';

    interval = "5m";
  in {
    services.random-background = {
      Unit = {
        Description = "GNOME background switcher";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = changeBackground;
        IOSchedulingClass = "idle";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };

    timers.random-background = {
      Unit = { Description = "GNOME background switcher"; };
      Timer = { OnUnitActiveSec = interval; };
      Install = { WantedBy = [ "timers.target" ]; };
    };
  };
}
