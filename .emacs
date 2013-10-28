;; use melpa for external pkgs
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; check if the packages is installed; if not, install it.
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 '(magit solarized-theme go-mode coffee-mode markdown-mode less-css-mode jade-mode
         ansi-color clojure-mode php-mode ace-jump-mode yaml-mode exec-path-from-shell
         thrift))

(add-to-list 'load-path "~/.emacs.d/")

;; font-lock mode enables syntax highlighting
(global-font-lock-mode 1)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; hitting delete on marked text deletes the text
(delete-selection-mode 1)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" system-name))

;; solarized
(load-theme 'solarized-dark t)

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
(global-set-key "\M-r" 'revert-buffer)
(global-set-key [\C-escape] 'electric-buffer-list)

;; scroll line by line instead of jumping
(setq scroll-step 1)

;; show time
(display-time)

;; use y or n instead of yes or not
(fset 'yes-or-no-p 'y-or-n-p)

;; show column number
(column-number-mode t)

;; Parenthesis matching
(show-paren-mode 1)

;; disable welcome mode
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; compilation stuff
(setq compilation-scroll-output 1)   ;; automatically scroll the compilation window
(setq compilation-window-height 30)

;; inconsolata font (this sometimes doesn't work...)
(set-default-font "Inconsolata-15")

;; don't wrap long lines onto new lines
(set-default 'truncate-lines t)

;; say no to unecessary whitespace
(require 'whitespace)
(setq whitespace-line-column 100
      whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; tabs are ok in go-mode
(require 'go-mode-load)
(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq whitespace-style '(face empty lines-tail trailing))))

(add-hook 'before-save-hook 'gofmt-before-save)
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
(require 'coffee-mode)
(setq coffee-tab-width 2)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; less css mode: https://github.com/purcell/less-css-mode
(require 'less-css-mode)
(setq css-indent-offset 2)

;; use js mode for json
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;; jade html templates
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; clojure
(require 'clojure-mode)

;; php
(require 'php-mode)

;; holy shit: http://emacs.wordpress.com/2007/01/17/eval-and-replace-anywhere/
(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (prin1 (eval (read (current-kill 0)))
         (current-buffer)))
(global-set-key (kbd "C-c e") 'fc-eval-and-replace)

;; ace-jump-mode https://github.com/winterTTr/ace-jump-mode
;; word jump C-c spc 
;; char jump C-u C-c spc
;; line jump C-u C-u C-c spc
(require 'ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; http://thornydev.blogspot.com/2012/08/happiness-is-emacs-trifecta.html
(defun toggle-windows-split()
  "Switch back and forth between one window and whatever split of windows we might have in the frame. The idea is to maximize the current buffer, while being able to go back to the previous split of windows in the frame simply by calling this command again."
  (interactive)
  (if (not (window-minibuffer-p (selected-window)))
      (progn
        (if (< 1 (count-windows))
            (progn
              (window-configuration-to-register ?u)
              (delete-other-windows))
          (jump-to-register ?u))))
  (my-iswitchb-close))
(define-key global-map (kbd "C-|") 'toggle-windows-split)

;; magit: https://github.com/magit/magit
;; make EMACS=/usr/local/Cellar/emacs/24.1/bin/emacs
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))
(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))
(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
;; Longlines minor mode for markdown files
(add-hook 'markdown-mode-hook (lambda () (longlines-mode 1)))
;;(add-to-list 'auto-mode-alist '("\\.md$" . longlines-mode))
(setq-default fill-column 95) ; fill up half of a split screen on laptop

;; yaml-mode
(add-to-list 'load-path "~/.emacs.d/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))

;; make sure M-x shell and M-x compile pick up normal environment
(setq explicit-bash-args (list "--login" "-i"))
(setq shell-file-name "bash")
(setq shell-command-switch "-ilc")

;; make sure colors show up in compilation buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; http://emacsredux.com/blog/2013/03/30/kill-other-buffers/
(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))
(global-set-key (kbd "C-c k") 'kill-other-buffers)

;; newline at end of file
(setq require-final-newline t)

;; go autocomplete https://github.com/nsf/gocode
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; save mini buffer history
(savehist-mode 1)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
