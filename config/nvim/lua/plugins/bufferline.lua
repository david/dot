return {
  "akinsho/bufferline.nvim",
  enabled = false,
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      max_name_length = 36,
      show_close_icon = false,
    },
  },
  keys = {
    { "<D-,>", "<cmd>BufferLineCyclePrev<cr>", mode = { "i", "n" } },
    { "<D-.>", "<cmd>BufferLineCycleNext<cr>", mode = { "i", "n" } },
    { "<D-C-,>", "<cmd>BufferLineMovePrev<cr>", mode = { "i", "n" } },
    { "<D-C-.>", "<cmd>BufferLineMoveNext<cr>", mode = { "i", "n" } },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  lazy = false,
}
