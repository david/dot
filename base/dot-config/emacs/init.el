(setq custom-file (concat user-emacs-directory "custom.el"))
      
(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")))

(use-package gruvbox-theme
  :ensure t
  :demand t

  :config
  (load-theme 'gruvbox-dark-medium t))

(use-package doom-modeline
  :ensure t

  :custom
  (doom-modeline-height 40)

  :hook emacs-startup)

(use-package general
  :ensure t
  :demand t)

;; core

(use-package core
  :no-require t

  :custom-face
  (default ((t (:family "JetBrains Mono"
                :height 145))))

  :custom
  (inhibit-splash-screen t)
  (blink-cursor-mode nil)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (indent-tabs-mode nil)
  (line-spacing 0.1)
  (make-backup-files nil)
  (menu-bar-mode nil)
  (ring-bell-function 'ignore)
  (savehist-autosave-interval 30)
  (savehist-mode t)
  (scroll-bar-mode nil)
  (tool-bar-mode nil)
  (undo-limit 67108864) ; 64MB
  (undo-strong-limit 100663296) ; 96MB
  (undo-outer-limit 1006632960)) ; 960MB.

(use-package recentf
  :hook emacs-startup)

(use-package which-key
  :hook emacs-startup)

(use-package windmove
  :hook emacs-startup
  
  :general
  (:keymaps 'windmove-mode-map
   "s-h" 'windmove-left
   "s-j" 'windmove-down
   "s-k" 'windmove-up
   "s-l" 'windmove-right))

(use-package keybindings
  :no-require t

  :preface
  (defun timbuktu/emacs-open-config ()
    (interactive)
    (find-file (expand-file-name "~/.config/emacs/init.el")))

  (defun timbuktu/emacs-open-scratch ()
    (interactive)
    (switch-to-buffer "*scratch*"))

  :general
  ("C-s" 'save-buffer)
  (:states 'normal
   "SPC" nil
   "q" 'kill-current-buffer)
  (:states '(normal insert)
   "s-," 'previous-buffer
   "s-." 'next-buffer)
  (:states '(normal visual)
   "," 'avy-goto-char-timer
   "+" 'universal-argument
   "-" 'negative-argument)
  (:states '(normal visual)
   :prefix "SPC"
   "SPC" 'execute-extended-command)
  (:states 'normal
   :prefix "SPC"
   "&"   '(project-async-shell-command :wk "shell command")
   "*"   '(timbuktu/emacs-open-scratch :wk "scratch buffer")
   "/"   '(consult-ripgrep :wk "search")

   "E"   '(nil :wk "emacs")
   "Ec"  '(timbuktu/emacs-open-config :wk "configure")
   "Eq"  '(save-buffers-kill-emacs :wk "quit")

   "d"   '(nil :wk "dev")

   "f"   '(nil :wk "find")
   "ff"  '(consult-buffer :wk "any")
   "fj"  '(project-find-file :wk "in project")

   "h"   '(nil :wk "help")
   "hf"  '(helpful-callable :wk "functions")
   "hk"  '(helpful-key :wk "keys")
   "hv"  '(helpful-variable :wk "variables")

   "v"   '(nil :wk "version control")
   "vv"  '(magit-project-status :wk "status")

   "w"   '(nil :wk "windows")
   "wd"  '(delete-window :wk "delete")
   "wo"  '(delete-other-windows :wk "one window")))

;; completion
 
(use-package corfu
  :ensure t

  :custom
  (corfu-auto t)

  :hook prog-mode)

(use-package consult
  :ensure t)

(use-package orderless
  :ensure t)

(use-package marginalia
  :ensure t
  :hook emacs-startup)

(use-package vertico
  :ensure t

  :hook emacs-startup)

;; evil

(use-package evil
  :ensure t

  :preface
  (setq evil-want-keybinding nil)

  :custom
  (evil-shift-width 2)
  (evil-undo-system 'undo-fu)
  (evil-want-C-u-scroll t)

  :hook	emacs-startup)

(use-package evil-cleverparens
  :ensure t

  :hook emacs-lisp-mode)

(use-package evil-collection
  :ensure t
  :after evil

  :preface
  (setq evil-collection-setup-minibuffer t)

  :hook (evil-mode . evil-collection-init))

(use-package evil-goggles
  :ensure t

  :hook evil-mode)

(use-package evil-matchit
  :ensure t

  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-surround
  :ensure t

  :hook (evil-mode . global-evil-surround-mode))

;; more editing

(use-package rainbow-delimiters
  :ensure t

  :hook prog-mode)

(use-package smartparens
  :ensure t

  :config
  (require 'smartparens-config)

  :hook (prog-mode text-mode markdown-mode))

(use-package undo-fu
  :ensure t)

(use-package undo-fu-session
  :ensure t

  :hook (emacs-startup . undo-fu-session-global-mode))

;; dev

(use-package flycheck
  :ensure t

  :hook (emacs-startup . global-flycheck-mode))

(use-package lsp-mode
  :ensure t

  :init
  (setq lsp-keymap-prefix "C-c l")

  :custom
  (lsp-elixir-dialyzer-enabled nil)

  :hook ((prog-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ui
  :ensure t

  :hook lsp-mode)

;; elisp

(use-package emacs-lisp-mode
  :general
  (:modes 'emacs-lisp-mode
   :states 'normal
   :prefix "SPC"
   "e" '(nil :wk "eval")
   "eb" '(eval-buffer :wk "buffer")))

;; elixir

(use-package elixir-ts-mode
  :ensure t
  :mode (("\\.exs?$" . elixir-ts-mode))

  :general
  (:states 'normal
   :keymaps 'elixir-ts-mode-map
   :prefix "SPC"
   "dT"  '(exunit-verify-all :wk "run all tests")
   "dr"  '(exunit-rerun :wk "rerun tests")
   "dt"  '(exunit-verify :wk "run tests in file")))

(use-package heex-ts-mode
  :ensure t
  :mode (("\\.heex$" . heex-ts-mode)))

(use-package exunit
  :ensure t

  :hook elixir-ts-mode)

;; git

(use-package forge
  :ensure t)

(use-package magit
  :ensure t)

;; ruby

(use-package inf-ruby
  :ensure t)

;; other

(use-package avy
  :ensure t

  :custom
  (avy-timeout-seconds 0.33))

(use-package colorful-mode
  :ensure t

  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)

  :config
  (add-to-list 'global-colorful-modes 'helpful-mode)

  :hook (emacs-startup . global-colorful-mode))

(use-package embark
  :ensure t

  :general
  (:states 'normal
   ";" 'embark-act))

(use-package embark-consult
  :ensure t)

(use-package helpful
  :ensure t)
