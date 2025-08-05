-- [nfnl] fnl/timbuktu/config/init.fnl
local _local_1_ = require("timbuktu.config.dsl")
local core = _local_1_["core"]
local filetype = _local_1_["filetype"]
local plugin = _local_1_["plugin"]
local colorscheme = _local_1_["colorscheme"]
local function _2_()
  return vim.cmd.nohlsearch()
end
local function _3_()
  return vim.cmd.write()
end
local function _4_()
  return vim.cmd.bnext()
end
local function _5_()
  return vim.cmd.bprevious()
end
local function _6_()
  return vim.cmd.bdelete()
end
core({opt = {autowrite = true, breakindent = true, cursorline = true, cursorlineopt = "both", expandtab = true, ignorecase = true, list = true, number = true, scrolloff = 999, shiftwidth = 2, signcolumn = "number", smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}, g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, localleader = ";", mapleader = " "}, key = {["<Esc>"] = _2_, ["<C-s>"] = _3_, ["."] = _4_, [","] = _5_, r = ".", q = _6_}})
local function _7_()
  return Snacks.picker.grep()
end
local function _8_()
  return Snacks.picker.smart({multi = {"buffers", "files"}, matcher = {cwd_bonus = true}})
end
plugin("snacks", {opt = {indent = {}, picker = {}}, key = {["<D-/>"] = _7_, ["<D-f>"] = _8_}})
local function _9_()
  return require("leap").leap({})
end
plugin("leap", {key = {s = _9_}})
local function _10_(...)
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "gemini", direction = "float"})
  local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
  local function _11_()
    return agent:toggle()
  end
  local function _12_()
    return lazygit:toggle()
  end
  return {opt = {direction = "float", open_mapping = "<D-t>"}, key = {["<D-a>"] = _11_, ["<D-g>"] = _12_}}
end
plugin("toggleterm", _10_(...))
filetype("fennel", {plugin = {nfnl = {}}})
filetype("yaml")
return colorscheme("gruvbox")
