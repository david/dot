{ config, pkgs, ... }: {
  imports = [
    ./kitty.nix
    ./nvim.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super><Control><Alt><Shift>q" ];
      minimize = [ "<Control><Alt><Shift>q" ];
      move-to-workspace-left = [ "<Super><Control><Alt><Shift>comma" ];
      move-to-workspace-right = [ "<Super><Control><Alt><Shift>period" ];
      switch-to-workspace-left = [ "<Control><Alt><Shift>comma" ];
      switch-to-workspace-right = [ "<Control><Alt><Shift>period" ];
      cycle-windows = [ "<Control><Alt><Shift>l" ];
      cycle-windows-backward = [ "<Control><Alt><Shift>h" ];
    };
    };

    "org/gnome/mutter" = {
      center-new-windows = true;
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "burn-my-windows@schneegans.github.com"
        "dash-to-panel@jderose9.github.com"
        "gsconnect@andyholmes.github.io"
        "tactile@lundal.io"
        "Vitals@CoreCoding.com"
        "azwallpaper@azwallpaper.gitlab.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
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
      ];
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-positions = builtins.toJSON { "0" = "TOP"; };

      panel-element-positions = builtins.toJSON {
        "0" = [
          { element = "showAppsButton";   visible = false; position = "stackedTL"; }
          { element = "activitiesButton"; visible = true;  position = "stackedTL"; }
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

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Control><Alt><Shift>c" ]; # Slack
      switch-to-application-2 = [ "<Control><Alt><Shift>d" ]; # Discord
      switch-to-application-3 = [ "<Control><Alt><Shift>w" ]; # Browser
      switch-to-application-4 = [ "<Control><Alt><Shift>v" ]; # Video
      switch-to-application-5 = [ "<Control><Alt><Shift>m" ]; # Mail
      switch-to-application-6 = [ "<Control><Alt><Shift>u" ]; # AR
      switch-to-application-8 = [ "<Control><Alt><Shift>i" ]; # SYS
      switch-to-application-7 = [ "<Control><Alt><Shift>o" ]; # HQ

      switch-input-source = [ "<Control><Alt><Shift>Tab" ];
    };
  };

  home.file = {
    "${config.xdg.dataHome}/backgrounds".source = ../backgrounds;
    "${config.xdg.dataHome}/fonts".source = ../fonts;
  };

  home.packages = with pkgs; [
    discord
    fd
    gnome.gnome-tweaks
    manix
    ripgrep
    slack
    wf-recorder
    wl-clipboard
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  home.stateVersion = "23.11";

  programs.bash.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.firefox = let
    True = { Value = true; Status = "locked"; };
    False = { Value = false; Status = "locked"; };
  in {
    enable = true;

    policies = {
      DisablePocket = true;

      Preferences = {
        "browser.aboutConfig.showWarning" = False;
        "browser.sessionstore.resume_from_crash" = False;
        "browser.translations.automaticallyPopup" = False;
        "browser.toolbars.bookmarks.visibility" = False;
        "devtools.toolbox.host" = { Value = "window"; };
        "toolkit.legacyUserProfileCustomizations.stylesheets" = True;
      };
    };

    profiles.default = {
      id = 0;

      isDefault = true;

      userChrome = ''
        #TabsToolbar {
          display: none;
        }
      '';
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  programs.fzf = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;

    delta = {
      enable = true;

      options = {
        hyperlinks = true;
        line-numbers = true;
        navigate = true;
        side-by-side = true;
        true-color = "always";
      };
    };

    extraConfig = {
      diff = {
        colorMoved = true;
      };

      merge = {
        conflictstyle = "diff3";
      };
    };
  };

  programs.gnome-shell = {
    enable = true;

    extensions = [
      { package = pkgs.gnomeExtensions.burn-my-windows; }
      { package = pkgs.gnomeExtensions.dash-to-panel; }
      { package = pkgs.gnomeExtensions.gsconnect; }
      { package = pkgs.gnomeExtensions.tactile; }
      { package = pkgs.gnomeExtensions.vitals; }
      { package = pkgs.gnomeExtensions.wallpaper-slideshow; }
    ];
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  services.pueue = {
    enable = true;
  };

  stylix.targets = {
    gnome.enable = true;
    kitty.variant256Colors = true;
  };

  xdg.desktopEntries = {
    ar = {
      name = "AR";
      exec = "kitty --class ar --directory /home/david/ar/trees/current";
    };

    hq = {
      name = "HQ";
      exec = "kitty --class hq --directory /home/david/hq/trees/current";
    };

    sys = {
      name = "SYS";
      exec = "kitty --class sys --directory /home/david/sys";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
  };
}
