return {
  "gbprod/yanky.nvim",
  opts = {
    ring = { storage = "sqlite" },
  },
  keys = {
    { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous yank entry" },
    { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next yank entry" },
    { "<leader>p", "<cmd>YankyRingHistory<cr>", mode = { "n", "x" }, desc = "Open Yank History" },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
  },
}
