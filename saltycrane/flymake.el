;;================================================
;; FLYMAKE (PYTHON) W/ PYFLAKES AND PEP8
;; http://stackoverflow.com/questions/1259873/how-can-i-use-emacs-flymake-mode-for-python-with-pyflakes-and-pylint-checking-cod
;;================================================
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")
(global-set-key [f9] 'flymake-mode)
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

;;================================================
;; FLYMAKE (HTML)
;; http://www.emacswiki.org/emacs/FlyMake#toc8
;; sudo apt-get install tidy
;;================================================
(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "tidy" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.html$\\|\\.ctp" flymake-html-init))
(add-to-list 'flymake-err-line-patterns
             '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
               nil 1 2 4))
