(lambda core [config]
  (let [{:opt opt :key keys :g g} config]
    (each [key val (pairs g)]
      (set (. vim.g key) val))

    (each [key val (pairs opt)]
      (set (. vim.opt key) val))

    (each [key val (pairs keys)]
      (vim.keymap.set "n" key val))))

(lambda plugin [name ?config]         
  (let [plugin (require name)
        {:opt opt :key keys} (or ?config {})]
    (plugin.setup (or opt {}))

    (each [key val (pairs (or keys {}))]
      (vim.keymap.set "n" key val))

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

{:colorscheme colorscheme
 :core core
 :filetype filetype
 :plugin plugin}
