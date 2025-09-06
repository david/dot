(setup :neovim/nvim-lspconfig
       {:config (fn []
                  (vim.diagnostic.config {:severity_sort true
                                          :float {:border :rounded
                                                  :source :if_many}
                                          :underline {:severity vim.diagnostic.severity.ERROR}
                                          :signs {:text {vim.diagnostic.severity.ERROR "󰅚 "
                                                         vim.diagnostic.severity.WARN "󰀪 "
                                                         vim.diagnostic.severity.INFO "󰋽 "
                                                         vim.diagnostic.severity.HINT "󰌶 "}}
                                          :virtual_text {:source :if_many
                                                         :spacing 2
                                                         :format (fn [diagnostic]
                                                                   (let [diagnostic_message {vim.diagnostic.severity.ERROR diagnostic.message
                                                                                             vim.diagnostic.severity.WARN diagnostic.message
                                                                                             vim.diagnostic.severity.INFO diagnostic.message
                                                                                             vim.diagnostic.severity.HINT diagnostic.message}]
                                                                     (. diagnostic_message
                                                                        diagnostic.severity)))}}))
        :dependencies [(kv :mason-org/mason.nvim {:opts {}})
                       (kv :mason-org/mason-lspconfig.nvim
                           {:opts {:ensure_installed [:biome
                                                      :lua_ls
                                                      :ruby_lsp
                                                      :tailwindcss
                                                      :ts_ls]}})
                       (kv :WhoIsSethDaniel/mason-tool-installer.nvim
                           {:opts {:ensure_installed [:erb-formatter :stylua]}})
                       (kv :j-hui/fidget.nvim {:opts {}})
                       :saghen/blink.cmp]})
