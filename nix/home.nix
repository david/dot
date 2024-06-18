{ config, pkgs, ... }: {
  imports = [
    ./gnome.nix
    ./kitty.nix
    ./nvim.nix
  ];

  home.file = {
    "${config.xdg.dataHome}/backgrounds".source = ../backgrounds;
    "${config.xdg.dataHome}/fonts".source = ../fonts;
  };

  home.packages = with pkgs; [
    discord
    fd
    ripgrep
    slack
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
