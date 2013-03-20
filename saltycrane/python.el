;;================================================
;; PYTHON MODE
;;================================================
(setq python-check-command "pycheckers2")

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

;;================================================
;; JARVIS
;; http://madlag.github.com/jarvis/
;;================================================
(pymacs-load "jarvis.emacs" "j-")
(global-set-key (kbd "C-x g") 'j-goto-error)
(global-set-key (kbd "C-x i") 'j-inspect-vars)

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-.")
            'python-indent-shift-right)
            (define-key python-mode-map (kbd "C-,")
            'python-indent-shift-left)
          )
)
