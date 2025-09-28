(setup {:lazy false
        :priority 10000
        :dir "~/.config/nvim"
        :main :timbuktu.setup
        :opts {:colorscheme :gruvbox
               :g {:loaded_node_provider 0
                   :loaded_perl_provider 0
                   :loaded_python3_provider 0
                   :loaded_ruby_provider 0
                   :neovide_hide_mouse_when_typing true
                   :neovide_opacity 0.85
                   :neovide_underline_stroke_scale 1.1}
               :opt {:autoread true
                     :autowrite true
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
                     :relativenumber true
                     :scrolloff 999
                     :shiftwidth 2
                     :showmode false
                     :signcolumn :yes
                     :splitbelow true
                     :splitright true
                     :smartcase true
                     :swapfile false
                     :timeoutlen 300
                     :undofile true
                     :undolevels 1024
                     :updatetime 250
                     :virtualedit :block}}
        :keys [(kv :<Esc> vim.cmd.nohlsearch)
               (kv :<Esc><Esc> "<C-\\><C-n>" {:mode [:t]})
               (kv :<A-p> "pV`]")
               (kv :<A-P> "PV`]")
               (kv :<C-S-v> "<C-\\><C-o>p" {:mode [:t]})
               (kv :<C-q> (fn []
                            (vim.cmd.bufdo {:args [:bd]})
                            (vim.cmd.vsplit)))
               (kv :<C-s> vim.cmd.write)
               (kv :<D-h> #(vim.cmd.wincmd {:args [:h]}) {:mode [:i :n :t]})
               (kv :<D-j> #(vim.cmd.wincmd {:args [:j]}) {:mode [:i :n :t]})
               (kv :<D-k> #(vim.cmd.wincmd {:args [:k]}) {:mode [:i :n :t]})
               (kv :<D-l> #(vim.cmd.wincmd {:args [:l]}) {:mode [:i :n :t]})
               (kv :<D-q> #(vim.cmd.wincmd {:args [:q]}) {:mode [:i :n :t]})
               (kv :<D-C-h> #(vim.cmd.wincmd {:args [:H]}))
               (kv :<D-C-j> #(vim.cmd.wincmd {:args [:J]}))
               (kv :<D-C-k> #(vim.cmd.wincmd {:args [:K]}))
               (kv :<D-C-l> #(vim.cmd.wincmd {:args [:L]}))
               (kv :<leader>Nu "<cmd>Lazy update<cr>" {:desc "Update plugins"})
               (kv :<leader>sj vim.cmd.split {:desc :Below})
               (kv :<D-L> vim.cmd.vsplit {:mode [:i :n]})
               (kv :<D-H>
                   (fn []
                     (vim.cmd.vsplit)
                     (vim.cmd.wincmd {:args [:h]}))
                   {:mode [:i :n]})
               (kv :<D-J> vim.cmd.split {:mode [:i :n]})
               (kv :<D-K>
                   (fn []
                     (vim.cmd.vsplit)
                     (vim.cmd.wincmd {:args [:k]}))
                   {:mode [:i :n]})
               (kv :<localleader>cd vim.diagnostic.open_float
                   {:desc "Line Diagnostics"})
               (kv :q #(vim.cmd.wincmd {:args [:q]}))
               (kv :m :q {:desc :Macro})]})
