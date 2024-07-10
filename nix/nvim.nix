  programs.nixvim = {
    enable = true;

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    colorschemes.gruvbox = {
      enable = true;

      settings = {
        overrides = {
          EndOfLine = { fg = "#282828"; };
          TelescopePreviewBorder = { fg = "#282828"; };
          TelescopePreviewNormal = { bg = "#282828"; };
          TelescopePromptBorder = { fg = "#504945"; };
          TelescopePromptNormal = { bg = "#504945"; };
          TelescopeResultsBorder = { fg = "#3c3836"; };
          TelescopeResultsNormal = { bg = "#3c3836"; };
          TelescopeSelection = { link = "Search"; };
          TelescopeSelectionCaret = { link = "GruvboxYellowBold"; };
          WinSeparator = { bg = "#282828"; fg = "#282828"; };
        };

        transparent_mode = true;
      };
    };

    defaultEditor = true;

    extraPlugins = with pkgs.vimPlugins; [
      neodev-nvim
      telescope-project-nvim
      vim-repeat
    ];

    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;
      mapleader = " ";
    };

    keymaps = let
      withDefaults = kms:
        map (km: {
          inherit (km) action key;

          options = {
            noremap = true;
            silent = true;
          };
        }) kms;
    in withDefaults [
      { key = "<leader><leader>"; action = "<cmd>nohlsearch<cr>"; }
      { key = "<leader>0";        action = "<C-w>q"; }
      { key = "<leader>1";        action = "<C-w>_"; }
      { key = "<leader>wh";       action = "<C-w>h"; }
      { key = "<leader>wj";       action = "<C-w>j"; }
      { key = "<leader>wk";       action = "<C-w>k"; }
      { key = "<leader>wl";       action = "<C-w>l"; }

      { key = "<c-,>";            action = "<cmd>bprevious<cr>"; }
      { key = "<c-.>";            action = "<cmd>bnext<cr>"; }
      { key = "<c-s>";            action = "<cmd>w<cr>=="; }

      { key = "[c";               action = "<cmd>cprevious<cr>"; }
      { key = "]c";               action = "<cmd>cnext<cr>"; }

      { key = "m";                action = "q"; }
      { key = "q";                action = "<cmd>bdelete<cr>"; }
    ];

    plugins = {
      auto-save.enable = true;

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "cmdline"; }
            { name = "cmdline-history"; }
            { name = "git"; }
            { name = "path"; }
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];
        };
      };

      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      cmp-cmdline-history.enable = true;
      cmp-git.enable = true;
      cmp-path.enable = true;
      comment.enable = true;
      diffview.enable = true;
      direnv.enable = true;
      endwise.enable = true;
      fidget.enable = true;
      git-conflict.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
      leap.enable = true;
      lint.enable = true;
      luasnip.enable = true;

      lsp = {
        enable = true;

        keymaps = {
          diagnostic = {
            "]e" = "goto_next";
            "[e" = "goto_prev";
          };

          lspBuf = {
            "K" = "hover";
            "gd" = "definition";
          };

          silent = true;
        };

        servers = {
          cssls.enable = true;

          elixirls = {
            enable = true;
            cmd = [ "elixir-ls" ];
            package = null;
          };

          eslint = {
            enable = true;
            package = null;
          };

          html = {
            enable = true;
            filetypes = [ "eruby" "html" ];
          };

          jsonls.enable = true;
          lua-ls.enable = true;
          nil-ls.enable = true;
          nushell.enable = true;

          solargraph = {
            enable = true;
            package = null;
          };

          tailwindcss = {
            enable = true;
            package = null;
          };

          tsserver = {
            enable = true;
            package = null;
          };

          yamlls.enable = true;
        };
      };

      lspkind = {
        enable = true;

        mode = "symbol";

        cmp.enable = true;
      };

      lualine = {
        enable = true;
      };

      mini = {
        enable = true;

        modules = {
          ai = {};
          align = {};
          splitjoin = {};
        };
      };

      neotest = {
        enable = true;

        adapters = {
          minitest.enable = true;
        };
      };

      nix.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      rainbow-delimiters.enable = true;
      schemastore.enable = true;
      statuscol.enable = true;
      surround.enable = true;

      telescope = {
        enable = true;

        enabledExtensions = [ "project" ];

        extensions = {
          file-browser.enable = true;
          fzf-native.enable = true;
        };

        keymaps = {
          "<leader>/" = {
            action = "live_grep";
            options = { desc = "search"; };
          };

          "<leader>hg" = {
            action = "highlights";
            options = { desc = "highlights"; };
          };

          "<leader>hh" = {
            action = "help_tags";
            options = { desc = "tags"; };
          };

          "<leader>f" = {
            action = "find_files";
            options = { desc = "find file"; };
          };

          "<d-f>" = {
            action = "buffers";
            options = { desc = "find buffer"; };
          };
        };

        settings = {
          defaults = {
            borderchars = [ "█" "█" "█" "█" "█" "█" "█" "█" ];

            layout_config = {
              vertical = {
                mirror = true;
                preview_height = 0.5;
                prompt_position = "top";
              };
            };

            layout_strategy = "vertical";

            prompt_prefix = "  ";
            selection_caret = "██";
            sorting_strategy = "ascending";
          };
        };
      };

      treesitter = {
        enable = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

        incrementalSelection.enable = true;
        indent = true;

        nixvimInjections = true;
      };

      treesitter-textobjects = {
        enable = true;

        lspInterop.enable = true;
        move.enable = true;
        select.enable = true;
        swap.enable = true;
      };

      trim.enable = true;

      toggleterm = {
        enable = true;

        settings = {
          open_mapping = "[[<d-s>]]";
          size = 16;
        };
      };

      trouble.enable = true;
      undotree.enable = true;
      which-key.enable = true;
    };

    opts = {
      autoindent = true;
      autoread = true;
      autowrite = true;
      background = "dark";
      backup = false;
      completeopt = [ "menu" "menuone" "noinsert" "preview" ];
      cursorline = true;
      cursorlineopt = "both";
      expandtab = true;
      fileencoding = "utf-8";
      foldmethod = "marker";
      guifont = "Iosevka Timbuktu:h12";
      hidden = true;
      hlsearch = true;
      ignorecase = true;
      inccommand = "split";
      incsearch = true;
      laststatus = 3;
      list = true;
      listchars = {
        tab = "⭾ ";
        trail = "󰈅";
        nbsp = "󱁐";
      };
      mouse = "";
      number = true;
      numberwidth = 4;
      relativenumber = true;
      scrolloff = 999;
      shiftwidth = 2;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = false;
      swapfile = false;
      termguicolors = true;
      timeout = true;
      timeoutlen = 300;
      title = true;
      titlestring = "%F";
      undofile = true;
      updatetime = 100;
      virtualedit = "block";
    };
  };
}
