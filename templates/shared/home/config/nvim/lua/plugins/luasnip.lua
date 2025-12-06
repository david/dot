-- [nfnl] config/nvim/fnl/plugins/luasnip.fnl
local function _1_()
  require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets"})
  return require("luasnip").config.set_config({enable_autosnippets = true})
end
local function _2_()
  return require("luasnip").expand_or_jump()
end
return setup("L3MON4D3/LuaSnip", {config = _1_, keys = {kv("<C-j>", _2_, {mode = {"i", "s"}})}})
