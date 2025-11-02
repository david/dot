return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    bufdelete = {},
    explorer = {},
    git = {},
    indent = {},
    input = {},
    lazygit = {},
    notifier = {},
    picker = {
      formatters = { file = { filename_first = true, truncate = 50 } },
      layout = {
        layout = {
          width = 0.9,
          height = 0.9,
        },
      },
      matcher = { frecency = true, history_bonus = true, cwd_bonus = false },
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 0.2,
            },
          },
        },
      },
    },
    scope = {},
    scratch = {},
    statuscolumn = {},
  },
  keys = {
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function() Snacks.picker.cliphist() end,
      desc = "Clipboard history",
    },
    {
      "<leader>fd",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics",
    },
    {
      "<leader>ff",
      function() Snacks.picker.files() end,
      desc = "Files",
    },
    {
      "<leader>fh",
      function() Snacks.picker.help() end,
      desc = "Help tags",
    },
    {
      "<leader>fI",
      function() Snacks.picker.icons() end,
      desc = "Icons",
    },
    {
      "<leader>fk",
      function() Snacks.picker.keymaps() end,
      desc = "Keymaps",
    },
    {
      "<leader>fl",
      function() Snacks.picker.highlights() end,
      desc = "Highlights",
    },
    {
      "<leader>fn",
      function() Snacks.picker.notifications() end,
      desc = "Notifications",
    },
    {
      "<leader>fr",
      function() Snacks.picker.registers() end,
      desc = "Registers",
    },
    {
      "<leader>fs",
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = "Symbols",
    },
    {
      "<D-/>",
      function() Snacks.picker.grep() end,
      mode = { "i", "n" },
    },
    {
      "<D-b>",
      function() Snacks.picker.buffers() end,
      mode = { "i", "n" },
    },
    {
      "<D-d>",
      function() Snacks.terminal("mise run services") end,
      mode = { "i", "n" },
    },
    {
      "<D-e>",
      function() Snacks.picker.explorer() end,
      mode = { "i", "n" },
    },
    {
      "<D-f>",
      function() Snacks.picker.smart() end,
      mode = { "i", "n" },
    },
    {
      "<D-g>",
      function() Snacks.lazygit() end,
      mode = { "i", "n" },
    },
    {
      "<D-n>",
      function() Snacks.terminal("mise run console") end,
      mode = { "i", "n" },
    },
    {
      "<D-s>",
      function() Snacks.terminal("/usr/bin/env bash") end,
      mode = { "i", "n" },
    },
    {
      "Q",
      function() Snacks.bufdelete() end,
    },
    {
      "g/",
      function() Snacks.picker.lines() end,
      desc = "Grep buffers",
    },
    {
      "gd",
      function() Snacks.picker.lsp_definitions() end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function() Snacks.picker.lsp_declarations() end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function() Snacks.picker.lsp_references() end,
      desc = "References",
    },
    {
      "gI",
      function() Snacks.picker.lsp_implementations() end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function() Snacks.picker.lsp_symbols() end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "gY",
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = "Goto T[y]pe Definition",
    },
  },
}
