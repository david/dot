(setup :saghen/blink.cmp
       {:version :1.*
        :opts {:cmdline {:keymap {:preset :inherit
                                  :<Enter> [:select_accept_and_enter]}
                         :completion {:menu {:auto_show true}}}
               :completion {:documentation {:auto_show true
                                            :auto_show_delay_ms 500}}
               :keymap {:<C-a> [:select_and_accept]}
               :sources {:default [:copilot :buffer :lsp :path :snippets]
                         :per_filetype {:lua (vk {:inherit_defaults true}
                                                 :lazydev)}
                         :providers {:copilot {:name :copilot
                                               :module :blink-copilot
                                               :score_offset 100
                                               :async true
                                               :opts {:debounce 100}}
                                     :lazydev {:name :LazyDev
                                               :module :lazydev.integrations.blink
                                               :score_offset 100}
                                     :lsp {:fallbacks []}}}}
        :dependencies [:fang2hou/blink-copilot]})
