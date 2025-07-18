;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "MesloLGL Nerd Font Mono" :size 22)
      doom-variable-pitch-font (font-spec :family "Sans" :size 22))

(setq doom-theme 'modus-operandi)

(setq display-line-numbers-type 'relative)
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

(setq org-directory "~/org/")

(map! :n "f" #'avy-goto-char)

(use-package denote
  :ensure t
  :config
  (setq denote-directory (expand-file-name "~/orgs/"))
  (setq denote-rename-buffer-format "[%t] %b")
  (denote-rename-buffer-mode 1)
  (setq denote-file-type 'org))

(map! :leader
      :desc "Open or create Denote file"
      "f n" #'denote-open-or-create)
