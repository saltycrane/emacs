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

;;================================================
;; Remove ^M characters
;; http://stackoverflow.com/questions/730751/hiding-m-in-emacs
;;================================================
(defun remove-dos-eol ()
  "Removes the disturbing '^M' showing up in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))


;;================================================
;; Shift indentation left/right by 4 spaces
;; TODO: keep region highlighted
;;================================================
(defun shift-left-like-python (start end)
  (interactive "r")
  (indent-rigidly start end -4)
)
(defun shift-right-like-python (start end)
  (interactive "r")
  (indent-rigidly start end 4)
)
(global-set-key (kbd "C-,") 'shift-left-like-python)
(global-set-key (kbd "C-.") 'shift-right-like-python)

;;================================================
;; Custom rgrep
;; https://blog.mozilla.org/nfroyd/tag/emacs/
;;================================================
(defun character-prompt (alist description)
  (message "Select [%s]: "
           (apply #'string (mapcar #'car alist)))
  (let* ((ch (save-window-excursion
               (select-window (minibuffer-window))
               (read-char)))
         (x (find ch alist :key #'car)))
    (cond
     ((null x)
      (message (format "No %s for character: %s" description ch))
      (sleep-for 1)
      (discard-input)
      (character-prompt alist description))
     (t (cdr x)))))
(defvar froydnj-mozilla-srcdir
  ;; TODO: set this per project
  (expand-file-name "/opt"))
(defvar froydnj-mozilla-ignored-files
  (list
   "laskdjfhaslkdjfh.js"
   ))
(defvar froydnj-mozilla-ignored-directories
  (list
   "assets/gen"
   ;; "*linux-x86_64*"
   "lib.linux-x86_64-2.7"
   ))
(defvar froydnj-mozilla-files
  '((?a . "*")                    ; All of it
    ;; ;; TODO: curly braces notation doesn't work with find
    ;; (?c . "*.{css,html,js,py}*")      ; Code
    ;; (?f . "*.{css,html,js}*")         ; Frontend code
    (?h . "*.html")
    (?j . "*.js*")
    (?p . "*.py")
    ))
;; normal rgrep needs to be run first otherwise we get an error about grep-read-regexp
;; this should be fixed
(defun froydnj-mozilla-rgrep ()
  (interactive)
  (let ((regexp (grep-read-regexp))
        (files (character-prompt froydnj-mozilla-files "filename pattern"))
        (grep-find-ignored-files (append grep-find-ignored-files
                                         froydnj-mozilla-ignored-files))
        (grep-find-ignored-directories (append grep-find-ignored-directories
                                               froydnj-mozilla-ignored-directories)))
    (rgrep regexp files froydnj-mozilla-srcdir)))
(global-set-key "\C-\M-g" 'froydnj-mozilla-rgrep)

(defun froydnj-compilation-buffer-name (major-mode-name)
  (let ((cfg-regexp "\\([-0-9_.a-z/+]+\\.cfg\\)"))
    (cond
     ;; We're doing local compilation, stick the name of the release
     ;; configuration in the buffer name.
     ((or (string-match "^cd /scratch/froydnj/\\([^ ;]+\\)" command)
          (string-match "^build-config" command))
      (string-match cfg-regexp command)
      (concat "*compilation " (match-string 1 command) "*"))
     ;; We're doing remote compilation, note the machine name and
     ;; the release configuration name.
     ((string-match "^ssh \\([^ ]+\\)" command)
      (let ((machine (match-string 1 command)))
        (string-match cfg-regexp command)
        (concat "*compilation@" machine " " (match-string 1 command) "*")))
     ;; grep.el invokes compile, we might as well take advantage of that.
     ((string-equal major-mode-name "grep")
      (if (boundp 'regexp)
          (concat "*grep for " regexp "*")
        "*grep*"))
     ;; We have no idea, just use the default.
     (t
      "*compilation*"))))
(setq compilation-buffer-name-function 'froydnj-compilation-buffer-name)
