{ config, pkgs, ... }: let
  browser = "vivaldi";
  browserApp = url: "vivaldi --app=${url}";

  colors = (import ./colors.nix);

  workspacesPerGroup = 10;

  workspaces = {
    discord = { name = "discord"; };
    slack   = { name = "slack"; };
    video   = { name = "video"; };
  };

  groups = let
    dev = { icon = " "; index = 5; name = "dev"; };
    web = { icon = "󰖟 "; index = 6; name = "web"; };
    home = config.home.homeDirectory;

    mkWorkspaces = grpIndex: {
      dev = dev // {
        cmd = "${nvimHere} & ${kittyHere}";
        index = toString (dev.index + grpIndex);
      };

      web = web // {
        cmd = browser;
        index = toString (web.index + grpIndex);
      };
    };

    mkGroup = index: let
      i = workspacesPerGroup * index;
    in { index = i; } // mkWorkspaces i;
  in {
    sys = mkGroup 1 // {
      cwd = "${home}/sys";
      name = "sys";
    };

    ar = let
      g = mkGroup 2;
    in g // {
      cwd = "${home}/ar/trees/current";
      name = "ar";

      web = g.web // { cmd = railsApp; };
    };

    habitat = let
      g = mkGroup 3;
    in g // {
      cwd = "${home}/habitat";
      name = "habitat";

      web = g.web // { cmd = phxApp; };
    };

    ibms = let
      g = mkGroup 4;
    in g // {
      cwd = "${home}/ibms/trees/current";
      name = "ibms";

      web = g.web // { cmd = phxApp; };
    };
  };

  kittyHere = let
    wspg = toString workspacesPerGroup;
  in pkgs.writeShellScript "kitty-here" ''
    WORKSPACE=$(hyprctl activeworkspace -j | jq .id)
    WORKGROUP=$(( $WORKSPACE / ${wspg} * ${wspg} ))

    case $WORKGROUP in
    ${builtins.concatStringsSep ""
      (builtins.map (
        key: let
          group = groups.${key};
        in ''
          ${toString group.index})
            GNAME=${key}
            GCWD=${group.cwd}
            ;;
          ''
        ) (builtins.attrNames groups))}
    esac

    kitty --directory $GCWD --single-instance --instance-group $GNAME $*
  '';

  gitHere = "${kittyHere} lazygit";
  nvimHere = "${kittyHere} --class nvim-manual nvim";
  srvHere = "${kittyHere} direnv exec . nix run .#srv";

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
        "nvim",
        "kitty",
      ]
    '';
  };

  wayland.windowManager.hyprland = let
    activeColor = "rgba(${colors.hex colors.yellowBright}dd)";
    inactiveColor = "rgba(${colors.hex colors.light2}dd)";
    activeBorder = "${activeColor} rgba(${colors.hex colors.orangeBright}dd) 90deg";
    inactiveBorder = "${inactiveColor} rgba(${colors.hex colors.dark3}dd) 90deg";
  in {
    enable = true;

    settings = {
      animations = {
        enabled = true;

        animation = [
          "windows, 1, 5, default, popin 90%"
          "windowsMove, 1, 5, default, slide"
          "border, 1, 5, default"
          "borderangle, 1, 5, default"
          "fade, 1, 5, default"
          "layers, 1, 5, default, fade"
          "workspaces, 1, 3, default, slide"
          "specialWorkspace, 1, 3, default, slidevert"
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
        "$s, comma, changegroupactive, b"
        "$s, period, changegroupactive, f"
        "$s, semicolon, workspace, previous"

        "$s, c, togglespecialworkspace, ${workspaces.slack.name}"
        "$s, d, togglespecialworkspace, ${workspaces.discord.name}"
        "$s, e, exec, ${nvimHere}"
        "$s, g, exec, ${gitHere}"
        "$s, h, movefocus, l"
        "$s, j, movefocus, d"
        "$s, k, movefocus, u"
        "$s, l, movefocus, r"
        "$s, q, killactive"
        "$s, r, exec, ${srvHere}"
        "$s, s, exec, ${kittyHere}"
        "$s, v, togglespecialworkspace, ${workspaces.video.name}"
        "$s, w, togglespecialworkspace, ${workspaces.video.name}"

        "$ss, f, fullscreen"
        "$ss, g, togglegroup"
        "$ss, h, movewindoworgroup, l"
        "$ss, j, movewindoworgroup, d"
        "$ss, k, movewindoworgroup, u"
        "$ss, l, movewindoworgroup, r"

        "$sc, comma, workspace, -1"
        "$sc, period, workspace, +1"

        "$cas, i, workspace, ${groups.ar.dev.index}"
        "$cas, o, workspace, ${groups.habitat.dev.index}"
        "$cas, u, workspace, ${groups.sys.dev.index}"
        "$cas, y, workspace, ${groups.ibms.dev.index}"

        "$cas, comma, workspace, e-1"
        "$cas, period, workspace, e+1"

        "$cas, a, exec, tofi-drun | xargs hyprctl dispatch exec"

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

        "col.shadow" = "rgba(${colors.hex colors.dark1}cc)";

        dim_inactive = true;
        dim_strength = 0.05;
        dim_special = 0.33;

        drop_shadow = true;

        inactive_opacity = 0.9;

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

        "col.active_border" = activeBorder;
        "col.inactive_border" = inactiveBorder;
        "col.nogroup_border_active" = activeBorder;
        "col.nogroup_border" = inactiveBorder;

        gaps_in = gaps.inner;
        gaps_out = gaps.outer;

        layout = "dwindle";
      };

      gestures = {
        workspace_swipe = false;
      };

      group = {
        "col.border_active" = activeBorder;
        "col.border_inactive" = inactiveBorder;

        groupbar = {
          enabled = true;

          "col.active" = activeColor;
          "col.inactive" = inactiveColor;

          font_family = "Cantarell:style=Extra Bold";
          font_size = 10;
          height = 20;
          text_color = "rgb(${colors.hex colors.dark0})";
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
        "workspace special:slack, class:^(Slack)$"
        "workspace special:discord, class:^(discord)$"
        "group set always, class:^(kitty)$"
        "group set always, class:^(vivaldi-stable)$"
        "group new, class:^(nvim)$"
        "group set always, class:^(nvim-manual)$"
      ];

      workspace = [
        "special:${workspaces.discord.name}, gapsout:${toString gaps.chat.y} ${toString gaps.chat.x}"
        "special:${workspaces.slack.name}, gapsout:${toString gaps.chat.y} ${toString gaps.chat.x}"
        "special:${workspaces.video.name}, on-created-empty:${browserApp "https://youtube.com"}"
      ] ++ (
        builtins.concatMap (k: let
          g = groups.${k};
        in [
          "${g.dev.index}, defaultName:  ${g.name}, on-created-empty: ${g.dev.cmd}"
          "${g.web.index}, defaultName:󰖟  ${g.name}, on-created-empty: ${g.web.cmd}"
        ]) (builtins.attrNames groups)
      );
    };

    systemd.enable = true;
  };

  stylix.targets.hyprland.enable = false;
}
