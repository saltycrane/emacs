;;================================================
;; GOOGLE REGION
;; http://blog.tuxicity.se/?p=32
;;================================================
(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" (buffer-substring beg end))))

;;================================================
;; my eclipse CTRL+ALT+G replacement
;;================================================
(defun grep-selected (start end)
  (interactive "r")
  (grep (concat "find . -maxdepth 1 "
                "! -regex '.*~$' "
                "! -regex '.*\.orig$' "
                "! -regex '.*\.new$' "
                "! -regex '.*\.pyc$' "
                "! -regex '.*\.elc$' "
                "! -regex '.*\.bak$' "
                "-exec grep -nH "
                " \'"
                (buffer-substring start end)
                "\' "
                "NUL {} + "
                )))
(global-set-key "\C-\M-g" 'grep-selected)

;;================================================
;; split into small and large window
;;================================================
(defun split-window-small ()
  (interactive)
  (split-window-vertically 55)
  (other-window 1)
)
(global-set-key "\C-x9" 'split-window-small)

;;================================================
;; CHANGE FONT SIZE ON THE FLY
;; http://sachachua.com/wp/2006/09/15/emacs-changing-the-font-size-on-the-fly/
;;================================================
(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C-=") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

;;================================================
;; rename current buffer filename
;; http://www.stringify.com/2006/apr/24/rename/
;;================================================
(defun rename-current-file-or-buffer ()
  (interactive)
  (if (not (buffer-file-name))
      (call-interactively 'rename-buffer)
    (let ((file (buffer-file-name)))
      (with-temp-buffer
        (set-buffer (dired-noselect file))
        (dired-do-rename)
        (kill-buffer nil))))
  nil)

;;================================================
;; GET HOSTNAME
;; http://jeremy.zawodny.com/emacs/.emacs
;;================================================
(defun jdz-get-hostname (&optional long-p)
  "Get the current hostname by calling 'hostname'"
  (interactive "*P")
  (let ((jdz-hostname-buffer (generate-new-buffer " get-hostname"))
       (hostname "unknown"))
  (unwind-protect
      (save-excursion
        (set-buffer jdz-hostname-buffer)
        (apply 'call-process
               (list "hostname" nil t nil))
        (skip-chars-backward "\n\t ")
        (setq hostname (buffer-substring (point-min) (point))))
    (kill-buffer jdz-hostname-buffer))
  (if (interactive-p)
      (insert hostname))
  hostname))
