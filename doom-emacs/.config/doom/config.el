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

;;;Experimental
;;;; Run commands in a popup frame

(defun prot-window-delete-popup-frame (&rest _)
  "Kill selected selected frame if it has parameter `prot-window-popup-frame'.
Use this function via a hook."
  (when (frame-parameter nil 'prot-window-popup-frame)
    (delete-frame)))

(defmacro prot-window-define-with-popup-frame (command)
  "Define interactive function which calls COMMAND in a new frame.
Make the new frame have the `prot-window-popup-frame' parameter."
  `(defun ,(intern (format "prot-window-popup-%s" command)) ()
     ,(format "Run `%s' in a popup frame with `prot-window-popup-frame' parameter.
Also see `prot-window-delete-popup-frame'." command)
     (interactive)
     (let ((frame (make-frame '((prot-window-popup-frame . t)))))
       (select-frame frame)
       (switch-to-buffer " prot-window-hidden-buffer-for-popup-frame")
       (condition-case nil
           (call-interactively ',command)
         ((quit error user-error)
          (delete-frame frame))))))

(declare-function org-capture "org-capture" (&optional goto keys))
(defvar org-capture-after-finalize-hook)

;;;###autoload (autoload 'prot-window-popup-org-capture "prot-window")
(prot-window-define-with-popup-frame org-capture)

(add-hook 'org-capture-after-finalize-hook #'prot-window-delete-popup-frame)

(declare-function tmr "tmr" (time &optional description acknowledgep))
(defvar tmr-timer-created-functions)

;;;###autoload (autoload 'prot-window-popup-tmr "prot-window")
(prot-window-define-with-popup-frame tmr)

(add-hook 'tmr-timer-created-functions #'prot-window-delete-popup-frame)

;;;Bind to some key although I dont even know what this is
;; emacsclient -e '(prot-window-popup-tmr)'
