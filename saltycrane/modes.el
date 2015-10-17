;;================================================
;; KEY-CHORD
;; http://www.emacswiki.org/emacs/key-chord.el
;;================================================
(require 'key-chord)
(key-chord-mode 1)
;; (key-chord-define-global "lr" 'revert-buffer)

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
;; COMPANY-MODE
;; http://company-mode.github.io/
;;================================================
(add-hook 'after-init-hook 'global-company-mode)

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
;; (add-hook 'yaml-mode-hook
;;           '(lambda ()
;;              (define-key yaml-mode-map "\C-j" 'next-line)))

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
;; (add-hook 'org-mode-hook
;;           '(lambda ()
;;              (define-key org-mode-map "\C-j" nil)
;;              (define-key org-mode-map "\C-k" nil)
;;              (define-key org-mode-map "\C-p" 'org-kill-line)
;;              ))
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

;; ;;================================================
;; ;; CUA MODE
;; ;;================================================
;; (cua-mode t)
;; (setq cua-keep-region-after-copy t)

;;================================================
;; PUPPET
;;================================================
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(setq puppet-indent-level 4)
(setq puppet-include-indent 4)

;;================================================
;; JSON-MODE
;;================================================
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;;================================================
;; JS2-MODE
;; JS2-REFACTOR-MODE
;;================================================
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-highlight-level 3)
(setq js2-basic-offset 4)
(setq js2-mode-show-strict-warnings nil)
;; (add-hook 'js2-mode-hook
;;           '(lambda ()
;;              (define-key js2-mode-map "\M-j" 'scroll-up)
;;              ))
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;;================================================
;; WEB-MODE
;; http://web-mode.org/
;;================================================
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("www\\.saltycrane\\.com" . web-mode))
(setq web-mode-engines-alist '
      (("django" . "\\.html\\'")
       ))
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-comment-style 2)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

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
(define-key web-mode-map (kbd "C-'") 'web-mode-mark-and-expand)

;; JSX (ReactJS)
;; http://truongtx.me/2014/03/10/emacs-setup-jsx-mode-and-jsx-syntax-checking/
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; http://cha1tanya.com/2015/06/20/configuring-web-mode-with-jsx.html
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;;================================================
;; COFFEE-MODE
;;================================================
(require 'coffee-mode)
(custom-set-variables '(coffee-tab-width 4))

;;================================================
;; MAGIT
;; https://github.com/magit/magit
;; https://github.com/jtatarik/magit-gitflow
;;================================================
(require 'magit)
(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
(key-chord-define-global "m," 'magit-status)

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
   (define-key (current-local-map) (kbd "M-f") 'forward-word)
   (define-key (current-local-map) (kbd "M-b") 'backward-word)
   (define-key (current-local-map) (kbd "M-n") 'scroll-up)
   (define-key (current-local-map) (kbd "M-p") 'scroll-down)
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
;; (helm-adaptative-mode t)
(helm-autoresize-mode t)

;; key bindings recommended by tuhdo
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "<backtab>")  'helm-select-action) ; list actions using Shift+Tab

;; ;; key bindings because I use j/k for down/up
;; (define-key helm-map (kbd "C-j")  'helm-next-line)
;; (define-key helm-map (kbd "C-k")  'helm-previous-line)
;; (define-key helm-map (kbd "M-j")  'helm-next-page)
;; (define-key helm-map (kbd "M-k")  'helm-previous-page)

;; set fuzzy match options
(setq helm-M-x-fuzzy-match t)
(setq helm-buffers-fuzzy-matching nil)
(setq helm-recentf-fuzzy-match t)

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
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;================================================
;; PROJECTILE
;; https://github.com/bbatsov/projectile
;;================================================
(require 'projectile)
(projectile-global-mode)
(setq projectile-mode-line '(:eval (format " Pr")))

;; helm + projectile
;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)
;; (global-set-key (kbd "C-b") 'helm-projectile)

;; from http://tuhdo.github.io/helm-projectile.html
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'helm-projectile)

;;================================================
;; PERSPECTIVE + PROJECTILE
;; https://github.com/nex3/perspective-el
;;================================================
(persp-mode)
(require 'persp-projectile)
;; (define-key projectile-mode-map (kbd "C-x C-b") 'projectile-persp-switch-project)
(key-chord-define-global "p[" 'projectile-persp-switch-project)

;;================================================
;; SILVER SEARCHER (AG)
;; https://github.com/Wilfred/ag.el
;;================================================
(require 'ag)
(setq ag-highlight-search t)
(global-set-key (kbd "C-;") 'ag-project)

;; helm + ag
;; (setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
;; (setq helm-ag-command-option "--all-text")
;; (setq helm-ag-insert-at-point 'symbol)
(defun projectile-helm-ag ()
  (interactive)
  (helm-ag (projectile-project-root)))

;;================================================
;; FLYCHECK (flymake alternative)
;; http://www.flycheck.org/en/latest/
;;================================================
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key [f9] 'flycheck-mode)
(global-set-key [f10] 'flycheck-prev-error)
(global-set-key [f11] 'flycheck-next-error)

;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;;================================================
;; ROBOT-MODE (for the Robot test framework)
;; https://github.com/sakari/robot-mode
;;================================================
(load-file (concat sc-vendor-dir "/robot-mode-a58d660/robot-mode.el"))
(add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))
(add-hook 'robot-mode-hook
          '(lambda ()
             (setq c-basic-offset 4)
             ))

;;================================================
;; ACE-JUMP-MODE
;; https://github.com/winterTTr/ace-jump-mode
;;================================================
;; ace jump mode major function
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;================================================
;; HELM-SWOOP
;; https://github.com/ShingoFukuyama/helm-swoop
;;================================================
(require 'helm-swoop)

;;================================================
;; EXPAND-REGION
;; https://github.com/magnars/expand-region.el
;;================================================
(require 'expand-region)
(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "C-\"") 'er/contract-region)

;;================================================
;; DIMINISH
;; https://www.eskimo.com/~seldon/diminish.el
;;================================================
(require 'diminish)
(diminish 'helm-mode "He")
;;(diminish 'ropemacs-mode "Ro")
(diminish 'magit-auto-revert-mode "MR")
(diminish 'yas-minor-mode "ya")
;;(diminish 'company-mode "co")
