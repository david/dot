return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    dashboard = {
      width = 82,
      preset = {
        header = [[
░██████████░██                ░██                   ░██          ░██
    ░██                       ░██                   ░██          ░██
    ░██    ░██░█████████████  ░████████  ░██    ░██ ░██    ░██░████████ ░██    ░██
    ░██    ░██░██   ░██   ░██ ░██    ░██ ░██    ░██ ░██   ░██    ░██    ░██    ░██
    ░██    ░██░██   ░██   ░██ ░██    ░██ ░██    ░██ ░███████     ░██    ░██    ░██
    ░██    ░██░██   ░██   ░██ ░███   ░██ ░██   ░███ ░██   ░██    ░██    ░██   ░███
    ░██    ░██░██   ░██   ░██ ░██░█████   ░█████░██ ░██    ░██    ░████  ░█████░██]],
      },
      formats = {
        header = { "%s", align = "left" },
      },
      sections = {
        { section = "header", indent = 0 },
        {
          section = "projects",
          title = "Projects",
          padding = 1,
          icon = " ",
          indent = 2,
        },
        {
          section = "recent_files",
          icon = " ",
          title = "Files",
          indent = 2,
        },
      },
    },
    indent = {},
    input = {},
    notifier = {},
    picker = {},
    scratch = {},
    statuscolumn = {},
  },
  keys = {
    {
      "<leader>fc",
      function()
        Snacks.picker.cliphist()
      end,
      desc = "Clipboard history",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Files",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help tags",
    },
    {
      "<leader>fi",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>fn",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notifications",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<D-/>",
      function()
        Snacks.picker.grep()
      end,
    },
    {
      "<D-.>",
      function()
        Snacks.scratch()
      end,
    },
    {
      "<D->>",
      function()
        Snacks.scratch.select()
      end,
    },
    {
      "<D-f>",
      function()
        Snacks.picker.smart({
          multi = { "buffers", "files" },
          matcher = { "cwd_bonus", true },
        })
      end,
    },
  },
}
