return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    bufdelete = {},
    dashboard = {
      autokeys = "asdfghjkl;",
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
        { section = "startup" },
      },
      width = 82,
    },
    git = {},
    indent = {},
    input = {},
    lazygit = {},
    notifier = {},
    picker = {
      win = {
        input = {
          keys = {
            ["<a-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
          },
        },
      },
      actions = {
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },
    },
    scope = {},
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
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
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
    {
      "<D-g>",
      function()
        Snacks.lazygit()
      end,
    },
    {
      "q",
      function()
        Snacks.bufdelete()
      end,
    },
  },
}
