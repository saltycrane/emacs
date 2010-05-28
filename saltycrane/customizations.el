(server-start)                         ; server mode
(setq inhibit-startup-message t)       ; don't show the startup message
(setq tool-bar-mode nil)               ; don't show the tool bar
(setq menu-bar-mode nil)               ; don't show the menu bar
(setq default-truncate-lines t)        ; don't word wrap
(setq column-number-mode t)            ; show column number in mode line
(setq transient-mark-mode t)           ; not sure
(setq default-tab-width 4)
(setq dabbrev-case-replace nil)        ; make sure case is preserved when expanding
(setq mark-holidays-in-calendar t)
(setq c-default-style '((c-mode . "bsd"))) ; cc mode
(setq c-basic-offset 3)
(setq frame-title-format '("%b: %f"))
(setq set-mark-command-repeat-pop t) ; move in mark ring with C-u C-space repeatedly
(put 'upcase-region 'disabled nil) ; allow use of upcase-region
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; from http://geosoft.no/development/emacs.html
(setq search-highlight           t) ; Highlight search object
(setq query-replace-highlight    t) ; Highlight query object
(setq mouse-sel-retain-highlight t) ; Keep mouse high-lightening

;; whitespace
(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq-default show-trailing-whitespace t)
(setq-default default-indicate-empty-lines t)

;; uniquify
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
