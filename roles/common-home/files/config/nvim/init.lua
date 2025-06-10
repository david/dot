vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = " "

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "marker"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { nbsp = "󱁐", tab = "⭾ ", trail = "󰈅" }
vim.opt.mouse = ""
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.titlestring = "󰅩 %{expand('%:h:t')}/%{expand('%:t')}"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.diagnostic.config({
  virtual_lines = {
    current_line = true
  }
})

vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "m", "q")
vim.keymap.set("n", "q", "<cmd>bdelete<cr>")
vim.keymap.set("n", "Q", "<cmd>quit<cr>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  checker = { enabled = true },
})

vim.cmd.colorscheme("gruvbox")
