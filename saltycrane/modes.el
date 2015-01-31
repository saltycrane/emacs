;;================================================
;; YASNIPPET
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/yasnippet-0.8.0"))
(require 'yasnippet)
(yas-global-mode 1)
(yas/load-directory (concat sc-emacs-dir "/snippets"))
(setq yas/prompt-functions '(yas/ido-prompt))
;; if we use setq, the default "TAB" key will not be unbound.
(custom-set-variables '(yas/trigger-key "<backtab>"))  ; backtab == S-tab

;;================================================
;; AUTO COMPLETE MODE
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/auto-complete-1.3.1"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat sc-vendor-dir "/auto-complete-1.3.1/dict"))
(ac-config-default)
(setq ac-sources '(ac-source-filename
                   ;; ac-source-functions
                   ;; ac-source-yasnippet
                   ;; ac-source-variables
                   ;; ac-source-symbols
                   ;; ac-source-features
                   ;; ac-source-abbrev
                   ;; ac-source-words-in-same-mode-buffers
                   ;; ac-source-dictionary
                   ;; ac-source-ropemacs
                   ;; ac-source-mysource1
                   ;; ac-source-rope
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
;; JS-MODE (formerly espresso-mode)
;; included with Emacs >= 23.2
;;================================================
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

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
(setq ido-default-buffer-method 'samewindow)

;;================================================
;; TRAMP
;;================================================
(require 'tramp)
(setq tramp-verbose 6)
(setq tramp-default-method "ssh")
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

;;================================================
;; VARNISH VCL-MODE
;;================================================
(require 'vcl-mode)

;;================================================
;; G++ / MAKE / GDB / C++ stuff
;;================================================
(setq gdb-many-windows t)  ;; allow debugger to show many windows
(setq compilation-window-height 18)
;; comment out because this affects rgrep also
;; (setq compilation-finish-function
;;       (lambda (buf str)
;;         (if (string-match "exited abnormally" str)
;;             ;;there were errors
;;             (message "compilation errors, press C-x ` to visit")
;;           ;;no errors, make the compilation window go away in 0.5 seconds
;;           (run-at-time 1.1 nil 'delete-windows-on buf)
;;           (message "No compilation errors."))))

;;================================================
;; ORG MODE SETTINGS
;;================================================
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map "\C-j" nil)
             (define-key org-mode-map "\C-k" nil)
             (define-key org-mode-map "\C-p" 'org-kill-line)
             ))
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
;; JABBER
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/emacs-jabber-0.8.0/share/emacs/site-lisp"))
(require 'jabber-autoloads)
(require 'jabber-wmii)
(setq jabber-alert-info-message-hooks (quote (jabber-info-display jabber-info-echo jabber-info-wmii)))
(setq jabber-alert-message-hooks (quote (jabber-message-scroll jabber-message-echo jabber-message-wmii)))
(setq jabber-alert-muc-hooks (quote (jabber-muc-scroll jabber-muc-echo jabber-muc-wmii)))
(setq jabber-alert-presence-hooks nil)
(setq jabber-auto-reconnect t)
(setq jabber-autoaway-method (quote jabber-xprintidle-get-idle-time))
(setq jabber-autoaway-status "Away")
(setq jabber-autoaway-timeout 5)
(setq jabber-backlog-days nil)
(setq jabber-backlog-number 1000)
(setq jabber-chat-buffer-show-avatar nil)
(setq jabber-history-enable-rotation t)
(setq jabber-history-enabled t)
(setq jabber-use-global-history nil)
(setq jabber-history-size-limit 102400)
(setq jabber-keepalive-interval 300)
(setq jabber-mode-line-mode t)
(setq jabber-post-connect-hooks (quote (jabber-send-current-presence jabber-muc-autojoin jabber-whitespace-ping-start jabber-vcard-avatars-find-current jabber-autoaway-start)))
(setq jabber-roster-line-format " %c %-25n %u %-8s  %S")

;;================================================
;; PUPPET
;;================================================
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(setq puppet-indent-level 4)
(setq puppet-include-indent 4)

;;================================================
;; WEB-MODE
;; http://web-mode.org/
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/web-mode-a3562c0889"))
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-engines-alist '
      (("django" . "\\.html\\'")
       ))
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-comment-style 2)

;; Change M-; to use {# ... #}
(defun sc-jinja-comment-dwim (arg)
  (interactive "*P")
  (require 'newcomment)
  (let ((comment-start "{#")
        (comment-end "#}")
        (comment-start-skip "{# *"))
    (comment-dwim arg)
    ))
(define-key web-mode-map (kbd "M-;") 'sc-jinja-comment-dwim)
(define-key web-mode-map (kbd "C-c /") 'web-mode-element-close)

;;================================================
;; COFFEE-MODE
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/coffee-mode-0.5.5"))
(require 'coffee-mode)
(custom-set-variables '(coffee-tab-width 2))

;; ;;================================================
;; ;; DJANGO/JINJA2 TEMPLATES
;; ;; wget http://ourcomments.org/Emacs/DL/elisp/nxhtml/zip/nxhtml-2.08-100425.zip
;; ;;================================================
;; (load (concat sc-vendor-dir "/nxhtml-835/autostart.el"))
;; ;; Workaround the annoying warnings:
;; ;; Warning (mumamo-per-buffer-local-vars):
;; ;; Already 'permanent-local t: buffer-file-name
;; ;; https://gist.github.com/tkf/3951163
;; (when (and (= emacs-major-version 24)
;;            (>= emacs-minor-version 2))
;;   (eval-after-load "mumamo"
;;     '(setq mumamo-per-buffer-local-vars
;;            (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; (setq mumamo-background-colors nil)
;; (add-to-list 'auto-mode-alist '("\\.html$" . django-nxhtml-mumamo-mode))
;; (add-to-list 'auto-mode-alist '("\\.rml$" . django-nxhtml-mumamo-mode))
;; (setq nxml-child-indent 4)  ;; work convention is 4 spaces for HTML, etc
;; (setq django-indent-width 4)
;; (setq sgml-basic-offset 4)
;; (setq mumamo-submode-indent-offset 4)
;; ;; Change M-; to use {# ... #}
;; ;; Thanks to https://github.com/jonathanchu/emacs/blob/master/jontourage/django_html.el
;; (add-hook
;;  'django-nxhtml-mumamo-mode-hook
;;  (lambda ()
;;    (define-key django-nxhtml-mumamo-mode-map [remap comment-dwim]
;;      'django-nxhtml-mumamo-comment-dwim)
;;    ))
;; (defun django-nxhtml-mumamo-comment-dwim (arg)
;;   (interactive "*P")
;;   (require 'newcomment)
;;   (let ((comment-start "{#")
;;         (comment-end "#}")
;;         (comment-start-skip "{# *"))
;;     (comment-dwim arg)))
;; ;; Restore my custom keybindings
;; (add-hook
;;  'nxml-mode-hook
;;  (lambda ()
;;    (define-key (current-local-map) (kbd "M-h") 'backward-word)
;;    )
;;  )

;; ;;================================================
;; ;; JINJA2
;; ;;================================================
;; (autoload 'jinja2-mode "jinja2-mode-b3e564bfef" nil t)
;; (add-to-list 'auto-mode-alist '("\\.html$" . jinja2-mode))

;;================================================
;; SMEX (M-x using ido-mode)
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/nonsequitur-smex-1.1.1"))
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)  ;; This is your old M-x.

;;================================================
;; MAGIT
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/magit-0.8.2/share/emacs/site-lisp"))
(require 'magit)

;;================================================
;; TWITTERING-MODE
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/twittering-mode-1.0.0"))
(require 'twittering-mode)

;;================================================
;; ACTIONSCRIPT-MODE
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/actionscript-mode"))
(require 'actionscript-mode)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

;;================================================
;; EasyPG
;;================================================
(setq epg-gpg-program "/usr/bin/gpg")

;;================================================
;; RE-BUILDER
;;================================================
(require 're-builder)
(setq reb-re-syntax 'string)

;;================================================
;; THRIFT-MODE
;;================================================
(require 'thrift-mode)

;;================================================
;; DIFF-MODE
;;================================================
(custom-set-faces
 '(diff-added ((t (:foreground "Green"))) 'now)
 '(diff-removed ((t (:foreground "Red"))) 'now)
 )
(setq special-display-buffer-names
      (cons '("*rope-preview*" (background-color . "LightSteelBlue"))
            special-display-buffer-names))

;;================================================
;; RPM-SPEC-MODE
;;================================================
(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(setq auto-mode-alist (append '(("\\.spec" . rpm-spec-mode))
                              auto-mode-alist))

;;================================================
;; SALTYCRANE.COM POSTS
;;================================================
(add-to-list 'auto-mode-alist '("www\\.saltycrane\\.com\\." . html-mode))

;;================================================
;; ANSI-TERM
;;================================================
(setq term-default-bg-color "#000000")
(setq term-default-fg-color "#FFFFFF")
(setq term-buffer-maximum-size 50000)

;;================================================
;; COLOR-THEME
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/color-theme-6.6.0"))
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

;;================================================
;; SCSS-MODE
;;================================================
(autoload 'scss-mode "scss-mode-2d25dec870")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)

;;================================================
;; MULTIPLE-CURSORS
;; https://github.com/magnars/multiple-cursors.el
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/multiple-cursors.el-1.2.1"))
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)

;;================================================
;; GIT-COMMIT-MODE (copied from Brandon Rhodes)
;; https://github.com/brandon-rhodes/dot-emacs/blob/a441d4019672128ec33e7924abb4ebafc4053d52/init.el#L178
;;================================================
(define-derived-mode git-commit-mode diff-mode
  (setq mode-name "Git-Commit")
  (auto-fill-mode)
  (flyspell-mode))
;; Restore keybindings that are different in diff-mode
(add-hook
 'git-commit-mode-hook
 (lambda ()
   (define-key (current-local-map) (kbd "M-q") 'fill-paragraph)
   (define-key (current-local-map) (kbd "M-l") 'forward-word)
   (define-key (current-local-map) (kbd "M-h") 'backward-word)
   (define-key (current-local-map) (kbd "M-j") 'scroll-up)
   (define-key (current-local-map) (kbd "M-k") 'scroll-down)
   (define-key (current-local-map) (kbd "M-DEL") 'backward-kill-word)
   (define-key (current-local-map) (kbd "M-/") 'dabbrev-expand)
   )
 )
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . git-commit-mode))

;;================================================
;; ELECTRIC-PAIR-MODE
;;================================================
(electric-pair-mode)

;;================================================
;; WINNER-MODE
;; `C-c left' (`winner-undo') undo the last window configuration change
;; `C-c right' (`winner-redo') redo the changes you had undone
;;================================================
(winner-mode)

;; ================================================
;; SUBWORD MODE
;; http://emacsredux.com/blog/2013/04/21/camelcase-aware-editing/
;; ================================================
(add-hook 'prog-mode-hook 'subword-mode)
;; prog-mode-hook doesn't cover django-html-mumamo-mode for some reason
(add-hook 'html-mode-hook 'subword-mode)

;; ================================================
;; HIDE SHOW MODE (CODE FOLDING)
;; http://stackoverflow.com/questions/12763566/permanently-enabling-the-hs-minor-mode-in-emacs
;; ================================================
(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'nxml-mode-hook #'hs-minor-mode)
(global-set-key [S-mouse-3] 'hs-mouse-toggle-hiding)

;;================================================
;; HELM
;; https://github.com/emacs-helm/helm
;; http://tuhdo.github.io/helm-intro.html
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/helm-1.6.6"))
(add-to-list 'load-path (concat sc-vendor-dir "/emacs-async-1.2"))
(require 'helm)
(require 'helm-config)
(helm-mode t)
(helm-adaptative-mode t)
(helm-autoresize-mode t)

;; key bindings recommended by tuhdo
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "<backtab>")  'helm-select-action) ; list actions using Shift+Tab

;; key bindings because I use j/k for down/up
(define-key helm-map (kbd "C-j")  'helm-next-line)
(define-key helm-map (kbd "C-k")  'helm-previous-line)
(define-key helm-map (kbd "M-j")  'helm-next-page)
(define-key helm-map (kbd "M-k")  'helm-previous-page)

;; set fuzzy match options
(setq helm-M-x-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;; custom colors to go with color-theme-midnight (dark theme)
(custom-set-faces
 '(helm-selection ((((class color)) (:background "#441100"))))
 '(helm-bookmark-directory ((((class color)) (:foreground "SteelBlue"))))
 '(helm-buffer-directory ((((class color)) (:foreground "SteelBlue"))))
 '(helm-ff-directory ((((class color)) (:foreground "SteelBlue"))))
 '(helm-source-header ((((class color)) (:foreground "white" :weight bold :height 1.1 :family "Sans Serif"))))
)

;; bind helm commands
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-mini)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

;;================================================
;; SILVER SEARCHER (AG)
;; https://github.com/Wilfred/ag.el/tree/0.45
;;================================================
(add-to-list 'load-path (concat sc-vendor-dir "/dash.el-2.10.0"))
(add-to-list 'load-path (concat sc-vendor-dir "/s.el-1.9.0"))
(add-to-list 'load-path (concat sc-vendor-dir "/ag.el-0.45"))
(require 'ag)
