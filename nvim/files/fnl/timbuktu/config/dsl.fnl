(lambda keymap [key config]
  (case config
    {:cmd cmd :mode mode} (vim.keymap.set mode key cmd)
    cmd (vim.keymap.set "n" key cmd)))

(lambda keymaps [{:keymaps ?keymaps}]
  (each [key val (pairs (or ?keymaps {}))]
    (keymap key val)))

(lambda plugin [name ?config]         
  (let [plugin (require name)
        config (or ?config {})]
    (plugin.setup (or config.opts {}))
    (keymaps config)

    plugin))

(lambda plugins [{:plugins ?plugins}]
  (each [name config (pairs (or ?plugins {}))]
    (plugin name config)))

(lambda filetype [ft ?config]
  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern ft 
     :callback (fn []
                 (plugins (or ?config {}))
                 (vim.treesitter.start))
     :group (vim.api.nvim_create_augroup (.. ft "-config") {:clear true})}))

(lambda colorscheme [name ?config]
  (plugin name ?config)

  (vim.cmd.colorscheme name))

(lambda configure [{:colorscheme cscheme : g : opts : filetypes &as config}]
  (each [key val (pairs g)]
    (set (. vim.g key) val))

  (each [key val (pairs opts)]
    (set (. vim.opt key) val))

  (keymaps config)
  (plugins config)

  (each [name config (pairs filetypes)]
    (filetype name config))

  (colorscheme cscheme))

{:configure configure}
