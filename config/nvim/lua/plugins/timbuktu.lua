return {
  priority = 10000,
  lazy = false,
  dir = "~/.config/nvim",
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
      neovide_padding_top = 20,
      neovide_padding_right = 20,
      neovide_padding_bottom = 20,
      neovide_padding_left = 20,
      neovide_underline_stroke_scale = 1.1,
    },
    opt = {
      autoread = true,
      autowrite = true,
      breakindent = true,
      clipboard = "unnamedplus",
      colorcolumn = "100",
      cursorline = true,
      cursorlineopt = "both",
      expandtab = true,
      guifont = { "JetBrains Mono", "Symbols Nerd Font", ":h11.25" },
      ignorecase = true,
      iskeyword = "@,48-57,192-255",
      laststatus = 3,
      linespace = 1,
      list = true,
      number = false,
      relativenumber = false,
      scrollback = 24576,
      scrolloff = 999,
      shiftwidth = 2,
      signcolumn = "yes",
      splitbelow = true,
      splitright = true,
      smartcase = true,
      timeoutlen = 300,
      undofile = true,
      undolevels = 2048,
      updatetime = 250,
      virtualedit = "block",
      showmode = false,
      swapfile = false,
    },
  },
  keys = {
    { "<Esc>", vim.cmd.nohlsearch },
    { "<Esc><Esc>", "<C-\\><C-n>", mode = { "t" } },
    { "<A-p>", "pV`]" },
    { "<A-P>", "PV`]" },
    { "<C-S-v>", "<C-\\><C-o>p", mode = { "t" } },
    {
      "<C-q>",
      function()
        vim.cmd.bufdo({ args = { "bd" } })
        vim.cmd.vsplit()
      end,
    },
    { "<C-s>", vim.cmd.write },
    { "<D-,>", "<cmd>bprevious<cr>", mode = { "i", "n" } },
    { "<D-.>", "<cmd>bnext<cr>", mode = { "i", "n" } },
    {
      "<D-h>",
      function() vim.cmd.wincmd({ args = { "h" } }) end,
      mode = { "i", "n", "t" },
    },
    {
      "<D-j>",
      function() vim.cmd.wincmd({ args = { "j" } }) end,
      mode = { "i", "n", "t" },
    },
    {
      "<D-k>",
      function() vim.cmd.wincmd({ args = { "k" } }) end,
      mode = { "i", "n", "t" },
    },
    {
      "<D-l>",
      function() vim.cmd.wincmd({ args = { "l" } }) end,
      mode = { "i", "n", "t" },
    },
    {
      "<D-q>",
      function() vim.cmd.wincmd({ args = { "q" } }) end,
      mode = { "i", "n", "t" },
    },
    {
      "<D-C-h>",
      function() vim.cmd.wincmd({ args = { "H" } }) end,
    },
    {
      "<D-C-j>",
      function() vim.cmd.wincmd({ args = { "J" } }) end,
    },
    {
      "<D-C-k>",
      function() vim.cmd.wincmd({ args = { "K" } }) end,
    },
    {
      "<D-C-l>",
      function() vim.cmd.wincmd({ args = { "L" } }) end,
    },
    { "<D-L>", vim.cmd.vsplit, mode = { "i", "n" } },
    {
      "<D-H>",
      function()
        vim.cmd.vsplit()
        vim.cmd.wincmd({ args = { "h" } })
      end,
      mode = { "i", "n" },
    },
    { "<D-J>", vim.cmd.split, { mode = { "i", "n" } } },
    {
      "<D-K>",
      function()
        vim.cmd.vsplit()
        vim.cmd.wincmd({ args = { "k" } })
      end,
      mode = { "i", "n" },
    },
    { "<leader>ol", "<cmd>Lazy<cr>", desc = "Lazy" },
    { "<leader>sj", vim.cmd.split, desc = "Below" },
    { "<leader>sl", vim.cmd.vsplit, desc = "Right" },
    { "<localleader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    {
      "q",
      function() vim.cmd.wincmd({ args = { "q" } }) end,
    },
    { "m", "q", desc = "Macro" },
  },
}
