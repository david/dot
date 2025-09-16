-- [nfnl] fnl/plugins/octo.fnl
return setup("pwntester/octo.nvim", {opts = {picker = "snacks", default_to_projects_v2 = true}, keys = {kv("<leader>fi", "<cmd>Octo issue list<cr>", {desc = "Issues"})}, dependencies = {"nvim-lua/plenary.nvim", "folke/snacks.nvim", "nvim-tree/nvim-web-devicons"}})
