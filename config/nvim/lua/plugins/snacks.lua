
return {
  "folke/snacks.nvim",
  opts = {
    indent = {},
    input = {},
    notifier = {},
    picker = {
      layout = {
        preset = "ivy",
        layout = {
          box = "vertical",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", height = 0.33 },
          { win = "preview", height = 0.66, border = "top" },
        },
      },
    },
    statuscolumn = {},
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("snacks").picker.smart({ matcher = { cwd_bonus = false } })
      end,
      desc = "File",
    },
    {
      "<leader>f/",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Buffer",
    },
  },
}
