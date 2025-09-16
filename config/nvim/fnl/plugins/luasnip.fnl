(setup :L3MON4D3/LuaSnip
       {:config (fn []
                  ((. (require :luasnip.loaders.from_lua) :lazy_load) {:paths "~/.config/nvim/snippets"})
                  ((. (require :luasnip) :config :set_config) {:enable_autosnippets true}))
        :keys [(kv :<C-j> #((. (require :luasnip) :expand_or_jump))
                   {:mode [:i :s]})]})
