-- [nfnl] files/config/nvim/fnl/plugins/treesitter.fnl
return setup("nvim-treesitter/nvim-treesitter", {branch = "master", build = ":TSUpdate", main = "nvim-treesitter.configs", opts = {ensure_installed = {"embedded_template", "fennel", "javascript", "json", "regex", "ruby", "yaml"}, highlight = {enable = true}, indent = {enable = true}}, dependencies = {"OXY2DEV/markview.nvim"}, lazy = false})
