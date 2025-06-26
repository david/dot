local T = require("toggleterm.terminal").Terminal

function Terminal(opts, defaults)
  return T:new(vim.tbl_extend("force", defaults or {}, opts))
end

function FloatTerm(opts)
  return Terminal(opts, {
    direction = "float",
    hidden = true,
    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.9),
      winblend = 0,
    },
  })
end

local LazyGit = FloatTerm({ cmd = "lazygit" })
local Shell = Terminal({ cmd = "bash" })

require("toggleterm").setup({
  direction = "horizontal",
  highlights = {
    FloatBorder = {
      link = "NormalFloat",
    },
  },
  open_mapping = "<D-s>",
  size = function()
    return vim.o.lines * 0.4
  end,
  winbar = {
    enabled = true,
  },
})

return {
  lazygit = { toggle = function() LazyGit:toggle() end },
  shell = { toggle = function() Shell:toggle() end },
}
