(local {: setup} (require :timbuktu.config.dsl))

(setup :nvim {:colorscheme :gruvbox
              :g {:loaded_node_provider 0
                  :loaded_perl_provider 0
                  :loaded_python3_provider 0
                  :loaded_ruby_provider 0
                  :localleader ";"
                  :mapleader " "}
              :opt {:autowrite true
                    :breakindent true
                    :colorcolumn :100
                    :cursorline true
                    :cursorlineopt :both
                    :expandtab true
                    :ignorecase true
                    :list true
                    :number true
                    :scrolloff 999
                    :shiftwidth 2
                    :showmode false
                    :signcolumn :number
                    :smartcase true
                    :swapfile false
                    :timeoutlen 300
                    :undofile true
                    :updatetime 250
                    :virtualedit :block}
              :keymap {:<Esc> #(vim.cmd.nohlsearch)
                       :<C-s> #(vim.cmd.write)
                       :q #(vim.cmd.bdelete)}})

(setup :conform {:opt {:format_after_save {:async true
                                           :lsp_format :fallback
                                           :timeout_ms 500}
                       :notify_no_formatters false}})

(setup :flit {:opt {:labeled_modes :nvo}})

(setup :leap {:keymap {:s {:cmd #((. (require :leap) :leap) {})
                           :mode [:n :o :v]}}})

(setup :lint)
(setup :lualine)
(setup :mini.icons)
(setup :mini.pairs)
(setup :nvim-surround)
(setup :nvim-treesitter)
(setup :rainbow-delimiters)

(setup :snacks
       {:opt {:indent {} :picker {}}
        :keymap {:<D-/> #(Snacks.picker.grep)
                 :<D-f> #(Snacks.picker.smart {:multi [:buffers :files]
                                               :matcher {:cwd_bonus true}})}})

(setup :substitute {:keymap {:x (. (require :substitute.exchange) :operator)}})

(setup :supermaven-nvim)

(setup :toggleterm
       (let [Terminal (. (require :toggleterm.terminal) :Terminal)
             agent (Terminal:new {:cmd :gemini :direction :float})
             lazydocker (Terminal:new {:cmd :lazydocker :direction :float})
             lazygit (Terminal:new {:cmd :lazygit :direction :float})
             shell (Terminal:new {:display_name :shell})]
         {:opt {:direction :float :open_mapping :<D-q>}
          :keymap {:<D-a> #(agent:toggle)
                   :<D-d> #(lazydocker:toggle)
                   :<D-g> #(lazygit:toggle)
                   :<D-s> #(shell:toggle (* vim.o.lines 0.33))}}))

(setup :which-key)

(setup [:filetype "*"] {:conform {:formatter [:trim_whitespace]}})
(setup [:filetype :fennel] {:plugin {:nfnl {}} :conform {:formatter [:fnlfmt]}})
(setup [:filetype :yaml])
