(setup :akinsho/toggleterm.nvim
 {:lazy false
  :config (fn []
            ((. (require :toggleterm) :setup) {:direction :float :open_mapping "<D-q>"})
            (let [Terminal (. (require :toggleterm.terminal) :Terminal)
                  agent (Terminal:new {:cmd "gemini"})
                  lazydocker (Terminal:new {:cmd "lazydocker"})
                  repl (Terminal:new {:cmd "rails console"})
                  shell (Terminal:new {:display_name "shell" :direction "horizontal"})
                  map vim.keymap.set]
              (map :n "<D-a>" #(agent:toggle))
              (map :n "<D-d>" #(lazydocker:toggle))
              (map :n "<D-r>" #(repl:toggle))
              (map :n "<D-s>" #(shell:toggle (* vim.o.lines 0.4)))))})
