(add-to-list 'load-path "~/.emacs.d/")

;; font-lock mode enables syntax highlighting
(global-font-lock-mode 1)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" system-name))

;; color theme: http://download.gna.org/color-theme/color-theme-6.6.0.tar.gz
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)

;; GUIs are for b*tches
(menu-bar-mode nil)
;;(scroll-bar-mode nil)

;; select with shift+arrows
(pc-selection-mode)

;; custom key bindings
(global-set-key [\C-tab] 'other-window)
(global-set-key [\C-\`] 'switch-to-buffer)
(global-set-key "\M-\`" 'ff-find-other-file)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-x\C-k" 'compile)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-x" 'uncomment-region)
(global-set-key "\M-q" 'query-replace)
(global-set-key "\M-1" 'revert-buffer)

;; scroll line by line
(setq scroll-step 1)

;; show time
(display-time)

;; use y or n instead of yes or not
(fset 'yes-or-no-p 'y-or-n-p)

;; show column number
(column-number-mode t)

;; Parenthesis matching
(show-paren-mode 1)

;; disable welcome message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; compilation stuff
(setq compilation-scroll-output 1)   ;; automatically scroll the compilation window
(setq compilation-window-height 10)

;; emacs and the clipboard should play nice
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; inconsolata font (this sometimes doesn't work...)
(set-default-font "Inconsolata-14")

;; don't wrap long lines onto new lines
(set-default 'truncate-lines t)

;; say no to unecessary whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; if you want to be really hardcore
;;(require 'drill-instructor)
;;(setq drill-instructor-global t)

;; indentation for different file types
(setq js-indent-level 2)
(setq-default indent-tabs-mode nil)
(add-hook 'python-mode-hook
      (lambda ()
        (setq tab-width 2)
        (setq python-indent 2)))

;; coffee-mode: https://github.com/defunkt/coffee-mode
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)
(setq coffee-tab-width 2)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; less css mode: https://github.com/purcell/less-css-mode
(add-to-list 'load-path "~/.emacs.d/less-css-mode")
(setq css-indent-offset 2)
(require 'less-css-mode)

;; use js mode for json
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;; jade html templates
(add-to-list 'load-path "~/.emacs.d/jade-mode")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; longlines mode for markdown files
(add-to-list 'auto-mode-alist '("\\.md$" . longlines-mode))

;; clojure
(add-to-list 'load-path "~/.emacs.d/clojure-mode")
(require 'clojure-mode)

;; php
(add-to-list 'load-path "~/.emacs.d/php-mode")
(require 'php-mode)
