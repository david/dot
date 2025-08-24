-- [nfnl] config/nvim/fnl/plugins/mini.fnl
local function _1_()
  require("mini.ai").setup({})
  require("mini.git").setup({})
  require("mini.icons").setup({})
  require("mini.move").setup({mappings = {left = "<", right = ">"}})
  return require("mini.operators").setup({})
end
return setup("echasnovski/mini.nvim", {config = _1_})
