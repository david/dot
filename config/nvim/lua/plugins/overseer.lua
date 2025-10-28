-- [nfnl] fnl/plugins/overseer.fnl
return setup("stevearc/overseer.nvim", {opts = {}, keys = {kv("<leader>ro", "<cmd>OverseerRun<cr>", {desc = "Overseer"}), kv("<D-r>", "<cmd>OverseerRun<cr>"), kv("<leader>oo", "<cmd>OverseerOpen<cr>", {desc = "Overseer"})}})
