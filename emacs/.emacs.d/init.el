;; Custom File
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; Async Settings
(setopt native-comp-async-report-warnings-errors 'silent
        warning-minimum-level :error
        native-compile-prune-cache t)

;; Package Management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

;; General Improvements and UI Elements
(use-package emacs
  :ensure nil
  :custom
  ;; Lines
  (display-line-numbers-type 'relative)
  (scroll-margin 6)
  (scroll-step 1)
  ;; Backup Files
  (make-backup-files nil)
  (create-lockfiles nil)
  ;; Simple Basic Settings
  (use-short-answers t)
  (visible-bell nil)
  ;; Start Buffer
  (initial-major-mode 'org-mode)
  (initial-scratch-message "")
  (initial-buffer-choice t)
  (inhibit-startup-screen t)
  :config
  (column-number-mode)
  (global-display-line-numbers-mode t)
  (setopt ring-bell-function 'ignore)
  ;; UI cleanup
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;; Evil Mode
(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :custom
  (evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Keyboard (General.el)
(use-package general
  :config
  (general-create-definer my-leader-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

(my-leader-def

    "f"  '(:ignore t :which-key "file")
    "ff" 'find-file

    "w"  '(:ignore t :which-key "window")
    "ws" 'split-window-below
    "wv" 'split-window-right
    "wh"  'evil-window-left
    "wj"  'evil-window-down
    "wk"  'evil-window-up
    "wl"  'evil-window-right
    
    "b"  '(:ignore t :which-key "buffer")
    "bb" 'switch-to-buffer
    "bk" 'kill-this-buffer

    "o"  '(:ignore t :which-key "open")
    "od" 'dictionary-search
    "ow" 'webjump
    "ot" 'tmr

    "g"   '(:ignore t :which-key "git")
    "gg"  'magit-status))

;; Clipboard Terminal
(use-package xt-mouse
  :ensure nil
  :config
  (xterm-mouse-mode 1)
  (setopt xterm-extra-capabilities '(getSelection setSelection)))

;; Which key
(use-package which-key
  :custom
  (which-key-idle-delay 0.3)
  :config
  (which-key-mode))

;; Completion (Vertico + Orderless)
(use-package vertico
  :init
  (vertico-mode)
  :config
  (define-key vertico-map (kbd "C-j") 'vertico-next)
  (define-key vertico-map (kbd "C-k") 'vertico-previous))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init
  (marginalia-mode))

;; Dictionary
(use-package dictionary
  :ensure nil
  :custom
  (dictionary-server "dict.org"))

;; Magit
(use-package magit
  :commands magit-status)

;; Webjump
(use-package webjump
  :defer t
  :ensure nil
  :custom
  (webjump-sites '(("Google" . [simple-query "www.google.com" "www.google.com/search?q=" ""]))))

;; Timer (tmr)
(use-package tmr
  :ensure t
  :custom
  (tmr-notification-urgency 'normal)
  (tmr-description-list 'tmr-description-history))
