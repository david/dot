-- [nfnl] fnl/timbuktu/config/init.fnl
local _local_1_ = require("timbuktu.config.dsl")
local setup = _local_1_["setup"]
local function _2_()
  return vim.cmd.nohlsearch()
end
local function _3_()
  return vim.cmd.write()
end
local function _4_()
  return vim.cmd.bdelete()
end
setup("nvim", {colorscheme = "gruvbox", g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, localleader = ";", mapleader = " "}, opt = {autowrite = true, breakindent = true, colorcolumn = "100", cursorline = true, cursorlineopt = "both", expandtab = true, ignorecase = true, list = true, number = true, scrolloff = 999, shiftwidth = 2, signcolumn = "number", smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}, keymap = {["<Esc>"] = _2_, ["<C-s>"] = _3_, q = _4_}})
setup("conform", {opt = {format_after_save = {async = true, lsp_format = "fallback", timeout_ms = 500}, notify_no_formatters = false}})
setup("flit", {opt = {labeled_modes = "nvo"}})
local function _5_()
  return require("leap").leap({})
end
setup("leap", {keymap = {s = {cmd = _5_, mode = {"n", "o", "v"}}}})
setup("lint")
setup("lualine")
setup("mini.icons")
setup("mini.pairs")
setup("nvim-surround")
setup("nvim-treesitter")
setup("rainbow-delimiters")
local function _6_()
  return Snacks.picker.grep()
end
local function _7_()
  return Snacks.picker.smart({multi = {"buffers", "files"}, matcher = {cwd_bonus = true}})
end
setup("snacks", {opt = {indent = {}, picker = {}}, keymap = {["<D-/>"] = _6_, ["<D-f>"] = _7_}})
setup("substitute", {keymap = {x = require("substitute.exchange").operator}})
setup("supermaven-nvim")
local function _8_(...)
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "gemini", direction = "float"})
  local lazydocker = Terminal:new({cmd = "lazydocker", direction = "float"})
  local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
  local repl = Terminal:new({cmd = "iex -S mix phx.server", direction = "float"})
  local shell = Terminal:new({display_name = "shell"})
  local function _9_()
    return agent:toggle()
  end
  local function _10_()
    return lazydocker:toggle()
  end
  local function _11_()
    return lazygit:toggle()
  end
  local function _12_()
    return repl:toggle()
  end
  local function _13_()
    return shell:toggle((vim.o.lines * 0.33))
  end
  return {opt = {direction = "float", open_mapping = "<D-q>"}, keymap = {["<D-a>"] = _9_, ["<D-d>"] = _10_, ["<D-g>"] = _11_, ["<D-r>"] = _12_, ["<D-s>"] = _13_}}
end
setup("toggleterm", _8_(...))
setup("which-key")
setup({"filetype", "*"}, {conform = {formatter = {"trim_whitespace"}}})
setup({"filetype", "fennel"}, {plugin = {nfnl = {}}, conform = {formatter = {"fnlfmt"}}})
setup({"filetype", "elixir"})
setup({"filetype", "heex"})
return setup({"filetype", "yaml"})
