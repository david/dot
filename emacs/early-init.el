(add-to-list 'default-frame-alist '(alpha-background . 0.8))
(add-to-list 'default-frame-alist '(font . "Iosevka Timbuktu-20"))
(add-to-list 'default-frame-alist '(undecorated . t))

(blink-cursor-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(require 'gruvbox-theme)

(load-theme 'gruvbox-dark-hard t)

