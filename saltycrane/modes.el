;;================================================
;; YASNIPPET
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/yasnippet-0.6.1c"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat emacs-dir "/snippets"))
(setq yas/prompt-functions '(yas/ido-prompt))

;;================================================
;; AUTO COMPLETE MODE
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/auto-complete-1.2"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat sc-vendor-dir "/auto-complete-1.2/dict"))
(ac-config-default)
(setq ac-use-fuzzy t)
(setq ac-fuzzy-cursor-color "orange")
(setq ac-sources '(ac-source-filename
                   ac-source-functions
                   ac-source-yasnippet
                   ac-source-variables
                   ac-source-symbols
                   ac-source-features
                   ac-source-abbrev
                   ac-source-words-in-same-mode-buffers
                   ac-source-dictionary
                   ac-source-ropemacs
                   ))

;;================================================
;; MARKDOWN MODE
;;================================================
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;;================================================
;; YAML MODE
;;================================================
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-j" 'next-line)))

;;================================================
;; ESPRESSO MODE
;;================================================
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;;================================================
;; PHP MODE
;;================================================
(autoload 'php-mode "php-mode-1.5.0")
(add-to-list 'auto-mode-alist
     	     '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

;;================================================
;; APACHE MODE
;;================================================
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;;================================================
;; IDO MODE
;;================================================
(ido-mode t)
(setq ido-enable-flex-matching t)

;;================================================
;; TRAMP
;;================================================
(require 'tramp)
(setq tramp-verbose 6)
(setq tramp-default-method "ssh")
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))

;;================================================
;; VARNISH VCL-MODE
;;================================================
(require 'vcl-mode)

;;================================================
;; G++ / MAKE / GDB / C++ stuff
;;================================================
(setq gdb-many-windows t)  ;; allow debugger to show many windows
(setq compilation-window-height 18)
(setq compilation-finish-function
      (lambda (buf str)

        (if (string-match "exited abnormally" str)

            ;;there were errors
            (message "compilation errors, press C-x ` to visit")

          ;;no errors, make the compilation window go away in 0.5 seconds
          (run-at-time 1.1 nil 'delete-windows-on buf)
          (message "No compilation errors."))))

;;================================================
;; ORG MODE SETTINGS
;;================================================
'(org-disputed-keys
  (quote (([(shift up)] . [(meta p)])
          ([(shift down)] . [(meta n)])
          ([(shift left)] . [(meta -)])
          ([(shift right)] . [(meta +)])
          ([(control shift right)] . [(meta shift +)])
          ([(control shift left)] . [(meta shift -)])
          ;; ([(control j)] . [(control shift j)])
          ;; ([(control k)] . [(control shift k)])
          )))
'(org-replace-disputed-keys t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "C-c c") 'org-insert-todo-heading)
(setq org-agenda-custom-commands
      '(("x" tags-tree "-done")
        ("d" tags-tree "done")
        )
      )
(setq org-use-speed-commands t)
(setq org-startup-indented t)
(setq org-agenda-files
      (quote ("~/Documents/notes"))
      )

;;================================================
;; CUA MODE
;;================================================
(cua-mode t)
(setq cua-keep-region-after-copy t)

;;================================================
;; REDO MODE
;;================================================
(require 'redo)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-y" 'redo)
