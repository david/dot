(setup :nvim-treesitter/nvim-treesitter
       {:branch :master
        :lazy false
        :build ":TSUpdate"
        :main :nvim-treesitter.configs
        :opts {:ensure_installed [:embedded_template
                                  :fennel
                                  :javascript
                                  :json
                                  :regex
                                  :ruby
                                  :yaml]
               :highlight {:enable true}
               :indent {:enable true}}
        :dependencies [:OXY2DEV/markview.nvim]})
