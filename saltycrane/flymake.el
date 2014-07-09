;; third-party flymake from https://github.com/illusori/emacs-flymake
;; added to support temp files in a temp directory
(add-to-list 'load-path (concat sc-vendor-dir "/emacs-flymake-0.4.16"))
(require 'flymake)
(setq flymake-run-in-place nil)
(setq temporary-file-directory "~/.emacs.d/tmp/")

;; set colors
;; http://www.emacswiki.org/emacs/FlymakeOcaml#toc11
(custom-set-faces
 '(flymake-errline ((((class color)) (:background "gray14"))))
 '(flymake-warnline ((((class color)) (:background "gray12"))))
 '(flymake-infoline ((((class color)) (:background "gray10"))))
)

;; turn on flymake for most files
(add-hook 'find-file-hook 'flymake-find-file-hook)

;;================================================
;; FLYMAKE (PYTHON) W/ PYFLAKES AND PEP8
;; http://stackoverflow.com/questions/1259873/how-can-i-use-emacs-flymake-mode-for-python-with-pyflakes-and-pylint-checking-cod
;;================================================
(when (load "flymake" t)

  (defun flymake-scss-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-copy))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list scss-sass-command (append scss-sass-options (list "--scss" "--check" local-file)))))

  (defun flymake-python-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-copy))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list (concat sc-emacs-dir "/bin/flymake-python") (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.scss\\'" flymake-scss-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-python-init))
  )

(load-library "flymake-cursor")

(global-set-key [f9] 'flymake-mode)
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

; disable flymake for some file types
; http://stackoverflow.com/questions/4095153/how-to-disable-emacs-flymake-for-html-mode
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(delete '("\\.xml\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(delete '("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup) flymake-allowed-file-name-masks)
