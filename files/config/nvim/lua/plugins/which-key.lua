-- [nfnl] fnl/plugins/which-key.fnl
return setup("folke/which-key.nvim", {opts = {spec = {kv("<leader>f", {group = "Find"}), kv("<leader>s", {group = "Split"})}}})
