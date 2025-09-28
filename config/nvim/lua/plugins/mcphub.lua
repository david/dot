-- [nfnl] config/nvim/fnl/plugins/mcphub.fnl
return setup("ravitemer/mcphub.nvim", {opts = {}, dependencies = {"nvim-lua/plenary.nvim"}, build = "npm install -g mcp-hub@latest"})
