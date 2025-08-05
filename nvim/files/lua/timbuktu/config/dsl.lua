-- [nfnl] fnl/timbuktu/config/dsl.fnl
local function plugin(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:1")
  local plugin0 = require(name)
  local _let_1_ = (_3fconfig or {})
  local opt = _let_1_["opt"]
  local keys = _let_1_["key"]
  plugin0.setup((opt or {}))
  for key, val in pairs((keys or {})) do
    vim.keymap.set("n", key, val)
  end
  return plugin0
end
local function filetype(ft, _3fconfig)
  _G.assert((nil ~= ft), "Missing argument ft on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:11")
  local function _2_()
    do
      local _let_3_ = (_3fconfig or {})
      local plugs = _let_3_["plugin"]
      for plug, cfg in pairs((plugs or {})) do
        plugin(plug, cfg)
      end
    end
    return vim.treesitter.start()
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = ft, callback = _2_, group = vim.api.nvim_create_augroup((ft .. "-config"), {clear = true})})
end
local function colorscheme(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:22")
  plugin(name, _3fconfig)
  return vim.cmd.colorscheme(name)
end
local function core(_4_)
  local g = _4_["g"]
  local keys = _4_["key"]
  local opts = _4_["opt"]
  local plugins = _4_["plugin"]
  local filetypes = _4_["filetype"]
  local cscheme = _4_["colorscheme"]
  _G.assert((nil ~= cscheme), "Missing argument cscheme on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  _G.assert((nil ~= filetypes), "Missing argument filetypes on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  _G.assert((nil ~= plugins), "Missing argument plugins on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  _G.assert((nil ~= opts), "Missing argument opts on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  _G.assert((nil ~= keys), "Missing argument keys on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  _G.assert((nil ~= g), "Missing argument g on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  for key, val in pairs(g) do
    vim.g[key] = val
  end
  for key, val in pairs(opts) do
    vim.opt[key] = val
  end
  for key, val in pairs(keys) do
    vim.keymap.set("n", key, val)
  end
  for name, config in pairs(plugins) do
    plugin(name, config)
  end
  for name, config in pairs(filetypes) do
    filetype(name, config)
  end
  return colorscheme(cscheme)
end
return {config = core}
