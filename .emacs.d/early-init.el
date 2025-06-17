;; -*- lexical-binding: t; -*-

;; Garbage Collections
(setq gc-cons-percentage 0.6)

;; Compile warnings
(setq native-comp-async-report-warnings-errors 'silent)
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

;; MISC OPTIMIZATIONS ----
(setq idle-update-delay 1.0)

(setq-default bidi-display-reordering 'left-to-right 
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq inhibit-compacting-font-caches t)

(menu-bar-mode 0)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Window configuration
(setq frame-inhibit-implied-resize t)

(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))
