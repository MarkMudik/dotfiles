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
  ;; Backup Files
  (make-backup-files nil)
  (create-lockfiles nil)
  ;; Simple Quality of Life Improvements
  (use-short-answers t)
  (visible-bell nil)
  (global-auto-revert-mode t)
  (savehist-mode t)
  (recentf-mode t)
  ;; Start Buffer
  (initial-major-mode 'org-mode)
  (initial-scratch-message "")
  (initial-buffer-choice t)
  (inhibit-startup-screen t)
  :config
  (set-face-attribute 'default nil 
		      :font "FiraCode Nerd Font Mono" 
		      :height 200)
  (column-number-mode)
  (global-display-line-numbers-mode t)
  (global-visual-line-mode t)
  (setopt ring-bell-function 'ignore)
  ;; UI cleanup
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;; Appearance
(use-package modus-themes
  :ensure t
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  (modus-themes-headings
   '((1 . (variable-pitch 1.3))
     (2 . (variable-pitch 1.2))
     (3 . (variable-pitch 1.1))
     (t . (variable-pitch 1.0))))
  :config
  (load-theme 'modus-operandi t))

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
    :states '(normal motion visual)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

(my-leader-def

    "X" 'org-capture

    "f"  '(:ignore t :which-key "file")
    "ff" 'find-file
    "fD" 'dired-jump
    "fr" 'recentf

    "w"  '(:ignore t :which-key "window")
    "ws" 'split-window-below
    "wv" 'split-window-right
    "wh"  'evil-window-left
    "wj"  'evil-window-down
    "wk"  'evil-window-up
    "wl"  'evil-window-right
    
    "b"  '(:ignore t :which-key "buffer")
    "bb" 'switch-to-buffer
    "bk" 'kill-buffer

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

;; Org Mode
(use-package org
  :ensure nil
  :custom
  (org-directory "~/projects/orgs")
  (org-agenda-files '("~/projects/orgs/"))
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers t)
  (org-return-follows-link t)
  (org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "|" "DONE(d)")))
  :config
  (setq org-todo-keyword-faces
        '(("DOING" . "orange")))
  (setq org-capture-templates
        `(("l" "Location" entry (file+headline ,(concat org-directory "/locations.org") "Locations")
           "** %^{Name}
:PROPERTIES:
:Visited: %^{Visited|false|true}
:Address: %^{Address}
:Price: %^{Price}
:Rating: %^{Rating}
:Phone: %^{Phone}
:Link: %^{Link}
:Description: %^{Description}
:END:
%?"
           :prepend t
	   :empty-lines-after 0))))

;; Dictionary
(use-package dictionary
  :ensure nil
  :custom
  (dictionary-server "dict.org"))

;; Dired
(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-agho")
  (dired-dwim-target t)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-kill-when-opening-new-buffer t)
  :config
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  (evil-define-key 'normal dired-mode-map
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-file))

  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  
  (evil-define-key 'normal dired-mode-map
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-file))

;; Dired Nerd Icons
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

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
  :config
  (setq tmr-sound-file (expand-file-name "sounds/SMA2_Sound.oga" user-emacs-directory)
        tmr-notification-urgency 'normal
        tmr-description-list 'tmr-description-history))

;; Snippets
(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))
