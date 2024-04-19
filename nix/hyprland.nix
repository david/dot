{ colors, config, inputs, pkgs, ... }: let
  work = (builtins.fromJSON (builtins.readFile ../private.json)).work;

  browse = "vivaldi";
  browseApp = url: "vivaldi --app=${url}";

  col = {
    active = "rgba(${builtins.substring 1 7 colors.light2}ff)";
    inactive = "rgba(${builtins.substring 1 7 colors.black}77)";
    shadow = "rgba(${builtins.substring 1 7 colors.black}bb)";
  };

  spacing = 16;

  cellHeight = 38;

  gap = {
    left = spacing * 38;
    right = spacing * 38;
  };

  widget = {
    x = spacing + 2;
    width = gap.left - (spacing * 2) - 4;
  };

  dateWidget = {
    inherit (widget) x width;

    y = spacing;
    height = cellHeight + 4;
  };

  sensorWidget = {
    inherit (widget) x width;

    y = dateWidget.y + dateWidget.height;
    height = cellHeight + 4;
  };

  desktopWidget = {
    inherit (widget) x width;

    y = sensorWidget.y + sensorWidget.height + spacing;
    height = cellHeight + 4;
  };

  projectWidget = {
    inherit (widget) x width;

    y = desktopWidget.y + desktopWidget.height;
    height = cellHeight + 4;
  };

  windowListWidget = {
    inherit (widget) x width;

    y = projectWidget.y + projectWidget.height + spacing;
    height = cellHeight * 9;
  };

  discord = browseApp "https://discord.com/channels/@me";
  meet = browseApp "https://meet.google.com/landing?authuser=1";
  music = browseApp "https://music.youtube.com";
  slack = browseApp work.slack.url;
  video = browseApp "https://youtube.com";
