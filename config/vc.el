
;-----------------------------------------------------------------------
; MAGIT
;
; Git in Emacs
;-----------------------------------------------------------------------
(autoload 'magit-status "magit" nil t)
;; (setq magit-status-buffer-switch-function 'switch-to-buffer)

(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")

;-----------------------------------------------------------------------
; GIT-GUTTER
;
; Display buffer vs git diffs in the gutter
;-----------------------------------------------------------------------
(require 'git-gutter)
(global-git-gutter-mode +1)
(set-face-foreground 'git-gutter:separator "black")
(global-set-key (kbd "M-n") 'git-gutter:next-hunk)
(global-set-key (kbd "M-p") 'git-gutter:previous-hunk)

;-----------------------------------------------------------------------
; P4
;
; P4 in emacs
;-----------------------------------------------------------------------
(require 'p4)
