(setup :ggandor/leap.nvim
 {:enabled false
  :opts {}
  :keys [{:L #((. (require :leap) :leap))
          :mode [:n :v :o]}]
  :dependencies [:tpope/vim-repeat]})