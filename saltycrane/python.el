;;================================================
;; PYTHON MODE
;;================================================
(setq python-check-command "pycheckers2")
(setq python-shell-interpreter "ipython")
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-.")
            'python-indent-shift-right)
            (define-key python-mode-map (kbd "C-,")
            'python-indent-shift-left)
          )
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
