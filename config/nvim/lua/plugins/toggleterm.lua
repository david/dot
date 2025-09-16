-- [nfnl] fnl/plugins/toggleterm.fnl
local function _1_()
  require("toggleterm").setup({direction = "float"})
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "npx https://github.com/google-gemini/gemini-cli"})
  local services = Terminal:new({cmd = "mise run services"})
  local repl = Terminal:new({cmd = "mise run console"})
  local shell = Terminal:new({display_name = "shell"})
  local map = vim.keymap.set
  local function _2_()
    return repl:toggle()
  end
  map({"i", "n"}, "<D-n>", _2_)
  local function _3_()
    return services:toggle()
  end
  map({"i", "n"}, "<D-d>", _3_)
  local function _4_()
    return shell:toggle((vim.o.lines * 0.4))
  end
  return map({"i", "n"}, "<D-s>", _4_)
end
return setup("akinsho/toggleterm.nvim", {config = _1_, lazy = false})
