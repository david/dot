(defvar +font-size-large 200)
(defvar +font-size-medium 130)

(add-to-list 'default-frame-alist '(alpha-background . 64))
(add-to-list 'default-frame-alist '(undecorated . t))

(blink-cursor-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(require 'gruvbox-theme)

(load-theme 'gruvbox-dark-hard t)

