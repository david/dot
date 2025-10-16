(lambda make-rspec-cmd [position-type]
  (case position-type
    :file [:bundle :exec :rspec :--format :documentation]
    :test [:bundle :exec :rspec :--format :documentation :--example]
    _ [:bundle :exec :rspec]))

(setup :nvim-neotest/neotest
       {:config (fn []
                  ((. (require :neotest) :setup) {:adapters [(require :neotest-rspec)]
                                                  :consumers [(require :neotest.consumers.overseer)]}))
        :keys [(kv :<D-p> #((. (require :neotest) :run :run) (vim.fn.getcwd)))
               (kv :<leader>rf
                   #((. (require :neotest) :run :run) (vim.fn.expand "%"))
                   {:desc "Tests in File"})
               (kv :<leader>ot "<cmd>Neotest output-panel<cr>"
                   {:desc "Show Test Output Panel"})
               (kv :<leader>rp
                   #((. (require :neotest) :run :run) (vim.fn.getcwd))
                   {:desc "Tests in Project"})
               (kv :<leader>rr
                   #((. (require :neotest) :run :run) (vim.fn.expand "%"))
                   {:desc "Tests in File"})
               (kv :<leader>ru #((. (require :neotest) :run :run))
                   {:desc :Closer})]
        :cmd [:Neotest]
        :dependencies [:antoinemadec/FixCursorHold.nvim
                       :nvim-lua/plenary.nvim
                       :nvim-neotest/nvim-nio
                       :nvim-treesitter/nvim-treesitter
                       :olimorris/neotest-rspec
                       :stevearc/overseer.nvim]})
