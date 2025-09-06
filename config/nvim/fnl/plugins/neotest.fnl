(lambda make-rspec-cmd (position-type)
  (case position-type
    :file [:bundle :exec :rspec :--format :documentation]
    :test [:bundle :exec :rspec :--format :documentation :--example]
    _ [:bundle :exec :rspec]))

(setup :nvim-neotest/neotest
       {:commit :52fca6717ef972113ddd6ca223e30ad0abb2800c
        :config (fn []
                  ((. (require :neotest) :setup) {:adapters [(. (require :neotest-rspec)
                                                                {:rspec_cmd make-rspec-cmd})]
                                                  :consumers [(require :neotest.consumers.overseer)]}))
        :keys [(kv :<leader>rf
                   #((. (require :neotest) :run :run) (vim.fn.expand "%"))
                   {:desc "Tests in File"})
               (kv :<leader>rn "<cmd>Neotest output-panel<cr>"
                   {:desc "Show Output Panel"})
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
