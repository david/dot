(setup :akinsho/bufferline.nvim {:opts {:options {:show_close_icon false
                                                  :diagnostics :nvim_lsp}}
                                 :lazy false
                                 :keys [(kv "<D-,>"
                                            :<cmd>BufferLineCyclePrev<cr>
                                            {:mode [:i :n]})
                                        (kv :<D-.>
                                            :<cmd>BufferLineCycleNext<cr>
                                            {:mode [:i :n]})]
                                 :dependencies [:nvim-tree/nvim-web-devicons]
                                 :version "*"})
