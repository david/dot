{ inputs, pkgs, ... }: {
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
}
