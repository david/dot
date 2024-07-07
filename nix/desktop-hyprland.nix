{ pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  programs.hyprlock.enable = true;
  programs.tofi.enable = true;

  services.hypridle = {
    enable = true;

    settings = {
      listener = [
        {
          timeout = 120;
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
        }

        {
          timeout = 240;
          onTimeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 480;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpaper.enable = true;

  services.mako = {
    enable = true;
    sort = "+time";
  };

  home.packages = [ pkgs.playerctl ];

  services.playerctld.enable = true;
}
