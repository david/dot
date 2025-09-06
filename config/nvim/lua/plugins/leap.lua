-- [nfnl] config/nvim/fnl/plugins/leap.fnl
return setup("ggandor/leap.nvim", {opts = {}, keys = {kv("L", "<Plug>(leap)", {mode = {"n", "v", "o"}})}, dependencies = {"tpope/vim-repeat"}})