in {
  programs.hyprlock.enable = true;

  services.hypridle = {
    enable = true;

    listeners = [
    {
      timeout = 300;
      onTimeout = pkgs.lib.getExe config.programs.hyprlock.package;
    }

    {
      timeout = 360;
      onTimeout = "hyprctl dispatch dpms off";
      onResume = "hyprctl dispatch dpms on";
    }

    {
      timeout = 600;
      onTimeout = "systemctl suspend";
    }
    ];
  };

  services.hyprpaper = let
    bg = builtins.head (map toString (pkgs.lib.filesystem.listFilesRecursive ../backgrounds));
  in {
    enable = true;
    preloads = [ bg ];
    wallpapers = [ "eDP-1,${bg}" "DP-1,${bg}" ];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    settings = {
      "$touchpad_enabled" = true;

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
        "$s, slash, exec, ws run fz-grep ui"
        "$s, semicolon, workspace, previous"

        "$s, 0, exec, notifyctl dismiss"

        "$s, c, togglespecialworkspace, slack"

        "$s, d, exec, ws switch devapp"
        "$s, d, exec, wm run-if-empty ${browse} http://localhost:3000"

        "$s, e, exec, ws switch code"
        "$s, e, exec, wm run-if-empty ws term nvim"

        "$s, f, exec, ws run fz-open ui"

        "$s, g, exec, ws switch gitui"
        "$s, g, exec, wm run-if-empty ws term lazygit"

        "$s, h, movefocus, l"
        "$s, j, changegroupactive, f"
        "$s, k, changegroupactive, b"
        "$s, l, movefocus, r"

        "$s, m, togglespecialworkspace, meet"

        "$s, n, exec, ${browse}"
        "$s, p, exec, term nvim $HOME/sys/plan.md"
        "$s, o, togglespecialworkspace, discord"
        "$s, s, exec, ws term"

        "$s, r, exec, ws switch services"
        "$s, r, exec, wm run-if-empty term ws services"

        "$s, u, togglespecialworkspace, music"
        "$s, u, exec, wm run-if-empty ${music}"

        "$s, v, workspace, name:video"
        "$s, v, exec, wm run-if-empty ${video}"

        "$s, w, exec, ws switch web"
        "$s, w, exec, wm run-if-empty ${browse}"

        "$ss, f, togglefloating"
        "$ss, g, togglegroup"
        "$ss, h, movewindoworgroup, l"
        "$ss, j, movewindoworgroup, d"
        "$ss, k, movewindoworgroup, u"
        "$ss, l, movewindoworgroup, r"

        "$sc, h, movefocus, l"
        "$sc, j, movefocus, d"
        "$sc, k, movefocus, u"
        "$sc, l, movefocus, r"
        "$sc, s, exec, ws term"

        "$cas, a, workspace, name:code%%${work.projects.current.root}"
        "$cas, g, workspace, name:game"

        ("$cas, h, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slide"
         "hyprctl dispatch workspace -1"
        ])

        ("$cas, j, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slidevert"
         "hyprctl dispatch workspace +100"
        ])

        ("$cas, k, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slidevert"
         "hyprctl dispatch workspace -100"
        ])

        ("$cas, l, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slide"
         "hyprctl dispatch workspace +1"
        ])

        "$cas, s, workspace, name:code%%$HOME/sys"
        "$cas, q, killactive"
        "$cas, w, exec, widgetctl toggle"

        "$scas, e, exec, variety -t"
        "$scas, h, movetoworkspace, -1"
        "$scas, l, movetoworkspace, +1"
        "$scas, q, exit"

        "$scs, f, fakefullscreen"
        "$scs, h, movegroupwindow, b"
        "$scs, j, movewindoworgroup, d"
        "$scs, k, movewindoworgroup, u"
        "$scs, l, movegroupwindow, f"
        "$scs, s, exec, kitty"

        "  , XF86AudioRaiseVolume, exec, mediactl vol up"
        "  , XF86AudioLowerVolume, exec, mediactl vol down"
        "  , XF86AudioMute, exec, mediactl vol mute"
        "$c, XF86AudioMute, exec, mediactl mic mute"
        "  , XF86AudioNext, exec, mediactl track next"
        "  , XF86AudioPrev, exec, mediactl track prev"
        "  , XF86AudioPlay, exec, mediactl track play-pause"

        "  , XF86MonBrightnessUp, exec, mediactl brightness up"
        "  , XF86MonBrightnessDown, exec, mediactl brightness down"
      ];

      bindm = [
        "$s, mouse:272, movewindow"
        # "$s, mouse:273, resizewindow"
      ];

      decoration = {
        rounding = 4;

        blur = {
          enabled = false;
          size = 16;
          passes = 2;
        };

        dim_inactive = true;
        dim_special = 0;

        drop_shadow = true;
        shadow_range = 16;
        shadow_render_power = 2;

        "col.shadow" = col.shadow;
      };

      dwindle = {
        default_split_ratio = 0.75;
        force_split = 1;
        preserve_split = true;
        pseudotile = true;
      };

      exec-once = [
        "widgetctl start"
      ];

      general = {
        allow_tearing = false;

        border_size = 3;

        "col.active_border" = col.active;
        "col.inactive_border" = col.inactive;
        "col.nogroup_border" = col.inactive;
        "col.nogroup_border_active" = col.active;

        gaps_in = 8;
        gaps_out = "16,16,16,608";

        layout = "dwindle";
      };

      gestures = {
        workspace_swipe = false;
      };

      group = {
        groupbar.enabled = false;

        "col.border_active" = col.active;
        "col.border_inactive" = col.inactive;
      };

      input = {
        kb_layout = "us";
        kb_variant = "intl";

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
      };

      monitor = [
        "eDP-1, 2880x1800, 0x0, 1"
        "DP-1, 1920x1080, 0x1800, 1"
      ];

      windowrulev2 = [
        "float, class:^widget."
        "noborder, class:^widget\\."
        "nodim, class:^widget\\."
        "nofocus, class:^widget\\."
        "noshadow, class:^widget\\."
        "pin, class:^widget\\."

        "group override deny, class:menu"
        "nodim, class:preview"

        "nodim, class:search-current"

        "group override deny, workspace:name:chat"

        "group set always, class:(.)"
      ] ++ [
        # TODO: nix module?
        "size ${toString dateWidget.width} ${toString dateWidget.height}, class:^widget\\.date"
        "move ${toString dateWidget.x} ${toString dateWidget.y}, class:^widget\\.date"

        "size ${toString sensorWidget.width} ${toString sensorWidget.height}, class:^widget\\.sensors"
        "move ${toString sensorWidget.x} ${toString sensorWidget.y}, class:^widget\\.sensors"

        "size ${toString desktopWidget.width} ${toString desktopWidget.height}, class:^widget\\.desktop"
        "move ${toString desktopWidget.x} ${toString desktopWidget.y}, class:^widget\\.desktop"

        "size ${toString projectWidget.width} ${toString projectWidget.height}, class:^widget\\.project"
        "move ${toString projectWidget.x} ${toString projectWidget.y}, class:^widget\\.project"

        "size ${toString windowListWidget.width} ${toString windowListWidget.height}, class:^widget\\.window-list"
        "move ${toString windowListWidget.x} ${toString windowListWidget.y}, class:^widget\\.window-list"
      ];

      workspace = let 
        gapY = spacing * 4;
        gapX = gap.left + (spacing * 2);
      in [
        "1, defaultName:code%%${work.projects.current.root}"
        "special:discord, gapsout:${toString gapY} ${toString gapX}, on-created-empty:${discord}"
        "special:slack, gapsout:${toString gapY} ${toString gapX}, on-created-empty:${slack}"
        "special:meet, on-created-empty:${meet}"
        "special:music, gapsout:${toString gapY} ${toString gapX}, on-created-empty:${music}"
      ];
    };
  };
}
