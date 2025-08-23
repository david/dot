-- [nfnl] fnl/plugins/markview.fnl
return setup("OXY2DEV/markview.nvim", {priority = 40, opts = {preview = {filetypes = {"markdown", "codecompanion"}, ignore_buftypes = {}}}, lazy = false})
