(setup :folke/which-key.nvim
       {:opts {:spec [(kv :<leader>f {:group :Find})
                      (kv :<leader>r {:group "Run Tests"})
                      (kv :<leader>s {:group :Split})]}})
