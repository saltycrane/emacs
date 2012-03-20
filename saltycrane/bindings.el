;; windows-like bindings
(global-set-key "\C-f" 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key "\C-s" 'save-buffer)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-c q") 'delete-frame)
(global-set-key (kbd "C-c w") 'kill-this-buffer)
(global-set-key (kbd "C-c n") 'make-frame)

;; movement key bindings (use h-j-k-l for movement like vi)
(global-set-key "\C-l" 'forward-char)
(global-set-key "\C-h" 'backward-char)
(global-set-key "\C-j" 'next-line)
(global-set-key "\C-k" 'previous-line)
(global-set-key "\M-l" 'forward-word)
(global-set-key "\M-h" 'backward-word)
(global-set-key "\M-j" 'scroll-up)
(global-set-key "\M-k" 'scroll-down)

;; rebind displaced movement key bindings
(global-set-key "\C-p" 'kill-line)
(global-set-key "\M-v" 'downcase-word)
(global-set-key "\M-b" 'recenter)

;; per Steve Yegge's suggestion
(global-set-key "\C-x\C-n" 'execute-extended-command)
(global-set-key "\C-c\C-n" 'execute-extended-command)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; for c/c++ devel
(global-set-key [f5] 'gdb)
(global-set-key [f6] 'gud-next)
(global-set-key [f7] 'gud-step)
(global-set-key [f8] 'gud-cont)
;; (global-set-key [f9] 'compile) ;; needed the keybinding
(global-set-key [f12] 'linum-mode)

;; buffer switching and listing
(global-set-key "\C-b" 'switch-to-buffer)
(global-set-key "\C-x\C-b" 'bs-show)

(global-set-key "\M-/" 'hippie-expand)
