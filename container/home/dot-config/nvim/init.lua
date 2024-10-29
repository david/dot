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

vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

vim.keymap.set("n", "<C-k>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<M-k>", "<cmd>cprevious<cr>")
vim.keymap.set("n", "<M-j>", "<cmd>cnext<cr>")
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
    {
      "AckslD/nvim-neoclip.lua",
      lazy = false,
      keys = {
        { "<leader>ey", "<cmd>Telescope neoclip<cr>", desc = "Yank history" },
      },
      dependencies = {
        { "nvim-telescope/telescope.nvim" },
      },
      opts = {},
    },

    { "Bilal2453/luvit-meta", lazy = true },
    { "HiPhish/rainbow-delimiters.nvim", main = "rainbow-delimiters.setup", opts = {} },

    { "Kasama/nvim-custom-diagnostic-highlight", opts = {} },

    {
      "NeogitOrg/neogit",
      opts = {
        signs = {
          hunk = { "", "" },
          item = { "", "" },
          section = { "", "" },
        },
      },
      keys = {
        { "<leader>vv", "<cmd>Neogit<cr>", desc = "Neogit" },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "sindrets/diffview.nvim",
      },
    },

    {
      "RRethy/nvim-treesitter-endwise",
      main = "nvim-treesitter.configs",
      opts = {
        endwise = { enable = true },
      },
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
      main = "nvim-treesitter.configs",
      opts = {
        matchup = { enable = true },
      },
    },

    { "direnv/direnv.vim" },

    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      config = function()
        require("gruvbox").setup({
          contrast = "hard",
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
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false },
    },

    {
      "folke/which-key.nvim",
      event = "VimEnter",
      opts = {
        icons = {
          mappings = true,
        },
        spec = {
          { "<leader>/", group = "Search" },
          { "<leader>c", group = "Code" },
          { "<leader>d", group = "Document" },
          { "<leader>e", group = "Edit" },
          { "<leader>h", group = "Help" },
          { "<leader>r", group = "Refactor" },
          { "<leader>v", group = "Version Control" },
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
        { "s", "<Plug>(leap-forward)", desc = "Leap forward", mode = { "n" } },
        { "S", "<Plug>(leap-backward)", desc = "Leap backward", mode = { "n" } },
      },
    },

    -- {
    --   "saghen/blink.cmp",
    --   dependencies = "rafamadriz/friendly-snippets",
    --   version = "v0.*",
    --   opts = {
    --     highlight = {
    --       use_nvim_cmp_as_default = true
    --     },
    --     nerd_font_variant = "normal"
    --   }
    -- },

    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = function()
            return "make install_jsregexp"
          end,
          dependencies = {
            {
              "rafamadriz/friendly-snippets",
              config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
              end,
            },
          },
        },

        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
        { "onsails/lspkind.nvim", opts = { mode = "symbol" } },
        { "saadparwaiz1/cmp_luasnip" },
      },
      config = function()
        local luasnip = require("luasnip")

        luasnip.config.setup({})
        luasnip.filetype_extend("ruby", { "rails" })

        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
          completion = { completeopt = "menu,menuone,noinsert" },
          formatting = {
            format = lspkind.cmp_format({ mode = "symbol" }),
          },
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

    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "<leader>//", "<cmd>FzfLua live_grep_glob<cr>", desc = "Live grep" },
        { "<leader>/r", "<cmd>FzfLua resume<cr>", desc = "Resume search" },
        { "<leader>F", "<cmd>FzfLua buffers<cr>", desc = "Open buffer" },
        { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Open file" },
        { "<leader>hc", "<cmd>FzfLua highlights<cr>", desc = "Colors" },
        { "<leader>hh", "<cmd>FzfLua helptags<cr>", desc = "Tags" },
        { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      },
      opts = {},
    },

    { "kevinhwang91/nvim-bqf", ft = "qf", opts = {} },
    { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
    {
      "lewis6991/gitsigns.nvim",
      lazy = false,
      keys = {
        { "<leader>vN", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk" },
        { "<leader>vn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
        { "<leader>vs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
        { "<leader>vu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage hunk" },
      },
      opts = {},
    },
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
        { "gx", "<cmd>ISwapNodeWith<cr>", desc = "Swap current node" },
        { "gX", "<cmd>ISwapNode<cr>", desc = "Swap node" },
      },
      opts = {},
    },

    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("timbuktu-lsp-attach", { clear = true }),
          callback = function(event)
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
            end

            local builtin = require("telescope.builtin")

            map("gd", builtin.lsp_definitions, "Go to definition")
            map("gr", builtin.lsp_references, "Go to references")
            map("<leader>ca", vim.lsp.buf.code_action, "Code action")
            map("<leader>dd", "<cmd>FzfLua diagnostics_document<cr>", "Diagnostics")
            map("<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", "Symbols")
            map("<leader>wd", "<cmd>FzfLua diagnostics_workspace<cr>", "Diagnostics")
            map("<leader>ws", "<cmd>FzfLua lsp_workspaced_symbols<cr>", "Symbols")
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

        local servers = {
          bashls = {},
          emmet_language_server = {},
          jsonls = {},
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = { disable = { "missing-fields" } },
              },
            },
          },
          ruby_lsp = {},
          tailwindcss = {},
          ts_ls = {},
          yamlls = {},
        }

        for server_name, opts in ipairs(servers) do
          opts.capabilities = vim.tbl_deep_extend(
            "force",
            opts.capabilities or {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
          )

          require("lspconfig")[server_name].setup(opts)
        end
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
        { "<leader>eu", "<cmd>Telescope undo<cr>", desc = "Undo history" },
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
      main = "nvim-treesitter.configs",
      opts = {
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
        indent = {
          enable = true,
          disable = { "ruby" },
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      main = "nvim-treesitter.configs",
      opts = {
        textobjects = {
          lsp_interop = {
            enable = true,
          },
          move = {
            enable = true,
            goto_next_start = {
              ["<M-a>"] = "@parameter.inner",
              ["<M-f>"] = "@function.outer",
              ["<M-b>"] = "@block.outer",
            },
            goto_prev_start = {
              ["<M-S-a>"] = "@parameter.inner",
              ["<M-S-f>"] = "@function.outer",
              ["<M-S-b>"] = "@block.outer",
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["gwa"] = "@parameter.inner",
            },
            swap_previous = {
              ["gwA"] = "@parameter.inner",
            },
          },
        },
      },
    },

    {
      "pwntester/octo.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-tree/nvim-web-devicons" },
      },
      opts = {
        default_merge_method = "rebase",
        ui = {
          use_signcolumn = true,
        },
        mappings_disable_default = true,
        suppress_missing_scope = {
          projects_v2 = true,
        },
      },
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
          mode = "",
          desc = "Format buffer",
        },
      },
      opts = {
        format_on_save = function()
          local cwd = vim.fn.getcwd()

          if not string.find(cwd, "Projects/ar/") then
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        end,
        formatters_by_ft = {
          elixir = { "mix" },
          eelixir = { "mix" },
          heex = { "mix" },
          lua = { "stylua" },
          ruby = { "rubocop" },
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

vim.cmd.colorscheme("gruvbox")
