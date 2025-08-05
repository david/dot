(local {: core : filetype : plugin : colorscheme} (require :timbuktu.config.dsl))

(core 
  {:opt 
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

   :key 
    {"<Esc>" #(vim.cmd.nohlsearch)
     "<C-s>" #(vim.cmd.write)
     "."     #(vim.cmd.bnext)
     ","     #(vim.cmd.bprevious)
     "r"     "."
     "s"     #((. (require :leap) :leap) {})
     "q"     #(vim.cmd.bdelete)}})

(plugin :snacks 
  {:opt {:indent {}
         :picker {}}
   :key {"<D-/>" #(Snacks.picker.grep)
         "<D-f>" #(Snacks.picker.smart {:multi [:buffers :files] :matcher {:cwd_bonus true}})}})

(plugin :leap)

(plugin :toggleterm
  (let [Terminal (. (require :toggleterm.terminal) :Terminal)
        agent (Terminal:new {:cmd "gemini" :direction "float"})
        lazygit (Terminal:new {:cmd "lazygit" :direction "float"})]
    {:opt {:direction "float"
           :open_mapping "<D-t>"}
     :key {"<D-a>" #(agent:toggle)
           "<D-g>" #(lazygit:toggle)}}))

(filetype :fennel {:plugin {:nfnl {}}})
(filetype :yaml)

(colorscheme :gruvbox)
