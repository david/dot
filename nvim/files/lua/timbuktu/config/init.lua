-- [nfnl] fnl/timbuktu/config/init.fnl
local configure = require("timbuktu.config.dsl").config
local function _1_()
  return vim.cmd.nohlsearch()
end
local function _2_()
  return vim.cmd.write()
end
local function _3_()
  return vim.cmd.bnext()
end
local function _4_()
  return vim.cmd.bprevious()
end
local function _5_()
  return vim.cmd.bdelete()
end
local function _6_()
  return Snacks.picker.grep()
end
local function _7_()
  return Snacks.picker.smart({multi = {"buffers", "files"}, matcher = {cwd_bonus = true}})
end
local function _8_()
  return require("leap").leap({})
end
local _9_
do
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "gemini", direction = "float"})
  local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
  local function _10_()
    return agent:toggle()
  end
  local function _11_()
    return lazygit:toggle()
  end
  _9_ = {opt = {direction = "float", open_mapping = "<D-t>"}, key = {["<D-a>"] = _10_, ["<D-g>"] = _11_}}
end
return configure({opt = {autowrite = true, breakindent = true, cursorline = true, cursorlineopt = "both", expandtab = true, ignorecase = true, list = true, number = true, scrolloff = 999, shiftwidth = 2, signcolumn = "number", smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}, g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, localleader = ";", mapleader = " "}, key = {["<Esc>"] = _1_, ["<C-s>"] = _2_, ["."] = _3_, [","] = _4_, r = ".", q = _5_}, plugin = {snacks = {opt = {indent = {}, picker = {}}, key = {["<D-/>"] = _6_, ["<D-f>"] = _7_}}, leap = {key = {s = {cmd = _8_, mode = {"n", "o", "v"}}}}, toggleterm = _9_}, filetype = {fennel = {plugin = {nfnl = {}}}, yaml = {}}, colorscheme = "gruvbox"})
