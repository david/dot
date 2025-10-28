return {
  "olimorris/codecompanion.nvim",
  opts = {
    extensions = {
      mcphub = { callback = "mcphub.extensions.codecompanion" },
      vectorcode = { opts = {} },
    },
    memory = { opts = { chat = { enabled = true } } },
    strategies = { chat = { adapter = "copilot", model = "gpt-5" } },
  },
  cmd = { "CodeCompanion", "CodeCompanionChat" },
  keys = {
    { "<D-c>", "<cmd>CodeCompanionChat Toggle<cr>" },
    { "<leader>nc", "<cmd>CodeCompanionChat<cr>", desc = "Chat" },
    { "<leader>oc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Chat" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
}
