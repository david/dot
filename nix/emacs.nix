{ pkgs, ... }: {
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
      nerd-icons
      nix-ts-mode
      orderless
      prodigy
      rainbow-delimiters
      rainbow-mode
      smartparens
      treesit-grammars.with-all-grammars
      vertico
      undo-fu
      undo-fu-session
      web-mode
    ];
  };

  stylix.targets.emacs.enable = false;
}
