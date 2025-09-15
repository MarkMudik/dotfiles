;;; -*- lexical-binding: t; -*-

(when (eq system-type 'darwin)

  (setq mac-command-modifier       'control
        mac-option-modifier        'meta
        mac-control-modifier       'hyper
        mac-right-command-modifier 'control
        mac-right-option-modifier  'meta)

  (setq insert-directory-program "/opt/homebrew/bin/gls"
        dired-use-ls-dired t)

  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
