(setup :stevearc/overseer.nvim
       {:opts {:strategy :toggleterm}
        :keys [(kv :<leader>ro :<cmd>OverseerRun<cr> {:desc :Overseer})
               (kv :<D-r> :<cmd>OverseerRun<cr>)]})
