return {
  lazy = false,
  priority = 1000,
  dir = "~/.config/nvim/lua/timbuktu",
  main = "timbuktu.setup",
  opts = {
    colorscheme = "gruvbox",
    g = {
      loaded_node_provider = 0,
      loaded_perl_provider = 0,
      loaded_python3_provider = 0,
      loaded_ruby_provider = 0,
      neovide_hide_mouse_when_typing = true,
      neovide_opacity = 0.85,
      neovide_underline_stroke_scale = 1.1,
    },
    opt = {
      autowrite = true,
      breakindent = true,
      colorcolumn = "100",
      cursorline = true,
      cursorlineopt = "both",
      expandtab = true,
      guifont = { "JetBrains Mono", "Symbols Nerd Font", ":h11" },
      ignorecase = true,
      linespace = 1,
      list = true,
      number = true,
      relativenumber = true,
      scrolloff = 999,
      shiftwidth = 2,
      showmode = false,
      signcolumn = "number",
      smartcase = true,
      swapfile = false,
      timeoutlen = 300,
      undofile = true,
      updatetime = 250,
      virtualedit = "block",
    },
  },
  keys = {
    { "<Esc>", vim.cmd.nohlsearch },
    { "<C-s>", vim.cmd.write },
    {
      "<D-h>",
      function()
        vim.cmd.wincmd({ args = { "h" } })
      end,
    },
    {
      "<D-j>",
      function()
        vim.cmd.wincmd({ args = { "j" } })
      end,
    },
    {
      "<D-k>",
      function()
        vim.cmd.wincmd({ args = { "k" } })
      end,
    },
    {
      "<D-l>",
      function()
        vim.cmd.wincmd({ args = { "l" } })
      end,
    },
    { "q", vim.cmd.bdelete },
    { "<leader>sb", vim.cmd.split, desc = "Below" },
    { "<leader>sr", vim.cmd.vsplit, desc = "Right" },
  },
}
