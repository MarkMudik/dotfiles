;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 20))
(setq doom-theme 'doom-one-light)
(setq display-line-numbers-type `relative)
(setq org-directory "~/projects/orgs/")
(setq scroll-margin 6)

;; Denote
(use-package! denote
  :config
  (setq denote-directory (expand-file-name "~/projects/orgs/")))
