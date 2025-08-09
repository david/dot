(local {: setup} (require :setup))

(setup :nvim {:colorscheme :gruvbox
              :g {:loaded_node_provider 0
                  :loaded_perl_provider 0
                  :loaded_python3_provider 0
                  :loaded_ruby_provider 0
                  :localleader ";"
                  :mapleader " "
                  :neovide_hide_mouse_when_typing true
                  :neovide_opacity 0.85
                  :neovide_underline_stroke_scale 1.1}
              :opt {:autowrite true
                    :breakindent true
                    :colorcolumn :100
                    :cursorline true
                    :cursorlineopt :both
                    :expandtab true
                    :guifont ["JetBrains Mono" "Symbols Nerd Font" ":h11"]
                    :ignorecase true
                    :linespace 1
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
                       :<D-h> #(vim.cmd.wincmd {:args [:h]})
                       :<D-j> #(vim.cmd.wincmd {:args [:j]})
                       :<D-k> #(vim.cmd.wincmd {:args [:k]})
                       :<D-l> #(vim.cmd.wincmd {:args [:l]})
                       :q #(vim.cmd.bdelete)}})

(setup :conform {:opt {:format_after_save {:async true
                                           :lsp_format :fallback
                                           :timeout_ms 500}
                       :notify_no_formatters false}})

(setup :flit {:opt {:labeled_modes :nvo :multiline false}})

(setup :leap {:keymap {:L {:cmd #((. (require :leap) :leap) {})
                           :mode [:n :o :v]}}})

(setup :lint)
(setup :lualine)
(setup :mini.icons)
(setup :mini.pairs)
(setup :nvim-surround)
(setup :nvim-treesitter)
(setup :rainbow-delimiters)

(setup :snacks
       {:opt {:dashboard {:sections [{:section :header}
                                     {:section :projects
                                      :title :Projects
                                      :padding 1
                                      :icon " "
                                      :indent 2}
                                     {:section :recent_files
                                      :icon " "
                                      :title :Files
                                      :indent 2}]}
              :indent {}
              :input {}
              :notifier {}
              :picker {}
              :scratch {}
              :statuscolumn {}}
        :keymap {:<D-/> #(Snacks.picker.grep)
                 :<D-f> #(Snacks.picker.smart {:multi [:buffers :files]
                                               :matcher {:cwd_bonus true}})}})

(setup :substitute {:keymap {:gx (. (require :substitute.exchange) :operator)}})

(setup :supermaven-nvim)

(setup :toggleterm
       (let [Terminal (. (require :toggleterm.terminal) :Terminal)
             agent (Terminal:new {:cmd :gemini :direction :float})
             lazydocker (Terminal:new {:cmd :lazydocker :direction :float})
             lazygit (Terminal:new {:cmd :lazygit :direction :float})
             repl (Terminal:new {:cmd "iex -S mix phx.server"
                                 :direction :float})
             shell (Terminal:new {:display_name :shell})]
         {:opt {:direction :float :open_mapping :<D-q>}
          :keymap {:<D-a> #(agent:toggle)
                   :<D-d> #(lazydocker:toggle)
                   :<D-g> #(lazygit:toggle)
                   :<D-r> #(repl:toggle)
                   :<D-s> #(shell:toggle (* vim.o.lines 0.33))}}))

(setup :which-key)

(setup [:filetype "*"] {:conform {:formatter [:trim_whitespace]}})
(setup [:filetype :fennel] {:plugin {:nfnl {}} :conform {:formatter [:fnlfmt]}})
(setup [:filetype :elixir])
(setup [:filetype :heex])
(setup [:filetype :yaml])
