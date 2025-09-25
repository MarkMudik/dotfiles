;;; -*- lexical-binding: t; -*-

(setq user-full-name "MarkieAurelius"
      user-mail-address "MarkieAurelius@gmail.com")

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(add-to-list 'load-path (locate-user-emacs-file "prot-lisp"))

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

    (setq make-backup-files nil)
    (setq create-lockfiles nil)
    (setq use-short-answers t)
    (setq confirm-kill-emacs 'yes-or-no-p)
    (setq initial-major-mode 'lisp-interaction-mode
        initial-scratch-message ""
        initial-buffer-choice t)

    (save-place-mode 1)

  (setq visible-bell nil)
  (setq ring-bell-function 'ignore)
  (setq scroll-margin 6)

  (setq ispell-alternate-dictionary "/usr/share/dict/words")

(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent)
  (setq native-compile-prune-cache t))

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize 'force
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box t
      use-file-dialog nil
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name
      inhibit-startup-buffer-menu t)

  (use-package recentf
    :ensure nil
    :hook (after-init . recentf-mode)
    :config
    (setq recentf-max-saved-items 100)
    (setq recentf-max-menu-items 25)
    (setq recentf-save-file-modes nil)
    (setq recentf-keep nil)
    (setq recentf-auto-cleanup nil)
    (setq recentf-initialize-file-name-history nil)
    (setq recentf-filename-handlers nil)
    (setq recentf-show-file-shortcuts-flag nil))

  (use-package bookmark
  :ensure nil
  :commands (bookmark-set bookmark-jump bookmark-bmenu-list)
  :hook (bookmark-bmenu-mode . hl-line-mode)
  :config
  (setq bookmark-use-annotations nil)
  (setq bookmark-automatically-show-annotations nil)
  (setq bookmark-fringe-mark nil)
  (setq bookmark-save-flag 1))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

  (use-package emacs
    :ensure nil
    :demand t
    :config
    (setq blink-matching-paren nil)
    (setq custom-unlispify-tag-names nil)
    (setq delete-pair-blink-delay 0.1)
    (setq delete-pair-push-mark t)
    (setq echo-keystrokes-help nil)
    (setq epa-keys-select-method 'minibuffer)
    (setq eval-expression-print-length nil)
    (setq find-library-include-other-files nil)
    (setq help-window-select t)
    (setq kill-do-not-save-duplicates t)
    (setq mode-require-final-newline 'visit-save)
    (setq next-error-recenter '(4))
    (setq remote-file-name-inhibit-auto-save t)
    (setq remote-file-name-inhibit-delete-by-moving-to-trash t)
    (setq save-interprogram-paste-before-kill t)
    (setq scroll-error-top-bottom t)
    (setq tramp-connection-timeout (* 60 10))
    (setq-default truncate-partial-width-windows nil)
    (setq tab-first-completion 'word-or-paren-or-punct)
    (setq-default tab-width 4
                indent-tabs-mode nil)
    :bind
    ( :map global-map
      ("<f2>" . toggle-input-method)
      ("<insert>" . nil)
      ("<menu>" . nil)
      ("C-x C-d" . nil)
      ("C-x C-v" . nil)
      ("C-z" . nil)
      ("C-x C-z" . nil)
      ("C-x C-c" . nil)
      ("C-x C-c C-c" . save-buffers-kill-emacs)
      ("C-x C-r" . restart-emacs)
      ("C-h h" . nil)
      ("M-`" . nil)
      ("M-o" . delete-blank-lines)
      ("M-SPC" . cycle-spacing)
      ("M-z" . zap-up-to-char)
      ("M-c" . capitalize-dwim)
      ("M-l" . downcase-dwim)
      ("M-u" . upcase-dwim)
      ("M-=" . count-words)
      ("C-x O" . next-multiframe-window)
      ("C-h K" . describe-keymap)
      ("C-x k" . kill-current-buffer)
      ("C-x K" . kill-buffer)
      ("C-c s" . scratch-buffer)

      :map ctl-x-x-map
      ("f" . follow-mode)
      ("r" . rename-uniquely)
      ("l" . visual-line-mode)
      ("v" . variable-pitch-mode)))

(mapc
 (lambda (command)
   (put command 'disabled nil))
 '(list-timers narrow-to-region narrow-to-page upcase-region downcase-region))

;; And disable these
(mapc
 (lambda (command)
   (put command 'disabled t))
 '(eshell project-eshell overwrite-mode iconify-frame diary))

(use-package winner
  :ensure nil
  :hook (after-init . winner-mode)
  :bind
  (("C-x <right>" . winner-redo)
   ("C-x <left>" . winner-undo)))

(use-package prot-simple
  :ensure nil
  :demand t
  :config
  (setq prot-simple-date-specifier "%F")
  (setq prot-simple-time-specifier "%R %z")

  (advice-add #'save-buffers-kill-emacs :before #'prot-simple-display-unsaved-buffers-on-exit)

  (prot-simple-override-mode 1)

  :bind
  ( :map prot-simple-override-mode-map
    ("C-d" . prot-simple-delete-line)

    ("C-v" . prot-simple-multi-line-below)
    ("<next>" . prot-simple-multi-line-below)
    ("M-v" . prot-simple-multi-line-above)
    ("<prior>" . prot-simple-multi-line-above)

    :map global-map
    ("<escape>" . prot-simple-keyboard-quit-dwim)
    ("C-g" . prot-simple-keyboard-quit-dwim)
    ("C-M-SPC" . prot-simple-mark-sexp)
    ("C-," . prot-simple-mark-sexp)
    ;; Commands for lines
    ("C-S-d" . prot-simple-delete-line-backward)
    ("C-S-k" . prot-simple-kill-line-backward)
    ("M-k" . prot-simple-copy-line-forward)
    ("M-K" . prot-simple-copy-line-backward)
    ("M-j" . delete-indentation)
    ("C-w" . prot-simple-kill-region)
    ("M-w" . prot-simple-kill-ring-save)

    ("C-S-w" . prot-simple-copy-line)
    ("C-S-y" . prot-simple-yank-replace-line-or-region)
    ("<C-return>" . prot-simple-new-line-below)
    ("<C-S-return>" . prot-simple-new-line-above)
    ("C-x x a" . prot-simple-auto-fill-visual-line-mode) ; auto-fill/visual-line toggle
    ;; Commands for text insertion or manipulation
    ("C-=" . prot-simple-insert-date)
    ("C-<" . prot-simple-escape-url-dwim)
    ;; "C->" prot-simple-insert-line-prefix-dwim
    ("M-Z" . prot-simple-zap-to-char-backward)
    ;; Commands for object transposition
    ("C-S-p" . prot-simple-move-above-dwim)
    ("C-S-n" . prot-simple-move-below-dwim)
    ("C-t" . prot-simple-transpose-chars)
    ("C-x C-t" . prot-simple-transpose-lines)
    ("C-S-t" . prot-simple-transpose-paragraphs)
    ("C-x M-t" . prot-simple-transpose-sentences)
    ("C-M-t" . prot-simple-transpose-sexps)
    ("M-t" . prot-simple-transpose-words)
    ;; Commands for paragraphs
    ("M-Q" . prot-simple-unfill-region-or-paragraph)
    ;; Commands for windows and pages
    ("C-x o" . prot-simple-other-window)
    ("C-x n k" . prot-simple-delete-page-delimiters)
    ("M-r" . window-layout-transpose)
    ("M-S-r" . rotate-windows-back)
    ;; Commands for buffers
    ("<C-f2>" . prot-simple-rename-file-and-buffer)
    ("C-x k" . prot-simple-kill-buffer-current)
    ("C-x K" . kill-buffer)
    ("M-s b" . prot-simple-buffers-major-mode)
    ("M-s v" . prot-simple-buffers-vc-root)
    ;; Commands for files
    ("C-x r ." . prot-simple-file-to-register)))

  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)

(let ((mono-spaced-font "Iosevka Nerd Font Mono")
      (proportionately-spaced-font "SF Pro"))
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
          '((1 . (rainbow overline background 1.2))
            (2 . (rainbow background 1.1))
            (3 . (rainbow bold 1.1))
            (t . (semilight 1.1))))
    (load-theme 'modus-operandi t))

  (use-package spacious-padding
  :ensure t
  :hook (after-init . spacious-padding-mode))

(use-package display-line-numbers
  :ensure nil
  :bind
  ("<f7>" . display-line-numbers-mode)
  :config
  (setq-default display-line-numbers-type t)
  (setq display-line-numbers-major-tick 0)
  (setq display-line-numbers-minor-tick 0)
  (setq-default display-line-numbers-widen t))

(use-package lin
  :ensure t
  :hook (after-init . lin-global-mode)
  :config
  (setq lin-face 'lin-cyan))

(use-package rfn-eshadow
  :ensure nil
  :hook (minibuffer-setup . cursor-intangible-mode)
  :config

  (setq resize-mini-windows t)
  (setq read-answer-short t) ; also check `use-short-answers' for Emacs28
  (setq echo-keystrokes 0.25)
  (setq kill-ring-max 60) ; Keep it small

  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))

  (setq crm-prompt (format "%s %%p" (propertize "[%d]" 'face 'shadow))) ; Emacs 31

  (file-name-shadow-mode 1))

(use-package minibuffer
  :ensure nil
  :config
;;;; Completion styles
  (setq completion-styles '(basic substring initials flex orderless))
  (setq completion-pcm-leading-wildcard t)
(setq completion-auto-deselect nil)
  (setq completion-auto-help 'always)
  (setq completion-auto-select 'second-tab)
  (setq completion-show-help nil)
  (setq completion-show-inline-help nil)
  (setq completions-detailed t)
  (setq completions-format 'one-column)
  (setq completions-header-format "")
  (setq completions-highlight-face 'completions-highlight)
  (setq completions-max-height 10)
  (setq completions-sort 'historical)
  (setq completion-eager-display 'auto)
  (setq minibuffer-completion-auto-choose t)
  (setq minibuffer-visible-completions nil))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode)
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 5)
  (setq vertico-resize t)
  (setq vertico-cycle t))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode)
  :config
  (setq marginalia-max-relative-age 0))

  (use-package consult
    :ensure t
    :hook (completion-list-mode . consult-preview-at-point-mode)
    :bind
    ( :map global-map
      ("M-g M-g" . consult-goto-line)
      ("M-s M-b" . consult-buffer)
      ("M-s M-f" . consult-find)
      ("M-s M-g" . consult-grep)
      ("M-s M-h" . consult-history)
      ("M-s M-i" . consult-imenu)
      ("M-s M-l" . consult-line)
      ("M-s M-m" . consult-mark)
      ("M-s M-y" . consult-yank-pop)
      ("M-s M-s" . consult-outline)
      :map consult-narrow-map
      ("?" . consult-narrow-help))
    :config
    (setq consult-line-numbers-widen t)
    (setq consult-async-min-input 3)
    (setq consult-async-input-debounce 0.5)
    (setq consult-async-input-throttle 0.8)
    (setq consult-narrow-key nil)
    (setq consult-find-args
          (concat "find . -not ( "
                  "-path */.git* -prune "
                  "-or -path */.cache* -prune )")))

(use-package orderless
  :ensure t
  :demand t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil)
  (setq orderless-matching-styles '(orderless-prefixes orderless-regexp)))

  (use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :config
  (setq savehist-file (locate-user-emacs-file "savehist"))
  (setq history-length 100)
  (setq history-delete-duplicates t)
  (setq savehist-save-minibuffer-history t)
  (add-to-list 'savehist-additional-variables 'kill-ring))

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
    :hook (embark-collect-mode . prot-common-truncate-lines-silently)
    :bind
    ( :map minibuffer-local-map
      ("C-c C-c" . embark-collect)
      ("C-c C-e" . embark-export)))

(use-package embark-consult
    :ensure t
    :after (embark consult))

(use-package isearch
  :ensure nil
  :demand t
  :config
  (setq search-whitespace-regexp ".*?"
        isearch-lax-whitespace t
        isearch-regexp-lax-whitespace nil)
  (setq search-highlight t)
  (setq isearch-lazy-highlight t)
  (setq lazy-highlight-initial-delay 0.5)
  (setq lazy-highlight-no-delay-length 4)
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "(%s/%s) ")
  (setq lazy-count-suffix-format nil)
  (setq isearch-wrap-pause t)
  (setq isearch-repeat-on-direction-change t)
  (setq list-matching-lines-jump-to-current-line nil)
  (add-hook 'occur-mode-hook #'prot-common-truncate-lines-silently)
  (add-hook 'occur-mode-hook #'hl-line-mode)
  :bind
  ( :map global-map
    ("C-." . isearch-forward-symbol-at-point)
    :map minibuffer-local-isearch-map
    ("M-/" . isearch-complete-edit)
    :map occur-mode-map
    ("t" . toggle-truncate-lines)
    :map isearch-mode-map
    ("C-g" . isearch-cancel)
    ("M-/" . isearch-complete)))

(unless (>= emacs-major-version 31)
  (use-package wgrep
    :ensure t
    :after grep
    :bind
    ( :map grep-mode-map
      ("e" . wgrep-change-to-wgrep-mode)
      ("C-x C-q" . wgrep-change-to-wgrep-mode)
      ("C-c C-c" . wgrep-finish-edit))
    :config
    (setq wgrep-auto-save-buffer t)
    (setq wgrep-change-readonly-file t)))

;; (use-package avy
;;   :ensure t
;;   :bind
;;   (("C-:" . avy-goto-char-timer)
;;    ("C-'" . avy-goto-char)
;;    ("M-g w" . avy-goto-word-1)))

  (use-package dired
    :ensure nil
    :commands (dired)
    :config
    (setq dired-kill-when-opening-new-dired-buffer t)
    (setq dired-recursive-copies 'always)
    (setq dired-recursive-deletes 'always)
    (setq delete-by-moving-to-trash t)
    (setq dired-dwim-target t)
    (setq dired-auto-revert-buffer #'dired-directory-changed-p)
    (setq dired-make-directory-clickable t)
    (setq dired-free-space nil)
    (setq dired-mouse-drag-files t)
    
    (define-key dired-jump-map (kbd "j") nil)
    ;; (define-key dired-mode-map (kbd "e") #'wdired-change-to-wdired-mode) (Disabled for evil mode)
    ;; (define-key dired-mode-map (kbd "b") #'dired-up-directory) (Disabled for evil mode)
    (setq dired-listing-switches
        "-AGFhlv --group-directories-first --time-style=long-iso")

    (add-hook 'dired-mode-hook #'dired-hide-details-mode)
    (add-hook 'dired-mode-hook #'hl-line-mode))


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

(use-package wdired
  :ensure nil
  :commands (wdired-change-to-wdired-mode)
  :config
  (setq wdired-allow-to-change-permissions t)
  (setq wdired-create-parent-directories t))

  (use-package magit
  :ensure t
  :bind
  ( :map global-map
    ("C-c g" . magit-status)
    :map magit-mode-map
    ("C-w" . nil)
    ("M-w" . nil))
  :init
  (setq magit-define-global-key-bindings nil))

(use-package forge
  :ensure t
  :after magit)

(use-package project
  :ensure nil
  :bind
  (("C-x p ." . project-dired)
   ("C-x p C-g" . keyboard-quit)
   ("C-x p <return>" . project-dired)
   ("C-x p <delete>" . project-forget-project)))

(use-package calendar
  :ensure nil
  :commands (calendar)
  :config
  (setq calendar-mark-diary-entries-flag nil)
  (setq calendar-mark-holidays-flag t)
  (setq calendar-mode-line-format nil)
  (setq calendar-time-display-form
        '( 24-hours ":" minutes
           (when time-zone (format "(%s)" time-zone))))
  (setq calendar-week-start-day 1)
  (setq calendar-date-style 'iso)
  (setq calendar-time-zone-style 'numeric))

      (use-package org
        :ensure nil
        :init
        (setq org-tags-column 0)
        (setq org-tag-alist nil)
        (setq org-auto-align-tags nil)
        (setq org-directory (expand-file-name "~/projects/private/orgs"))
        (setq org-imenu-depth 7)
      :bind
      ( :map global-map
        ("C-c l" . org-store-link)
        ("C-c o" . org-open-at-point-global)
        :map org-mode-map
        ("C-a" . nil)
        ("C-d" . nil)
        ("C-S-d" . nil)
        ("C-'" . nil)
        ("C-," . nil)
        ("M-;" . nil)
        ("<C-return>" . nil)
        ("<C-S-return>" . nil)
        ("C-M-S-<right>" . nil)
        ("C-M-S-<left>" . nil)
        ("C-c ;" . nil)
        ("C-c M-l" . org-insert-last-stored-link)
        ("C-c C-M-l" . org-toggle-link-display)
        ("M-." . org-edit-special)
        :map org-src-mode-map
        ("M-," . org-edit-src-exit)
        :map narrow-map
        ("b" . org-narrow-to-block)
        ("e" . org-narrow-to-element)
        ("s" . org-narrow-to-subtree))
      :config
      (setq org-ellipsis "⮧")
      (setq org-special-ctrl-a/e nil)
      (setq org-special-ctrl-k nil)
      (setq org-M-RET-may-split-line '((default . nil)))
      (setq org-hide-emphasis-markers nil)
      (setq org-hide-macro-markers nil)
      (setq org-hide-leading-stars nil)
      (setq org-cycle-separator-lines 0)
      (setq org-fold-catch-invisible-edits 'show)
      (setq org-return-follows-link nil)
      (setq org-loop-over-headlines-in-active-region 'start-level)
      (setq org-fontify-quote-and-verse-blocks t)
      (setq org-fontify-whole-block-delimiter-line t)
      (setq org-track-ordered-property-with-tag t)
      (setq org-highest-priority ?A)
      (setq org-lowest-priority ?C)
      (setq org-default-priority ?A)
      (setq org-priority-faces nil)
      (setq org-adapt-indentation nil)
      (setq org-indent-mode-turns-on-hiding-stars nil)
      (setq org-indent-indentation-per-level 4)

  (setq org-refile-targets
        '((org-agenda-files . (:maxlevel . 2))
          (nil . (:maxlevel . 2))))
  (setq org-refile-use-outline-path t)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-refile-use-cache t)
  (setq org-reverse-note-order nil)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "MAYBE(m)" "|" "CANCELLED(c@)" "DONE(d!)")))

  (setq org-use-fast-todo-selection 'expert)

  (setq org-fontify-done-headline nil)
  (setq org-fontify-todo-headline nil)
  (setq org-fontify-whole-heading-line nil)
  (setq org-enforce-todo-dependencies t)
  (setq org-enforce-todo-checkbox-dependencies t)

  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-log-note-clock-out nil)
  (setq org-log-redeadline 'time)
  (setq org-log-reschedule 'time)
  (setq org-return-follows-link t)
  (setq org-link-context-for-files t)
  (setq org-link-keep-stored-after-insertion nil)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))

(use-package org-capture
  :ensure nil
  :bind ("C-c c" . org-capture)
  :config
  (setq org-capture-templates
        '(("b" "book" entry
           (file+headline "20250919T122651--book-tracker.org" "Book Agenda")
           "* TODO [#A] %? %^{Title} by %^{Author}"
           :prepend t)
          ("w" "weight" item
           (file+headline "20250919T130545--weight-tracking.org" "Weight")
           "- %t : %?")
)))

(use-package org
  :ensure nil
  :config
  (setq org-confirm-babel-evaluate nil
        org-src-window-setup 'current-window
        org-edit-src-persistent-message nil
        org-src-fontify-natively t
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
)))

(use-package org
  :ensure nil
  :config
  (setq org-export-with-toc t)
  (setq org-export-headline-levels 8)
  (setq org-export-dispatch-use-expert-ui nil)
  (setq org-html-htmlize-output-type nil)
  (setq org-html-head-include-default-style nil)
  (setq org-html-head-include-scripts nil))

(use-package ox-reveal
  :ensure t
  :after ox
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))

(use-package htmlize
  :ensure t
  :config
  (setq org-html-htmlize-output-type 'inline-css))

(use-package org
:ensure nil
  :bind
  ( :map global-map
    ("C-c A" . org-agenda))
:config
(setq org-default-notes-file (make-temp-file "emacs-org-notes-")) ; send it to oblivion
  (setq org-agenda-files (list org-directory))
  (setq org-agenda-span 'week)
  (setq org-agenda-start-on-weekday 1)  ; Monday
  (setq org-agenda-confirm-kill t)
  (setq org-agenda-show-all-dates t)
  (setq org-agenda-show-outline-path nil)
  (setq org-agenda-window-setup 'current-window)
  (setq org-agenda-skip-comment-trees t)
  (setq org-agenda-menu-show-matcher t)
  (setq org-agenda-menu-two-columns nil)
  (setq org-agenda-sticky nil)
  (setq org-agenda-custom-commands-contexts nil)
  (setq org-agenda-max-entries nil)
  (setq org-agenda-max-todos nil)
  (setq org-agenda-max-tags nil)
  (setq org-agenda-max-effort nil)
  (setq org-deadline-warning-days 3)

(setq org-agenda-prefix-format
        '((agenda . " %i %-12:c%?-12t% s")
          (todo . " %i %-12:c")
          (tags . " %i %-12:c")
          (search . " %i %-12:c")))
  (setq org-agenda-sorting-strategy
        '(((agenda habit-down time-up priority-down category-keep)
           (todo priority-down category-keep)
           (tags priority-down category-keep)
           (search category-keep))))
  (setq org-agenda-breadcrumbs-separator "->")
  (setq org-agenda-todo-keyword-format "%-1s")
  (setq org-agenda-fontify-priorities 'cookies)
  (setq org-agenda-category-icon-alist nil)
  (setq org-agenda-remove-times-when-in-prefix nil)
  (setq org-agenda-remove-timeranges-from-blocks nil)
  (setq org-agenda-compact-blocks nil)
  (setq org-agenda-block-separator ?—)

;;;;; Agenda marks
  (setq org-agenda-bulk-mark-char "#")
  (setq org-agenda-persistent-marks nil)

;;;;; Agenda diary entries
  (setq org-agenda-insert-diary-strategy 'date-tree)
  (setq org-agenda-insert-diary-extract-time nil)
  (setq org-agenda-include-diary nil)
  (setq diary-file (make-temp-file "emacs-diary-"))
  (setq org-agenda-diary-file 'diary-file)

;;;;; Agenda follow mode
  (setq org-agenda-start-with-follow-mode nil)
  (setq org-agenda-follow-indirect t)

;;;;; Agenda multi-item tasks
  (setq org-agenda-dim-blocked-tasks t)
  (setq org-agenda-todo-list-sublevels t)

;;;;; Agenda filters and restricted views
  (setq org-agenda-persistent-filter nil)
  (setq org-agenda-restriction-lock-highlight-subtree t)

  ;; Time grid
  (setq org-agenda-time-leading-zero t)
  (setq org-agenda-timegrid-use-ampm nil)
  (setq org-agenda-use-time-grid t)
  (setq org-agenda-show-current-time-in-grid t)
  (setq org-agenda-current-time-string (concat "Now " (make-string 70 ?.)))
  (setq org-agenda-time-grid
        '((daily today require-timed)
          ( 0500 0600 0700 0800 0900 1000
            1100 1200 1300 1400 1500 1600
            1700 1800 1900 2000 2100 2200)
          "" ""))
  (setq org-agenda-default-appointment-duration nil)

;;;;; Agenda global to-do list
  (setq org-agenda-todo-ignore-with-date t)
  (setq org-agenda-todo-ignore-timestamp t)
  (setq org-agenda-todo-ignore-scheduled t)
  (setq org-agenda-todo-ignore-deadlines t)
  (setq org-agenda-todo-ignore-time-comparison-use-seconds t)
  (setq org-agenda-tags-todo-honor-ignore-options nil)

;;;;; Agenda tagged items
  (setq org-agenda-show-inherited-tags t)
  (setq org-agenda-use-tag-inheritance
        '(todo search agenda))
  (setq org-agenda-hide-tags-regexp nil)
  (setq org-agenda-remove-tags nil)
  (setq org-agenda-tags-column 1)

;;;;; Agenda entry
  (setq org-agenda-start-with-entry-text-mode nil)
  (setq org-agenda-entry-text-maxlines 5)
  (setq org-agenda-entry-text-exclude-regexps nil)
  (setq org-agenda-entry-text-leaders "    > "))

(use-package org-protocol
  :ensure nil)

;(use-package org-modern
;  :ensure t
;  :hook
;  (org-mode . org-modern-mode)
;  (org-agenda-finalize . org-modern-agenda))

(use-package eww
  :ensure nil
  :after prot-simple
  :commands (eww)
  :bind
  ( :map eww-mode-map
    ("S" . nil)
    ("b" . prot-simple-buffers-major-mode)
    ("m" . bookmark-set)
    :map eww-link-keymap
    ("v" . nil)
    :map dired-mode-map
    ("E" . eww-open-file))
  :config
  (setq eww-auto-rename-buffer 'title)
  (setq eww-header-line-format nil)
  (setq eww-bookmarks-directory (locate-user-emacs-file "eww-bookmarks/"))
  (setq eww-history-limit 150)
  (setq eww-use-external-browser-for-content-type
        "\\`\\(video/\\|audio\\)")
  (setq eww-form-checkbox-selected-symbol "[X]")
  (setq eww-form-checkbox-symbol "[ ]")

  (setq eww-retrieve-command nil)

  (dolist (command '( eww-list-bookmarks eww-add-bookmark eww-bookmark-mode
                      eww-list-buffers eww-toggle-fonts eww-toggle-colors
                      eww-switch-to-buffer))
    (put command 'disabled t)))

(use-package eww
  :ensure nil
  :commands (eww)
  :bind
  ( :map eww-mode-map
    ("S" . nil)
    ("m" . bookmark-set)
    :map eww-link-keymap
    ("v" . nil)
    :map dired-mode-map
    ("E" . eww-open-file))
  :config
  (setq eww-auto-rename-buffer 'title)
  (setq eww-header-line-format nil)
  (setq eww-bookmarks-directory (locate-user-emacs-file "eww-bookmarks/"))
  (setq eww-history-limit 150)
  (setq eww-form-checkbox-selected-symbol "[X]")
  (setq eww-form-checkbox-symbol "[ ]"))

(use-package denote
  :ensure t
  :hook
  ((dired-mode . denote-dired-mode))
  :bind
  ( :map global-map
    ("C-c n n" . denote-open-or-create)
    ("C-c n N" . denote-type)
    ("C-c n d" . denote-sort-dired)
    ("C-c n r" . denote-rename-file)
    :map text-mode-map
    ("C-c n i" . denote-link)
    ("C-c n I" . denote-add-links)
    ("C-c n b" . denote-backlinks)
    ("C-c n R" . denote-rename-file-using-front-matter)
    :map dired-mode-map
    ("C-c C-d C-i" . denote-dired-link-marked-notes)
    ("C-c C-d C-r" . denote-dired-rename-marked-files)
    ("C-c C-d C-k" . denote-dired-rename-marked-files-with-keywords)
    ("C-c C-d C-f" . denote-dired-rename-marked-files-using-front-matter))
  :config
  (setq denote-directory (expand-file-name "~/projects/private/orgs"))
  ;(setq denote-file-type 'markdown-yaml)
  (setq denote-file-type 'org)
  (setq denote-known-keywords '("business"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-excluded-directories-regexp nil)
  (setq denote-date-format nil)
  (setq denote-rename-confirmations nil)
  (setq denote-backlinks-show-context nil)
  (setq denote-buffer-name-prefix "[D] ")
  (setq denote-rename-buffer-format "%D")

  (denote-rename-buffer-mode 1))

(use-package denote-org
  :ensure t)

(use-package vterm
  :ensure t
  :commands (vterm)
  :bind
   ("C-c t" . vterm)
  :config
  (setq vterm-shell "/bin/bash"))

 (use-package webjump
   :defer
   :ensure nil
   :bind
   ("C-x /" . webjump)
   :config
   (setq webjump-sites
	  '(
	    ("ChatGPT" . "https://chatgpt.com/")
	    ("GitHub" . "https://github.com/")
        ("Privacy (cards)" . "https://app.privacy.com/home")	    	    ("Amazon" . [simple-query "https://www.amazon.com/" "https://www.amazon.com/s?k=" ""])
	    ("Google" . [simple-query "www.google.com" "www.google.com/search?q=" ""])
	    ("YouTube" . [simple-query "www.youtube.com/feed/subscriptions" "www.youtube.com/results?search_query=" ""])
	    ("Reddit" . [simple-query "https://www.reddit.com" "https://www.reddit.com/search/?q=" ""])
	    ("Canvas" . "https://lrccd.instructure.com/")
	    ("Desmos Graphing Calculator" . "https://www.desmos.com/calculator")
	    ("Discord" . "https://discord.com/channels/@me")
)))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; Make C-u scroll like Vim and let evil-collection own keybindings
(setq evil-want-C-u-scroll t
      evil-want-keybinding nil)

(use-package evil
  :ensure t
  :init
  ;; Optionally keep TAB for Org (so Org cycling still works)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(dolist (m '(term-mode vterm-mode eshell-mode shell-mode))
  (add-to-list 'evil-emacs-state-modes m))

(use-package evil-snipe
  :ensure t
  :after evil
  :custom
  (evil-snipe-scope 'whole-visible)
  (evil-snipe-repeat-scope 'whole-visible)
  (evil-snipe-smart-case t)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :after evil
  :ensure t
  :bind (("M-;" . evilnc-comment-or-uncomment-lines))
  :config
  ;; (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
  (define-key evil-visual-state-map "gc" 'evilnc-comment-operator)
  (define-key evil-normal-state-map "gcc" 'evilnc-comment-or-uncomment-lines))

(use-package undo-fu
  :ensure t)
(with-eval-after-load 'evil
  (setq evil-undo-system 'undo-fu))

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

(use-package tab-bar
  :ensure nil
  :config
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-show 1))

(use-package electric
  :ensure nil
  :hook
  (prog-mode . electric-indent-local-mode)
  :config
  (electric-pair-mode -1)
  (electric-quote-mode -1)
  (electric-indent-mode -1))

(defun efs/org-babel-tangle-config ()
  (when (string= (buffer-file-name)
                 (expand-file-name "~/projects/public/dotfiles/emacs/.emacs.d/init.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'after-save-hook #'efs/org-babel-tangle-config)
