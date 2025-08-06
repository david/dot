(local configure (. (require :timbuktu.config.dsl) :configure))

(configure
  {:opts
    {:autowrite true
     :breakindent true
     :cursorline true
     :cursorlineopt "both"
     :expandtab true
     :ignorecase true
     :list true
     :number true
     :scrolloff 999
     :shiftwidth 2
     :showmode false
     :signcolumn "number"
     :smartcase true
     :swapfile false
     :timeoutlen 300
     :undofile true
     :updatetime 250
     :virtualedit "block"}

   :g 
    {:loaded_node_provider 0
     :loaded_perl_provider 0
     :loaded_python3_provider 0
     :loaded_ruby_provider 0
     :localleader ";" 
     :mapleader " "}

   :keymaps
    {"<Esc>" #(vim.cmd.nohlsearch)
     "<C-s>" #(vim.cmd.write)
     "."     #(vim.cmd.bnext)
     ","     #(vim.cmd.bprevious)
     "r"     "."
     "q"     #(vim.cmd.bdelete)}

   :plugins
    {:snacks 
      {:opts {:indent {}
              :picker {}}
       :keymaps {"<D-/>" #(Snacks.picker.grep)
                 "<D-f>" #(Snacks.picker.smart {:multi [:buffers :files] :matcher {:cwd_bonus true}})}}

     :leap 
      {:keymaps {"s" {:cmd #((. (require :leap) :leap) {})
                      :mode [:n :o :v]}}}

     :toggleterm
      (let [Terminal (. (require :toggleterm.terminal) :Terminal)
            agent (Terminal:new {:cmd "gemini" :direction "float"})
            lazygit (Terminal:new {:cmd "lazygit" :direction "float"})]
        {:opts {:direction "float"
                :open_mapping "<D-t>"}
         :keymaps {"<D-a>" #(agent:toggle)
                   "<D-g>" #(lazygit:toggle)}})}

   :filetypes
    {:fennel {:plugins {:nfnl {}}}
     :yaml {}}

   :colorscheme :gruvbox})
