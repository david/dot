{ lib, ... }: let
  colors = (import ./colors.nix);
in {
  programs.waybar = let
    fade = s: "<span foreground=\"${colors.light4}\">${s}</span>";
    disable = s: "<span foreground=\"${colors.dark4}\">${s}</span>";
    small = s: "<sub>${s}</sub>";
    pct = fade (small "%");
  in {
    enable = true;

    settings = {
      mainBar = {
        height = 20;

        modules-left = [
          "hyprland/workspaces"
          "battery"
          "cpu"
          "temperature"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "language"
          "bluetooth"
          "network"
          "tray"
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
          format = "{:%a, %b %e  ${fade "•"}  %H:%M}";
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

    style = lib.mkAfter ''
      * {
        font-family: "Symbols Nerd Font Mono", Cantarell;
        font-size: 13;
        font-weight: bold;
        padding: 0;
      }

      .modules-center #workspaces button,
      .modules-center #workspaces button.active,
      .modules-center #workspaces button.focused {
        border-bottom: 0;
      }

      .modules-left, .modules-right {
        padding: 8px 0;
      }

      .modules-left {
        padding: 0;
        padding-left: 0;
      }

      .modules-right {
        padding-right: 12px;
      }

      window#waybar {
        padding: 4px 16px;
      }

      #workspaces button {
        padding-right: 10px;
        padding-left: 10px;
      }

      #workspaces button.active {
        border-radius: 0;
        color: ${colors.bg};
        background-color: ${colors.fg};
      }
    '';

    systemd.enable = true;
  };
}
