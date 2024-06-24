{ pkgs, ... }: {
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
      cycle-windows-backward = [ "<Control><Alt><Shift>Tab" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      workspace-names = [ "chat" "mail" "ar 1" "ar 2" "sys 1" "sys 2" "hq 1" "hq 2" "ibms 1" "ibms 2" ];
    };

    "org/gnome/mutter" = {
      center-new-windows = true;
      dynamic-workspaces = false;
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "azwallpaper@azwallpaper.gitlab.com"
        "burn-my-windows@schneegans.github.com"
        "dash-to-panel@jderose9.github.com"
        "gsconnect@andyholmes.github.io"
        "gTile@vibou"
        "Vitals@CoreCoding.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];

      favorite-apps = [
        "slack.desktop"
        "discord.desktop"
        "vivaldi-stable.desktop"
        "org.gnome.Geary.desktop"
        "ar.desktop"
        "sys.desktop"
        "hq.desktop"
        "ibms.desktop"
        "vivaldi-agimnkijcaahngcdmfeangaknmldooml-Default.desktop"
      ];
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "discord.desktop:1"
        "slack.desktop:1"
        "org.gnome.Geary.desktop:2"
        "ar.desktop:3"
        "sys.desktop:5"
        "hq.desktop:7"
        "ibms.desktop:9"
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

    "org/gnome/shell/extensions/gtile" = {
      autotile-1 = [ "<Shift><Control><Alt>8" ];
      autotile-gridspec-1 = "cols(1)";

      autotile-2 = [ "<Shift><Control><Alt>7" ];
      autotile-gridspec-2 = "cols(1d, 8, 1d)";

      autotile-3 = [ "<Shift><Control><Alt>9" ];
      autotile-gridspec-3 = "cols(9d, 11)";
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Control><Alt><Shift>c" ]; # Slack
      switch-to-application-2 = [ "<Control><Alt><Shift>d" ]; # Discord
      switch-to-application-3 = [ "<Control><Alt><Shift>w" ]; # Browser
      switch-to-application-4 = [ "<Control><Alt><Shift>m" ]; # Mail
      switch-to-application-5 = [ "<Control><Alt><Shift>u" ]; # AR
      switch-to-application-6 = [ "<Control><Alt><Shift>i" ]; # SYS
      switch-to-application-7 = [ "<Control><Alt><Shift>o" ]; # HQ
      switch-to-application-8 = [ "<Control><Alt><Shift>p" ]; # IBMS
      switch-to-application-9 = [ "<Control><Alt><Shift>v" ]; # Video

      switch-input-source = [ "<Control><Alt><Shift>Space" ];
    };
  };

  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs; [
      { package = gnomeExtensions.burn-my-windows; }
      { package = gnomeExtensions.dash-to-panel; }
      { package = gnomeExtensions.gsconnect; }
      { package = gnomeExtensions.gtile; }
      { package = gnomeExtensions.vitals; }
      { package = gnomeExtensions.wallpaper-slideshow; }
    ];
  };

  stylix.targets.gnome.enable = true;
}
