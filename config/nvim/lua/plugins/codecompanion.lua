-- [nfnl] config/nvim/fnl/plugins/codecompanion.fnl
return setup("olimorris/codecompanion.nvim", {opts = {}, cmd = {"CodeCompanion", "CodeCompanionChat"}, keys = {kv("<D-a>", "<cmd>CodeCompanionChat Toggle<cr>")}, dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"}})
