;;================================================
;; PYTHON MODE
;;================================================
(add-hook
 'python-mode-hook
 (lambda ()
   (define-key python-mode-map (kbd "C-.") 'python-indent-shift-right)
   (define-key python-mode-map (kbd "C-,") 'python-indent-shift-left)
   (define-key python-mode-map "\C-m" 'newline-and-indent)
   ))

;; IPython setup
;; https://github.com/fgallina/python.el/blob/master/python.el
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--no-confirm-exit"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
 )

;; ================================================
;; PYMACS, ROPEMACS
;; ================================================
(setq ropemacs-enable-shortcuts nil)  ;; This needs to be first
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
(setq ropemacs-guess-project t)
(global-set-key (kbd "C-c g") 'rope-goto-definition)
(global-set-key (kbd "C-c d") 'rope-show-doc)
(global-set-key (kbd "C-c f") 'rope-find-occurrences)
(global-set-key (kbd "M-?") 'rope-code-assist)

;; ================================================
;; FILL COLUMN INDICATOR
;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
;; ================================================
(require 'fill-column-indicator)
(setq fci-rule-column 80)
;; need to suspend fill column indicator when using showing completions
;; http://emacs.stackexchange.com/questions/147/how-can-i-get-a-ruler-at-column-80
;; (add-hook 'python-mode-hook 'fci-mode)
