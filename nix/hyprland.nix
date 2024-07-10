{ config, pkgs, ... }: let
  browser = "vivaldi";
  browserApp = url: "vivaldi --app=${url}";

  colors = (import ./colors.nix);

  workspaces = {
    perGroup = { dev = 5; git = 4; web = 6; };

    discord = { name = "󰙯"; };
    slack   = { name = ""; };
    video   = { name = ""; };
  };

  wsIndex = group: wsName:
    toString(group.index + workspaces.perGroup.${wsName});

    groups = let
    home = config.home.homeDirectory;
  in {
    sys    = { index = 0;   name = "y"; cwd = "${home}/sys"; };
    ar     = { index = 100; name = "r"; cwd = "${home}/ar/trees/current"; };
    ibms   = { index = 200; name = "i"; cwd = "${home}/ibms/trees/current"; };
    hq     = { index = 300; name = "h"; cwd = "${home}/hq/trees/current"; };
  };

  nextWs = pkgs.writeShellScript "next-ws" ''
    set -eo pipefail

    CURR_WS=$(hyprctl activeworkspace -j | jq .id)
    CURR_GRP=$(( $CURR_WS / 100 * 100 ))
    NEXT_WS=$(( $CURR_GRP + $1 ))

    hyprctl dispatch workspace $NEXT_WS
  '';

  phxApp   = "${browser} http://localhost:4000";
  railsApp = "${browser} http://localhost:3000";

  monitor = {
    xreal = { x = 1920; y = 1080; };
  };

  gaps = rec {
    outer = 12;
    inner = (outer / 2);

    chat = {
      x = (monitor.xreal.x / 4);
      y = (outer * 3);
    };
  };
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

  wayland.windowManager.hyprland = let
    rgba = c: "rgba(${colors.hex(c)}ee)";
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

        "$s, i, exec, ${nextWs} ${toString workspaces.perGroup.dev}"
        "$s, u, exec, ${nextWs} ${toString workspaces.perGroup.git}"
        "$s, o, exec, ${nextWs} ${toString workspaces.perGroup.web}"

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
        "$cas, a, exec, tofi-drun | xargs hyprctl dispatch exec"

        "$cas, c, togglespecialworkspace, ${workspaces.slack.name}"
        "$cas, d, togglespecialworkspace, ${workspaces.discord.name}"
        "$cas, v, togglespecialworkspace, ${workspaces.video.name}"

        "$cas, u, workspace, ${wsIndex groups.sys "dev"}"
        "$cas, i, workspace, ${wsIndex groups.ar "dev"}"
        "$cas, o, workspace, ${wsIndex groups.ibms "dev"}"
        "$cas, p, workspace, ${wsIndex groups.hq "dev"}"

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

        gaps_in = gaps.inner;
        gaps_out = gaps.outer;

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
        "workspace special:, class:(Slack)"
        "workspace special:󰙯, class:(discord)"
        "group set always, class:(shell)"
        "group set always, class:(vivaldi-stable)"
        "group deny, class:(editor)"
      ];

      workspace = let
        kitty = { class ? null, cmd ? "", cwd, session ? null }: let
          classOpt = if class != null then "--class ${class}" else "";
          sessionOpt =
            if session != null then
              "--session ${config.xdg.configHome}/kitty/sessions/${session}.conf"
            else
              "";
        in "kitty --directory ${cwd} ${classOpt} ${sessionOpt} ${cmd}";

        kittyGit = cwd: kitty { cwd = cwd; class = "git"; cmd = "lazygit"; };
        kittyDev = cwd: session: kitty { inherit cwd session; };
      in [
        "special:${workspaces.video.name}, on-created-empty:${browserApp "https://youtube.com"}"
        "special:${workspaces.slack.name}, gapsout:${toString gaps.chat.y} ${toString gaps.chat.x},"
        "special:${workspaces.discord.name}, gapsout:${toString gaps.chat.y} ${toString gaps.chat.x},"

        "${wsIndex groups.sys "git"}, defaultName:${groups.sys.name}/g, on-created-empty:${kittyGit groups.sys.cwd}"
        "${wsIndex groups.sys "dev"}, defaultName:${groups.sys.name}/e, on-created-empty:${kittyDev groups.sys.cwd "sys"}"
        "${wsIndex groups.sys "web"}, defaultName:${groups.sys.name}/w, on-created-empty:${browser}"

        "${wsIndex groups.ar "git"}, defaultName:${groups.ar.name}/g, on-created-empty:${kittyGit groups.ar.cwd}"
        "${wsIndex groups.ar "dev"}, defaultName:${groups.ar.name}/e, on-created-empty:${kittyDev groups.ar.cwd "rails"}"
        "${wsIndex groups.ar "web"}, defaultName:${groups.ar.name}/w, on-created-empty:${railsApp}"

        "${wsIndex groups.ibms "git"}, defaultName:${groups.ibms.name}/g, on-created-empty:${kittyGit groups.ibms.cwd}"
        "${wsIndex groups.ibms "dev"}, defaultName:${groups.ibms.name}/e, on-created-empty:${kittyDev groups.ibms.cwd "phx"}"
        "${wsIndex groups.ibms "web"}, defaultName:${groups.ibms.name}/w, on-created-empty:${phxApp}"

        "${wsIndex groups.hq "git"}, defaultName:${groups.hq.name}/g, on-created-empty:${kittyGit groups.hq.cwd}"
        "${wsIndex groups.hq "dev"}, defaultName:${groups.hq.name}/e, on-created-empty:${kittyDev groups.hq.cwd "phx"}"
        "${wsIndex groups.hq "web"}, defaultName:${groups.hq.name}/w, on-created-empty:${phxApp}"
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
