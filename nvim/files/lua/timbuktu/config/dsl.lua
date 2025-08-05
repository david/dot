-- [nfnl] fnl/timbuktu/config/dsl.fnl
local function core(config)
  _G.assert((nil ~= config), "Missing argument config on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:1")
  local opt = config["opt"]
  local keys = config["key"]
  local g = config["g"]
  for key, val in pairs(g) do
    vim.g[key] = val
  end
  for key, val in pairs(opt) do
    vim.opt[key] = val
  end
  for key, val in pairs(keys) do
    vim.keymap.set("n", key, val)
  end
  return nil
end
local function plugin(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:12")
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
  _G.assert((nil ~= ft), "Missing argument ft on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:22")
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
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:33")
  plugin(name, _3fconfig)
  return vim.cmd.colorscheme(name)
end
return {colorscheme = colorscheme, core = core, filetype = filetype, plugin = plugin}
