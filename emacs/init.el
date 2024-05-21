(setq use-package-always-demand t)

(use-package envrc
  :hook (emacs-startup . envrc-global-mode))

(use-package general)

(use-package +core
  :no-require t

  :custom
  (auth-sources '("~/sys/secrets/authinfo.gpg"))
  (auto-save-no-message t)
  (auto-save-visited-interval 3)
  (auto-save-visited-mode t)
  (column-number-mode t)
  (global-auto-revert-mode t)
  (indent-tabs-mode nil)
  (inhibit-startup-echo-area-message t)
  (inhibit-startup-message t)
  (inhibit-startup-screen t)
  (left-fringe-width 16)
  (make-backup-files nil)
  (recentf-mode t)
  (right-fringe-width 16)
  (ring-bell-function 'ignore)
  (save-place-mode t)
  (savehist-mode t)

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
   "C-s"   'save-buffer
   "s-j"   'next-buffer
   "s-k"   'previous-buffer
   "q"     'kill-this-buffer
   "s"     'evil-avy-goto-char-timer)
  (:states 'normal
   :prefix "SPC"
   "0"     '(delete-window           :wk "close this window")
   "1"     '(delete-other-windows    :wk "keep this window")
   "Q"     '(save-buffers-kill-emacs :wk "quit")
   "s"     '(project-eshell          :wk "shell")))

(use-package +help
  :no-require t

  :general
  (:states 'normal
   :prefix "SPC"
   "h"  '(nil              :wk "help")
   "hf" '(helpful-callable :wk "callable")
   "hk" '(helpful-key      :wk "key")
   "hi" '(consult-info     :wk "info")
   "hm" '(consult-man      :wk "man")
   "hv" '(helpful-variable :wk "variable")))

(use-package +vc
  :no-require t

  :general
  (:states 'normal
   :prefix "SPC"
   "v"     '(nil   :wk "vc")
   "vr"    '(vc-region-history :wk "region history")
   "vv"    '(magit :wk "magit")))

(use-package centered-cursor-mode
  :init (global-centered-cursor-mode))

(use-package consult
  :general
  (:states 'normal
   :prefix "SPC"
   "/"     '(consult-ripgrep        :wk "find text in project")
   "F"     '(consult-buffer         :wk "find")
   "b"     '(consult-buffer         :wk "buffer")
   "f"     '(consult-project-buffer :wk "find in project")
   "y"     '(consult-imenu          :wk "imenu"))

  :init
  (setq +consult-source-project-files
        `(:category file
          :name "Project File"
          :items ,(lambda ()
                    (let ((in (project-files (project-current)))
                          (dir (project-root (project-current)))
                          out)
                      (dolist (f in (reverse out))
                        (setq out (cons (file-relative-name f dir) out)))))))

  (add-to-list 'consult-project-buffer-sources '+consult-source-project-files))

(use-package corfu
  :custom
  (corfu-auto t)

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

(use-package embark
  :custom
  (embark-indicators '(embark-minimal-indicator embark-highlight-indicator))

  :general
  (:states 'normal 
   ";" 'embark-act))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package eshell
  :custom
  (eshell-prefer-lisp-functions t))

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

(use-package evil-collection
  :custom
  (evil-collection-setup-minibuffer t)

  :config
  (evil-collection-init))

(use-package evil-goggles
  :init
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

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
  (forge-add-default-bindings nil))

(use-package helpful
  :init
  (add-to-list 'display-buffer-alist '("\\`\\*helpful" . ((display-buffer-same-window)
                                                          (reusable-frames . 0)))))
(use-package inf-ruby
  :preface
  (defun +rails-console-development ()
    (interactive)
    (let ((default-directory (project-root (project-current))))
      (inf-ruby-console-run "rails console" "rails-development"))))

(use-package lsp-mode
  :custom
  (lsp-warn-no-matched-clients nil)

  :hook (prog-mode . lsp-deferred))

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

(use-package prog-mode
  :hook
  (prog-mode . electric-pair-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ruby-ts-mode
  :mode ("\\.\\(?:rb\\)" "\\`Gemfile\\'"))

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
