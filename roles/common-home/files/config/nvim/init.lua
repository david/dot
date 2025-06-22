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
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { nbsp = "󱁐", tab = "⭾ ", trail = "󰈅" }
vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 999
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = "yes"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.title = true
vim.opt.titlestring = "󰅩 %{expand('%:h:t')}/%{expand('%:t')}"
vim.opt.undofile = true

vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

vim.opt.virtualedit = "block"

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.keymap.set("n", "<leader>ff", function()
  require("snacks").picker.smart({ matcher = { cwd_bonus = false } })
end, { desc = "File" })
vim.keymap.set("n", "<leader>f/", function()
  require("snacks").picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", function()
  require("snacks").picker.buffers()
end, { desc = "Buffer" })

vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "Q", "<cmd>quit<cr>")

vim.keymap.set("n", "gs", function()
  require("treesj").toggle()
end, { desc = "Toggle single line/multiline" })

vim.keymap.set("n", "m", "q")

-- Leap mappings
vim.keymap.set("n", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
vim.keymap.set("n", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })

vim.keymap.set("n", "q", "<cmd>bdelete<cr>")

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
  format_on_save = function()
    if next(vim.fs.find({ "mix.exs" }, { limit = 1 })) == nil then
      return { timeout_ms = 500, lsp_format = "fallback" }
    else
      return { timeout_ms = 2000, lsp_format = "fallback" }
    end
  end,

  formatters_by_ft = {
    lua = { "stylua" },
    elixir = { "mix" },
    eelixir = { "mix" },
    heex = { "mix" },
    lua = { "stylua" },
    ruby = { "rubocop" },
    ["*"] = { "trim_whitespace" },
  },

  notify_no_formatters = false,
  notify_on_error = false,
})

require("bqf").setup({})

require("codecompanion").setup({})

require("diffview").setup({})

require("flit").setup({
  labeled_mods = "nvo",
  multiline = false,
})

require("git-conflict").setup({})

require("lazydev").setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})

require("leap").setup({})

require("lint").linters_by_ft = {
  markdown = { "vale" },
}

require("lualine").setup({
  options = {
    theme = "gruvbox",
  },
})

require("gitsigns").setup({
  current_line_blame = true,
  numhl = true,

  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk)
    map("n", "<leader>hr", gitsigns.reset_hunk)

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hp", gitsigns.preview_hunk)
    map("n", "<leader>hi", gitsigns.preview_hunk_inline)

    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end)

    map("n", "<leader>hd", gitsigns.diffthis)

    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end)

    map("n", "<leader>hQ", function()
      gitsigns.setqflist("all")
    end)
    map("n", "<leader>hq", gitsigns.setqflist)

    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>tw", gitsigns.toggle_word_diff)

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
})

require("mini.align").setup({})
require("mini.move").setup({})
require("nvim-autopairs").setup({})
require("nvim-custom-diagnostic-highlight").setup({})
require("nvim-highlight-colors").setup({})

local lint = require("lint")

local group = vim.api.nvim_create_augroup("timbuktu-lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = group,
  callback = function()
    lint.try_lint()
  end,
})

require("nvim-surround").setup({})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "eex",
    "elixir",
    "embedded_template",
    "heex",
    "html",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "regex",
    "ruby",
    "vim",
    "vimdoc",
  },

  endwise = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "ruby" },
  },

  incremental_selection = { enable = true },

  indent = {
    enable = true,
    disable = { "ruby" },
  },

  matchup = {
    enable = true,
  },

  textobjects = {
    lsp_interop = {
      enable = true,
    },

    move = {
      enable = true,
      goto_next_start = {
        ["<M-a>"] = "@parameter.inner",
        ["<M-f>"] = "@function.outer",
        ["<M-b>"] = "@block.outer",
      },
      goto_prev_start = {
        ["<M-S-a>"] = "@parameter.inner",
        ["<M-S-f>"] = "@function.outer",
        ["<M-S-b>"] = "@block.outer",
      },
    },

    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["gwa"] = "@parameter.inner",
      },
      swap_previous = {
        ["gwA"] = "@parameter.inner",
      },
    },
  },
})

require("nvim-ts-autotag").setup({})

require("quicker").setup({
  keys = {
    {
      ">",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

require("rainbow-delimiters.setup").setup({})

require("snacks").setup({
  indent = {},

  input = {},

  notifier = {},

  picker = {
    layout = {
      preset = "ivy",
      layout = {
        box = "vertical",
        height = 0.9,
        width = 0.8,
        { win = "input", height = 1, border = "bottom" },
        { win = "list", height = 0.33 },
        { win = "preview", height = 0.66, border = "top" },
      },
    },
  },

  statuscolumn = {},
})

require("supermaven-nvim").setup({})
require("tiny-glimmer").setup({})
require("todo-comments").setup({})
require("treesj").setup({
  use_default_keymaps = false,
})
require("virt-column").setup({})
require("which-key").setup({
  icons = {
    mappings = true,
  },
  preset = "helix",
  spec = {
    { "<leader>/", group = "Search" },
    { "<leader>b", group = "Buffer" },
    { "<leader>c", group = "Code" },
    { "<leader>e", group = "Edit" },
    { "<leader>f", group = "Find" },
    { "<leader>h", group = "Help" },
    { "<leader>r", group = "Refactor" },
    { "<leader>v", group = "Version control" },
    { "<leader>w", group = "Workspace" },
  },
  win = {
    border = "none",
  },
})

vim.cmd.colorscheme("gruvbox")
