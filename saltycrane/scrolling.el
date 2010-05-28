;; from http://www.postulate.org/emacs.php
;; Pgup/dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)

;; don't automatically add new lines when scrolling down at
;; the bottom of a buffer
(setq next-line-add-newlines nil)

;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; move around a little
(defun cursor-up-slightly () (interactive) (previous-line 5))
(defun cursor-down-slightly () (interactive) (next-line 5))
(global-set-key "\C-\M-j" 'cursor-down-slightly)
(global-set-key "\C-\M-k" 'cursor-up-slightly)

(defun scroll-up-slightly () (interactive) (scroll-up 5))
(defun scroll-down-slightly () (interactive) (scroll-down 5))
(global-set-key [M-down] 'scroll-down-slightly)
(global-set-key [M-up] 'scroll-up-slightly)

(defun scroll-right-slightly () (interactive) (scroll-right 5))
(defun scroll-left-slightly () (interactive) (scroll-left 5))
(global-set-key [M-right] 'scroll-right-slightly)
(global-set-key [M-left] 'scroll-left-slightly)

;; do scroll horizontally when at edge of screen
(setq auto-hscroll-mode t)
(setq hscroll-margin 0)
