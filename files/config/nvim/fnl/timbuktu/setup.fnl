(local M {})

(fn M.setup [config]
  (each [k v (pairs config.g)]
    (tset vim.g k v))
  (each [k v (pairs config.opt)]
    (tset vim.opt k v))
  (vim.cmd.colorscheme {:args [config.colorscheme]}))

M