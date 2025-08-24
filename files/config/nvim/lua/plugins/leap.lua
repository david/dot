-- [nfnl] files/config/nvim/fnl/plugins/leap.fnl
local function _1_()
  return require("leap").leap()
end
return setup("ggandor/leap.nvim", {opts = {}, keys = {{L = _1_, mode = {"n", "v", "o"}}}, dependencies = {"tpope/vim-repeat"}, enabled = false})
