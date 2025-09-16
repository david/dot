-- [nfnl] config/nvim/fnl/plugins/bufferline.fnl
return setup("akinsho/bufferline.nvim", {opts = {options = {diagnostics = "nvim_lsp", show_close_icon = false}}, keys = {kv("<D-,>", "<cmd>BufferLineCyclePrev<cr>", {mode = {"i", "n"}}), kv("<D-.>", "<cmd>BufferLineCycleNext<cr>", {mode = {"i", "n"}})}, dependencies = {"nvim-tree/nvim-web-devicons"}, version = "*", lazy = false})
