return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    cmdline = { keymap = { preset = "inherit", ["<C-j>"] = { "select_accept_and_enter" } } },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      list = { max_items = 20 },
    },
    keymap = { ["<C-a>"] = { "select_and_accept" } },
    signature = {
      enabled = true,
    },
    sources = {
      default = { "lsp", "path", "buffer", "snippets" },
      per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = {
          fallbacks = {},
        },
        path = {
          opts = {
            get_cwd = function(_) return vim.fn.getcwd() end,
            show_hidden_files_by_default = true,
          },
        },
      },
    },
    term = {
      enabled = true,
    },
  },
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
}
