-- [nfnl] fnl/plugins/snacks.fnl
local function _1_()
  return Snacks.picker.buffers()
end
local function _2_()
  return Snacks.picker.cliphist()
end
local function _3_()
  return Snacks.picker.diagnostics()
end
local function _4_()
  return Snacks.picker.files()
end
local function _5_()
  return Snacks.picker.help()
end
local function _6_()
  return Snacks.picker.icons()
end
local function _7_()
  return Snacks.picker.keymaps()
end
local function _8_()
  return Snacks.picker.highlights()
end
local function _9_()
  return Snacks.picker.notifications()
end
local function _10_()
  return Snacks.picker.registers()
end
local function _11_()
  return Snacks.picker.lsp_workspace_symbols()
end
local function _12_()
  return Snacks.picker.grep()
end
local function _13_()
  return Snacks.scratch()
end
local function _14_()
  return Snacks.scratch.select()
end
local function _15_()
  return Snacks.picker.explorer()
end
local function _16_()
  return Snacks.picker.smart()
end
local function _17_()
  return Snacks.lazygit()
end
local function _18_()
  return Snacks.bufdelete()
end
local function _19_()
  return Snacks.picker.lines()
end
local function _20_()
  return Snacks.picker.lsp_definitions()
end
local function _21_()
  return Snacks.picker.lsp_declarations()
end
local function _22_()
  return Snacks.picker.lsp_references()
end
local function _23_()
  return Snacks.picker.lsp_implementations()
end
local function _24_()
  return Snacks.picker.lsp_symbols()
end
local function _25_()
  return Snacks.picker.lsp_workspace_symbols()
end
return setup("folke/snacks.nvim", {priority = 1000, opts = {bufdelete = {}, explorer = {}, git = {}, indent = {}, input = {}, lazygit = {}, notifier = {}, picker = {formatters = {file = {filename_first = true, truncate = 50}}, matcher = {frecency = true, history_bonus = true, cwd_bonus = false}}, scope = {}, scratch = {}, statuscolumn = {}}, keys = {kv("<leader>fb", _1_, {desc = "Buffers"}), kv("<leader>fc", _2_, {desc = "Clipboard history"}), kv("<leader>fd", _3_, {desc = "Diagnostics"}), kv("<leader>ff", _4_, {desc = "Files"}), kv("<leader>fh", _5_, {desc = "Help tags"}), kv("<leader>fi", _6_, {desc = "Icons"}), kv("<leader>fk", _7_, {desc = "Keymaps"}), kv("<leader>fl", _8_, {desc = "Highlights"}), kv("<leader>fn", _9_, {desc = "Notifications"}), kv("<leader>fr", _10_, {desc = "Registers"}), kv("<leader>fs", _11_, {desc = "Symbols"}), kv("<D-/>", _12_), kv("<D-.>", _13_), kv("<D->>", _14_), kv("<D-e>", _15_), kv("<D-f>", _16_, {mode = {"i", "n"}}), kv("<D-g>", _17_), kv("Q", _18_), kv("g/", _19_, {desc = "Grep buffers"}), kv("gd", _20_, {desc = "Goto Definition"}), kv("gD", _21_, {desc = "Goto Declaration"}), kv("gr", _22_, "nowait", true, "desc", "References"), kv("gI", _23_, {desc = "Goto Implementation"}), kv("gy", _24_, {desc = "Goto T[y]pe Definition"}), kv("gY", _25_, {desc = "Goto T[y]pe Definition"})}, lazy = false})
