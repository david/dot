(use-package general)

(use-package +core
  :custom
  (indent-tabs-mode nil)
  (make-backup-files nil)

  :general
  (:states 'normal
   "SPC"   nil
   "q"     'kill-this-buffer)
  (:states 'normal
   :prefix "SPC"
   "SPC"   '(execute-extended-command :wk "M-x")
   "Q"     '(save-buffers-kill-emacs :wk "quit")))

(use-package centered-cursor-mode
  :hook (emacs-startup . global-centered-cursor-mode))

(use-package embark
  :general
  (:states 'normal
   ";" 'embark-act))

(use-package evil
  :preface
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)

  :hook (emacs-startup . evil-mode))

(use-package evil-collection
  :hook (evil-mode . evil-collection-init))

(use-package evil-matchit
  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package lsp-mode
  :custom
  (lsp-warn-no-matched-clients nil)
  :hook (prog-mode . lsp-deferred))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package prog-mode
  :hook (prog-mode . electric-pair-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package vertico
  :hook (emacs-startup . vertico-mode))

(use-package which-key
  :hook (emacs-startup . which-key-mode))
