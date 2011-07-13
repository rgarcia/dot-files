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

;; mako minor mode: https://bitbucket.org/pjenvey/mmm-mako/src
;; requires mmm: http://sourceforge.net/projects/mmm-mode/files/
(add-to-list 'load-path "~/.emacs.d/mmm-mode-0.4.8")
(require 'mmm-mode)
(add-to-list 'load-path "~/.emacs.d/mmm-mako")
(require 'mmm-mako)
(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
(mmm-add-mode-ext-class 'html-mode "\\.mako\\'" 'mako)

;; GUIs are for b*tches
(tool-bar-mode nil)
(menu-bar-mode nil)
(scroll-bar-mode nil)

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
(set-default-font "Inconsolata-13")

;; don't wrap long lines onto new lines
(set-default 'truncate-lines t)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; if you want to be really hardcore
;;(require 'drill-instructor)
;;(setq drill-instructor-global t)
