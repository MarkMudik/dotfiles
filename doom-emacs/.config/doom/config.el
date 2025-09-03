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

(after! evil-snipe
  (setq evil-snipe-scope 'buffer))

(after! webjump
  (setq webjump-sites
        '(
          ("Canvas" . "https://lrccd.instructure.com/login/saml")
          ("Discord" . "https://discord.com/channels/@me")
          ("YouTube Search" . [simple-query "www.youtube.com" "https://www.youtube.com/results?search_query="])
          )))


(map! :leader
      :desc "Webjump"
      "o w" #'webjump)
