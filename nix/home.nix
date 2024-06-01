{ config, pkgs, ... }: {
  dconf.settings = {
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = ["<Super>c"]; # Slack
      switch-to-application-2 = ["<Super>d"]; # Discord
      switch-to-application-3 = ["<Super>e"]; # Emacs
      switch-to-application-4 = ["<Super>w"]; # Browser
      switch-to-application-5 = ["<Super>v"]; # Video
      switch-to-application-6 = ["<Super>m"]; # Mail

      switch-input-source = ["<Shift><Control><Alt>semicolon"];
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

      trans-panel-opacity = "0.0";
      trans-use-custom-opacity = true;
    };
  };

  home.file = {
    "${config.xdg.dataHome}/backgrounds".source = ../backgrounds;
    "${config.xdg.dataHome}/fonts".source = ../fonts;
  };

  home.packages = with pkgs; [
    fd
    gnome.gnome-tweaks
    manix
    ripgrep
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

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: with epkgs; [
      alchemist
      avy
      centered-cursor-mode
      consult
      corfu
      diff-hl
      elixir-mode
      embark
      embark-consult
      envrc
      evil
      evil-cleverparens
      evil-collection
      evil-commentary
      evil-easymotion
      evil-goggles
      evil-indent-plus
      evil-matchit
      evil-surround
      flycheck
      forge
      general
      git-timemachine
      gruvbox-theme
      helpful
      inf-ruby
      lsp-mode
      lsp-ui
      magit
      marginalia
      nix-ts-mode
      orderless
      prodigy
      rainbow-delimiters
      rainbow-mode
      smartparens
      vertico
      treesit-grammars.with-all-grammars
      undo-fu
      undo-fu-session
      web-mode
      which-key
    ];
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
      { package = pkgs.gnomeExtensions.dash-to-panel; }
      { package = pkgs.gnomeExtensions.gsconnect; }
      { package = pkgs.gnomeExtensions.paperwm; }
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

  stylix.targets.emacs.enable = false;
}
