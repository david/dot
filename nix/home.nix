{ config, pkgs, ... }: {
  home.file = {
    "${config.xdg.dataHome}/backgrounds".source = ../backgrounds;
    "${config.xdg.dataHome}/fonts".source = ../fonts;
  };

  home.packages = with pkgs; [
    brave
    fd
    gnome.gnome-tweaks
    gnomeExtensions.paperwm
    gnomeExtensions.vitals
    gnomeExtensions.wallpaper-slideshow
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
      magit
      marginalia
      mini-modeline
      nerd-icons
      nix-ts-mode
      orderless
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

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  stylix.targets.emacs.enable = false;
}
