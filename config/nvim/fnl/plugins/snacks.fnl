(setup :folke/snacks.nvim
       {:lazy false
        :priority 1000
        :opts {:bufdelete {}
               :explorer {}
               :git {}
               :indent {}
               :input {}
               :lazygit {}
               :notifier {}
               :picker {:formatters {:file {:filename_first true :truncate 50}}
                        :matcher {:cwd_bonus false
                                  :frecency true
                                  :history_bonus true}}
               :scope {}
               :scratch {}
               :statuscolumn {}}
        :keys [(kv :<leader>fb #(Snacks.picker.buffers) {:desc :Buffers})
               (kv :<leader>fc #(Snacks.picker.cliphist)
                   {:desc "Clipboard history"})
               (kv :<leader>fd #(Snacks.picker.diagnostics)
                   {:desc :Diagnostics})
               (kv :<leader>ff #(Snacks.picker.files) {:desc :Files})
               (kv :<leader>fh #(Snacks.picker.help) {:desc "Help tags"})
               (kv :<leader>fi #(Snacks.picker.icons) {:desc :Icons})
               (kv :<leader>fk #(Snacks.picker.keymaps) {:desc :Keymaps})
               (kv :<leader>fl #(Snacks.picker.highlights) {:desc :Highlights})
               (kv :<leader>fn #(Snacks.picker.notifications)
                   {:desc :Notifications})
               (kv :<leader>fr #(Snacks.picker.registers) {:desc :Registers})
               (kv :<leader>fs #(Snacks.picker.lsp_workspace_symbols)
                   {:desc :Symbols})
               (kv :<D-/> #(Snacks.picker.grep))
               (kv :<D-.> #(Snacks.scratch))
               (kv :<D->> #(Snacks.scratch.select))
               (kv :<D-e> #(Snacks.picker.explorer))
               (kv :<D-f> #(Snacks.picker.smart) {:mode [:i :n]})
               (kv :<D-g> #(Snacks.lazygit))
               (kv :Q #(Snacks.bufdelete))
               (kv :g/ #(Snacks.picker.lines) {:desc "Grep buffers"})
               (kv :gd #(Snacks.picker.lsp_definitions)
                   {:desc "Goto Definition"})
               (kv :gD #(Snacks.picker.lsp_declarations)
                   {:desc "Goto Declaration"})
               (kv :gr #(Snacks.picker.lsp_references) :nowait true :desc
                   :References)
               (kv :gI #(Snacks.picker.lsp_implementations)
                   {:desc "Goto Implementation"})
               (kv :gy #(Snacks.picker.lsp_symbols)
                   {:desc "Goto T[y]pe Definition"})
               (kv :gY #(Snacks.picker.lsp_workspace_symbols)
                   {:desc "Goto T[y]pe Definition"})]})
