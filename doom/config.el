;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "MesloLGM Nerd Font Mono" :size 24))

(setq doom-theme 'doom-one-light)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/notes/")

(setq webjump-sites
'(
("Google" . [simple-query "https://www.google.com/search?q=" ""])
("DuckDuckGo" . [simple-query "https://duckduckgo.com/?q=" ""])
("Arch Wiki" . [simple-query "https://wiki.archlinux.org/index.php?search=" ""])
("Reddit" . [simple-query "https://www.reddit.com/search/?q=" ""])
))

(use-package! evil-escape
  :after evil
  :config
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.2)
  (evil-escape-mode 1))
