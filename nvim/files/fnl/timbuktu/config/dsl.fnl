(lambda keybinding [key config]
  (case config
    {:cmd cmd :mode mode} (vim.keymap.set mode key cmd)
    cmd (vim.keymap.set "n" key cmd)))

(lambda plugin [name ?config]         
  (let [plugin (require name)
        {:opt opt :key keys} (or ?config {})]
    (plugin.setup (or opt {}))

    (each [key val (pairs (or keys {}))]
      (keybinding key val))

    plugin))

(lambda filetype [ft ?config]
  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern ft 
     :callback (fn []
                 (let [{:plugin plugs} (or ?config {})]
                   (each [plug cfg (pairs (or plugs {}))]
                     (plugin plug cfg)))
                 (vim.treesitter.start))
     :group (vim.api.nvim_create_augroup (.. ft "-config") {:clear true})}))

(lambda colorscheme [name ?config]
  (plugin name ?config)

  (vim.cmd.colorscheme name))

(lambda configure [{:g g :key keys :opt opts :plugin plugins :filetype filetypes :colorscheme cscheme}]
  (each [key val (pairs g)]
    (set (. vim.g key) val))

  (each [key val (pairs opts)]
    (set (. vim.opt key) val))

  (each [key val (pairs keys)]
    (keybinding key val))

  (each [name config (pairs plugins)]
    (plugin name config))

  (each [name config (pairs filetypes)]
    (filetype name config))

  (colorscheme cscheme))

{:configure configure}
