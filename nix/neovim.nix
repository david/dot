{ inputs, pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    defaultEditor = true;

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

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
      { key = "<c-k>";            action = "<cmd>m-2<cr>=="; }
      { key = "<c-j>";            action = "<cmd>m+1<cr>=="; }
      { key = "<c-j>";            action = "<cmd>m+1<cr>=="; }

      { key = "m";                action = "q"; }
      { key = "q";                action = "<cmd>q<cr>"; }
    ];

    plugins = {
      auto-save.enable = true;

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings = {
          sources = [
            { name = "buffer"; }
            { name = "cmdline"; }
            { name = "cmdline-history"; }
            { name = "git"; }
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
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
      luasnip.enable = true;

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
          # solargraph.enable = true;
          tailwindcss.enable = true;
          tsserver.enable = true;
        };
      };

      lspkind = {
        enable = true;

        mode = "symbol";

        cmp.enable = true;
      };

      mini = {
        enable = true;

        modules = {
          align = {};
        };
      };

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
      trouble.enable = true;
      which-key.enable = true;
      yanky = {
        enable = true;
        ring.storage = "sqlite";
      };
    };

    opts = {
      autoindent = true;
      autoread = true;
      autowrite = true;
      background = "dark";
      backup = false;
      colorcolumn = [ 120 ];
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
      laststatus = 0;
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
