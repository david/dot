{ lib, pkgs, ... }: let
  colors = (import ./colors.nix);
in {
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 300;
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
        }

        {
          timeout = 450;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        grace = 60;
      };

      background = [
        {
          color = "rgb(${colors.hex(colors.bg)})";
          blur_passes = 0;
        }
      ];

      input-field = [
        {
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(${colors.hex(colors.fg)})";
          halign = "center";
          hide_input = false;
          inner_color = "rgb(${colors.hex(colors.bg)})";
          monitor = "";
          outer_color = "rgb(${colors.hex(colors.fg)})";
          outline_thickness = 3;
          placeholder_text = "";
          position = "0, 10";
          shadow_size = 0;
          size = "200, 50";
          valign = "center";
        }
      ];
    };
  };

  programs.tofi.enable = true;

  services.hyprpaper.enable = true;

  services.mako = {
    enable = true;
    font = lib.mkForce "Cantarell 10, Symbols Nerd Font 10";
    sort = "+time";

    extraConfig = ''
      [app-name=which-key]
      anchor=bottom-right
      border-size=0
      format=%s\n%b
      group-by=app-name
      height=256
      margin=0
      markup=1
      outer-margin=0
      text-alignment=center
      width=384
    '';
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
