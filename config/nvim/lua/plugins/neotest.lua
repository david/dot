-- [nfnl] fnl/plugins/neotest.fnl
local function _1_()
  return require("neotest").setup({adapters = {require("neotest-rspec")}, consumers = {require("neotest.consumers.overseer")}})
end
local function _2_()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _3_()
  return require("neotest").run.run(vim.fn.getcwd())
end
local function _4_()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _5_()
  return require("neotest").run.run()
end
return setup("nvim-neotest/neotest", {commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c", config = _1_, keys = {kv("<leader>rf", _2_, {desc = "Tests in File"}), kv("<leader>rn", "<cmd>Neotest output-panel<cr>", {desc = "Show Output Panel"}), kv("<leader>rp", _3_, {desc = "Tests in Project"}), kv("<leader>rr", _4_, {desc = "Tests in File"}), kv("<leader>ru", _5_, {desc = "Closer"})}, cmd = {"Neotest"}, dependencies = {"antoinemadec/FixCursorHold.nvim", "nvim-lua/plenary.nvim", "nvim-neotest/nvim-nio", "OXY2DEV/markview.nvim", "nvim-treesitter/nvim-treesitter", "olimorris/neotest-rspec", "stevearc/overseer.nvim"}})
