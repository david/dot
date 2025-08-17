return {
  "ggandor/leap.nvim",
  enabled = false,
  opts = {},
  keys = {
    {
      "L",
      function()
        require("leap").leap()
      end,
      mode = { "n", "v", "o" },
    },
  },
  dependencies = {
    "tpope/vim-repeat",
  },
}
