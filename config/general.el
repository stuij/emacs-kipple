;; general setup oneliners
(setq whitespace-style '(face trailing lines))
(setq whitespace-line-column 80)
(setq-default fill-column 80)

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))

;; scrolling
(setq scroll-step 1)
(setq scroll-conservatively 5)



;; self contained libs

;; ido
(require 'ido)
(ido-mode t)
(setq browse-kill-ring-highlight-inserted-item t)

;; moving to window by arrow key
(require 'windmove)
(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)


;; dubious fns once handy
(defun replace-garbabe (bla)
  (interactive "P")
  (goto-char (point-min))
  (while (search-forward "\200" nil t)
    (replace-match "")))

;; (global-set-key  [f1] (lambda ()
;;                        (interactive)
;;                        (manual-entry (current-word))))
