return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      globalstatus = true,
      sections = {
        lualine_x = {
          "overseer",
          { require("opencode").statusline },
        },
      },
    })
  end,
  dependencies = {
    { "nickvandyke/opencode.nvim" },
  },
}
