
return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  keys = {
    { "s", "<Plug>(leap-forward)", desc = "Leap forward", mode = { "n" } },
    { "S", "<Plug>(leap-backward)", desc = "Leap backward", mode = { "n" } },
  },
}
