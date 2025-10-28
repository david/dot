return {
  "pwntester/octo.nvim",
  opts = {
    default_to_projects_v2 = true,
    picker = "snacks",
  },
  keys = {
    { "<leader>fi", "<cmd>Octo issue list<cr>", desc = "Issues" },
    { "<leader>ni", "<cmd>Octo issue create<cr>", desc = "Issue" },
  },
  cmd = { "Octo" },
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim", "nvim-tree/nvim-web-devicons" },
}
