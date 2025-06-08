
return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    icons = {
      mappings = true,
    },
    preset = "helix",
    spec = {
      { "<leader>/", group = "Search" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>e", group = "Edit" },
      { "<leader>f", group = "Find" },
      { "<leader>h", group = "Help" },
      { "<leader>r", group = "Refactor" },
      { "<leader>v", group = "Version control" },
      { "<leader>w", group = "Workspace" },
    },
    win = {
      border = "none",
    },
  },
}
