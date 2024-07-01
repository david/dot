{ ... }: let
  colors = (import ./colors.nix);
in {
  programs.waybar = let
    fade = s: "<span foreground=\"${colors.light4}\">${s}</span>";
    disable = s: "<span foreground=\"${colors.dark4}\">${s}</span>";
    small = s: "<span size=\"small\">${s}</span>";
    pct = fade (small "%");
  in {
    enable = true;

    settings = {
      mainBar = {
        height = 20;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "battery"
          "cpu"
          "temperature"
          "language"
          "bluetooth"
          "network"
          "tray"
          "custom/sep"
        ];
        output = [ "DP-1" ];
        spacing = 16;

        battery = {
          format = "${fade "󰂑 "} {capacity}${pct}";
          format-discharging = "${fade "󰂌 "} {capacity}${pct}";
          format-charging = "${fade " "} {capacity}${pct}";
        };

        bluetooth = {
          format-connected = "󰂱";
          format-disabled = "󰂲";
          format-on= "󰂯";
          format-off= disable "󰂯";
        };

        clock = {
          format = "{:%a, %b %e  •  %H:%M}";
        };

        cpu = {
          format = "${fade " "} {usage}${pct}";
        };

        "custom/sep" = {
          format = "  ";
        };

        "hyprland/workspaces" = {
          format = "{name}";
        };

        memory = {
          format = "${fade "󰍛 "} {percentage}${pct}";
        };

        network = {
          format-disconnected = "󰖪 ";
          format-linked = "󱚵 ";
          format-wifi = "󰖩 ";
        };

        temperature = {
          format = "${fade "󰔏 "} {temperatureC}${fade (small "󰔄")} ";
        };

        tray = {
          spacing = 24;
        };
      };
    };

    style = ''
      * {
        font-family: "Symbols Nerd Font Mono", Cantarell;
        font-weight: bold;
      }
    '';

    systemd.enable = true;
  };
}
