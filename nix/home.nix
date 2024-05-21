{ config, pkgs, ... }: {
  home.file = {
    "${config.xdg.dataHome}/backgrounds".source = ../backgrounds;
    "${config.xdg.dataHome}/fonts".source = ../fonts;
  };

  home.packages = with pkgs; [
    brave
    fd
    gnome.gnome-tweaks
    gnomeExtensions.backslide
    gnomeExtensions.paperwm
    manix
    ripgrep
    wf-recorder
    wl-clipboard
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  home.stateVersion = "23.11";


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
      flycheck
      forge
      general
      gruvbox-theme
      helpful
      lsp-mode
      magit
      marginalia
      mini-modeline
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

  stylix.targets.emacs.enable = false;
}
