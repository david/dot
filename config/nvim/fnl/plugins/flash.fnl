(setup :folke/flash.nvim
       {:opts {}
        :event :VeryLazy
        :keys [(kv :s #((. (require :flash) :jump))
                   {:desc :Flash :mode [:n :x :o]})
               (kv :S #((. (require :flash) :treesitter))
                   {:desc "Flash Treesitter" :mode [:n :x :o]})
               (kv :r #((. (require :flash) :remote))
                   {:desc "Flash Remote" :mode [:n :x :o]})
               (kv :R #((. (require :flash) :treesitter_remote))
                   {:desc "Flash Remote Treesitter" :mode [:n :x :o]})]})
