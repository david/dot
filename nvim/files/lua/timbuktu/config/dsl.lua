-- [nfnl] fnl/timbuktu/config/dsl.fnl
local function keymap_handler(_1_)
  local _3fconfig = _1_["keymap"]
  if _3fconfig then
    for key, val in pairs(_3fconfig) do
      if ((_G.type(val) == "table") and (nil ~= val.cmd) and (nil ~= val.mode)) then
        local cmd = val.cmd
        local mode = val.mode
        vim.keymap.set(mode, key, cmd)
      elseif (nil ~= val) then
        local cmd = val
        vim.keymap.set("n", key, cmd)
      else
      end
    end
    return nil
  else
    return nil
  end
end
local vim_handlers = {colorscheme = {}, g = {}, opt = {}, keymap = {fn = keymap_handler}}
vim_handlers.colorscheme.fn = function(_4_)
  local _3fconfig = _4_["colorscheme"]
  local and_5_ = (nil ~= _3fconfig)
  if and_5_ then
    local str = _3fconfig
    and_5_ = (type(str) == "string")
  end
  if and_5_ then
    local str = _3fconfig
    require(str).setup({})
    return vim.cmd.colorscheme(str)
  else
    return nil
  end
end
vim_handlers.g.fn = function(_8_)
  local _3fconfig = _8_["g"]
  for key, val in pairs(_3fconfig) do
    vim.g[key] = val
  end
  return nil
end
vim_handlers.opt.fn = function(_9_)
  local _3fconfig = _9_["opt"]
  for key, val in pairs(_3fconfig) do
    vim.opt[key] = val
  end
  return nil
end
local plugin_handlers
local function _11_(_10_, plugin)
  local _3fopts = _10_["opt"]
  _G.assert((nil ~= plugin), "Missing argument plugin on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  local _12_ = require(plugin).setup
  if (nil ~= _12_) then
    local setup = _12_
    return setup((_3fopts or {}))
  else
    return nil
  end
end
plugin_handlers = {opt = {fn = _11_}, keymap = {fn = keymap_handler}}
local ft_handlers = {lang = {}, plugin = {}}
ft_handlers.plugin.fn = function(_14_, ft)
  local _3fconfig = _14_["plugin"]
  _G.assert((nil ~= ft), "Missing argument ft on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:34")
  local group_name = (ft .. "-ft-plugin")
  local group = vim.api.nvim_create_augroup(group_name, {clear = true})
  for key, val in pairs((_3fconfig or {})) do
    local function _15_()
      return require(key).setup(val)
    end
    vim.api.nvim_create_autocmd("FileType", {pattern = ft, callback = _15_, group = group})
  end
  return nil
end
ft_handlers.lang.fn = function(_config, ft)
  _G.assert((nil ~= ft), "Missing argument ft on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:43")
  local group = vim.api.nvim_create_augroup((ft .. "-ft-lang"), {clear = true})
  local function _16_()
    return vim.treesitter.start()
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = ft, callback = _16_, group = group})
end
local handlers = {filetype = ft_handlers, nvim = vim_handlers, plugin = plugin_handlers}
local function call_handlers(handlers0, ...)
  local rest = {...}
  _G.assert((nil ~= rest), "Missing argument rest on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:54")
  _G.assert((nil ~= handlers0), "Missing argument handlers on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:54")
  for key, handler in pairs(handlers0) do
    handler.fn(unpack(rest))
  end
  return nil
end
local function setup(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:58")
  local config = (_3fconfig or {})
  if (name == "nvim") then
    return call_handlers(handlers.nvim, config)
  elseif ((_G.type(name) == "table") and (name[1] == "filetype") and (nil ~= name[2])) then
    local ft = name[2]
    return call_handlers(handlers.filetype, config, ft)
  else
    local _ = name
    return call_handlers(handlers.plugin, config, name)
  end
end
return {setup = setup}
