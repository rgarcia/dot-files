(add-to-list 'load-path "~/.emacs.d/")

;; font-lock mode enables syntax highlighting
(global-font-lock-mode 1)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" system-name))

;; color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-light t)

;; GUIs are for b*tches
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

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
(global-set-key [\C-escape] 'electric-buffer-list)

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

;; compilation stuff
(setq compilation-scroll-output 1)   ;; automatically scroll the compilation window
(setq compilation-window-height 10)

;; inconsolata font (this sometimes doesn't work...)
(set-default-font "Inconsolata-14")

;; don't wrap long lines onto new lines
(set-default 'truncate-lines t)

;; say no to unecessary whitespace
(require 'whitespace)
(setq whitespace-line-column 100
      whitespace-style '(face empty tabs lines-tail trailing))
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
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

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
