(setup :olimorris/codecompanion.nvim
       {:opts {:extensions {:vectorcode {:opts {}}}}
        :cmd [:CodeCompanion :CodeCompanionChat]
        :keys [(kv :<D-c> "<cmd>CodeCompanionChat Toggle<cr>")
               (kv :<leader>nc :<cmd>CodeCompanionChat<cr> {:desc :Chat})
               (kv :<leader>oc "<cmd>CodeCompanionChat Toggle<cr>"
                   {:desc :Chat})]
        :dependencies [:nvim-lua/plenary.nvim
                       :nvim-treesitter/nvim-treesitter
                       (setup :ravitemer/mcphub.nvim
                              {:opts {}
                               :lazy false
                               :dependencies [:nvim-lua/plenary.nvim]
                               :build "npm install -g mcp-hub@latest"})]})
