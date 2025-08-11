-- [nfnl] fnl/timbuktu/config/init.fnl
local _local_1_ = require("setup")
local setup = _local_1_["setup"]
local function _2_()
  return vim.cmd.nohlsearch()
end
local function _3_()
  return vim.cmd.write()
end
local function _4_()
  return vim.cmd.wincmd({args = {"h"}})
end
local function _5_()
  return vim.cmd.wincmd({args = {"j"}})
end
local function _6_()
  return vim.cmd.wincmd({args = {"k"}})
end
local function _7_()
  return vim.cmd.wincmd({args = {"l"}})
end
local function _8_()
  return vim.cmd.bdelete()
end
setup("nvim", {colorscheme = "gruvbox", g = {loaded_node_provider = 0, loaded_perl_provider = 0, loaded_python3_provider = 0, loaded_ruby_provider = 0, localleader = ";", mapleader = " ", neovide_hide_mouse_when_typing = true, neovide_opacity = 0.85, neovide_underline_stroke_scale = 1.1}, opt = {autowrite = true, breakindent = true, colorcolumn = "100", cursorline = true, cursorlineopt = "both", expandtab = true, guifont = {"JetBrains Mono", "Symbols Nerd Font", ":h11"}, ignorecase = true, linespace = 1, list = true, number = true, scrolloff = 999, shiftwidth = 2, signcolumn = "number", smartcase = true, timeoutlen = 300, undofile = true, updatetime = 250, virtualedit = "block", showmode = false, swapfile = false}, keymap = {["<Esc>"] = _2_, ["<C-s>"] = _3_, ["<D-h>"] = _4_, ["<D-j>"] = _5_, ["<D-k>"] = _6_, ["<D-l>"] = _7_, q = _8_}})
setup("conform", {opt = {format_after_save = {async = true, lsp_format = "fallback", timeout_ms = 500}, notify_no_formatters = false}})
setup("conjure", {opt = false})
setup("direnv", {opt = false})
setup("flit", {opt = {labeled_modes = "nvo", multiline = false}})
local function _9_()
  return require("leap").leap({})
end
setup("leap", {keymap = {L = {cmd = _9_, mode = {"n", "o", "v"}}}})
setup("lint")
setup("lualine")
setup("mini.icons")
setup("mini.pairs")
setup("neo-tree")
setup("nvim-surround")
setup("nvim-treesitter")
setup("rainbow-delimiters")
local function _10_()
  return Snacks.picker.grep()
end
local function _11_()
  return Snacks.scratch()
end
local function _12_()
  return Snacks.scratch.select()
end
local function _13_()
  return Snacks.picker.smart({multi = {"buffers", "files"}, matcher = {cwd_bonus = true}})
end
setup("snacks", {opt = {dashboard = {sections = {{section = "header"}, {section = "projects", title = "Projects", padding = 1, icon = "\239\148\131 ", indent = 2}, {section = "recent_files", icon = "\239\133\155 ", title = "Files", indent = 2}}}, indent = {}, input = {}, notifier = {}, picker = {}, scratch = {}, statuscolumn = {}, terminal = {}}, keymap = {["<D-/>"] = _10_, ["<D-.>"] = _11_, ["<D->>"] = _12_, ["<D-f>"] = _13_}})
local function _14_()
  return require("substitute.exchange").operator()
end
setup("substitute", {keymap = {gx = _14_}})
setup("supermaven-nvim")
local function _15_()
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "gemini"})
  local lazydocker = Terminal:new({cmd = "lazydocker"})
  local lazygit = Terminal:new({cmd = "lazygit"})
  local repl = Terminal:new({cmd = "iex -S mix phx.server"})
  local shell = Terminal:new({display_name = "shell", direction = "horizontal"})
  local function _16_()
    return agent:toggle()
  end
  local function _17_()
    return lazydocker:toggle()
  end
  local function _18_()
    return lazygit:toggle()
  end
  local function _19_()
    return repl:toggle()
  end
  local function _20_()
    return shell:toggle((vim.o.lines * 0.4))
  end
  return {["<D-a>"] = _16_, ["<D-d>"] = _17_, ["<D-g>"] = _18_, ["<D-r>"] = _19_, ["<D-s>"] = _20_}
end
setup("toggleterm", {opt = {direction = "float", open_mapping = "<D-q>"}, keymap = _15_})
setup("which-key")
setup({"filetype", "*"}, {conform = {formatter = {"trim_whitespace"}}})
setup({"filetype", "fennel"}, {plugin = {nfnl = {}}, conform = {formatter = {"fnlfmt"}}})
setup({"filetype", "elixir"})
setup({"filetype", "heex"})
return setup({"filetype", "yaml"})
