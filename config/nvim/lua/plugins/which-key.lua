-- [nfnl] fnl/plugins/which-key.fnl
return setup("folke/which-key.nvim", {opts = {spec = {kv("<leader>N", {group = "Neovim"}), kv("<leader>f", {group = "Find"}), kv("<leader>n", {group = "New"}), kv("<leader>o", {group = "Open"}), kv("<leader>r", {group = "Run"}), kv("<leader>s", {group = "Split"})}}})
