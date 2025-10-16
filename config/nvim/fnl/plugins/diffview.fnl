(setup :sindrets/diffview.nvim
       {:opts {}
        :keys [(kv :<leader>od :<cmd>DiffviewOpen<cr> {:desc "Open Diffview"})
               (kv :<leader>oh "<cmd>DiffviewFileHistory %<cr>"
                   {:desc "File History"})
               (kv :<leader>ob :<cmd>DiffviewFileHistory<cr>
                   {:desc "Branch History"})]})
