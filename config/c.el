;; Make Emacs automatically hit return for you after left curly braces,
;; right curly braces, and semi-colons.

;; Make Emacs use "newline-and-indent" when you hit the Enter key so
;; that you don't need to keep using TAB to align yourself when coding.
;; This is akin to setting autoindent in vi.
(require 'cc-mode)
(require 'flycheck)
(require 'company)

;; In versions of Emacs greater than 23.2, do the following

;; Use the GDB visual debugging mode
(setq gdb-many-windows t)

;; ;; add semantic options
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)

;; ;; Class suggest improvement
;; ;;(defun my-c-mode-cedet-hook ()
;; ;;  (local-set-key "." 'semantic-complete-self-insert)
;; ;;  (local-set-key ">" 'semantic-complete-self-insert))
;; ;;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; ;; Turn Semantic on
;; (semantic-mode 1)
;; (require 'semantic/ia)
;; (require 'semantic/bovine/gcc)
;; (require 'gtags)

;; (global-set-key [(control ?\,)] 'pop-global-mark)
;; (global-set-key [(control ?\.)] 'semantic-ia-fast-jump)

;; (defun my-semantic-hook ()
;;   (semantic-add-system-include "/home/zeno/teclo/code/clibs" 'c-mode)
;;   (semantic-add-system-include "/home/zeno/teclo/code/clibs" 'c++-mode))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

;; ;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)

;; ;; if you want to enable support for gnu global
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;; ;; enable ctags for some languages:
;; ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; ;; (semantic-load-enable-primary-exuberent-ctags-support)


;; ;; Try to make completions when not typing
;; (global-semantic-idle-completions-mode 1)

;; ;; Use the Semantic speedbar additions
;; (add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb)))


;; ensure that we use only rtags checking
;; https://github.com/Andersbakken/rtags#optional-1
(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

;; only run this if rtags is installed
(require 'rtags)
;; make sure you have company-mode installed
(require 'company)
(define-key c-mode-base-map (kbd "M-.")
  (function rtags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,")
  (function rtags-find-references-at-point))
;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
;; (define-key prelude-mode-map (kbd "C-c r") nil)
;; install standard rtags keybindings. Do M-. on the symbol below to
;; jump to definition and see the keybindings.
(rtags-enable-standard-keybindings)
;; comment this out if you don't have or don't use helm
;; (setq rtags-use-helm t)
;; company completion setup
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(global-company-mode)
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
;; use rtags flycheck mode -- clang warnings shown inline
(require 'flycheck-rtags)
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c++-mode-hook #'setup-flycheck-rtags)

(add-hook 'after-init-hook #'global-flycheck-mode)

(global-set-key "\C-m" 'newline-and-indent)
(add-hook 'c-mode-hook 'turn-on-font-lock)


;; autofill in c
(add-hook 'c-mode-hook 'turn-on-auto-fill)

;; (add-hook 'c-mode-hook
;; 	  '(lambda () (local-set-key "\C-c\C-k" 'compile)
;;                       (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
;;                       (local-set-key (kbd "M-,") 'pop-global-mark)
;;                       (setq c-basic-offset 2)))

;; (add-hook 'c++-mode-hook
;; 	  '(lambda () (local-set-key "\C-ck" 'compile)
;;                       (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
;;                       (local-set-key (kbd "M-,") 'pop-global-mark)
;;                       (setq c-basic-offset 2)))


(define-key c++-mode-map "\C-c\C-k" 'compile)
(setq compilation-read-command nil)

(add-hook 'c-mode-common-hook
	  '(lambda () (c-toggle-auto-hungry-state 1)))

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(setq c-default-style "google")
(setq c-basic-offset 2)
(setq-default tab-width 2)

;; Return adds a newline and indents
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; To associate *.h files with c mode use the following line
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;;(setq tags-table-list
;;           '("~/hack/c" "/usr/src/linux"))
