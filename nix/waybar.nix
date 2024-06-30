{ ... }: let
  colors = (import ./colors.nix);
in {
  programs.waybar = let
    fade = s: "<span foreground=\"${colors.light4}\">${s}</span>";
    small = s: "<span size=\"small\">${s}</span>";
    pct = fade (small "%");
  in {
    enable = true;

    settings = {
      mainBar = {
        height = 20;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "bluetooth" "battery" "cpu" "temperature" "memory" "tray" ];
        output = [ "DP-1" ];
        spacing = 16;

        battery = {
          format = "${fade "󰂑 "} {capacity}${pct}";
          format-discharging = "${fade "󰂌 "} {capacity}${pct}";
          format-charging = "${fade " "} {capacity}${pct}";
        };

        clock = {
          format = "{:%a, %b %e  •  %H:%M}";
        };

        cpu = {
          format = "${fade " "} {usage}${pct}";
        };

        "hyprland/workspaces" = {
          active-only = true;
          format = "{name}";
        };

        memory = {
          format = "${fade "󰍛 "} {percentage}${pct}";
        };

        temperature = {
          format = "${fade "󰔏 "} {temperatureC}${fade (small "󰔄 ")} ";
        };
      };
    };

    style = ''
      * {
        font-family: "Symbols Nerd Font Mono", Cantarell;
        font-weight: bold;
      }

      #hyprland-workspaces {
        border: 0;
      }

      window#waybar {
        padding-left: 12px;
        padding-right: 12px;
      }
    '';

    systemd.enable = true;
  };
}
