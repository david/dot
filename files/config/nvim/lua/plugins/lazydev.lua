-- [nfnl] files/config/nvim/fnl/plugins/lazydev.fnl
return setup("folke/lazydev.nvim", {ft = "lua", opts = {library = {{path = "${3rd}/luv/library", words = {"vim%.uv"}}, {path = "snacks.nvim", words = {"snacks"}}}}})
