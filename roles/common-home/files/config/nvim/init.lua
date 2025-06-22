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
    current_line = true,
  },
})

vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "m", "q")
vim.keymap.set("n", "q", "<cmd>bdelete<cr>")
vim.keymap.set("n", "Q", "<cmd>quit<cr>")

-- Snacks mappings
vim.keymap.set("n", "<leader>ff", function()
  require("snacks").picker.smart({ matcher = { cwd_bonus = false } })
end, { desc = "File" })
vim.keymap.set("n", "<leader>f/", function()
  require("snacks").picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", function()
  require("snacks").picker.buffers()
end, { desc = "Buffer" })

-- TreeSJ mappings
vim.keymap.set("n", "gs", function()
  require("treesj").toggle()
end, { desc = "Toggle single line/multiline" })

-- Leap mappings
vim.keymap.set("n", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
vim.keymap.set("n", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("timbuktu-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", function()
      require("snacks").picker.lsp_definitions()
    end, "Go to definition")
    map("gr", function()
      require("snacks").picker.lsp_references()
    end, "Go to references")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>fm", function()
      require("snacks").picker.lsp_symbols()
    end, "Symbols")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("timbuktu-lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("timbuktu-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = "timbuktu-lsp-highlight",
            buffer = event2.buf,
          })
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

require("lspconfig").elixirls.setup({
  cmd = { "elixir-ls" },
  filetypes = { "elixir", "eelixir", "heex", "elixirscript" },
})

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = { disable = { "missing-fields" } },
    },
  },
})

require("gruvbox").setup({
  inverse = true,
  invert_selection = true,
  invert_signs = true,
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    elixir = { "mix" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

require("bqf").setup({})
require("diffview").setup({})
require("flit").setup({})
require("git-conflict").setup({})
require("lazydev").setup({})
require("leap").setup({})

require("lint").linters_by_ft = {
  markdown = { "vale" },
}

require("lualine").setup({})
require("mason").setup({})
require("mason-lspconfig").setup({})
require("mini.align").setup({})
require("mini.move").setup({})
require("neoclip").setup({})
require("nvim-autopairs").setup({})
require("nvim-custom-diagnostic-highlight").setup({})
require("nvim-highlight-colors").setup({})
require("nvim-surround").setup({})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "elixir", "heex", "eex" },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
})

require("nvim-ts-autotag").setup({})

require("codecompanion").setup({})

require("quicker").setup({})
require("rainbow-delimiters.setup").setup({})
require("snacks").setup({})
require("supermaven-nvim").setup({})
require("tiny-glimmer").setup({})
require("todo-comments").setup({})
require("treesj").setup({})
require("virt-column").setup({})
require("which-key").setup({})

vim.cmd.colorscheme("gruvbox")
