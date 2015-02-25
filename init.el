;; set stuff based on operating system
(cond
 ((eq system-type 'windows-nt)
  (setq sc-os "windows")
  )
 ((eq system-type 'cygwin)
  (setq sc-os "cygwin")
  )
 ((eq system-type 'gnu/linux)
  (setq sc-os "linux")
  (setq sc-emacs-dir "~/.emacs.d")
  (setq sc-vendor-dir "~/.emacs.d/vendor")
  )
 )
(print sc-os)

;; set load-path
(add-to-list 'load-path sc-emacs-dir)
(add-to-list 'load-path sc-vendor-dir)

;; Configure MELPA packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; load other stuff
(load "saltycrane/defuns")
(sc-ensure-packages-compiled)
(load "saltycrane/customizations")
(load "saltycrane/bindings")
(load "saltycrane/appearance")
(load "saltycrane/scrolling")
(load "saltycrane/modes")
(load "saltycrane/python")

;; load os-specific stuff
(setq sc-os-config (concat sc-emacs-dir "/saltycrane/os/" sc-os ".el"))
(when (file-exists-p sc-os-config)
  (load sc-os-config))

;; load host-specific stuff
(setq sc-hostname (jdz-get-hostname))
(print sc-hostname)
(setq sc-host-config (concat sc-emacs-dir "/saltycrane/host/" sc-hostname ".el"))
(print sc-host-config)
(when (file-exists-p sc-host-config)
  (load sc-host-config))

;; load private stuff
(setq sc-private-config "~/.emacs.prv")
(when (file-exists-p sc-private-config)
  (load sc-private-config))

(put 'ido-exit-minibuffer 'disabled nil)
