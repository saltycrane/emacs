;;================================================
;; COLORS
;; see http://www.gnu.org/software/emacs/manual/html_node/emacs/Standard-Faces.html
;;================================================
(set-face-background 'mode-line "#4477aa")
;; (set-face-background 'mode-line-inactive "#99aaff")
(set-face-background 'fringe "#809088")
(set-face-background 'trailing-whitespace "#e0e0e0")
(set-face-background 'scroll-bar "#4477aa") ;; this doesn't work

;;================================================
;; SCROLLBAR
;; set scroll bar on the right with a width to 8 pixels
;;================================================
(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)
(modify-all-frames-parameters
 '((scroll-bar-width . 5)))

;;================================================
;; FONT
;; override this in hosts/hostname.el
;;================================================

;; (modify-all-frames-parameters
;;  '((font . "DejaVu Sans Mono-10")))
