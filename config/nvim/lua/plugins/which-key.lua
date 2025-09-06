-- [nfnl] config/nvim/fnl/plugins/which-key.fnl
return setup("folke/which-key.nvim", {opts = {spec = {kv("<leader>N", {group = "Neovim"}), kv("<leader>f", {group = "Find"}), kv("<leader>r", {group = "Run Tests"}), kv("<leader>s", {group = "Split"})}}})
