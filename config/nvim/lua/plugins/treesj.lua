
return {
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
}
