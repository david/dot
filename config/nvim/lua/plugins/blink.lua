return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    cmdline = { keymap = { preset = "inherit", ["<C-j>"] = { "select_accept_and_enter" } } },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
    keymap = { ["<C-a>"] = { "select_and_accept" } },
    sources = {
      default = { "buffer", "lsp", "path", "snippets" },
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
      },
    },
  },
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
}
