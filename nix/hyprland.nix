{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    hyprland-per-window-layout
  ];

  home.file."${config.xdg.configHome}/hyprland-per-window-layout/options.toml" = {
    text = ''
      keyboards = [
        "zsa-technology-labs-ergodox-ez",
      ]

      [[default_layouts]]
      1 = [
        "Slack",
        "discord",
      ]
    '';
  };

  programs.hyprlock.enable = true;

  services.hypridle = {
    enable = true;

    settings = {
      listener = [
        {
          timeout = 120;
          on-timeout = pkgs.lib.getExe config.programs.hyprlock.package;
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

  wayland.windowManager.hyprland = let
    dirs = {
      ar = "${config.home.homeDirectory}/ar/trees/current";
      hq = "${config.home.homeDirectory}/hq/trees/current";
      ibms = "${config.home.homeDirectory}/ibms/trees/current";
      sys = "${config.home.homeDirectory}/sys";
    };

    browser = "vivaldi";
    browserApp = url: "vivaldi --app=${url}";
    colors = (import ./colors.nix);
    rgba = c: "rgba(${colors.hex(c)}bb)";

    terminal = { class ? null, cwd ? null, cmd ? null }: let
      classArg = if class != null then "--app-id=${class}" else "";
      cwdArg = if cwd != null then "--working-directory=${cwd}" else "";
      cmdArg = if cmd != null then "direnv exec . ${cmd}" else "";
    in "foot ${classArg} ${cwdArg} ${cmdArg}";

    shell = cwd: terminal { class = "shell"; cwd = cwd; };
    editor = cwd: terminal { class = "editor"; cmd = "nvim"; cwd = cwd; };
  in {
    enable = true;

    settings = {
      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 3, myBezier, popin 90%"
          "windowsOut, 1, 3, default, popin 90%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default, slide"
          "specialWorkspace, 1, 3, myBezier, slidevert"
        ];
      };

      "$c"    = "CONTROL";
      "$cas"  = "CONTROL ALT SHIFT";
      "$s"    = "SUPER";
      "$ss"   = "SUPER SHIFT";
      "$sc"   = "SUPER CONTROL";
      "$scas" = "SUPER CONTROL ALT SHIFT";
      "$scs"  = "SUPER CONTROL SHIFT";

      bind = [
        "$s, period, changegroupactive, f"
        "$s, comma, changegroupactive, b"

        "$s, c, workspace, 1"
        "$s, h, movefocus, l"
        "$s, j, movefocus, d"
        "$s, k, movefocus, u"
        "$s, l, movefocus, r"
        "$s, w, workspace, name:web"
        "$s, v, workspace, 2"

        "$sc, f, fullscreen"

        "$ss, g, togglegroup"
        "$ss, h, movewindoworgroup, l"
        "$ss, j, movewindoworgroup, d"
        "$ss, k, movewindoworgroup, u"
        "$ss, l, movewindoworgroup, r"

        "$cas, period, workspace, +1"
        "$cas, comma, workspace, -1"

        "$cas, c, workspace, 1"
        "$cas, v, workspace, 2"
        "$cas, i, workspace, 5"
        "$cas, u, workspace, 105"
        "$cas, o, workspace, 205"

        ("$cas, h, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slide"
         "hyprctl dispatch workspace -1"
        ])

        ("$cas, j, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slidevert"
         "hyprctl dispatch workspace +2"
        ])

        ("$cas, k, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slidevert"
         "hyprctl dispatch workspace -2"
        ])

        ("$cas, l, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slide"
         "hyprctl dispatch workspace +1"
        ])

        "$cas, q, killactive"
        "$cas, s, exec, ${terminal { class = "shell"; }}"
        "$cas, y, exec, ${browser}"

        "$scas, h, movetoworkspace, -1"
        "$scas, l, movetoworkspace, +1"
        "$scas, q, exit"
      ];

      bindm = [
        "$s, mouse:272, movewindow"
        # "$s, mouse:273, resizewindow"
      ];

      binds = {
        workspace_back_and_forth = true;
      };

      decoration = {
        rounding = 0;

        blur = {
          enabled = false;
          size = 16;
          passes = 2;
        };

        "col.shadow" = rgba colors.dark2;

        dim_inactive = true;
        dim_strength = 0.25;
        dim_special = 0.33;

        drop_shadow = true;

        shadow_offset = "1, 1";
        shadow_range = 12;
        shadow_render_power = 4;
      };

      dwindle = {
        force_split = 1;
        preserve_split = true;
        pseudotile = true;
      };

      exec-once = [
        "slack"
        "discord"
        "${pkgs.hyprland-per-window-layout}/bin/hyprland-per-window-layout"
      ];

      general = {
        allow_tearing = false;

        border_size = 3;

        "col.active_border" = rgba colors.orangeBright;
        "col.inactive_border" = rgba colors.dark0Hard;
        "col.nogroup_border_active" = rgba colors.orangeBright;
        "col.nogroup_border" = rgba colors.dark0Hard;

        gaps_in = 6;
        gaps_out = 12;

        layout = "dwindle";
      };

      gestures = {
        workspace_swipe = false;
      };

      group = {
        "col.border_active" = rgba colors.purpleBright;
        "col.border_inactive" = rgba colors.purpleFaded;

        groupbar = {
          enabled = true;

          "col.active" = rgba colors.purpleBright;
          "col.inactive" = rgba colors.purpleFaded;

          font_family = "Cantarell";
          font_size = 10;
          height = 22;
        };
      };

      input = {
        kb_layout = "us, us";
        kb_variant = ", intl";

        follow_mouse = 1;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = false;
        };

        sensitivity = 0;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        vrr = 1;
      };

      monitor = [
        "eDP-1, disabled"
        "DP-1, 1920x1080, 0x1800, 1"
      ];

      windowrulev2 = [
        "group set always, class:(shell)"
        "group set always, class:(shell)"
        "group deny, class:(editor)"
      ];

      workspace = [
        "1, name:chat"
        "2, name:video, on-created-empty:${browserApp "https://youtube.com"}"

        "4, default:true, name:git-sys, on-created-empty:${
          terminal { cwd = dirs.sys; class = "git"; cmd = "direnv exec . lazygit"; }
        }"
        "5, default:true, name: dev-sys, on-created-empty:${
          pkgs.writeShellScript "sys-session" ''
            ${editor dirs.sys} &
            sleep 0.5
            ${shell dirs.sys} &
          ''
        }"

        "105, default:true, name:dev-ar, on-created-empty:${
          pkgs.writeShellScript "ar-session" ''
            ${editor dirs.ar} &
            sleep 0.5
            ${shell dirs.ar} &
            ${terminal { cwd = dirs.ar; class = "shell"; cmd = "nix run .#srv"; }} &
          ''
        }"

        "204, default:true, name:git-ibms, on-created-empty:${
          terminal { cwd = dirs.ibms; class = "git"; cmd = "direnv exec . lazygit"; }
        }"
        "205, default:true, name:dev-ibms, on-created-empty:${
          pkgs.writeShellScript "ibms-session" ''
            ${editor dirs.ibms} &
            sleep 0.5
            ${shell dirs.ibms} &
            ${terminal { cwd = dirs.ibms; class = "shell"; cmd = "nix run .#srv"; }} &
            ${terminal { cwd = dirs.ibms; class = "shell"; cmd = "iex -S mix phx.server"; }} &
            ''
        }"
        "206, default:true, name:git-ibms, on-created-empty:${browser} http://localhost:4000"

        "305, default:true, name:dev-ibms, on-created-empty:${
          pkgs.writeShellScript "hq-session" ''
            ${editor dirs.hq} &
            sleep 0.5
            ${shell dirs.hq} &
            ${terminal { cwd = dirs.hq; class = "shell"; cmd = "iex -S mix phx.server"; }} &
          ''
        }"
      ];
    };

    systemd.enable = true;
  };

  stylix.targets.bemenu.fontSize = 12;
  stylix.targets.hyprland.enable = false;

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
