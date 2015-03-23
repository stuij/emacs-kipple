
;; need to enable lib
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(recentf-mode 1)
(global-set-key [f5] 'recentf-open-files)
(setq recentf-max-saved-items 40)
(setq recentf-max-menu-items 40)

(require 'ido)
(ido-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;;; prior art

;;(global-set-key [f11] 'imenu)

;;(load "suggbind")

;;(load "redo")
;;(global-set-key "\C-\\" 'redo)
