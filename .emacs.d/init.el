(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(setq initial-major-mode 'org-mode
      initial-scratch-message ""
      initial-buffer-choice t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-visual-line-mode 1)

(tab-bar-mode 1)

(recentf-mode 1)
(setq recentf-auto-cleanup 'never)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq use-short-answers t)

(save-place-mode 1)

(set-fringe-mode 10)

(setq scroll-margin 8)

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			   ("org" . "https://orgmode.org/elpa/")
			   ("elpa" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1))

(set-face-attribute 'default nil :family "MesloLGL Nerd Font Mono" :height 230)

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-operandi :no-confirm-loading))

(use-package all-the-icons)

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (("C-s" . consult-line)
         ("M-y" . consult-yank-pop)
         ("C-x b" . consult-buffer)
         ("C-x C-r" . consult-recent-file)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g i" . consult-imenu)))

;; Optional: add icons in minibuffer (requires nerd-icons-completion + marginalia setup)
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-fine-undo t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-set-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-create-definer space/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

(space/leader-keys
  ;; General bindings
  "RET" '(consult-bookmark :which-key "Bookmark")
  ":" '(execute-extended-command :which-key "M-x")
  "'" '(vertico-repeat :which-key "M-x")
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
  
  ;; Buffers
  "b"  '(:ignore t :which-key "Buffer")
  "<" '(consult-buffer :which-key "Switch buffer")
  "bi" '(ibuffer :which-key "Ibuffer")
  "bb" '(switch-to-buffer :which-key "Switch buffer")
  "bk" '(kill-current-buffer :which-key "Kill buffer")
  "bn" '(next-buffer :which-key "Next buffer")
  "bp" '(previous-buffer :which-key "Previous buffer")

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
  "gG" '(magit-status-here :which-key "Status here")
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
  :diminish
  :config
  (setq which-key-idle-delay 0.3)
  (which-key-mode))

(use-package projectile
  :ensure t
  :defer t
  :diminish projectile-mode
  :config
  (projectile-mode 1)
  :custom
  ((projectile-project-search-path '("~/code/"))
   (projectile-switch-project-action #'projectile-dired)
   ;; (projectile-indexing-method 'alien)
   (projectile-enable-caching t)))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

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
  (setq dired-kill-when-opening-new-dired-buffer t)
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

(use-package org
  :ensure t
  :custom
  (org-directory "~/notes")
  ;; Optionally: org-default-notes-file setup
  ;; (org-default-notes-file (concat org-directory "/20250531T210853--smoothie-recipes.org"))
  :config
  (setq org-capture-templates
        '(("s" "Smoothie" entry
           (file+headline "~/notes/20250531T210853--smoothie-recipes.org" "Recipes")
           "** %^{Title}\n:properties:\n:source: %^{Source|Self}\n:end:\n- %?")))
)

(use-package denote
  :ensure t
  :init
  (setq denote-directory (expand-file-name "~/notes/"))
  :bind
  (("C-c n n" . denote)
   ("C-c n o" . denote-open-or-create)
   ("C-c n s" . denote-search-notes)
   ("C-c n l" . denote-link)))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

  ;; === Undo & Search ===
  (use-package undo-fu)

  (use-package avy
    :bind ("M-s" . avy-goto-char))

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

;; === Indentation ===
(electric-pair-mode 1)
(setq indent-tabs-mode t)
(defun my-c-style-setup ()
  (c-set-style "linux")
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil))


(add-hook 'c-mode-hook #'my-c-style-setup)
(add-hook 'c++-mode-hook #'my-c-style-setup)

(use-package magit)

;;  (use-package lsp-mode
;;    :ensure t
;;    :commands lsp
;;    :hook ((c-mode . lsp)
;;           (c++-mode . lsp)
;;           (objc-mode . lsp))
;;    :config
;;    (setq lsp-prefer-flymake nil)
;;    (setq lsp-enable-snippet t)
;;    (setq lsp-headerline-breadcrumb-enable t)
;;    )
;;
;;  (use-package lsp-ui
;;    :ensure t
;;    :commands lsp-ui-mode
;;    :config
;;    (setq lsp-ui-sideline-enable t)
;;    (setq lsp-ui-doc-enable t)
;;    (setq lsp-ui-imenu-enable t))
;;
;;
;;  (use-package company
;;    :after lsp-mode
;;    :hook (lsp-mode . company-mode)
;;    :bind (:map company-active-map
;;  			  ("<tab>" . company-complete-selection))
;;    (:map lsp-mode-map
;;          ("<tab>" . company-indent-or-complete-common))
;;    :custom
;;    (company-minimum-prefix-length 1)
;;    (company-idle-delay 0.0))
;;
;;  (use-package company-box
;;    :hook (company-mode . company-box-mode))

(use-package yasnippet
  :config
  (yas-global-mode 1))

;;  (use-package webjump
;;    :defer
;;    :ensure nil
;;    :config
;;    (setq webjump-sites
;;	  '(
;;	    ("ChatGPT" . "https://chatgpt.com/")
;;	    ("Claude" . "https://claude.ai/")
;;	    ("Todoist" . "https://app.todoist.com/app/today")
;;	    ("Microsoft Excel" . "https://excel.cloud.microsoft/")
;;	    ("Microsoft Word" . "https://word.cloud.microsoft/")
;;	    ("Microsoft One Drive" . "https://appslosrios-my.sharepoint.com/")
;;	    ("Pearson Revel Computer Science" . "https://console.pearson.com/console/home/")
;;	    ("Discord" . "https://discord.com/channels/@me")
;;	    ("Desmos Graphing Calculator" . "https://www.desmos.com/calculator")
;;	    ("Readwise Reader" . "https://read.readwise.io/")
;;	    ("Canvas Los Rios" . "https://lrccd.instructure.com/")
;;	    ("Pearson Realize Math" . "https://mylab.pearson.com/")
;;	    ("Deepseek" . "https://chat.deepseek.com/")
;;	    ("GitHub" . "https://github.com/")
;;	    ("Amazon" . [simple-query "https://www.amazon.com/" "https://www.amazon.com/s?k=" ""])
;;	    ("DuckDuckGo" . [simple-query "www.duckduckgo.com" "www.duckduckgo.com/?q=" ""])
;;	    ("Google" . [simple-query "www.google.com" "www.google.com/search?q=" ""])
;;	    ("Google Images" . [simple-query "www.google.com" "www.google.com/images?q=" ""])
;;	    ("YouTube" . [simple-query "www.youtube.com/feed/subscriptions" "www.youtube.com/results?search_query=" ""])
;;	  ("Reddit" . [simple-query "https://www.reddit.com" "https://www.reddit.com/search/?q=" ""]))))

(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles/.emacs.d/init.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

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
