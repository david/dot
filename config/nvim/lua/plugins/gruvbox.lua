
return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      inverse = true,
      invert_selection = true,
      invert_signs = true,
    })
  end,
}
