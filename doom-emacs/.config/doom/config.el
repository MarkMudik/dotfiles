;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 22)
;      doom-variable-pitch-font (font-spec :family "SF Pro" :size 22))

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 22))

(setq doom-theme 'doom-one-light)

(setq display-line-numbers-type `relative)

(setq org-directory "~/projects/public/orgs/")

(after! denote
  (setq denote-directory "~/projects/private/notes/")
  (setq denote-file-type 'markdown-yaml))
