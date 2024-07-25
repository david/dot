{ lib, pkgs, ... }: {
  home.packages = with pkgs; [ gnome-tweaks ];

  dconf.settings = {
    "org/gnome/Geary" = {
      run-in-background = true;
      single-key-shortcuts = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.gvariant.mkTuple ["xkb" "us"])
        (lib.gvariant.mkTuple ["xkb" "us+intl"])
      ];
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      minimize = [ "<Super><Shift>q" ];
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      switch-input-source-backward = [ "<Control><Alt>apostrophe" ];
      switch-input-source = [ "<Control><Alt><Shift>apostrophe" ];
      switch-to-workspace-left = [];
      switch-to-workspace-right = [];
    };

    "org/gnome/mutter" = {
      action-double-click-titlebar = "none";
      center-new-windows = true;
      dynamic-workspaces = true;
      overlay-key = [];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-temperature = lib.gvariant.mkUint32 4096;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [];
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "arcmenu@arcmenu.com"
        "gsconnect@andyholmes.github.io"
        "just-perfection-desktop@just-perfection"
        "paperwm@paperwm.github.com"
        "monitor@astraext.github.io"
        "trayIconsReloaded@selfmade.pl"
      ];

      favorite-apps = [
        "slack.desktop"
        "discord.desktop"
        "vivaldi-stable.desktop"
        "org.gnome.Geary.desktop"
      ];
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [];
      menu-button-appearance = "None";
      runner-hotkey = [ "<Super>a" ];
    };

    "org/gnome/shell/extensions/astra-monitor" = {
      panel-box = "left";
      panel-box-order = -1;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      animation = 4;
      notification-banner-position = 0;
      panel-indicator-padding-size = 16;
      startup-status = 0;
    };

    "org/gnome/shell/extensions/paperwm" = {
      default-focus-mode = 1;
      edge-preview-enabled = false;
      gesture-enabled = false;
      horizontal-margin = 16;
      selection-border-radius-top = 0;
      selection-border-size = 3;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      show-window-position-bar = false;
      vertical-margin = 16;
      vertical-margin-bottom = 16;
      window-gap = 16;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      center-horizontally = [];
      close-window = [ "<Super>q" ];
      move-down-workspace = [ "<Shift><Super>j" ];
      move-left = [ "<Shift><Super>h" ];
      move-right = [ "<Shift><Super>l" ];
      move-up-workspace = [ "<Shift><Super>k" ];
      new-window = [ "<Control><Alt><Shift>n" ];
      switch-down = [];
      switch-down-or-else-workspace = [ "<Super>j" ];
      switch-focus-mode = [];
      switch-left = [ "<Super>h" ];
      switch-next = [];
      switch-previous = [];
      switch-right = [ "<Super>l" ];
      switch-up = [];
      switch-up-or-else-workspace = [ "<Super>k" ];
      toggle-quick-settings = [];
    };

    "org/gnome/shell/extensions/paperwm/workspaces" = {
      list = [
        "3c8ab0fb-4c66-4abe-b5ed-f0f3e472c1e5"
        "f400ff65-87b6-4845-b0ce-f5127e7a5235"
        "21ee9f1a-dc96-40b0-bfaa-f20184fb76c1"
      ];
    };

    "org/gnome/shell/extensions/paperwm/workspaces/3c8ab0fb-4c66-4abe-b5ed-f0f3e472c1e5" = {
      directory = "/home/david/ar/trees/current";
      index = 0;
      name = "ar";
    };

    "org/gnome/shell/extensions/paperwm/workspaces/f400ff65-87b6-4845-b0ce-f5127e7a5235" = {
      directory = "/home/david/sys";
      index = 1;
      name = "sys";
    };

    "org/gnome/shell/extensions/paperwm/workspaces/21ee9f1a-dc96-40b0-bfaa-f20184fb76c1" = {
      directory = "/home/david/ibms/trees/current";
      index = 2;
      name = "ibms";
    };

    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = true;
      hot-sensors = [ "_battery_percentage_" "_processor_usage_" "_temperature_acpi_thermal zone_" ];
      icon-style = 1;
      show-battery = true;
      show-fan = false;
      show-memory = false;
      show-network = false;
      show-storage = false;
      show-system = false;
      show-voltage = false;
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      switch-to-application-1 = [ "<Super>c" ]; # Slack
      switch-to-application-2 = [ "<Super>d" ]; # Discord
      switch-to-application-3 = [ "<Super>w" ]; # Browser
      switch-to-application-4 = [ "<Super>m" ]; # Mail
      switch-to-application-9 = [ "<Super>v" ]; # Video
      toggle-application-view = [];
    };
  };

  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs; [
      { package = gnomeExtensions.arcmenu; }
      { package = gnomeExtensions.appindicator; }
      { package = gnomeExtensions.gsconnect; }
      { package = gnomeExtensions.just-perfection; }
      { package = gnomeExtensions.paperwm; }
      { package = gnomeExtensions.vitals; }
    ];
  };

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
