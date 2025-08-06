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
local function plugin(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:6")
  local plugin0 = require(name)
  local _let_2_ = (_3fconfig or {})
  local opts = _let_2_["opts"]
  local keymaps = _let_2_["keymaps"]
  plugin0.setup((opts or {}))
  for key, val in pairs((keymaps or {})) do
    keymap(key, val)
  end
  return plugin0
end
local function filetype(ft, _3fconfig)
  _G.assert((nil ~= ft), "Missing argument ft on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:16")
  local function _3_()
    do
      local _let_4_ = (_3fconfig or {})
      local plugs = _let_4_["plugin"]
      for plug, cfg in pairs((plugs or {})) do
        plugin(plug, cfg)
      end
    end
    return vim.treesitter.start()
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = ft, callback = _3_, group = vim.api.nvim_create_augroup((ft .. "-config"), {clear = true})})
end
local function colorscheme(name, _3fconfig)
  _G.assert((nil ~= name), "Missing argument name on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:27")
  plugin(name, _3fconfig)
  return vim.cmd.colorscheme(name)
end
local function configure(_5_)
  local cscheme = _5_["colorscheme"]
  local g = _5_["g"]
  local keymaps = _5_["keymaps"]
  local opts = _5_["opts"]
  local plugins = _5_["plugins"]
  local filetypes = _5_["filetypes"]
  _G.assert((nil ~= filetypes), "Missing argument filetypes on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:32")
  _G.assert((nil ~= plugins), "Missing argument plugins on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:32")
  _G.assert((nil ~= opts), "Missing argument opts on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:32")
  _G.assert((nil ~= keymaps), "Missing argument keymaps on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:32")
  _G.assert((nil ~= g), "Missing argument g on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:32")
  _G.assert((nil ~= cscheme), "Missing argument cscheme on /var/home/david/Worktrees/dot/nvim/files/fnl/timbuktu/config/dsl.fnl:32")
  for key, val in pairs(g) do
    vim.g[key] = val
  end
  for key, val in pairs(opts) do
    vim.opt[key] = val
  end
  for key, val in pairs(keymaps) do
    keymap(key, val)
  end
  for name, config in pairs(plugins) do
    plugin(name, config)
  end
  for name, config in pairs(filetypes) do
    filetype(name, config)
  end
  return colorscheme(cscheme)
end
return {configure = configure}
