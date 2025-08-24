(setup :folke/flash.nvim
       {:event :VeryLazy
        :opts {:modes {:search {:enabled true}}}
        :keys [(kv :s #((. (require :flash) :jump))
                   {:mode [:n :x :o] :desc :Flash})
               (kv :S #((. (require :flash) :treesitter))
                   {:mode [:n :x :o] :desc "Flash Treesitter"})
               (kv :r #((. (require :flash) :remote))
                   {:mode :o :desc "Remote Flash"})
               (kv :R #((. (require :flash) :treesitter_search))
                   {:mode [:o :x] :desc "Treesitter Search"})]})
