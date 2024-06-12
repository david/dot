(setq use-package-always-demand t)

(use-package envrc
  :hook (emacs-startup . envrc-global-mode))

(use-package general)

(use-package +core
  :no-require t

  :preface
  (defun +kill-this-buffer ()
    (interactive)
    (kill-buffer (current-buffer)))

  (defun +adjust-font-size ()
    '(let* ((monitor (car (display-monitor-attributes-list)))
            (geom (alist-get 'geometry monitor))
            (x (nth 2 geom))
            (y (nth 3 geom))
            (font-size (pcase (list x y)
                         ('(1920 1080) +font-size-medium)
                         ('(2880 1800) +font-size-large))))
       (dolist (f (frame-list))
         (set-face-attribute 'default f :height font-size))))

  :custom
  (auth-sources '("~/sys/secrets/authinfo.gpg"))
  (auto-save-no-message t)
  (auto-save-visited-interval 3)
  (auto-save-visited-mode t)
  (column-number-mode t)
  (display-buffer-alist '(("\\`\\*compilation\\*\\'" . ((display-buffer-reuse-window
                                                         display-buffer-pop-up-frame)
                                                        (reusable-frames . t)))))
  (frame-resize-pixelwise t)
  (gc-cons-threshold 100000000)
  (global-auto-revert-mode t)
  (indent-tabs-mode nil)
  (inhibit-startup-echo-area-message t)
  (inhibit-startup-message t)
  (inhibit-startup-screen t)
  (left-fringe-width 16)
  (make-backup-files nil)
  (mode-line-format '("%e"
                      mode-line-front-space
                      (:propertize
                       ("" mode-line-modified mode-line-remote mode-line-window-dedicated)
                       display (min-width (6.0)))
                      mode-line-frame-identification mode-line-buffer-identification
                      (project-mode-line project-mode-line-format) (vc-mode vc-mode) "  "
                      mode-line-misc-info
                      mode-line-format-right-align
                      mode-line-position
                      mode-line-end-spaces))
  (read-process-output-max (* 2 1024 1024))
  (recentf-mode t)
  (right-fringe-width 16)
  (ring-bell-function 'ignore)
  (save-place-mode t)
  (savehist-mode t)

  :custom-face
  (default ((t (:background "#1d2021" :font "Iosevka Timbuktu" :height 120))))
  (fringe ((t (:background "#282828"))))
  (mode-line ((t (:background "#282828"))))

  :general
  (:states '(normal visual)
   "SPC"   nil)
  (:states '(normal visual)
   :prefix "SPC"
   "SPC"   '(execute-extended-command :wk "M-x"))
  (:states '(insert normal)
   "C-<Tab>" 'indent-relative)
  (:states 'normal
   "C-s"   'save-buffer
   "s-j"   'next-buffer
   "s-k"   'previous-buffer
   "Q"     '+kill-this-buffer
   "q"     'quit-window)
  (:states 'normal
   :prefix "SPC"
   "#"     '(scratch-buffer          :wk "scratch buffer")
   "0"     '(delete-window           :wk "close this window")
   "1"     '(delete-other-windows    :wk "keep this window")
   "F"     '(nil                     :wk "file")
   "Ff"    '(find-file               :wk "find")
   "Fi"    '(insert-file             :wk "insert")
   "Q"     '(save-buffers-kill-emacs :wk "quit")
   "b"     '(nil                     :wk "buffer")
   "e"     '(nil                     :wk "eval")
   "ef"    '(eval-buffer             :wk "file or buffer")
   "g"     '(nil                     :wk "go")
   "h"     '(nil                     :wk "help")
   "s"     '(project-eshell          :wk "shell")
   "t"     '(nil                     :wk "test")
   "tf"    '(compile                 :wk "file or test file")
   "tt"    '(recompile               :wk "re-run last test run")
   "w"     '(nil                     :wk "window")
   "wd"    '(delete-frame            :wk "delete")
   "wn"    '(make-frame-command      :wk "new")
   "wo"    '(other-window            :wk "other"))

  :hook
  (compilation-filter . ansi-color-compilation-filter)

  :init
  (add-function :after after-focus-change-function #'+adjust-font-size))

(use-package +vc
  :no-require t

  :general
  (:states 'normal
   :prefix "SPC"
   "v"     '(nil   :wk "vc")
   "vr"    '(vc-region-history :wk "region history")
   "vv"    '(magit-project-status :wk "magit")))

(use-package centered-cursor-mode
  :init (global-centered-cursor-mode))

(use-package consult
  :preface
  (setq +consult-source-project-files
        `(:category file
          :name "Project File"
          :items ,(lambda ()
                    (let* ((default-directory (consult--project-root))
                           (in (process-lines "fd" "--color=never" "--strip-cwd-prefix=always" "--type=file"))
                           out)
                      (dolist (f in (reverse out))
                        (setq out (cons (file-relative-name f) out)))))
          :action ,(lambda (f)
                     (find-file (file-name-concat (consult--project-root) f)))))

  :custom
  (consult-project-buffer-sources '(consult--source-buffer
                                    consult--source-recent-file
                                    +consult-source-project-files))

  :general
  (:states 'normal
   :prefix "SPC"
   "/"     '(consult-ripgrep        :wk "find text in project")
   "f"     '(consult-project-buffer :wk "find in project")
   "hi"    '(consult-info           :wk "info")
   "hm"    '(consult-man            :wk "man")
   "y"     '(consult-imenu          :wk "imenu")))

(use-package corfu
  :preface
  (defun +corfu-disable-in-mode ()
    (corfu-mode -1))

  (defun +corfu-disable-auto-in-mode ()
    (setq-local corfu-auto nil))

  :custom
  (corfu-auto t)

  :hook
  (eshell-mode . +corfu-disable-auto-in-mode)

  :init
  (global-corfu-mode 1))

(use-package diff-hl
  :custom
  (diff-hl-show-staged-changes nil)

  :general
  (:states 'normal
   :prefix "SPC"
   "vs"    '(diff-hl-stage-dwim :wk "stage hunk(s)"))

  :init
  (global-diff-hl-mode))

(use-package elixir-ts-mode
  :mode ("\\.\\(?:exs?\\)"))

(use-package embark
  :custom
  (embark-indicators '(embark-minimal-indicator embark-highlight-indicator))

  :general
  (:states 'normal 
   ";" 'embark-act)
  (:keymaps 'embark-symbol-map
   "h" 'helpful-symbol))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package eshell
  :custom
  (eshell-prefer-lisp-functions t)

  :hook
  (eshell-preoutput-filter-functions . ansi-color-apply))

(use-package evil
  :preface
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)

  :custom
  (evil-mode-line-format nil)
  (evil-shift-width 2)
  (evil-undo-system 'undo-fu)
  (evil-want-minibuffer t)

  :general
  (:states 'normal
   "s"     'evil-avy-goto-char-timer)

  :init
  (evil-mode 1))

(use-package evil-cleverparens
  :hook emacs-lisp-mode)

(use-package evil-collection
  :custom
  (evil-collection-setup-minibuffer t)

  :config
  (evil-collection-init))

(use-package evil-commentary
  :hook evil-mode)

(use-package evil-goggles
  :hook
  (evil-mode
   (evil-mode . evil-goggles-use-diff-faces)))

(use-package evil-indent-plus
  :config
  (evil-indent-plus-default-bindings))

(use-package evil-matchit
  :config
  (evilmi-load-plugin-rules '(ruby-ts-mode) '(simple ruby))

  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package forge
  :custom
  (forge-add-default-bindings nil)

  :custom-face
  (forge-pullreq-open ((t (:foreground "#458588")))))

(use-package heex-ts-mode
  :mode ("\\.\\(?:heex\\)"))

(use-package helpful
  :general
  (:states 'normal
   :prefix "SPC"
   "hf" '(helpful-callable :wk "callable")
   "hk" '(helpful-key      :wk "key")
   "hv" '(helpful-variable :wk "variable"))
  
  :init
  (add-to-list 'display-buffer-alist '("\\`\\*helpful" . ((display-buffer-same-window)
                                                          (reusable-frames . 0)))))
(use-package inf-ruby
  :preface
  (defun +rails-console-development ()
    (interactive)
    (let ((default-directory (project-root (project-current))))
      (inf-ruby-console-run "rails console" "rails-development")))

  (defun +rails-console-production ()
    (interactive)
    (let ((default-directory (project-root (project-current))))
      (inf-ruby-console-run (concat "heroku run rails console --app " (getenv "APP_NAME_PROD"))
                            "rails-production")))

  :general
  (:states 'normal
   :prefix "SPC"
   "gd"    '(+rails-console-development :wk "dev console")
   "gp"    '(+rails-console-production  :wk "prod console"))

  :hook
  (inf-ruby-mode . +corfu-disable-in-mode))

(use-package js
  :mode ("\\.\\(?:js\\)" . js-ts-mode))

(use-package json-ts-mode
  :mode ("\\.\\(?:json\\)"))

(use-package lsp-mode
  :custom
  (lsp-elixir-server-command '("elixir-ls"))
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-warn-no-matched-clients nil)

  :hook (prog-mode . lsp-deferred))

(use-package lsp-ui
  :custom
  (lsp-ui-doc-delay 1.5))

(use-package magit
  :general
  (:keymaps '(magit-status-mode-map)
   "SPC" nil)

  :init
  (dolist (regex '("\\`magit-revision:" "\\`magit-log:" "\\`magit:"))
    (add-to-list 'display-buffer-alist `(,regex . ((display-buffer-same-window) (reusable-frames . 0))))))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package prodigy
  :preface
  (defun +prodigy-set-up-for-project ()
    (hack-dir-local-variables-non-file-buffer)

    (let (lst)
      (setq prodigy-services
            (dolist (srv prodigy-services lst)
              (setq lst (cons (plist-put srv :cwd default-directory) lst)))))

    (prodigy-refresh))

  :config
  (setq prodigy-tags '((:name ar :cwd "/home/david/work/ar/trees/current")
                       (:name hq :cwd "/home/david/work/hq/trees/current")
                       (:name mariadb
                        :command "direnv"
                        :args ("exec" "."
                               "mysqld"
                               "--datadir=../../data/mariadb"
                               "--socket=/tmp/mysql.sock"))
                       (:name postgres
                        :command "direnv"
                        :args ("exec" "." "postgres" "-D" "../../data/postgres" "-k" "../../tmp"))
                       (:name rails-css :command "direnv" :args ("exec" "." "yarn" "build:css" "--watch"))
                       (:name rails-js :command "direnv" :args ("exec" "." "yarn" "build" "--watch"))
                       (:name rails-server :command "direnv" :args ("exec" "." "rails" "server"))
                       (:name redis
                        :command "direnv"
                        :args ("exec" "." "redis-server" "--dir" "../../data/redis"))))
  (setq prodigy-services '((:name "[ar] s3"
                            :command "direnv"
                            :args ("exec" "." "fakes3" "-r" "secure/" "-p" "4567")
                            :tags (ar))
                           (:name "[ar] css" :tags (ar rails-css))
                           (:name "[ar] db" :tags (ar mariadb))
                           (:name "[ar] js" :tags (ar rails-js))
                           (:name "[ar] redis" :tags (ar redis))
                           (:name "[ar] server" :tags (ar rails-server))
                           (:name "[hq] db" :tags (hq postgres))))

  :general
  (:states 'normal
   :prefix "SPC"
   "gr" '(prodigy :wk "services"))

  :hook
  (prodigy-mode . +prodigy-set-up-for-project))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ruby-ts-mode
  :preface
  (defun +ruby-set-up-compile-command ()
    (let ((fn (buffer-file-name)))
      (setq-local compile-command
                  (concat "rails test "
                          (cond
                           ((string-match-p "_test\\.rb\\'" fn) fn))))))

  :hook
  (ruby-ts-mode . +ruby-set-up-compile-command)

  :mode ("\\.\\(?:rb\\)" "\\`Gemfile\\'"))

(use-package smartparens
  :config
  (require 'smartparens-config)

  :hook
  (prog-mode . smartparens-mode)
  (emacs-lisp-mode . smartparens-strict-mode))

(use-package undo-fu-session
  :init (undo-fu-session-global-mode 1))

(use-package vertico
  :custom
  (vertico-cycle t)

  :init (vertico-mode 1))

(use-package web-mode
  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)

  :mode "\\.html\\.erb\\'")

(use-package which-key
  :init (which-key-mode 1))
