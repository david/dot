-- [nfnl] config/nvim/fnl/plugins/neotest.fnl
local function make_rspec_cmd(position_type)
  _G.assert((nil ~= position_type), "Missing argument position-type on /var/home/david/Homes/dot/dot/config/nvim/fnl/plugins/neotest.fnl:1")
  if (position_type == "file") then
    return {"bundle", "exec", "rspec", "--format", "documentation"}
  elseif (position_type == "test") then
    return {"bundle", "exec", "rspec", "--format", "documentation", "--example"}
  else
    local _ = position_type
    return {"bundle", "exec", "rspec"}
  end
end
local function _2_()
  return require("neotest").setup({adapters = {require("neotest-rspec")}, consumers = {require("neotest.consumers.overseer")}})
end
local function _3_()
  return require("neotest").run.run(vim.fn.getcwd())
end
local function _4_()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _5_()
  return require("neotest").run.run(vim.fn.getcwd())
end
local function _6_()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _7_()
  return require("neotest").run.run()
end
return setup("nvim-neotest/neotest", {config = _2_, keys = {kv("<D-p>", _3_), kv("<leader>rf", _4_, {desc = "Tests in File"}), kv("<leader>ot", "<cmd>Neotest output-panel<cr>", {desc = "Show Test Output Panel"}), kv("<leader>rp", _5_, {desc = "Tests in Project"}), kv("<leader>rr", _6_, {desc = "Tests in File"}), kv("<leader>ru", _7_, {desc = "Closer"})}, cmd = {"Neotest"}, dependencies = {"antoinemadec/FixCursorHold.nvim", "nvim-lua/plenary.nvim", "nvim-neotest/nvim-nio", "nvim-treesitter/nvim-treesitter", "olimorris/neotest-rspec", "stevearc/overseer.nvim"}})
