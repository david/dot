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
  return Snacks.picker.smart({multi = {"buffers", "files"}, matcher = {cwd_bonus = true}})
end
local function _5_()
  return Snacks.picker.grep()
end
local function _6_()
  return vim.cmd.bnext()
end
local function _7_()
  return vim.cmd.bprevious()
end
local function _8_()
  return require("leap").leap({})
end
local function _9_()
  return vim.cmd.bdelete()
end
core({opt = {autowrite = true, breakindent = true, cursorline = true, cursorlineopt = "both", expandtab = true, ignorecase = true, list = true, number = true, scrolloff = 999, shiftwidth = 2, signcolumn = "number", smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}, g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, localleader = ";", mapleader = " "}, key = {["<Esc>"] = _2_, ["<C-s>"] = _3_, ["<D-f>"] = _4_, ["<D-/>"] = _5_, ["."] = _6_, [","] = _7_, r = ".", s = _8_, q = _9_}})
plugin("snacks", {opt = {indent = {}, picker = {}}})
plugin("leap")
filetype("fennel", {plugin = {nfnl = {}}})
filetype("yaml")
return colorscheme("gruvbox")
