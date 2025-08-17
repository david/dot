return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup({})
    require("mini.git").setup({})
    require("mini.icons").setup({})
    require("mini.move").setup({
      mappings = {
        left = "<",
        right = ">",
      },
    })
    require("mini.operators").setup({})
  end,
}
