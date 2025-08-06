-- [nfnl] fnl/timbuktu/config/init.fnl
local configure = require("timbuktu.config.dsl").configure
local function _1_()
  return vim.cmd.nohlsearch()
end
local function _2_()
  return vim.cmd.write()
end
local function _3_()
  return vim.cmd.bdelete()
end
local function _4_()
  return require("leap").leap({})
end
local function _5_()
  return Snacks.picker.grep()
end
local function _6_()
  return Snacks.picker.smart({multi = {"buffers", "files"}, matcher = {cwd_bonus = true}})
end
local _7_
do
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "gemini", direction = "float"})
  local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
  local shell = Terminal:new()
  local function _8_()
    return agent:toggle()
  end
  local function _9_()
    return lazygit:toggle()
  end
  local function _10_()
    return shell:toggle()
  end
  _7_ = {opts = {direction = "float", open_mapping = "<D-q>"}, keymaps = {["<D-a>"] = _8_, ["<D-g>"] = _9_, ["<D-s>"] = _10_}}
end
return configure({opts = {autowrite = true, breakindent = true, colorcolumn = "100", cursorline = true, cursorlineopt = "both", expandtab = true, ignorecase = true, list = true, number = true, scrolloff = 999, shiftwidth = 2, signcolumn = "number", smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}, g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, localleader = ";", mapleader = " "}, keymaps = {["<Esc>"] = _1_, ["<C-s>"] = _2_, q = _3_}, plugins = {conform = {opts = {formatters_by_ft = {fennel = {"fnlfmt"}}, format_on_save = {async = true, lsp_format = "fallback", timeout_ms = 5000}, notify_no_formatters = false}}, leap = {keymaps = {s = {cmd = _4_, mode = {"n", "o", "v"}}}}, lint = {}, lualine = {}, ["mini.icons"] = {}, ["mini.pairs"] = {}, ["rainbow-delimiters"] = {}, snacks = {opts = {indent = {}, picker = {}}, keymaps = {["<D-/>"] = _5_, ["<D-f>"] = _6_}}, toggleterm = _7_, ["which-key"] = {}}, filetypes = {fennel = {plugins = {nfnl = {}}}, yaml = {}}, colorscheme = "gruvbox"})
