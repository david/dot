(lambda keymap-handler [{:keymap ?config}]
  (when ?config
    (each [key val (pairs ?config)]
      (case val
        {: cmd : mode} (vim.keymap.set mode key cmd)
        cmd (vim.keymap.set :n key cmd)))))

(local vim-handlers {:colorscheme {}
                     :g {}
                     :opt {}
                     :keymap {:fn keymap-handler}})

(lambda vim-handlers.colorscheme.fn [{:colorscheme ?config}]
  (case ?config
    (where str (= (type str) :string)) (do
                                         ((. (require str) :setup) {})
                                         (vim.cmd.colorscheme str))))

(lambda vim-handlers.g.fn [{:g ?config}]
  (each [key val (pairs ?config)]
    (set (. vim.g key) val)))

(lambda vim-handlers.opt.fn [{:opt ?config}]
  (each [key val (pairs ?config)]
    (set (. vim.opt key) val)))

(local plugin-handlers {:opt {:fn (lambda [{:opt ?opts} plugin]
                                    (case (. (require plugin) :setup)
                                      setup (setup (or ?opts {}))))}
                        :keymap {:fn keymap-handler}})

(local ft-handlers {:lang {} :plugin {}})

(lambda ft-handlers.plugin.fn [{:plugin ?config} ft]
  (let [group-name (.. ft :-ft-plugin)
        group (vim.api.nvim_create_augroup group-name {:clear true})]
    (each [key val (pairs (or ?config {}))]
      (vim.api.nvim_create_autocmd :FileType
                                   {:pattern ft
                                    :callback #((. (require key) :setup) val)
                                    : group}))))

(lambda ft-handlers.lang.fn [_config ft]
  (let [group (vim.api.nvim_create_augroup (.. ft :-ft-lang) {:clear true})]
    (vim.api.nvim_create_autocmd :FileType
                                 {:pattern ft
                                  :callback #(vim.treesitter.start)
                                  : group})))

(local handlers {:filetype ft-handlers
                 :nvim vim-handlers
                 :plugin plugin-handlers})

(lambda call-handlers [handlers & rest]
  (each [key handler (pairs handlers)]
    (handler.fn (unpack rest))))

(lambda setup [name ?config]
  (let [config (or ?config {})]
    (case name
      :nvim (call-handlers handlers.nvim config)
      [:filetype ft] (call-handlers handlers.filetype config ft)
      _ (call-handlers handlers.plugin config name))))

{: setup}
