-- [nfnl] files/config/nvim/fnl/plugins/copilot.fnl
return setup("zbirenbaum/copilot.lua", {cmd = "Copilot", event = "InsertEnter", opts = {suggestion = {enabled = false}, panel = {enabled = false}}})
