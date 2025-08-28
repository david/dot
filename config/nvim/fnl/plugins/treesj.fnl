(setup :Wansmer/treesj
       {:opts {}
        :keys [(kv :gt #((. (require :treesj) :toggle)))]
        :dependencies [:nvim-treesitter/nvim-treesitter]})
