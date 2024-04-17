{
  description = "System flake";

  inputs = {
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle.url = "github:hyprwm/hypridle";
    hyprland.url = "github:hyprwm/hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";

    tree-sitter-nu = {
      url = "github:nushell/tree-sitter-nu";
      flake = false;
    };
  };

  outputs = {
    hm,
    hypridle,
    hyprlock,
    hyprpaper,
    neovim-nightly-overlay,
    nixos-hardware,
    nixpkgs,
    nixvim,
    tree-sitter-nu,
    ...
  }: let
    pvt = builtins.fromJSON (builtins.readFile ./private.json);

    user = pvt.user;
    work = pvt.work;

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [ neovim-nightly-overlay.overlay ];
    };
  in {
    nixosConfigurations = {
      timbuktu = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;

        modules = [
          ./nix/hardware-configuration.nix
          nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          ./nix/configuration.nix

          hm.nixosModules.home-manager {
            home-manager.sharedModules = [
              hypridle.homeManagerModules.default
              hyprlock.homeManagerModules.default
              hyprpaper.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${user.login} = { config, pkgs, ... }: let
              colors = {
                aquaBright    = "#8ec07c";
                aquaFaded     = "#427b58";
                aquaNeutral   = "#689d6a";

                black         = "#000000";

                blueBright    = "#83a598";
                blueFaded     = "#076678";
                blueNeutral   = "#458588";

                dark0Hard     = "#1d2021";
                dark0         = "#282828";
                dark0Soft     = "#32302f";
                dark1         = "#3c3836";
                dark2         = "#504945";
                dark3         = "#665c54";
                dark4         = "#7c6f64";

                gray          = "#928374";

                greenBright   = "#b8bb26";
                greenFaded    = "#79740e";
                greenNeutral  = "#98971a";

                light0Hard    = "#f9f5d7";
                light0        = "#fbf1c7";
                light0Soft    = "#f2e5bc";
                light1        = "#ebdbb2";
                light2        = "#d5c4a1";
                light3        = "#bdae93";
                light4        = "#a89984";

                limeGreen     = "#39ff14";

                orangeBright  = "#fe8019";
                orangeFaded   = "#af3a03";
                orangeNeutral = "#d65d0e";

                purpleBright  = "#d3869b";
                purpleFaded   = "#8f3f71";
                purpleNeutral = "#b16286";

                redBright     = "#fb4934";
                redFaded      = "#9d0006";
                redNeutral    = "#cc241d";

                white         = "#ffffff";

                yellowBright  = "#fabd2f";
                yellowFaded   = "#b57614";
                yellowNeutral = "#d79921";
              };
            in {
              gtk = {
                enable = true;

                cursorTheme = {
                  package = pkgs.gnome.adwaita-icon-theme;
                  name = "Adwaita";
                  size = 48;
                };

                iconTheme = {
                  package = pkgs.gnome.adwaita-icon-theme;
                  name = "Adwaita";
                };

                theme = {
                  package = pkgs.gruvbox-gtk-theme;
                  name = "Gruvbox-Dark-BL-LB";
                };
              };

              home.file = {
                ".local/bin/browse".source = ./bin/browse;
                ".local/bin/files".source = ./scripts/files.nu;
                ".local/bin/fz".source = ./scripts/fz.nu;
                ".local/bin/mediactl".source = ./scripts/mediactl.nu;
                ".local/bin/notifyctl".source = ./scripts/notifyctl.nu;
                ".local/bin/sys".source = ./scripts/sys.nu;
                ".local/bin/term".source = ./scripts/term.nu;
                ".local/bin/widgetctl".source = ./scripts/widgetctl.nu;
                ".local/bin/ws".source = ./scripts/ws.nu;

                ".config/nushell/scripts".source = ./scripts;
              };

              home.packages = with pkgs; [
                brave
                brightnessctl
                fd
                grimblast
                lazygit
                libnotify
                lutris
                manix
                netcat
                openshot-qt
                pamixer
                polkit_gnome
                playerctl
                ripgrep
                sound-theme-freedesktop
                vorbis-tools
                wl-clipboard
              ];

              home.pointerCursor = {
                gtk.enable = true;
                package = pkgs.gnome.adwaita-icon-theme;
                name = "Adwaita";
                size = 48;
              };

              home.stateVersion = "23.11";

              programs.bat.enable = true;

              programs.btop.enable = true;

              programs.carapace = {
                enable = true;
                enableNushellIntegration = true;
              };

              programs.direnv = {
                enable = true;
                enableNushellIntegration = true;
                nix-direnv.enable = true;
              };

              programs.firefox.enable = true;

              programs.fzf.enable = true;

              programs.gh = {
                enable = true;
                gitCredentialHelper.enable = true;
              };

              programs.git = {
                enable = true;
                delta.enable = true;
              };

              programs.hyprlock.enable = true;

              programs.kitty = {
                enable = true;

                font = {
                  name = "Iosevka Timbuktu";
                  size = 20;
                };

                keybindings = {
                  "super+o" = "load_config_file";
                  "super+equal" = "change_font_size all +1.0";
                  "super+minus" = "change_font_size all -1.0";
                };

                settings = {
                  background = colors.black;
                  background_opacity = "0.64";
                  cursor = colors.limeGreen;
                  cursor_blink_interval = 0;
                  disable_ligatures = "cursor";
                  enable_audio_bell = false;
                  forward_stdio = true;
                  remember_window_size = false;
                  scrollback_lines = 8192;
                  scrollback_pager_history_size = 256;
                  shell_integration = "no-title";
                  shell = "nu";
                  symbol_map = (
                    builtins.concatStringsSep "," [
                      "U+23FB-U+23FE"
                      "U+2500-U+259F"
                      "U+2665"
                      "U+26A1"
                      "U+2B58"
                      "U+E000-U+E00A"
                      "U+E0A0-U+E0A2"
                      "U+E0A3"
                      "U+E0B0-U+E0B3"
                      "U+E0B4-U+E0C8"
                      "U+E0CA"
                      "U+E0CC-U+E0D4"
                      "U+E200-U+E2A9"
                      "U+E300-U+E3E3"
                      "U+E5FA-U+E6B1"
                      "U+E700-U+E7C5"
                      "U+EA60-U+EBEB"
                      "U+F000-U+F2E0"
                      "U+F300-U+F372"
                      "U+F400-U+F532"
                      "U+F500-U+FD46"
                      "U+E276C-U+E2771"
                      "U+F0001-U+F1AF0"
                    ]
                  ) + " Symbols Nerd Font Mono";
                  visual_bell_duration = "0.25";
                  window_padding_width = 4;
                };

                theme = "Gruvbox Dark Hard";

                extraConfig = ''
                  symbol_map U+26A1 Noto Color Emoji
                '';
              };

              programs.nixvim = {
                enable = true;

                defaultEditor = true;

                clipboard.providers.wl-copy.enable = true;

                colorschemes.gruvbox = {
                  enable = true;

                  settings = {
                    overrides = {
                      NormalFloat = {
                        bg = "#1d2021";
                      };
                    };
                    transparent_mode = true;
                  };
                };

                extraPlugins = with pkgs.vimPlugins; [
                  (pkgs.vimUtils.buildVimPlugin {
                    name = "tree-sitter-nu";
                    src = tree-sitter-nu;
                  })

                  neodev-nvim
                  vim-repeat
                ];

                keymaps = let
                  options = {
                    silent = true;
                    noremap = true;
                  };
                in [
                  {
                    inherit options;
                    action = "q";
                    key = "m";
                  }
                  {
                    inherit options;
                    action = "<cmd>q<cr>";
                    key = "q";
                  }
                ];

                plugins = {
                  auto-save.enable = true;
                  cmp.enable = true;
                  cmp-buffer.enable = true;
                  cmp-cmdline.enable = true;
                  cmp-cmdline-history.enable = true;
                  cmp-git.enable = true;
                  cmp-path.enable = true;
                  comment.enable = true;

                  conform-nvim = {
                    enable = true;
                    formatOnSave = {
                      timeoutMs = 3000;
                      lspFallback = true;
                    };
                    formattersByFt = {
                      "_" = [ "trim_whitespace" ];
                    };
                  };

                  copilot-cmp.enable = true;

                  copilot-lua = {
                    enable = true;
                    panel.enabled = false;
                    suggestion.enabled = false;
                  };

                  direnv.enable = true;
                  endwise.enable = true;
                  fidget.enable = true;
                  gitsigns.enable = true;
                  leap.enable = true;
                  lint.enable = true;

                  lsp = {
                    enable = true;

                    servers = {
                      cssls.enable = true;
                      eslint.enable = true;

                      html = {
                        enable = true;
                        filetypes = [ "eruby" "html" ];
                      };

                      jsonls.enable = true;
                      lua-ls.enable = true;
                      nil_ls.enable = true;
                      nushell.enable = true;
                      solargraph.enable = true;
                      tailwindcss.enable = true;
                      tsserver.enable = true;
                    };
                  };

                  lspkind.enable = true;
                  noice.enable = true;
                  nvim-autopairs.enable = true;
                  nvim-colorizer.enable = true;
                  surround.enable = true;

                  treesitter = {
                    enable = true;

                    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars ++ [
                      (pkgs.tree-sitter.buildGrammar {
                        language = "nu";
                        version = tree-sitter-nu.rev;
                        src = tree-sitter-nu;
                      })
                    ];
                  };

                  treesitter-textobjects.enable = true;
                  which-key.enable = true;
                  yanky = {
                    enable = true;
                    ring.storage = "sqlite";
                  };
                };

                opts = {
                  autoread = true;
                  autowrite = true;
                  background = "dark";
                  backup = false;
                  clipboard = "unnamedplus";
                  completeopt = [ "menu" "menuone" "noinsert" "preview" ];
                  cursorline = true;
                  cursorlineopt = "both";
                  expandtab = true;
                  fileencoding = "utf-8";
                  foldmethod = "marker";
                  guifont = "Iosevka Timbuktu:h12";
                  hidden = true;
                  hlsearch = false;
                  ignorecase = true;
                  inccommand = "split";
                  incsearch = true;
                  laststatus = 0;
                  mouse = "";
                  numberwidth = 4;
                  relativenumber = true;
                  scrolloff = 999;
                  shiftwidth = 2;
                  smartcase = true;
                  splitbelow = true;
                  splitright = false;
                  swapfile = false;
                  termguicolors = true;
                  timeout = true;
                  timeoutlen = 300;
                  title = true;
                  titlestring = "%t";
                  undofile = true;
                  virtualedit = "block";
                };
              };

              programs.nushell = {
                enable = true;
                configFile.source = ./nushell/config.nu;
                envFile.source = ./nushell/env.nu;
              };

              services.hypridle = {
                enable = true;

                listeners = [
                  {
                    timeout = 300;
                    onTimeout = nixpkgs.lib.getExe config.programs.hyprlock.package;
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
                bg = builtins.head (map toString (nixpkgs.lib.filesystem.listFilesRecursive ./backgrounds));
              in {
                enable = true;
                preloads = [ bg ];
                wallpapers = [ "eDP-1,${bg}" ];
              };

              services.mako = {
                enable = true;

                anchor = "bottom-left";
                backgroundColor = colors.dark0Hard;
                borderColor = colors.dark0;
                borderRadius = 4;
                borderSize = 1;
                font = "Iosevka Timbuktu 16";
                height = 128;
                iconPath = "${pkgs.gnome.adwaita-icon-theme}/share/icons/Adwaita";
                margin = "16";
                maxVisible = 16;
                padding = "8";
                progressColor = colors.yellowNeutral;
                sort = "+time";
                textColor = colors.light1;
                width = 572;
              };

              wayland.windowManager.hyprland = let
                col = {
                  active = "rgba(${builtins.substring 1 7 colors.light2}ff)";
                  inactive = "rgba(${builtins.substring 1 7 colors.black}77)";
                  shadow = "rgba(${builtins.substring 1 7 colors.black}bb)";
                };

                spacing = 16;

                cellHeight = spacing * 2.94;

                gap = {
                  left = spacing * 38;
                  right = spacing * 38;
                };

                widget = {
                  x = spacing;
                  width = gap.left - (spacing * 2);
                };

                dateWidget = {
                  inherit (widget) x width;

                  y = spacing;
                  height = cellHeight;
                };

                sensorWidget = {
                  inherit (widget) x width;

                  y = dateWidget.y + dateWidget.height + spacing;
                  height = cellHeight;
                };

                desktopWidget = {
                  inherit (widget) x width;

                  y = sensorWidget.y + sensorWidget.height + spacing;
                  height = cellHeight * 2;
                };

                windowListWidget = {
                  inherit (widget) x width;

                  y = desktopWidget.y + desktopWidget.height + spacing;
                  height = cellHeight * 9;
                };
              in {
                enable = true;

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
                    "$s, slash, exec, ws.nu search --new-window"
                    "$s, 0, exec, notifyctl dismiss"
                    "$s, b, togglespecialworkspace, bugs"
                    "$s, c, togglespecialworkspace, chat"
                    "$s, d, togglespecialworkspace, devapp"
                    "$s, e, exec, ws.nu show dev"
                    "$s, f, exec, ws run files"
                    "$s, g, togglespecialworkspace, gitui"
                    "$s, h, movefocus, l"
                    "$s, j, changegroupactive, f"
                    "$s, k, changegroupactive, b"
                    "$s, l, movefocus, r"
                    "$s, n, exec, browse"
                    "$s, p, exec, ws.nu pull-request"
                    "$s, s, exec, ws run term"
                    "$s, r, exec, ws.nu services"
                    "$s, u, togglespecialworkspace, music"
                    "$s, v, togglespecialworkspace, video"
                    "$s, w, togglespecialworkspace, web"

                    "$ss, f, togglefloating"
                    "$ss, g, togglegroup"
                    "$ss, h, movewindoworgroup, l"
                    "$ss, j, movewindoworgroup, d"
                    "$ss, k, movewindoworgroup, u"
                    "$ss, l, movewindoworgroup, r"

                    "$sc, d, exec, ws.nu chdir"
                    "$sc, f, exec, ws.nu open"
                    "$sc, g, workspace, name:game"
                    "$sc, h, movefocus, l"
                    "$sc, j, movefocus, d"
                    "$sc, k, movefocus, u"
                    "$sc, l, movefocus, r"
                    "$sc, s, exec, ws.nu term new"

                    ("$cas, h, exec, " + builtins.concatStringsSep " && " [
                      "hyprctl keyword animation workspaces,1,3,default,slide"
                      "hyprctl dispatch workspace -1"
                    ])

                    ("$cas, j, exec, " + builtins.concatStringsSep " && " [
                      "hyprctl keyword animation workspaces,1,3,default,slidevert"
                      "hyprctl dispatch workspace +100"
                    ])

                    ("$cas, k, exec, " + (builtins.concatStringsSep " && " [
                      "hyprctl keyword animation workspaces,1,3,default,slidevert"
                      "hyprctl dispatch workspace -100"
                    ]))

                    ("$cas, l, exec, " + (builtins.concatStringsSep " && " [
                      "hyprctl keyword animation workspaces,1,3,default,slide"
                      "hyprctl dispatch workspace +1"
                    ]))

                    "$cas, q, killactive"

                    "$scas, e, exec, variety -t"
                    "$scas, h, movetoworkspace, -1"
                    "$scas, j, movetoworkspace, +100"
                    "$scas, k, movetoworkspace, -100"
                    "$scas, l, movetoworkspace, +1"
                    "$scas, q, exit"
                    "$scas, r, exec, variety -n"
                    "$scas, w, exec, variety -p"

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

                  binds = {
                    workspace_back_and_forth = true;
                  };

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
                    force_split = 1;
                    preserve_split = true;
                    pseudotile = true;
                  };

                  general = {
                    allow_tearing = false;

                    border_size = 3;

                    "col.active_border" = col.active;
                    "col.inactive_border" = col.inactive;
                    "col.nogroup_border" = col.inactive;
                    "col.nogroup_border_active" = col.active;

                    gaps_in = 8;
                    gaps_out = "16,608";

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

                  monitor = [ ", preferred, auto, 1"];

                  windowrulev2 = [
                    "float, class:^widget."
                    "noborder, class:^widget\\."
                    "nodim, class:^widget\\."
                    "nofocus, class:^widget\\."
                    "noshadow, class:^widget\\."
                    "pin, class:^widget\\."

                    "group override deny, class:menu"

                    "nodim, class:search-current"

                    "group override deny, class: ^brave-(app\\.slack|discord)\\.com"

                    "group override deny, class: ^filter$"

                    "group set always, class:(.)"
                  ] ++ [
                    # TODO: nix module?
                    "size ${toString dateWidget.width} ${toString dateWidget.height}, class:^widget\\.date"
                    "move ${toString dateWidget.x} ${toString dateWidget.y}, class:^widget\\.date"

                    "size ${toString sensorWidget.width} ${toString sensorWidget.height}, class:^widget\\.sensors"
                    "move ${toString sensorWidget.x} ${toString sensorWidget.y}, class:^widget\\.sensors"

                    "size ${toString desktopWidget.width} ${toString desktopWidget.height}, class:^widget\\.desktop"
                    "move ${toString desktopWidget.x} ${toString desktopWidget.y}, class:^widget\\.desktop"

                    "size ${toString windowListWidget.width} ${toString windowListWidget.height}, class:^widget\\.window-list"
                    "move ${toString windowListWidget.x} ${toString windowListWidget.y}, class:^widget\\.window-list"
                  ];

                  workspace = let
                    discord = "browse https://discord.com/channels/@me";
                    mail = "browse https://mail.google.com";
                    music = "browse https://music.youtube.com";
                    slack = "browse ${work.slack.url}";
                    video = "browse https://youtube.com";
                  in [
                    "name:game, on-created-empty: lutris"
                    "special:bugs, on-created-empty:browse, gapsout:16 16 16 604"
                    "special:chat, on-created-empty:${slack} & ${discord}, gapsout:48, gapsin:24"
                    "special:devapp, on-created-empty:browse, gapsout:16 16 16 604"
                    "special:gitui, on-created-empty:term --opacity 0.8 ws run lazygit, gapsout:16"
                    "special:mail, on-created-empty:${mail}, gapsout:96 480"
                    "special:music, on-created-empty:${music}, gapsout:96 480"
                    "special:video, on-created-empty:${video}, gapsout:96 480"
                    "special:plan, on-created-empty:browse, gapsout:16 16 16 604"
                    "special:web, on-created-empty:browse, gapsout:16 16 16 604"
                  ];
                };
              };

              xdg = {
                enable = true;
                mimeApps.enable = true;
              };
            };
          }
        ];
      };
    };
  };
}
