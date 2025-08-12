return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },

    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "lua_ls",
        },
      },
    },

    { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "stylua" } } },

    { "j-hui/fidget.nvim", opts = {} },

    "saghen/blink.cmp",
  },
}
