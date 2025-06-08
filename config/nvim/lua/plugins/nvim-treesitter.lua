
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash",
      "eex",
      "elixir",
      "embedded_template",
      "gleam",
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
}
