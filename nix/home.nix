{ colors, config, inputs, pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./kitty.nix
  ];

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
    ".local/bin/files".source = ../scripts/files.nu;
    ".local/bin/fz".source = ../scripts/fz.nu;
    ".local/bin/mediactl".source = ../scripts/mediactl.nu;
    ".local/bin/notifyctl".source = ../scripts/notifyctl.nu;
    ".local/bin/sys".source = ../scripts/sys.nu;
    ".local/bin/term".source = ../scripts/term.nu;
    ".local/bin/widgetctl".source = ../scripts/widgetctl.nu;
    ".local/bin/ws".source = ../scripts/ws.nu;

    ".config/nushell/scripts".source = ../scripts;
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
       src = inputs.tree-sitter-nu;
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
          "eruby" = [ "trim_whitespace" ];
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
            version = inputs.tree-sitter-nu.rev;
            src = inputs.tree-sitter-nu;
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
      number = true;
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
    configFile.source = ../nushell/config.nu;
    envFile.source = ../nushell/env.nu;
  };

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

  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
      };
    };
  };
}
