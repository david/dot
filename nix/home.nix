{ config, inputs, pkgs, ... }: {
  imports = [
    ./gnome.nix
    # ./hyprdesktop.nix
    ./dev.nix
    ./terminal.nix
  ];

  home.file."${config.xdg.dataHome}/fonts".source = ../fonts;

  home.packages = with pkgs; [
    discord
    foot
    neovide
    slack
    vivaldi
    vivaldi-ffmpeg-codecs
    zoxide
  ] ++ [ inputs.neovim-nightly-overlay.packages.${pkgs.system}.default ];

  home.sessionVariables = {
    FLAKE = "/home/david/sys";
  };

  home.stateVersion = "23.11";

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
  };
}
