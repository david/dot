(defvar +font-size-large 200)
(defvar +font-size-medium 130)

(add-to-list 'default-frame-alist '(alpha-background . 96))
(add-to-list 'default-frame-alist '(undecorated . t))

(blink-cursor-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package gruvbox-theme
  :ensure t

  :config
  (load-theme 'gruvbox-dark-hard t))
