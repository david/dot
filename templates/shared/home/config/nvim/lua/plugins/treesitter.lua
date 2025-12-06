return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "elixir",
      "embedded_template",
      "heex",
      "html",
      "javascript",
      "json",
      "jsonc",
      "regex",
      "ruby",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
  },
}
