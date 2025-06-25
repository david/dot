function timbuktu/vim-load-hook {
  bleopt keymap_vi_mode_show=

  ble-bind -m vi_nmap --cursor 2
  ble-bind -m vi_imap --cursor 6
}

bleopt history_share=1

ble-face auto_complete="fg=242"

ble-face command_builtin="fg=108"
ble-face command_builtin_dot="fg=108,bold"
ble-face command_directory="fg=214,bold"
ble-face command_function="fg=108"

ble-face filename_directory="fg=214,bold"
ble-face filename_orphan="fg=167"

ble-face syntax_error="fg=167,bold"

blehook/eval-after-load keymap_vi timbuktu/vim-load-hook

