{ config, pkgs, ... }: {
  imports = [
    ./desktop-hyprland.nix
    ./dev.nix
    ./nvim.nix
    ./terminal.nix
  ];

  home.file."${config.xdg.dataHome}/fonts".source = ../fonts;

  home.packages = with pkgs; [
    discord
    slack
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/home/david/sys";
    VISUAL = "nvim";
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
