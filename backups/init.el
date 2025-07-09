;; -*- lexical-binding: t; -*-
  (winner-mode 1)

  (setq custom-file (locate-user-emacs-file "custom.el"))
  (load custom-file :no-error-if-file-is-missing)

  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)

  (setq use-short-answers t)
  (setq confirm-kill-emacs 'yes-or-no-p)
  (setq initial-major-mode 'org-mode
        initial-scratch-message ""
        initial-buffer-choice t)

  (setq-default truncate-lines t)
  (setq-default tab-width 4)
  (setq-default c-basic-offset 4)
  (setq-default fill-column 80)
  (setq line-move-visual t)

  (use-package paren
    ;; highlight matching delimiters
    :ensure nil
    :config
    (setq show-paren-delay 0.1
          show-paren-highlight-openparen t
          show-paren-when-point-inside-paren t
          show-paren-when-point-in-periphery t)
    (show-paren-mode 1))

  (setq sentence-end-double-space nil) ;; Sentences end with one space

  (setq bookmark-set-fringe-mark nil)

  (setq visible-bell nil) ;; Make it ring (so no visible bell) (default)
  (setq ring-bell-function 'ignore) ;; BUT ignore it, so we see and hear nothing

  (setq delete-by-moving-to-trash t)

  (setq-default display-line-numbers-width 3)

  (setq vc-follow-symlinks t)

  (setq create-lockfiles nil
        make-backup-files nil)

  ;;  (use-package recentf
  ;;  :ensure nil
  ;;  :init
  ;;  (setq recentf-max-saved-items 200
  ;;        recentf-filename-handlers
  ;;        (append '(abbreviate-file-name) recentf-filename-handlers))
  ;;  :config
  ;;  (recentf-mode 1))

  (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward)

  ;; ENCODING -------------
  (when (fboundp 'set-charset-priority)
    (set-charset-priority 'unicode))
  (prefer-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-language-environment "UTF-8")

  (setq blink-cursor-interval 0.6)
  (blink-cursor-mode 0)

  (setq save-interprogram-paste-before-kill t
        apropos-do-all t
        mouse-yank-at-point t)

  (setq what-cursor-show-names t)

  (setq dired-kill-when-opening-new-dired-buffer t)

  (setq reb-re-syntax 'string) ;; https://www.masteringemacs.org/article/re-builder-interactive-regexp-builder

  (setq xref-search-program 'ripgrep)

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

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

(let ((mono-spaced-font "MesloLGL Nerd Font Mono")
      (proportionately-spaced-font "Adwaita Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 200)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-operandi :no-confirm-loading))

;; Remember to do M-x and run `nerd-icons-install-fonts' to get the font files.
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package evil
    :init
    (setq evil-want-keybinding nil)
    (setq evil-want-fine-undo t)
    (setq evil-want-Y-yank-to-eol t)
    :config

    (evil-set-initial-state 'dashboard-mode 'motion)
    (evil-set-initial-state 'debugger-mode 'motion)
    (evil-set-initial-state 'pdf-view-mode 'motion)
    (evil-set-initial-state 'bufler-list-mode 'emacs)
    (evil-set-initial-state 'inferior-python-mode 'emacs)
    (evil-set-initial-state 'term-mode 'emacs)
    (evil-set-initial-state 'calc-mode 'emacs)

    ;; ----- Setting cursor colors
    (setq evil-emacs-state-cursor    '("#649bce" box))
    (setq evil-normal-state-cursor   '("#d9a871" box))
    (setq evil-operator-state-cursor '("#ebcb8b" hollow))
    (setq evil-visual-state-cursor   '("#677691" box))
    (setq evil-insert-state-cursor   '("#eb998b" (bar . 2)))
    (setq evil-replace-state-cursor  '("#eb998b" hbar))
    (setq evil-motion-state-cursor   '("#ad8beb" box))

    (evil-mode 1))

  (use-package evil-surround
    :after evil
    :defer 2
    :config
    (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :config
  ;; (setq evil-collection-mode-list '(dired (custom cus-edit) (package-menu package) calc diff-mode))
  ;; (setq evil-collection-mode-list '(dired))
  ;; (evil-collection-init '(dired))
  )

  ;;  (evil-define-key 'motion 'dired-mode-map "Q" 'kill-this-buffer)
  (evil-define-key 'motion help-mode-map "q" 'kill-this-buffer)
  (evil-define-key 'motion calendar-mode-map "q" 'kill-this-buffer)

(use-package general
	:ensure t
    :after evil
    :config
    (general-create-definer space/leader-keys
      :keymaps '()
      :prefix "SPC"
      :global-prefix "C-SPC")

  (space/leader-keys
    ;; General bindings
    "RET" '(consult-bookmark :which-key "Bookmark")
    ":" '(execute-extended-command :which-key "M-x")
    "'" '(vertico-repeat :which-key "Vertico repeat")
    "/" '(consult-ripgrep :which-key "Rgrep current")

    ;; File
    "f"  '(:ignore t :which-key "File")
    "ff" '(find-file :which-key "Find file")
    "." '(find-file :which-key "Find file")
    "fr" '(consult-recent-file :which-key "Recent files")
    "fd" '(dired :which-key "Dired")

    ;; Open
    "o"  '(:ignore t :which-key "Org")
    "o-" '(dired-jump :which-key "Dired")
    "oA" '(org-agenda :which-key "Agenda")
    "of" '(make-frame :which-key "Frame")
    "oF" '(select-frame-by-name :which-key "Select frame")
    "oL" '(org-open-at-point :which-key "Open Link")

    ;; Buffers
    "b"  '(:ignore t :which-key "Buffer")
    "<" '(consult-buffer :which-key "Switch buffer")
    "bi" '(ibuffer :which-key "Ibuffer")
    "bb" '(switch-to-buffer :which-key "Switch buffer")
    "bk" '(kill-current-buffer :which-key "Kill buffer")
    "bn" '(next-buffer :which-key "Next buffer")
    "bp" '(previous-buffer :which-key "Previous buffer")

    ;; Tabs
    "t"  '(:ignore t :which-key "Tab")
    "tt" '(tab-switch :which-key "Switch")
    "th" '(tab-next :which-key "Next")
    "tl" '(tab-previous :which-key "Previous")
    "tk" '(tab-close :which-key "Close")

    ;; Window management
    "w"  '(:ignore t :which-key "Window")
    "ws" '(split-window-below :which-key "Split below")
    "wv" '(split-window-right :which-key "Split right")
    "wd" '(delete-window :which-key "Delete window")
    "wq" '(delete-frame :which-key "Delete frame")
    "wh" '(evil-window-left :which-key "Left window")
    "wl" '(evil-window-right :which-key "Right window")
    "wj" '(evil-window-down :which-key "Down window")
    "wk" '(evil-window-up :which-key "Up window")

    ;; Projectile (file search)
    "p"  '(:ignore t :which-key "Project")
    "SPC" '(projectile-find-file :which-key "Find file")
    "pf" '(projectile-find-file :which-key "Find file")
    "pp" '(projectile-switch-project :which-key "Find file")
    "pb" '(projectile-switch-to-buffer :which-key "Switch buffer in project")
    "pr" '(projectile-recentf :which-key "Recent files")
    "pv" '(projectile-dired :which-key "Dired")
    "pd" '(projectile-find-dir :which-key "Find directory")
    "pt" '(projectile-toggle-between-implementation-and-test :which-key "Toggle between impl/test")
    "ps" '(projectile-grep :which-key "Search in project")

    ;; Magit
    "g"  '(:ignore t :which-key "Magit")
    "gG" '(magit-fetch :which-key "Fetch")
    "gC" '(magit-clone :which-key "Clone")
    "gcr" '(magit-init :which-key "Init")
    "gg" '(magit-status :which-key "Status")
    "g/" '(magit-dispatch :which-key "Dispatch")
    "gff" '(magit-find-file :which-key "Find file")
    "gS" '(magit-file-stage :which-key "File stage")
    "gD" '(magit-file-delete :which-key "File delete")
    "gfc" '(magit-show-commit :which-key "Show commit")
    "gcf" '(magit-commit-fixup :which-key "Commit fixup")
    "gU" '(magit-file-unstage :which-key "File unstage")
    "gcc" '(magit-commit-create :which-key "Commit create")
    "g." '(magit-file-dispatch :which-key "File dispatch")
    "gB" '(magit-blame-addition :which-key "Blame addition")
    "gb" '(magit-branch-checkout :which-key "Branch checkout")
    "glr" '(magit-list-repositories :which-key "List repositories")

    ;; Code
    "c"  '(:ignore t :which-key "Code")
    "cc" '(compile :which-key "Compile")
    "cC" '(recompile :which-key "Recompile")

    ;; Notes
    "n"  '(:ignore t :which-key "Notes")
    "na" '(org-agenda :which-key "Org agenda")
    "x" '(org-capture :which-key "Org capture")

    ;; Undo/Redo
    "u"  '(:ignore t :which-key "Undo")
    "uu" '(undo-fu-only-undo :which-key "Undo")
    "ur" '(undo-fu-only-redo :which-key "Redo")
    "ud" '(undo-fu-session-clear :which-key "Clear undo history")

    ;; Avy navigation
    "s"  '(:ignore t :which-key "Avy")
    "ss" '(avy-goto-char :which-key "Avy char")
    "sf" '(avy-goto-line :which-key "Avy line")
    "sb" '(avy-goto-word-1 :which-key "Avy word")

    ;; Helper
    "h"  '(:ignore t :which-key "Help")
    "hk" '(describe-key :which-key "Describe key")
    ))

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

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
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

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles/emacs/init.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package org
  :ensure t
  :custom
  (org-directory "~/notes"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (calc . t)))

(setq org-confirm-babel-evaluate nil)
(push '("conf-unix" . conf-unix) org-src-lang-modes)

(use-package denote
  :ensure t
  :init
  (setq denote-directory (expand-file-name "~/notes/"))
  :bind
  (("C-c n n" . denote)
   ("C-c n o" . denote-open-or-create)
   ("C-c n s" . denote-search-notes)
   ("C-c n l" . denote-link)))

(use-package magit
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package webjump
  :defer
  :ensure nil
  :config
  (setq webjump-sites
	  '(
	    ("ChatGPT" . "https://chatgpt.com/")
	    ("Claude" . "https://claude.ai/")
	    ("Todoist" . "https://app.todoist.com/app/today")
	    ("Microsoft Excel" . "https://excel.cloud.microsoft/")
	    ("Microsoft Word" . "https://word.cloud.microsoft/")
	    ("Microsoft One Drive" . "https://appslosrios-my.sharepoint.com/")
	    ("Pearson Revel Computer Science" . "https://console.pearson.com/console/home/")
	    ("Discord" . "https://discord.com/channels/@me")
	    ("Desmos Graphing Calculator" . "https://www.desmos.com/calculator")
	    ("Readwise Reader" . "https://read.readwise.io/")
	    ("Canvas Los Rios" . "https://lrccd.instructure.com/")
	    ("Pearson Realize Math" . "https://mylab.pearson.com/")
	    ("Deepseek" . "https://chat.deepseek.com/")
	    ("GitHub" . "https://github.com/")
	    ("Amazon" . [simple-query "https://www.amazon.com/" "https://www.amazon.com/s?k=" ""])
	    ("DuckDuckGo" . [simple-query "www.duckduckgo.com" "www.duckduckgo.com/?q=" ""])
	    ("Google" . [simple-query "www.google.com" "www.google.com/search?q=" ""])
	    ("Google Images" . [simple-query "www.google.com" "www.google.com/images?q=" ""])
	    ("YouTube" . [simple-query "www.youtube.com/feed/subscriptions" "www.youtube.com/results?search_query=" ""])
	  ("Reddit" . [simple-query "https://www.reddit.com" "https://www.reddit.com/search/?q=" ""]))))
