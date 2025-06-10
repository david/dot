
return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    winopts = {
      fullscreen = true,
      preview = {
        vertical = "down:66%",
        layout = "vertical",
      },
    },
  },
}
