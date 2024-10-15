vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = " "

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.breakindent = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "marker"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { nbsp = "󱁐", tab = "⭾ ", trail = "󰈅" }
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.titlestring = "%F"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "m", "q")
vim.keymap.set("n", "q", "<cmd>bdelete<cr>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("timbuktu-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  checker = { enabled = true },

  spec = {
    { "Bilal2453/luvit-meta", lazy = true },
    { "HiPhish/rainbow-delimiters.nvim", main = "rainbow-delimiters.setup", opts = {} },

    {
      "RRethy/nvim-treesitter-endwise",
      config = function()
        require("nvim-treesitter.configs").setup({
          endwise = { enable = true },
        })
      end,
    },

    {
      "Wansmer/treesj",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      keys = {
        {
          "gs",
          function()
            require("treesj").toggle()
          end,
          desc = "Toggle single line/multiline",
        },
      },
      opts = {
        use_default_keymaps = false,
      },
    },

    {
      "akinsho/git-conflict.nvim",
      version = "*",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {},
    },

    {
      "andymass/vim-matchup",
      config = function()
        require("nvim-treesitter.configs").setup({
          matchup = { enable = true },
        })
      end,
    },

    { "direnv/direnv.vim" },

    {
      "echasnovski/mini.nvim",
      version = "*",
      config = function()
        require("mini.ai").setup({})
      end,
    },

    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      config = function()
        local overrides

        if vim.o.background == "dark" then
          overrides = {
            EndOfLine = { fg = "#282828" },
            WinSeparator = { bg = "#282828", fg = "#282828" },

            NotifyBackground = { bg = "#504945" },
            NotifyERRORBorder = { fg = "#504945", bg = "#504945" },
            NotifyWARNBorder = { fg = "#504945", bg = "#504945" },
            NotifyINFOBorder = { fg = "#504945", bg = "#504945" },
            NotifyDEBUGBorder = { fg = "#504945", bg = "#504945" },
            NotifyTRACEBorder = { fg = "#504945", bg = "#504945" },
            NotifyERRORBody = { bg = "#504945" },
            NotifyWARNBody = { bg = "#504945" },
            NotifyINFOBody = { bg = "#504945" },
            NotifyDEBUGBody = { bg = "#504945" },
            NotifyTRACEBody = { bg = "#504945" },

            TelescopePreviewBorder = { fg = "#282828", bg = "#282828" },
            TelescopePreviewNormal = { bg = "#282828" },
            TelescopePreviewTitle = { bg = "#282828", fg = "#282828" },
            TelescopePromptBorder = { bg = "#504945", fg = "#504945" },
            TelescopePromptNormal = { bg = "#504945" },
            TelescopePromptTitle = { bg = "#504945", fg = "#504945" },
            TelescopeResultsBorder = { bg = "#3c3836", fg = "#3c3836" },
            TelescopeResultsNormal = { bg = "#3c3836" },
            TelescopeResultsTitle = { bg = "#3c3836", fg = "#3c3836" },
            TelescopeSelection = { bg = "#fabd2f", fg = "#3c3836" },
            TelescopeSelectionCaret = { bg = "#fabd2f", fg = "#fabd2f" },
          }
        else
          overrides = {}
        end

        require("gruvbox").setup({
          contrast = "hard",
          overrides = overrides,
          transparent_mode = true,
        })
      end,
    },

    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },

    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          lsp_doc_border = false,
        },
      },
      dependencies = {
        { "MunifTanjim/nui.nvim" },

        {
          "rcarriga/nvim-notify",
          opts = {
            background_color = "NotifyBackground",
            render = "wrapped-compact",
            stages = "fade",
            top_down = false,
          },
        },
      },
    },

    {
      "folke/which-key.nvim",
      event = "VimEnter",
      opts = {
        icons = {
          mappings = true,
        },
        spec = {
          { "<leader>c", group = "Code" },
          { "<leader>d", group = "Document" },
          { "<leader>h", group = "Help" },
          { "<leader>r", group = "Refactor" },
          { "<leader>w", group = "Workspace" },
        },
      },
    },

    {
      "ggandor/flit.nvim",
      opts = {
        labeled_modes = "nv",
        multiline = false,
      },
    },

    {
      "ggandor/leap.nvim",
      dependencies = "tpope/vim-repeat",
      keys = {
        { "gs", "<Plug>(leap-backward)", desc = "Leap backward", mode = { "x" } },
        { "s", "<Plug>(leap-forward)", desc = "Leap forward", mode = { "n", "x", "o" } },
        { "S", "<Plug>(leap-backward)", desc = "Leap backward", mode = { "n", "o" } },
      },
    },

    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = function()
            return "make install_jsregexp"
          end,
          config = function()
            require("luasnip").config.setup({})
          end,
        },

        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
      },
      config = function()
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        cmp.setup({
          completion = { completeopt = "menu,menuone,noinsert" },
          mapping = cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<C-l>"] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { "i", "s" }),
          }),
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          sources = {
            {
              name = "lazydev",
              group_index = 0,
            },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          },
        })
      end,
    },

    { "kevinhwang91/nvim-bqf", ft = "qf", opts = {} },

    { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },

    { "lewis6991/gitsigns.nvim", opts = {} },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    { "okuuva/auto-save.nvim", lazy = false, opts = {} },

    {
      "mfussenegger/nvim-lint",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lint = require("lint")
        local group = vim.api.nvim_create_augroup("timbuktu-lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = group,
          callback = function()
            lint.try_lint()
          end,
        })
      end,
    },

    {
      "mizlan/iswap.nvim",
      keys = {
        { "gx", "<cmd>ISwapNodeWith<cr>", desc = "Toggle single line/multiline" },
        { "gX", "<cmd>ISwapNode<cr>", desc = "Toggle single line/multiline" },
      },
      opts = {},
    },

    {
      "neovim/nvim-lspconfig",
      config = function()
        local lsp = require("lspconfig")

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("timbuktu-lsp-attach", { clear = true }),
          callback = function(event)
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            map("gD", vim.lsp.buf.declaration, "Go to declaration")
            map("gI", require("telescope.builtin").lsp_implementations, "Go to implementation")
            map("gd", require("telescope.builtin").lsp_definitions, "Go to definition")
            map("gr", require("telescope.builtin").lsp_references, "Go to references")
            map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
            map("<leader>ca", vim.lsp.buf.code_action, "Code action")
            map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
            map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
            map("<leader>rn", vim.lsp.buf.rename, "Rename")

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup("timbuktu-lsp-highlight", { clear = false })

              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("timbuktu-lsp-detach", { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({
                    group = "timbuktu-lsp-highlight",
                    buffer = event2.buf,
                  })
                end,
              })
            end
          end,
        })

        local capabilities = vim.tbl_deep_extend(
          "force",
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )

        lsp.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        })

        lsp.elixirls.setup({
          cmd = { "elixir-ls" },
          capabilities = capabilities,
        })

        lsp.ruby_lsp.setup({
          capabilities = capabilities,
        })
      end,
    },

    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({}, { names = false })
      end,
    },

    {
      "nvim-lualine/lualine.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
        options = {
          theme = "gruvbox",
        },
      },
    },

    {
      "nvim-telescope/telescope.nvim",
      lazy = false,
      dependencies = {
        { "debugloop/telescope-undo" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      keys = {
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>hc", "<cmd>Telescope highlights<cr>", desc = "Colors" },
        { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Tags" },
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Open file" },
        { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undo history" },
        { "<leader>z", "<cmd>Telescope zoxide list<cr>", desc = "Visit known directory" },
      },
      config = function()
        require("telescope").setup({
          defaults = {
            layout_config = {
              vertical = { mirror = true, preview_height = 0.5, prompt_position = "top" },
            },
            layout_strategy = "vertical",
            prompt_prefix = "  ",
            sorting_strategy = "ascending",
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown(),
            },
          },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("undo")
      end,
    },

    { "nvim-tree/nvim-web-devicons" },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "bash",
            "eex",
            "elixir",
            "embedded_template",
            "heex",
            "html",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "regex",
            "ruby",
            "terraform",
            "vim",
            "vimdoc",
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby" },
          },
          indent = { enable = true },
        })
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        require("nvim-treesitter.configs").setup({
          textobjects = {
            lsp_interop = {
              enable = true,
            },
            move = {
              enable = true,
            },
            select = {
              enable = true,
              lookahead = true,
            },
            swap = {
              enable = true,
            },
          },
        })
      end,
    },

    {
      "stevearc/conform.nvim",
      event = "BufWritePre",
      cmd = { "ConformInfo" },
      keys = {
        {
          "<leader>df",
          function()
            require("conform").format({
              async = true,
              lsp_fallback = true,
            })
          end,
          desc = "Format buffer",
        },
      },
      opts = {
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          elixir = { "mix" },
          eelixir = { "mix" },
          heex = { "mix" },
          lua = { "stylua" },
          ["*"] = { "trim_whitespace" },
        },
        notify_on_error = false,
      },
    },

    {
      "stevearc/quicker.nvim",
      ft = "qf",
      opts = {
        keys = {
          {
            ">",
            function()
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      },
    },

    {
      "windwp/nvim-autopairs",
      event = { "InsertEnter" },
      config = function()
        require("nvim-autopairs").setup({})

        local autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        cmp.event:on("confirm_done", autopairs.on_confirm_done())
      end,
      dependencies = { "hrsh7th/nvim-cmp" },
    },

    { "windwp/nvim-ts-autotag", event = { "InsertEnter" }, opts = {} },
  },
})

vim.cmd([[colorscheme gruvbox]])
