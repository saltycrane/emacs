;;================================================
;; PYTHON MODE
;;================================================
(setq python-check-command "pycheckers2")
(global-set-key [?\C-.] 'python-shift-right)
(global-set-key [?\C-,] 'python-shift-left)

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
