(setup :akinsho/toggleterm.nvim
       {:lazy false
        :config (fn []
                  ((. (require :toggleterm) :setup) {:direction :float})
                  (let [Terminal (. (require :toggleterm.terminal) :Terminal)
                        agent (Terminal:new {:cmd "npx https://github.com/google-gemini/gemini-cli"})
                        services (Terminal:new {:cmd "mise run services"})
                        repl (Terminal:new {:cmd "mise run console"})
                        shell (Terminal:new {:display_name :shell})
                        map vim.keymap.set]
                    (map [:i :n] :<D-n> #(repl:toggle))
                    (map [:i :n] :<D-d> #(services:toggle))
                    (map [:i :n] :<D-s> #(shell:toggle (* vim.o.lines 0.4)))))})
