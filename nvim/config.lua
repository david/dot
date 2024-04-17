-- options {{{
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "preview" }
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "marker"
vim.opt.guifont = "Iosevka Timbuktu:h12"
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 0
vim.opt.mouse = ""
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = false
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.titlestring = "%t"
vim.opt.undofile = true
vim.opt.virtualedit = "block"

vim.wo.number = true
vim.wo.signcolumn = "yes"

vim.g.mapleader = " "
-- }}}
-- colors {{{
require("gruvbox").setup({
  overrides = {
    NormalFloat = {
      bg = "#1d2021",
    },
  },
  transparent_mode = true,
});

vim.cmd.colorscheme("gruvbox")
--}}}

-- auto-save {{{ 
require("auto-save").setup({}) --}}}
-- autopairs {{{
require("nvim-autopairs").setup({
  check_ts = true,
  fast_wrap = {},
}) --}}}
-- colorizer {{{
require("colorizer").setup({}) --}}}
-- comment {{{
require("Comment").setup({}) --}}}
-- conform {{{
require("conform").setup({
  opts = {
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },  
    formatters_by_ft = {
      javascript = { "prettier" },  
      lua = { "stylua" },
      ["_"] = { "trim_whitespace" },
    },
  },
}) --}}}
-- copilot {{{
require("copilot").setup({
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
  },
}) --}}}
-- copilot_cmp {{{
require("copilot_cmp").setup({}) --}}}
-- fidget {{{
require("fidget").setup({
  notification = {
    override_vim_notify = true
  },
})
-- }}}
-- flit {{{
require("flit").setup({
  keys = { f = "f", F = "F", t = "t", T = "T" },
  labeled_modes = "nvo",
  multiline = false,
}) -- }}}
-- leap {{{
require("leap").setup({}) -- }}}
-- lint {{{
local lint = require("lint")

lint.linters_by_ft = {
  eruby = { "erb_lint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
}) -- }}}
-- lspkind {{{
require("lspkind").init({}) -- }}}
-- neodev {{{
require("neodev").setup({
  override = function(root_dir, library)
    if root_dir:find(vim.fn.expand("$HOME/sys/nvim"), 1, true) == 1 then
      library.enabled = true
      library.plugins = true
    end
  end,
}) --}}}
-- noice {{{
require("noice").setup({
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
    inc_rename = false,
    lsp_doc_border = false,
  },
}) --}}}
-- nu {{{
-- vim.filetype.add({ extension = { nu = "nu" } })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "nu",
--   callback = function(event)
--     vim.bo[event.buf].commentstring = "# %s"
--   end,
-- })
--
-- require("nvim-treesitter.parsers").get_parser_configs().nu = {
--   install_info = {},
--   filetype = "nu",
-- }
-- }}}
-- surround {{{
require("nvim-surround").setup({}) --}}}
-- which-key {{{
require("which-key").setup({}) --}}}

-- completion {{{
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      ellipsis_char = "…",
      mode = "symbol",
      maxwidth = 48,
      show_labelDetails = true,
    }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "LuaSnip" },
  }, {
    { name = "buffer" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "buffer" },
  })
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline({
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
  }),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline({
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
  }),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

--}}}
-- lsp {{{
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.cssls.setup({ capabilities = capabilities })

lsp.emmet_language_server.setup({ capabilities = capabilities })

lsp.eslint.setup({ capabilities = capabilities })

lsp.html.setup({
  capabilities = capabilities,
  filetypes = { "eruby", "html" },
})

lsp.jsonls.setup({ capabilities = capabilities })

lsp.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        }
      }
    }
  }
})

lsp.nil_ls.setup({ capabilities = capabilities })

lsp.nushell.setup({ capabilities = capabilities })

lsp.solargraph.setup({ capabilities = capabilities })

lsp.tailwindcss.setup({ capabilities = capabilities })

lsp.tsserver.setup({ capabilities = capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- require("which-key").register({
    --   ["<leader>"] = {
    --     c = {
    --       name = "Code...",
    --       a = { "<cmd>Telescope lsp_code_actions", "Action", mode = { "n", "v" } },
    --       d = { function() vim.diagnostic.open_float() end, "Diagnostics in line" },
    --       f = {
    --         function() vim.lsp.buf.format({ async = true }) end,
    --         "Format",
    --         mode = { "n", "v" }
    --       },
    --       r = { function() vim.lsp.buf.rename() end, "Rename" },
    --     },
    --     j = {
    --       s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols" },
    --     },
    --   },
    --   K = { function() vim.lsp.buf.hover() end, "Hover" },
    --   ["["] = {
    --     e = { function() vim.diagnostic.goto_prev() end, "diagnostic" },
    --   },
    --   ["]"] = {
    --     e = { function() vim.diagnostic.goto_next() end, "diagnostic" },
    --   },
    --   g = {
    --     d = { function() vim.lsp.buf.definition() end, "Definition" },
    --     r = { function() vim.lsp.buf.references() end, "References" },
    --   },
    -- }, { buffer = ev.buf })
  end,
})
-- }}}
-- treesitter {{{
require("nvim-treesitter.configs").setup({
  auto_install = false,
  autotag = { enable = true },
  endwise = { enable = true },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gS",
      node_incremental = "+",
      scope_incremental = "s",
      node_decremental = "-",
    },
  },
  indent = { enable = true },
  matchup = { enable = true },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = "none",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter"s `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ai"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "<c-v>",
      },
      include_surrounding_whitespace = true
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}) --}}}
-- bindings {{{
local defaults = { silent = true, noremap = true };

vim.keymap.set("n", "m", "q", defaults)
vim.keymap.set("n", "q", "ZZ", defaults)
vim.keymap.set("n", "]n", "<cmd>cn<cr>", defaults)
vim.keymap.set("n", "[n", "<cmd>cN<cr>", defaults)
--}}}
