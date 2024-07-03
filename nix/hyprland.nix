{ config, pkgs, ... }: let
  browser = "vivaldi";
  browserApp = url: "vivaldi --app=${url}";

  colors = (import ./colors.nix);

  wsChat = 1;
  wsVideo = 2;

  wsDev = 5;
  wsGit = 4;
  wsWeb = 6;

  groupSys  = 100;
  groupAr   = 200;
  groupIbms = 300;
  groupHq   = 400;

  groupWs = groupIndex: wsIndex: toString(groupIndex + wsIndex);

  sysWs  = groupWs groupSys;
  arWs   = groupWs groupAr;
  ibmsWs = groupWs groupIbms;
  hqWs   = groupWs groupHq;

  nextWs = ws:
    pkgs.writeShellScript "next-ws" ''
      set -eo pipefail

      CURR_WS=$(hyprctl activeworkspace -j | jq .id)
      NEXT_WS=$(( (($CURR_WS / 100) * 100) + ${toString(ws)}))

      hyprctl dispatch workspace $NEXT_WS
    '';

  phxApp   = "${browser} http://localhost:4000";
  railsApp = "${browser} http://localhost:3000";
in {
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

    rgba = c: "rgba(${colors.hex(c)}ee)";

    kitty = { class ? null, cmd ? "", cwd, session ? null }: let
      classOpt = if class != null then "--class ${class}" else "";
      sessionOpt = if session != null then
        "--session ${config.xdg.configHome}/kitty/sessions/${session}.conf"
      else
        "";
    in "kitty --directory ${cwd} ${classOpt} ${sessionOpt} ${cmd}";
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

        "$s, g, togglegroup"

        "$s, i, exec, ${nextWs wsDev}"
        "$s, u, exec, ${nextWs wsGit}"
        "$s, o, exec, ${nextWs wsWeb}"

        "$s, q, killactive"

        "$s,  h, movefocus, l"
        "$ss, h, movewindoworgroup, l"
        "$s,  j, movefocus, d"
        "$ss, j, movewindoworgroup, d"
        "$s,  k, movefocus, u"
        "$ss, k, movewindoworgroup, u"
        "$s,  l, movefocus, r"
        "$ss, l, movewindoworgroup, r"

        "$cas, period, workspace, +1"
        "$cas, comma, workspace, -1"

        "$cas, c, workspace, ${toString wsChat}"
        "$cas, v, workspace, ${toString wsVideo}"

        "$cas, u, workspace, ${sysWs wsDev}"
        "$cas, i, workspace, ${arWs wsDev}"
        "$cas, o, workspace, ${ibmsWs wsDev}"
        "$cas, p, workspace, ${hqWs wsDev}"

        "$scas, q, exit"

        ", Xf86AudioRaiseVolume , exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", Xf86AudioLowerVolume , exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", Xf86AudioMute , exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ", Xf86AudioPlay , exec, playerctl play-pause"
        ", Xf86AudioNext , exec, playerctl next"
        ", Xf86AudioPrev , exec, playerctl previous"
      ];

      bindm = [ "$s, mouse:272, movewindow" ];

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
        force_split = 2;
        preserve_split = true;
        pseudotile = true;
      };

      exec-once = [
        "slack"
        "discord"
        "hyprland-per-window-layout"
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
        "group set always, class:(vivaldi-stable)"
        "group deny, class:(editor)"
      ];

      workspace = [
        "1, defaultName:󰭹"
        "2, defaultName:󰗃, on-created-empty:${browserApp "https://youtube.com"}"

        "${sysWs wsGit}, default:true, defaultName:󰊢  sys, on-created-empty:${
          kitty { cwd = dirs.sys; class = "git"; cmd = "lazygit"; }
        }"
        "${sysWs wsDev}, default:true, defaultName:  sys, on-created-empty:${
          kitty { cwd = dirs.sys; session = "sys"; }
        }"
        "${sysWs wsWeb}, default:true, defaultName:󰖟  sys, on-created-empty:${railsApp}"

        "${arWs wsGit}, defaultName:󰊢  ar, on-created-empty:${
          kitty { cwd = dirs.ar; class = "git"; cmd = "lazygit"; }
        }"
        "${arWs wsDev}, defaultName:  ar, on-created-empty:${
          kitty { cwd = dirs.ar; session = "rails"; }
        }"
        "${arWs wsWeb}, defaultName:󰖟  ar, on-created-empty:${railsApp}"

        "${ibmsWs wsGit}, defaultName:󰊢  ibms, on-created-empty:${
          kitty { cwd = dirs.ibms; class = "git"; cmd = "lazygit"; }
        }"
        "${ibmsWs wsDev}, defaultName:  ibms, on-created-empty:${
          kitty { cwd = dirs.ibms; session = "phx"; }
        }"
        "${ibmsWs wsWeb}, defaultName:󰖟  ibms, on-created-empty:${phxApp}"

        "${hqWs wsGit}, defaultName:󰊢  hq, on-created-empty:${
          kitty { cwd = dirs.hq; class = "git"; cmd = "lazygit"; }
        }"
        "${hqWs wsDev}, defaultName:  hq, on-created-empty:${
          kitty { cwd = dirs.hq; session = "phx"; }
        }"
        "${hqWs wsWeb}, defaultName:󰖟  hq, on-created-empty:${phxApp}"
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
