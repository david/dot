-- [nfnl] fnl/timbuktu/config/dsl.fnl
local function keymap(key, config)
  _G.assert((nil ~= config), "Missing argument config on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:1")
  _G.assert((nil ~= key), "Missing argument key on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:1")
  if ((_G.type(config) == "table") and (nil ~= config.cmd) and (nil ~= config.mode)) then
    local cmd = config.cmd
    local mode = config.mode
    return vim.keymap.set(mode, key, cmd)
  elseif (nil ~= config) then
    local cmd = config
    return vim.keymap.set("n", key, cmd)
  else
    return nil
  end
end
local function keymaps(_2_)
  local _3fkeymaps = _2_["keymaps"]
  for key, val in pairs((_3fkeymaps or {})) do
    keymap(key, val)
  end
  return nil
end
local function plugin(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:10")
  local plugin0 = require(name)
  local config = (_3fconfig or {})
  plugin0.setup((config.opts or {}))
  keymaps(config)
  return plugin0
end
local function plugins(_3_)
  local _3fplugins = _3_["plugins"]
  for name, config in pairs((_3fplugins or {})) do
    plugin(name, config)
  end
  return nil
end
local function filetype(ft, _3fconfig)
  _G.assert((nil ~= ft), "Missing argument ft on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:22")
  local function _4_()
    plugins((_3fconfig or {}))
    return vim.treesitter.start()
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = ft, callback = _4_, group = vim.api.nvim_create_augroup((ft .. "-config"), {clear = true})})
end
local function colorscheme(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:31")
  plugin(name, _3fconfig)
  return vim.cmd.colorscheme(name)
end
local function configure(_5_)
  local cscheme = _5_["colorscheme"]
  local g = _5_["g"]
  local opts = _5_["opts"]
  local filetypes = _5_["filetypes"]
  local config = _5_
  _G.assert((nil ~= config), "Missing argument config on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:36")
  _G.assert((nil ~= filetypes), "Missing argument filetypes on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:36")
  _G.assert((nil ~= opts), "Missing argument opts on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:36")
  _G.assert((nil ~= g), "Missing argument g on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:36")
  _G.assert((nil ~= cscheme), "Missing argument cscheme on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:36")
  for key, val in pairs(g) do
    vim.g[key] = val
  end
  for key, val in pairs(opts) do
    vim.opt[key] = val
  end
  keymaps(config)
  plugins(config)
  for name, config0 in pairs(filetypes) do
    filetype(name, config0)
  end
  return colorscheme(cscheme)
end
return {configure = configure}
