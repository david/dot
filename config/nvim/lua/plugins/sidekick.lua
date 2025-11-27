return {
  "folke/sidekick.nvim",
  opts = {},
  keys = {
    { "<leader>oa", function() require("sidekick.cli").toggle() end, desc = "Sidekick" },
    { "<Right>", function() require("sidekick.nes").apply() end, mode = "n" },
    { "<Left>", function() require("sidekick.nes").clear() end, mode = "n" },
    { "<Down>", function() require("sidekick.nes").update() end, mode = "n" },
  },
}
