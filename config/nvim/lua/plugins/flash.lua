-- [nfnl] config/nvim/fnl/plugins/flash.fnl
local function _1_()
  return require("flash").jump()
end
local function _2_()
  return require("flash").treesitter()
end
local function _3_()
  return require("flash").remote()
end
local function _4_()
  return require("flash").treesitter_remote()
end
return setup("folke/flash.nvim", {opts = {}, event = "VeryLazy", keys = {kv("s", _1_, {desc = "Flash", mode = {"n", "x", "o"}}), kv("S", _2_, {desc = "Flash Treesitter", mode = {"n", "x", "o"}}), kv("r", _3_, {desc = "Flash Remote", mode = {"n", "x", "o"}}), kv("R", _4_, {desc = "Flash Remote Treesitter", mode = {"n", "x", "o"}})}})
