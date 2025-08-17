return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },

    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "biome",
          "docker_compose_language_service",
          "lua_ls",
          "ruby_lsp",
          "ts_ls",
        },
      },
    },

    { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "stylua" } } },

    { "j-hui/fidget.nvim", opts = {} },

    "saghen/blink.cmp",
  },
}
