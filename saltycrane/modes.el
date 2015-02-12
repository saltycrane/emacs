;;================================================
;; YASNIPPET
;;================================================
(require 'yasnippet)
(yas-global-mode 1)
(yas/load-directory (concat sc-emacs-dir "/snippets"))
(setq yas/prompt-functions '(yas/ido-prompt))
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)  ; backtab == S-tab

;;================================================
;; AUTO COMPLETE MODE
;;================================================
(require 'auto-complete-config)
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
(add-to-list 'auto-mode-alist
     	     '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

;;================================================
;; APACHE MODE
;;================================================
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

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
;; PUPPET
;;================================================
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(setq puppet-indent-level 4)
(setq puppet-include-indent 4)

;;================================================
;; WEB-MODE
;; http://web-mode.org/
;;================================================
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
(define-key web-mode-map [S-mouse-3] 'web-mode-fold-or-unfold)

;;================================================
;; COFFEE-MODE
;;================================================
(require 'coffee-mode)
(custom-set-variables '(coffee-tab-width 2))

;;================================================
;; SMEX (M-x using ido-mode)
;;================================================
(require 'smex)
(smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)  ;; This is your old M-x.

;;================================================
;; MAGIT
;;================================================
(require 'magit)

;;================================================
;; TWITTERING-MODE
;;================================================
(require 'twittering-mode)

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
(require 'thrift)

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
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

;;================================================
;; SCSS-MODE
;;================================================
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)

;;================================================
;; MULTIPLE-CURSORS
;; https://github.com/magnars/multiple-cursors.el
;;================================================
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
   (define-key (current-local-map) (kbd "C-,") 'shift-left-like-python)
   (define-key (current-local-map) (kbd "C-.") 'shift-right-like-python)
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
;; https://github.com/Wilfred/ag.el
;;================================================
(require 'ag)
(setq ag-highlight-search t)

;;================================================
;; IDO / IDO-VERTICAL-MODE / FLX-IDO
;; https://github.com/emacsmirror/ido-vertical-mode
;; https://github.com/lewang/flx
;;================================================
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-default-buffer-method 'samewindow)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;; (require 'flx-ido)
;; (flx-ido-mode 1)
;; ;; disable ido faces to see flx highlights.
;; (setq ido-use-faces nil)

;;================================================
;; PROJECTILE
;; https://github.com/bbatsov/projectile
;;================================================
(require 'projectile)
(projectile-global-mode)

;;================================================
;; FLYCHECK (flymake alternative)
;; http://www.flycheck.org/en/latest/
;;================================================
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key [f9] 'flycheck-mode)
(global-set-key [f10] 'flycheck-prev-error)
(global-set-key [f11] 'flycheck-next-error)
