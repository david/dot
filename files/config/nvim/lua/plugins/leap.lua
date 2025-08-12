return {
  "ggandor/leap.nvim",
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
