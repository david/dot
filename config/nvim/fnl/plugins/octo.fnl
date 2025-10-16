(setup :pwntester/octo.nvim
       {:opts {:picker :snacks :default_to_projects_v2 true}
        :keys [(kv :<leader>fi "<cmd>Octo issue list<cr>" {:desc :Issues})
               (kv :<leader>ni "<cmd>Octo issue create<cr>" {:desc :Issue})]
        :cmd [:Octo]
        :dependencies [:nvim-lua/plenary.nvim
                       :folke/snacks.nvim
                       :nvim-tree/nvim-web-devicons]})
