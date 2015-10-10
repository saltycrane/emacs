;; windows-like bindings
;; (global-set-key "\C-f" 'isearch-forward)
;; (define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
;; (global-set-key "\C-s" 'save-buffer)
(global-set-key "\M-g" 'goto-line)
;; (global-set-key (kbd "C-c q") 'delete-frame)  ;; C-x C-c
;; (global-set-key (kbd "C-c w") 'kill-this-buffer)  ;; C-x k
(global-set-key (kbd "C-c n") 'make-frame)

;; ;; movement key bindings (use h-j-k-l for movement like vi)
;; (global-set-key "\C-l" 'forward-char)
;; (global-set-key "\C-h" 'backward-char)
;; (global-set-key "\C-j" 'next-line)
;; (global-set-key "\C-k" 'previous-line)
;; (global-set-key "\M-l" 'forward-word)
;; (global-set-key "\M-h" 'backward-word)
(global-set-key "\M-n" 'scroll-up)
(global-set-key "\M-p" 'scroll-down)

;; ;; rebind displaced movement key bindings
;; (global-set-key "\C-p" 'kill-line)
;; (global-set-key "\M-v" 'downcase-word)
;; (global-set-key "\M-b" 'recenter-top-bottom)

;; per Steve Yegge's suggestion
(global-set-key "\C-x\C-n" 'execute-extended-command)
(global-set-key "\C-c\C-n" 'execute-extended-command)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; ;; for c/c++ devel
;; (global-set-key [f5] 'gdb)
;; (global-set-key [f6] 'gud-next)
(global-set-key [f7] 'previous-error)
(global-set-key [f8] 'next-error)
;; (global-set-key [f9] 'compile) ;; needed the keybinding
(global-set-key [f12] 'linum-mode)

;; buffer switching and listing
;; (global-set-key "\C-b" 'switch-to-buffer)
;; (global-set-key "\C-x\C-b" 'bs-show)

;; (global-set-key "\M-/" 'hippie-expand)
(global-set-key "\M-/" 'dabbrev-expand)

(global-set-key [C-f5] 'revert-buffer)
(key-chord-define-global "r5" 'revert-buffer)

;; https://github.com/magnars/.emacs.d/blob/master/settings/sane-defaults.el
;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top
;; A saner ediff
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; ;; Keep cursor away from edges when scrolling up/down
;; (require 'smooth-scrolling)
