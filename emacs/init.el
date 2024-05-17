(use-package envrc
  :hook (emacs-startup . envrc-global-mode))

(use-package general)

(use-package +core
  :custom
  (auto-save-no-message t)
  (auto-save-visited-interval 3)
  (auto-save-visited-mode t)
  (column-number-mode t)
  (display-line-numbers-type 'relative)
  (display-line-numbers-width 3)
  (indent-tabs-mode nil)
  (inhibit-startup-echo-area-message t)
  (inhibit-startup-message t)
  (inhibit-startup-screen t)
  (make-backup-files nil)
  (ring-bell-function 'ignore)

  :custom-face
  (default ((t (:background "#000000"))))
  (mode-line ((t (:background "#101010"))))

  :general
  (:states '(normal visual)
   "SPC"   nil)
  (:states '(normal visual)
   :prefix "SPC"
   "SPC"   '(execute-extended-command :wk "M-x"))
  (:states 'normal
   "s-j"   'next-buffer
   "s-k"   'previous-buffer
   "q"     'delete-frame)
  (:states 'normal
   :prefix "SPC"
   "Q"     '(save-buffers-kill-emacs :wk "quit"))

  :init
  (recentf-mode 1))

(use-package centered-cursor-mode
  :init (global-centered-cursor-mode))

(use-package corfu
  :custom
  (corfu-auto t)

  :init
  (global-corfu-mode 1))

(use-package embark
  :custom
  (embark-indicators '(embark-minimal-indicator embark-highlight-indicator))

  :general
  (:states 'normal 
   ";" 'embark-act))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package evil-collection
  :custom
  (evil-collection-setup-minibuffer t)

  :hook (evil-mode . evil-collection-init))

(use-package evil
  :preface
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)

  :custom
  (evil-shift-width 2)
  (evil-undo-system 'undo-fu)
  (evil-want-minibuffer t)

  :init
  (evil-mode 1))

(use-package evil-matchit
  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package helpful)

(use-package lsp-mode
  :custom
  (lsp-warn-no-matched-clients nil)

  :hook (prog-mode . lsp-deferred))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package prog-mode
  :hook
  (prog-mode . display-line-numbers-mode)
  (prog-mode . electric-pair-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package undo-fu-session
  :init (undo-fu-session-global-mode 1))

(use-package vertico
  :init (vertico-mode 1))

(use-package which-key
  :init (which-key-mode 1))
