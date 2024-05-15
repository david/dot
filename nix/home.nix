{ colors, config, pkgs, ... }: {
  imports = [
    ./backgrounds.nix
    ./hyprland.nix
    ./kitty.nix
    ./neovim.nix
  ];

  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 48;
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-BL-LB";
    };
  };

  home.file = {
    ".local/bin/fz".source = ../scripts/fz.nu;
    ".local/bin/fz-open".source = ../scripts/fz-open.nu;
    ".local/bin/fz-grep".source = ../scripts/fz-grep.nu;
    ".local/bin/mediactl".source = ../scripts/mediactl.nu;
    ".local/bin/notifyctl".source = ../scripts/notifyctl.nu;
    ".local/bin/term".source = ../scripts/term.nu;
    ".local/bin/widget-bar".source = ../scripts/widget-bar.nu;
    ".local/bin/wm".source = ../scripts/wm.nu;
    ".local/bin/ws".source = ../scripts/ws.nu;

    ".config/nushell/scripts".source = ../scripts;

    "${config.xdg.dataHome}/backgrounds".source = ../backgrounds;
    "${config.xdg.dataHome}/fonts".source = ../fonts;
  };

  home.packages = with pkgs; [
    brave
    brightnessctl
    fd
    grimblast
    libnotify
    manix
    netcat
    openshot-qt
    pamixer
    polkit_gnome
    playerctl
    ripgrep
    sound-theme-freedesktop
    vorbis-tools
    wf-recorder
    wl-clipboard
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 48;
  };

  home.stateVersion = "23.11";

  programs.bat.enable = true;

  programs.btop.enable = true;

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: with epkgs; [
      avy
      centered-cursor-mode
      consult
      corfu
      embark
      embark-consult
      envrc
      evil
      evil-collection
      evil-matchit
      evil-surround
      general
      gruvbox-theme
      helpful
      lsp-mode
      magit
      nix-ts-mode
      orderless
      rainbow-delimiters
      vertico
      treesit-grammars.with-all-grammars
      undo-fu
      undo-fu-session
      which-key
    ];
  };

  programs.fzf.enable = true;

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

  programs.lazygit = {
    enable = true;

    settings = {
      disableStartupPopups = true; 

      git = {
        paging = {
          colorArg = "always";
          pager = "delta --paging=never";
        };
      };

      gui = {
        enlargedSideViewLocation = "top";
        nerdFontsVersion = "3";
        shortTimeFormat = "15:04";
        sidePanelWidth = 0.25;
        showCommandLog = false;
        showRandomTip = false;
        skipRewordInEditorWarning = true;
        skipStashWarning = true;
      };

      notARepository = "skip";

      update = {
        method = "never";
      };
    };
  };

  programs.nushell = {
    enable = true;
    configFile.source = ../nushell/config.nu;
    envFile.source = ../nushell/env.nu;
  };

  services.mako = {
    enable = true;

    anchor = "top-right";
    backgroundColor = colors.dark0Hard;
    borderColor = colors.dark0;
    borderRadius = 4;
    borderSize = 1;
    font = "Iosevka Timbuktu 16";
    height = 384;
    iconPath = "${pkgs.gnome.adwaita-icon-theme}/share/icons/Adwaita";
    margin = "16";
    maxVisible = 16;
    padding = "8";
    progressColor = colors.yellowNeutral;
    sort = "+time";
    textColor = colors.light1;
    width = 482;
  };

  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/http"         = "vivaldi.desktop";
        "x-scheme-handler/https"        = "vivaldi.desktop";
        "x-scheme-handler/chrome"       = "vivaldi.desktop";
        "text/html"                     = "vivaldi.desktop";
        "application/x-extension-htm"   = "vivaldi.desktop";
        "application/x-extension-html"  = "vivaldi.desktop";
        "application/x-extension-shtml" = "vivaldi.desktop";
        "application/xhtml+xml"         = "vivaldi.desktop";
        "application/x-extension-xhtml" = "vivaldi.desktop";
        "application/x-extension-xht"   = "vivaldi.desktop";
      };
    };
  };
}
