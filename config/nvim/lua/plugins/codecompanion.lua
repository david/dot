return {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
            },
          })
        end,
      },
    },
    extensions = {
      mcphub = { callback = "mcphub.extensions.codecompanion" },
      vectorcode = { opts = {} },
    },
    memory = {
      default = {
        description = "Default memory files",
        files = {
          "AGENTS.md",
        },
      },
      opts = {
        chat = { enabled = true },
      },
    },
    strategies = {
      chat = { adapter = "claude_code" },
      inline = { adapter = "claude_code" },
      cmd = { adapter = "claude_code" },
    },
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
