(setup :akinsho/toggleterm.nvim
       {:lazy false
        :config (fn []
                  ((. (require :toggleterm) :setup) {:direction :float})
                  (let [Terminal (. (require :toggleterm.terminal) :Terminal)
                        agent (Terminal:new {:cmd "npx https://github.com/google-gemini/gemini-cli"})
                        services (Terminal:new {:cmd "mise run srv"})
                        repl (Terminal:new {:cmd "mise run repl"})
                        shell (Terminal:new {:display_name :shell})
                        map vim.keymap.set]
                    (map :n :<D-a> #(agent:toggle))
                    (map :n :<D-d> #(services:toggle))
                    (map :n :<D-r> #(repl:toggle))
                    (map :n :<D-s> #(shell:toggle (* vim.o.lines 0.4)))))})
