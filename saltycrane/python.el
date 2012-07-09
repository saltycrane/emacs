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

;;================================================
;; JARVIS
;; http://madlag.github.com/jarvis/
;;================================================
(pymacs-load "jarvis.emacs" "j-")
(global-set-key (kbd "C-x g") 'j-goto-error)
(global-set-key (kbd "C-x i") 'j-inspect-vars)

;;================================================
;; Fix python-shift-left and python-shift-right so that they keep the region
;; highlighted.
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2011-06/msg00063.html
;;================================================
(defun balle-python-shift-left ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
           mark-active)
        (setq start (region-beginning) end (region-end))
      (progn
        (setq bds (bounds-of-thing-at-point 'line))
        (setq start (car bds) end (cdr bds))))
  (python-shift-left start end))
  (setq deactivate-mark nil)
)
(defun balle-python-shift-right ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
           mark-active)
        (setq start (region-beginning) end (region-end))
      (progn
        (setq bds (bounds-of-thing-at-point 'line))
        (setq start (car bds) end (cdr bds))))
  (python-shift-right start end))
  (setq deactivate-mark nil)
)
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-.")
            'balle-python-shift-right)
            (define-key python-mode-map (kbd "C-,")
            'balle-python-shift-left)
          )
)
