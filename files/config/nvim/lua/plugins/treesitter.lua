return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "embedded_template",
      "javascript",
      "json",
      "regex",
      "ruby",
      "yaml",
    },
  },
}
