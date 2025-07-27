;;; -*- lexical-binding: t; -*-

(setq user-full-name "MarkieAurelius"
      user-mail-address "MarkieAurelius@gmail.com")

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(setq make-backup-files nil)

;;; Set up the package manager

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(defun prot/keyboard-quit-dwim ()
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(define-key global-map (kbd "C-g") #'prot/keyboard-quit-dwim)

(setq use-short-answers t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq initial-major-mode 'org-mode ;; Major mode of new buffers
      initial-scratch-message ""
      initial-buffer-choice t)

(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq scroll-margin 6)


(savehist-mode 1)
(use-package recentf
  :ensure nil
  :config
  (setq
   recentf-auto-cleanup 'never
   ;; recentf-max-menu-items 0
   recentf-max-saved-items 200)
  (setq recentf-filename-handlers
        (append '(abbreviate-file-name) recentf-filename-handlers))
  (recentf-mode))

(global-set-key (kbd "C-c r") 'consult-recent-file)

;;; Appearance

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(let ((mono-spaced-font "MesloLGL Nerd Font Mono")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 180)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(use-package modus-themes
  :ensure t
  :config
  (setq modus-themes-mode-line '(accented borderless)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-fringes 'subtle
        modus-themes-tabs-accented t
        modus-themes-paren-match '(bold intense)
        modus-themes-prompts '(bold intense)
        modus-themes-org-blocks 'tinted-background
        modus-themes-scale-headings t
        modus-themes-region '(bg-only)
        modus-themes-headings
        '((1 . (rainbow overline background 1.4))
          (2 . (rainbow background 1.3))
          (3 . (rainbow bold 1.2))
          (t . (semilight 1.1))))
  (load-theme 'modus-operandi t))

;;; Configure the minibuffer and completions

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-y" . consult-yank-pop)
   ("C-c h" . consult-history)
   ("C-c m" . consult-mode-command)
   ("C-c k" . consult-kmacro)
   ("C-x r b" . consult-bookmark)
   ("C-x p b" . consult-project-buffer)))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep
  :ensure t)

;;; The file manager (Dired)

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package avy
  :ensure t
  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-2)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0))
  :custom
  (avy-background t)
  (avy-style 'at-full)
  (avy-keys (number-sequence ?a ?z)))

;; Magit 

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; Projectile

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code")))
  (setq projectile-switch-project-action #'projectile-dired))

;;; Which Key

(use-package which-key
  :diminish which-key-mode
  :init
  (which-key-mode)
  (which-key-setup-minibuffer)
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "◉ ")
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-min-display-lines 3
        which-key-max-display-columns nil))

;;; Org

(use-package org
  :ensure nil
  :config
  (setq org-ellipsis " ⬎"
        org-hide-leading-stars t)
  (setq org-tags-column 0)
  (add-hook 'org-mode-hook #'visual-line-mode))

(setq org-capture-templates
  '(("l" "later" entry
     (file "~/orgs/20250714T190120--read-it-later.org")
     "* TODO %x %^g" :empty-lines 1)))

(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)

;;; Denote


(use-package denote
  :ensure t
  :config
  (setq denote-directory (expand-file-name "~/notes/"))
  (setq denote-rename-buffer-format "[%t] %b")
  (denote-rename-buffer-mode 1)
  (setq denote-file-type 'markdown-yaml))

(global-set-key (kbd "C-c n") #'denote-open-or-create)

;;; Vterm (terminal emulation)

(use-package vterm
  :ensure t
  :commands (vterm)
  :config
  (setq vterm-shell "/bin/bash"))

(global-set-key (kbd "C-c t") 'vterm)

;;; Multiple Cursors (mc)

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C->" . mc/mark-next-like-this-word)
	 ("C-c C-<" . mc/mark-previous-like-this-word)
	 ("C-c S-n" . mc/insert-numbers)))

;;; Webjump

 (use-package webjump
   :defer
   :ensure nil
   :config
   (setq webjump-sites
	  '(
	    ("ChatGPT" . "https://chatgpt.com/")
	    ("Todoist" . "https://app.todoist.com/app/today")
	    ("GitHub" . "https://github.com/")
	    ("CamelCamelCamel" . "https://camelcamelcamel.com")
	    ("Amazon" . [simple-query "https://www.amazon.com/" "https://www.amazon.com/s?k=" ""])
	    ("Google" . [simple-query "www.google.com" "www.google.com/search?q=" ""])
	    ("YouTube" . [simple-query "www.youtube.com/feed/subscriptions" "www.youtube.com/results?search_query=" ""])
	    ("Reddit" . [simple-query "https://www.reddit.com" "https://www.reddit.com/search/?q=" ""]))))

;;; Spacious Padding Mode

(use-package spacious-padding
  :ensure t
  :hook (after-init . spacious-padding-mode))

;;; mu4e
;(use-package mu4e
;  :ensure nil
;  :load-path "/usr/share/emacs/site-lisp/mu4e"
;  ;; :defer 20 ; uncomment after a bit of time
;  :config
;  (setq mu4e-change-filenames-when-moving t)
;  (setq mu4e-update-interval (* 30 60))
;  (setq mu4e-get-mail-command "mbsync -a")
;  (setq mu4e-maildir "~/.mail/personal")

  ;(setq mu4e-drafts-folder "[Gmail]/Drafts")
  ;(setq mu4e-sent-folder "[Gmail]/Sent Mail")
  ;(setq mu4e-refile-folder "[Gmail]/All Mail")
  ;(setq mu4e-trash-folder "[Gmail]/Trash")

  ;(setq mu4e-maildir-shortcuts
  ;      '((:maildir "Inbox"    :key ?i)
  ;        (:maildir "[Gmail]/Sent Mail" :key ?s)
  ;        (:maildir "[Gmail]/Trash"     :key ?t)
  ;        (:maildir "[Gmail]/Drafts"    :key ?d)
  ;        (:maildir "[Gmail]/All Mail"  :key ?a))))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))
