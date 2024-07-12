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
    sys    = { index = 0;   name = "y"; defaultWs = "5"; cwd = "${home}/sys"; };
    ar     = { index = 100; name = "r"; defaultWs = "105"; cwd = "${home}/ar/trees/current"; };
    ibms   = { index = 200; name = "i"; defaultWs = "205"; cwd = "${home}/ibms/trees/current"; };
    hq     = { index = 300; name = "h"; defaultWs = "305"; cwd = "${home}/hq/trees/current"; };
    sys-ng = { index = 400; name = "n"; defaultWs = "405"; cwd = "${home}/sys-ng"; };
  };

  emacsHere = pkgs.writeShellScript "emacs-here" ''
    WORKSPACE=$(hyprctl activeworkspace -j | jq .id)
    WORKGROUP=$(( $WORKSPACE / 100 * 100 ))

    case $WORKGROUP in
      ${toString groups.sys.index}) ROOT=${groups.sys.cwd} ;;
      ${toString groups.ar.index}) ROOT=${groups.ar.cwd} ;;
      ${toString groups.ibms.index}) ROOT=${groups.ibms.cwd} ;;
      ${toString groups.hq.index}) ROOT=${groups.hq.cwd} ;;
      ${toString groups.sys-ng.index}) ROOT=${groups.sys-ng.cwd} ;;
    esac

    SOCKET="$(realpath --relative-base $HOME $ROOT | sed "s|/trees/current||")-current"

    cd $ROOT
    emacsclient --create-frame --alternate-editor "" --socket-name $SOCKET
  '';

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
      2 = [
        "editor",
        "git",
        "shell",
      ]
    '';
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

        "$sc, g, togglegroup"

        "$s, e, exec, ${nextWs} ${toString workspaces.perGroup.dev}"
        "$s, g, exec, ${nextWs} ${toString workspaces.perGroup.git}"
        "$s, w, exec, ${nextWs} ${toString workspaces.perGroup.web}"

        "$s, q, killactive"

        "$s,  h, movefocus, l"
        "$ss, h, movewindoworgroup, l"
        "$s,  j, movefocus, d"
        "$ss, j, movewindoworgroup, d"
        "$s,  k, movefocus, u"
        "$ss, k, movewindoworgroup, u"
        "$s,  l, movefocus, r"
        "$ss, l, movewindoworgroup, r"

        "$cas, comma, workspace, -1"
        "$cas, period, workspace, +1"
        "$cas, a, exec, tofi-drun | xargs hyprctl dispatch exec"

        "$cas, c, togglespecialworkspace, ${workspaces.slack.name}"
        "$cas, d, togglespecialworkspace, ${workspaces.discord.name}"
        "$cas, g, workspace, ${workspaces.palia.index}"
        "$cas, h, workspace, ${groups.hq.defaultWs}"
        "$cas, i, workspace, ${groups.ibms.defaultWs}"
        "$cas, n, workspace, ${groups.sys-ng.defaultWs}"
        "$cas, r, workspace, ${groups.ar.defaultWs}"
        "$cas, v, togglespecialworkspace, ${workspaces.video.name}"
        "$cas, y, workspace, ${wsIndex groups.sys "dev"}"

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
        kb_variant = "intl,";

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
        "special:${workspaces.discord.name}, gapsout:${toString gaps.chat.y} ${toString gaps.chat.x},"
        "special:${workspaces.slack.name}, gapsout:${toString gaps.chat.y} ${toString gaps.chat.x},"
        "special:${workspaces.video.name}, on-created-empty:${browserApp "https://youtube.com"}"

        "${wsIndex groups.sys "git"}, defaultName:${groups.sys.name}/g, on-created-empty:${kittyGit groups.sys.cwd}"
        "${wsIndex groups.sys "dev"}, defaultName:${groups.sys.name}/e, on-created-empty:${emacsHere}"
        "${wsIndex groups.sys "web"}, defaultName:${groups.sys.name}/w, on-created-empty:${browser}"

        "${wsIndex groups.ar "git"}, defaultName:${groups.ar.name}/g, on-created-empty:${kittyGit groups.ar.cwd}"
        "${wsIndex groups.ar "dev"}, defaultName:${groups.ar.name}/e, on-created-empty:${emacsHere}"
        "${wsIndex groups.ar "web"}, defaultName:${groups.ar.name}/w, on-created-empty:${railsApp}"

        "${wsIndex groups.ibms "git"}, defaultName:${groups.ibms.name}/g, on-created-empty:${kittyGit groups.ibms.cwd}"
        "${wsIndex groups.ibms "dev"}, defaultName:${groups.ibms.name}/e, on-created-empty:${emacsHere}"
        "${wsIndex groups.ibms "web"}, defaultName:${groups.ibms.name}/w, on-created-empty:${phxApp}"

        "${wsIndex groups.hq "git"}, defaultName:${groups.hq.name}/g, on-created-empty:${kittyGit groups.hq.cwd}"
        "${wsIndex groups.hq "dev"}, defaultName:${groups.hq.name}/e, on-created-empty:${emacsHere}"
        "${wsIndex groups.hq "web"}, defaultName:${groups.hq.name}/w, on-created-empty:${phxApp}"

        "${wsIndex groups.sys-ng "git"}, defaultName:${groups.sys-ng.name}/g, on-created-empty:${kittyGit groups.sys-ng.cwd}"
        "${wsIndex groups.sys-ng "dev"}, defaultName:${groups.sys-ng.name}/e, on-created-empty:${emacsHere}"
        "${wsIndex groups.sys-ng "web"}, defaultName:${groups.sys-ng.name}/w, on-created-empty:${phxApp}"
      ];
    };

    systemd.enable = true;
  };

  stylix.targets.bemenu.fontSize = 12;
  stylix.targets.hyprland.enable = false;
}
