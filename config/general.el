;;------------------general setup oneliners------------------

;; (setq default-major-mode 'text-mode)

(load "hungry")
(load "keywiz")

(global-set-key "\C-cr" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

;;(global-set-key [f11] 'imenu)

(setq suggest-key-bindings t)           ; turn on builtin pre-command hints
;;(load "suggbind")

;;; It is always better to know current line and column number
(column-number-mode t)
(line-number-mode t)

;;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

(setq whitespace-style '(face trailing lines))
(setq whitespace-line-column 80)
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(require 'whitespace)


(global-hl-line-mode 1)
(set-face-background 'hl-line "gray13")

(global-set-key "\C-\\" 'undo)

;; autopair
(require 'autopair)
(setf autopair-blink nil)
(autopair-global-mode)

;; scrolling
(setq scroll-step 1
      scroll-conservatively 5
      scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

;; (setq printer-name "ipp://192.168.0.144")

(load "password")
(setq password-cache-expiry 3600)

;; ------------- copy pasting ----------------------
;;use the windows-kind clipboard for copy/past in stead of the middle-mouse-button way
(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;; ========== Place Backup Files in Specific Directory ==========

;; Enable backup files.
(setq make-backup-files t)

;; Saved my life more than once
(setq version-control t)
(setq kept-new-versions 7)
(setq delete-old-versions t)

;; Save all backup file in this directory.
(setq backup-directory-alist `(("." . ,(concat *emacs-base* "backups"))))


;; ------------- buffer switchers -------------

;;(when (require 'bubble-buffer nil t)
;;  (global-set-key [f2] 'bubble-buffer-next)
;;  (global-set-key [(shift f2)] 'bubble-buffer-previous))
;;(setq bubble-buffer-omit-regexp "\\(^ .+$\\|\\*Messages\\*\\|*Compile-Log\\*\\|*inferior-lisp\\*\\|*Completions\\*\\|*slime-events\\*\\)")

(require 'swbuff)
(setq swbuff-exclude-buffer-regexps
      ;;'("\\(^ .+$\\|\\*Messages\\*\\|*Compile-Log\\*\\|*inferior-lisp\\*\\|*Completions\\*\\|*slime-events\\*\\)")
      '("^ .*" "^\\*.*\\*"))

;; Make control+pageup/down scroll the other buffer
(global-set-key [C-next] 'scroll-other-window)
(global-set-key [C-prior] 'scroll-other-window-down)

;;--------------
;; moving to window by arrow key
;;--------------
(require 'windmove)
(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)


;;--------------
;; small self contained libs
;;--------------
;; recentf
;;--------------
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(recentf-mode 1)
(global-set-key [f4] 'recentf-open-files)
(setq recentf-max-saved-items 40)
(setq recentf-max-menu-items 40)
;;--------------
;; color theme
;;--------------
(load "color-theme-library")
(load "calm-charcoal")


;;--------------
;; ido
;;--------------
(require 'ido)
(ido-mode t)
(setq browse-kill-ring-highlight-inserted-item t)
;;--------------
;; dubious fns once handy
;;--------------
(defun replace-garbabe (bla)
  (interactive "P")
  (goto-char (point-min))
  (while (search-forward "\200" nil t)
    (replace-match "")))

;; (global-set-key  [f1] (lambda ()
;;                        (interactive)
;;                        (manual-entry (current-word))))

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))

;; compile from subdirectory
(setq compilation-filenames '("Makefile" "makefile"))

(defun get-nearest-compilation-file ()
  "Search for the compilation file traversing up the directory tree."
  (let ((dir default-directory)
        (parent-dir (file-name-directory (directory-file-name default-directory)))
        (nearest-compilation-file 'nil))
    (while (and (not (string= dir parent-dir))
                (not nearest-compilation-file))
      (dolist (filename compilation-filenames)
        (setq file-path (concat dir filename))
        (when (file-readable-p file-path)
          (setq nearest-compilation-file file-path)))
      (setq dir parent-dir
            parent-dir (file-name-directory (directory-file-name parent-dir))))
    nearest-compilation-file))

;; bind compiling with get-above-makefile to f5
(global-set-key [f5] (lambda ()
                       (interactive)
                       (compile (format
                                 "make -f %s" (get-nearest-compilation-file)))))
