-- [nfnl] config/nvim/fnl/plugins/timbuktu.fnl
local function _1_()
  return vim.cmd.wincmd({args = {"h"}})
end
local function _2_()
  return vim.cmd.wincmd({args = {"j"}})
end
local function _3_()
  return vim.cmd.wincmd({args = {"k"}})
end
local function _4_()
  return vim.cmd.wincmd({args = {"l"}})
end
local function _5_()
  return vim.cmd.wincmd({args = {"H"}})
end
local function _6_()
  return vim.cmd.wincmd({args = {"J"}})
end
local function _7_()
  return vim.cmd.wincmd({args = {"K"}})
end
local function _8_()
  return vim.cmd.wincmd({args = {"L"}})
end
return setup({priority = 10000, dir = "~/.config/nvim", main = "timbuktu.setup", opts = {colorscheme = "gruvbox", g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, neovide_hide_mouse_when_typing = true, neovide_opacity = 0.85, neovide_underline_stroke_scale = 1.1}, opt = {autoread = true, autowrite = true, breakindent = true, colorcolumn = "100", cursorline = true, cursorlineopt = "both", expandtab = true, guifont = {"JetBrains Mono", "Symbols Nerd Font", ":h11"}, ignorecase = true, linespace = 1, list = true, number = true, relativenumber = true, scrolloff = 999, shiftwidth = 2, signcolumn = "yes", splitbelow = true, splitright = true, smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}}, keys = {kv("<Esc>", vim.cmd.nohlsearch), kv("<C-s>", vim.cmd.write), kv("<D-h>", _1_), kv("<D-j>", _2_), kv("<D-k>", _3_), kv("<D-l>", _4_), kv("<D-S-h>", _5_), kv("<D-S-j>", _6_), kv("<D-S-k>", _7_), kv("<D-S-l>", _8_), kv("<leader>sj", vim.cmd.split, {desc = "Below"}), kv("<leader>sl", vim.cmd.vsplit, {desc = "Right"})}, lazy = false})
