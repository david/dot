-- [nfnl] fnl/plugins/overseer.fnl
return setup("stevearc/overseer.nvim", {opts = {strategy = "toggleterm"}, keys = {kv("<leader>ro", "<cmd>OverseerRun<cr>", {desc = "Overseer"})}})
