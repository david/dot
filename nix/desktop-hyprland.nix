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
          on-timeout = "hyprctl dispatch dpms off";
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

  systemd.user = let
    changeBackground = let
      hyprpaper = "hyprctl hyprpaper";
    in pkgs.writeShellScript "change-background" ''
      set -eo pipefail

      FILE="$(fd . ${../backgrounds} | shuf --head-count 1)"

      ${hyprpaper} unload unused
      ${hyprpaper} preload $FILE
      ${hyprpaper} wallpaper "DP-1,$FILE"
    '';
  in {
    services.random-background = {
      Unit = {
        Description = "Background switcher";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = changeBackground;
        IOSchedulingClass = "idle";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };

    timers.random-background = {
      Unit = { Description = "Background switcher timer"; };
      Timer = { OnUnitActiveSec = "5m"; };
      Install = { WantedBy = [ "timers.target" ]; };
    };
  };
}
