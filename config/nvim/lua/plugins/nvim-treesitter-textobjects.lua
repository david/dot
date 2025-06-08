
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  main = "nvim-treesitter.configs",
  opts = {
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
  },
}
