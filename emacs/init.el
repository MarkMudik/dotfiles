;;; -*- lexical-binding: t; -*-

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
(setq initial-major-mode 'org-mode
      initial-scratch-message "")
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq scroll-margin 6)

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
  (load-theme 'modus-operandi :no-confirm-loading))

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
 
;;; Keybinds

;;; Set before evil is loaded or error given
;(setq evil-want-integration t)
;(setq evil-want-keybinding nil)

;(use-package evil
;  :ensure t
;  :config
;  (evil-mode 1))

;(use-package evil-collection
;  :after evil
;  :ensure t
;  :config
;  (evil-collection-init))

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

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

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

;;; Denote

(use-package denote
  :ensure t
  :init
  (setq denote-directory (expand-file-name "~/notes/"))

  (setq denote-rename-buffer-format "[%t] %b")
  (denote-rename-buffer-mode 1)

  (setq denote-file-type 'markdown-yaml)

  :bind
  (("C-c n n" . denote)
   ("C-c n s" . denote-subdirectory)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks-buffer)
   ("C-c n r" . denote-rename-file-using-front-matter)
   ("C-c n d r" . denote-dired-rename-files)))
