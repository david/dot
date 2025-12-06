-- [nfnl] config/nvim/fnl/plugins/treesj.fnl
local function _1_()
  return require("treesj").toggle()
end
return setup("Wansmer/treesj", {opts = {}, keys = {kv("gt", _1_)}, dependencies = {"nvim-treesitter/nvim-treesitter"}})
