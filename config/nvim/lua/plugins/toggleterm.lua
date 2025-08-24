-- [nfnl] config/nvim/fnl/plugins/toggleterm.fnl
local function _1_()
  require("toggleterm").setup({direction = "float", open_mapping = "<D-q>"})
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new({cmd = "npx https://github.com/google-gemini/gemini-cli"})
  local services = Terminal:new({cmd = "mise run srv"})
  local repl = Terminal:new({cmd = "mise run repl"})
  local shell = Terminal:new({display_name = "shell"})
  local map = vim.keymap.set
  local function _2_()
    return agent:toggle()
  end
  map("n", "<D-a>", _2_)
  local function _3_()
    return services:toggle()
  end
  map("n", "<D-d>", _3_)
  local function _4_()
    return repl:toggle()
  end
  map("n", "<D-r>", _4_)
  local function _5_()
    return shell:toggle((vim.o.lines * 0.4))
  end
  return map("n", "<D-s>", _5_)
end
return setup("akinsho/toggleterm.nvim", {config = _1_, lazy = false})
