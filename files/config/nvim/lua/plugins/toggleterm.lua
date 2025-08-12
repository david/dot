return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  config = function()
    require("toggleterm").setup({ direction = "float", open_mapping = "<D-q>" })

    local Terminal = require("toggleterm.terminal").Terminal

    local agent = Terminal:new({ cmd = "gemini" })
    local lazydocker = Terminal:new({ cmd = "lazydocker" })
    local lazygit = Terminal:new({ cmd = "lazygit" })
    local repl = Terminal:new({ cmd = "iex -S mix phx.server" })
    local shell = Terminal:new({ display_name = "shell", direction = "horizontal" })

    local map = vim.keymap.set

    map("n", "<D-a>", function()
      agent:toggle()
    end)

    map("n", "<D-d>", function()
      lazydocker:toggle()
    end)

    map("n", "<D-g>", function()
      lazygit:toggle()
    end)

    map("n", "<D-r>", function()
      repl:toggle()
    end)

    map("n", "<D-s>", function()
      shell:toggle(vim.o.lines * 0.4)
    end)
  end,
}
