;;================================================
;; PYTHON MODE
;;================================================
(setq python-check-command "pycheckers2")
(global-set-key [?\C-.] 'python-shift-right)
(global-set-key [?\C-,] 'python-shift-left)

;; ;;================================================
;; ;; PYTHON-MODE.EL
;; ;;================================================
;; (add-to-list 'load-path (concat sc-vendor-dir "/python-mode-5.2.0"))
;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (global-set-key [?\C-.] 'py-shift-region-right)
;; (global-set-key [?\C-,] 'py-shift-region-left)

;; ;; ;; add underscore to symbol class (make underscore a word boundary)
;; ;; (setq py-dotted-expression-syntax-table t)

;; ;;================================================
;; ;; IPYTHON (requires python-mode.el)
;; ;;================================================
;; (require 'ipython)
;; (setq ansi-color-for-comint-mode t)

;; ;;================================================
;; ;; VIRTUALENV
;; ;;================================================
;; (require 'virtualenv)

;; ================================================
;; PYMACS, ROPEMACS
;; ================================================
(setq ropemacs-enable-shortcuts nil)
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;;================================================
;; 80-column highlighting
;; http://ruslanspivak.com/2010/09/27/keep-track-of-whitespaces-and-column-80-overflow/
;;================================================
;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
;; (setq whitespace-line-column 80
;;       whitespace-style '(tabs lines-tail))
