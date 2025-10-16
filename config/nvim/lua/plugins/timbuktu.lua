-- [nfnl] config/nvim/fnl/plugins/timbuktu.fnl
local function _1_()
  vim.cmd.bufdo({args = {"bd"}})
  return vim.cmd.vsplit()
end
local function _2_()
  return vim.cmd.wincmd({args = {"h"}})
end
local function _3_()
  return vim.cmd.wincmd({args = {"j"}})
end
local function _4_()
  return vim.cmd.wincmd({args = {"k"}})
end
local function _5_()
  return vim.cmd.wincmd({args = {"l"}})
end
local function _6_()
  return vim.cmd.wincmd({args = {"q"}})
end
local function _7_()
  return vim.cmd.wincmd({args = {"H"}})
end
local function _8_()
  return vim.cmd.wincmd({args = {"J"}})
end
local function _9_()
  return vim.cmd.wincmd({args = {"K"}})
end
local function _10_()
  return vim.cmd.wincmd({args = {"L"}})
end
local function _11_()
  vim.cmd.vsplit()
  return vim.cmd.wincmd({args = {"h"}})
end
local function _12_()
  vim.cmd.vsplit()
  return vim.cmd.wincmd({args = {"k"}})
end
local function _13_()
  return vim.cmd.wincmd({args = {"q"}})
end
return setup({priority = 10000, dir = "~/.config/nvim", main = "timbuktu.setup", opts = {colorscheme = "gruvbox", g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, neovide_hide_mouse_when_typing = true, neovide_opacity = 0.85, neovide_underline_stroke_scale = 1.1}, opt = {autoread = true, autowrite = true, breakindent = true, colorcolumn = "100", cursorline = true, cursorlineopt = "both", expandtab = true, guifont = {"JetBrains Mono", "Symbols Nerd Font", ":h11"}, ignorecase = true, iskeyword = "@,48-57,192-255", laststatus = 3, linespace = 1, list = true, number = true, relativenumber = true, scrollback = 24576, scrolloff = 999, shiftwidth = 2, signcolumn = "yes", splitbelow = true, splitright = true, smartcase = true, timeoutlen = 300, undofile = true, undolevels = 2048, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}}, keys = {kv("<Esc>", vim.cmd.nohlsearch), kv("<Esc><Esc>", "<C-\\><C-n>", {mode = {"t"}}), kv("<A-p>", "pV`]"), kv("<A-P>", "PV`]"), kv("<C-S-v>", "<C-\\><C-o>p", {mode = {"t"}}), kv("<C-q>", _1_), kv("<C-s>", vim.cmd.write), kv("<D-h>", _2_, {mode = {"i", "n", "t"}}), kv("<D-j>", _3_, {mode = {"i", "n", "t"}}), kv("<D-k>", _4_, {mode = {"i", "n", "t"}}), kv("<D-l>", _5_, {mode = {"i", "n", "t"}}), kv("<D-q>", _6_, {mode = {"i", "n", "t"}}), kv("<D-C-h>", _7_), kv("<D-C-j>", _8_), kv("<D-C-k>", _9_), kv("<D-C-l>", _10_), kv("<D-L>", vim.cmd.vsplit, {mode = {"i", "n"}}), kv("<D-H>", _11_, {mode = {"i", "n"}}), kv("<D-J>", vim.cmd.split, {mode = {"i", "n"}}), kv("<D-K>", _12_, {mode = {"i", "n"}}), kv("<leader>ol", "<cmd>Lazy<cr>", {desc = "Lazy"}), kv("<leader>sj", vim.cmd.split, {desc = "Below"}), kv("<leader>sl", vim.cmd.vsplit, {desc = "Right"}), kv("<localleader>cd", vim.diagnostic.open_float, {desc = "Line Diagnostics"}), kv("q", _13_), kv("m", "q", {desc = "Macro"})}, lazy = false})
