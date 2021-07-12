(add-hook 'emacs-lisp-mode-hook
          (lambda () (whitespace-mode 1)))

(add-hook 'lisp-mode-hook
          (lambda () (whitespace-mode 1)))


(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))

(load "paredit")

;;; SLIME ;;;

;;(require  'slime)
;; (setq slime-net-coding-system 'utf-8-unix)

(add-hook 'slime-repl-mode-hook
          #'(lambda ()
              (autopair-mode -1)))

(setq slime-lisp-implementations
      `(;;(alisp ("alisp"))
        (sbcl ("sbcl"))
        (teclo ("/home/zeno/teclo/scripts/teclo" "sbcl"))))

(setq slime-default-implementation 'slime-alisp)


;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

(require 'slime-autoloads)

(slime-setup '(slime-fancy slime-banner slime-asdf slime-tramp slime-sprof))

;;(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;;(define-key slime-mode-map [(tab)] 'slime-complete-symbol)
;;(define-key slime-mode-map (kbd "C-M-;") (lambda () (interactive) (insert "(")))
;;(define-key slime-mode-map (kbd "C-M-'") (lambda () (interactive) (insert ")")))

;;(define-key slime-repl-mode-map (kbd "C-M-[") (lambda () (interactive) (insert "(")))
;;(define-key slime-repl-mode-map (kbd "C-M-]") (lambda () (interactive) (insert ")")))
;; (define-key slime-mode-map (kbd "C-,") 'backward-sexp)
;; no term (define-key slime-mode-map "\C-." 'forward-sexp)

(setq slime-complete-symbol*-fancy t)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

;;(define-key paredit-mode-map (kbd "C-DEL") nil)

;; keybindings - in paredit, so we should be good for elisp, lisp and slime
(define-key paredit-mode-map (kbd "C-\\") 'hungry-electric-delete)
(define-key paredit-mode-map (kbd "C-M-,") (lambda () (interactive) (insert "\"")))
(define-key paredit-mode-map [(control ?\])] 'paredit-close-parenthesis-and-newline)
(define-key paredit-mode-map (kbd "C-]") 'paredit-close-parenthesis)
(define-key paredit-mode-map (kbd "C-t") 'transpose-sexps)
(define-key paredit-mode-map (kbd "C-M-t") 'transpose-chars)
(define-key paredit-mode-map (kbd "C-M-k") 'paredit-kill)
(define-key paredit-mode-map (kbd "C-k") 'kill-sexp)
(define-key paredit-mode-map (kbd "M-k") 'backward-kill-sexp)
(define-key paredit-mode-map (kbd "M-u") 'backward-up-list)
(define-key paredit-mode-map (kbd "M-j") 'down-list)
(define-key paredit-mode-map (kbd "M-o") 'up-list)
(define-key paredit-mode-map (kbd "M-l") 'backward-down-list)
(define-key paredit-mode-map (kbd "C-M-l") 'recenter)
(define-key paredit-mode-map (kbd "M-]") 'paredit-forward-slurp-sexp)
(define-key paredit-mode-map (kbd "M-[") 'paredit-forward-barf-sexp)
;;(define-key paredit-mode-map (kbd "M-;") 'paredit-backward-slurp-sexp)
(define-key paredit-mode-map (kbd "M-;") 'slime-beginning-of-defun)
(define-key paredit-mode-map (kbd "M-'") 'paredit-backward-barf-sexp)
;;(define-key paredit-mode-map (kbd "M-\\") 'paredit-splice-sexp-killing-forward)
(define-key paredit-mode-map (kbd "M-\\") 'paredit-raise-sexp)
(define-key paredit-mode-map (kbd "C-j") 'paredit-newline)
(define-key paredit-mode-map (kbd "C-u") 'backward-sexp)
(define-key paredit-mode-map (kbd "C-o") 'forward-sexp)


;; don't define git-gutter for slime-repl-mode-map
(define-key slime-mode-map (kbd "M-n") 'git-gutter:next-hunk)
(define-key slime-mode-map (kbd "M-p") 'git-gutter:previous-hunk)
(define-key lisp-mode-map (kbd "M-n") 'git-gutter:next-hunk)
(define-key lisp-mode-map (kbd "M-p") 'git-gutter:previous-hunk)
(define-key emacs-lisp-mode-map (kbd "M-n") 'git-gutter:next-hunk)
(define-key emacs-lisp-mode-map (kbd "M-p") 'git-gutter:previous-hunk)

;;(define-key paredit-mode-map (kbd "M-p") 'slime-repl-backward-input)
;; (define-key paredit-mode-map (kbd "M-p") 'slime-repl-forward-input)


(define-key slime-mode-map (kbd "TAB") 'slime-complete-symbol)
(define-key slime-repl-mode-map (kbd "M-i") 'slime-inspect-presentation-at-point)

;; (define-key slime-mode-map (kbd "C-M-p") 'previous-line)


;; still need to find a good one for this:
;; no term (define-key slime-mode-map (kbd "C-'") 'paredit-splice-sexp-killing-backward)



;; Shortcut key for starting a SLIME CL connection
(global-set-key [f2] 'slime)
(global-set-key [f3] 'revert-buffer)
;;(slime-setup)


(setq slime-startup-animation nil)




;; so you can enter in the repl:
(define-key paredit-mode-map (kbd "RET") nil)
(define-key lisp-mode-shared-map (kbd "RET") 'paredit-newline)

;;(define-key slime-repl-mode-map [(?\()] 'insert-parentheses)
;;(define-key slime-repl-mode-map [(?\))] 'move-past-close-and-reindent)
;;(define-key slime-mode-map [(return)] 'newline-and-indent)



(add-hook 'inferior-lisp-mode-hook 'inferior-slime-mode)


;;(setq inferior-lisp-program "sbcl"
;;      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;;      lisp-indent-function 'common-lisp-indent-function)

;;(setq inferior-lisp-program "sbcl"
;;      slime-enable-evaluate-in-emacs t
;;      slime-outline-mode-in-events-buffer t
;;      slime-repl-return-behaviour :send-only-if-after-complete
;;      slime-autodoc-use-multiline-p t
;;      slime-highlight-compiler-notes t
;;      slime-fuzzy-completion-in-place t
;;      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;;      lisp-indent-function 'common-lisp-indent-function)




;; (add-hook 'slime-repl-mode-hook 'hungry)
;;(add-hook 'slime-repl-mode-hook 'inferior-lisp-mode-hook)

;(add-hook 'lisp-mode-hook 'hungry)
;(add-hook 'emacs-lisp-mode 'hungry)


(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook       #'enable-paredit-mode)

;; (defmacro defslime-start (name lisp)
;;  `(defun ,name ()
;;    (interactive)
;;     (slime ,lisp)))

;;(defslime-start cmucl "/usr/local/cmucl/bin/lisp
;;)")

;;(eval-after-load 'paredit
;;  '(progn
;;    (define-key paredit-mode-map (kbd "")
;;     'paredit-close-parenthesis)
;;    (define-key paredit-mode-map (kbd "M-)")
;;     'paredit-close-parenthesis-and-newline)))

;;(modify-syntax-entry ?{ "(}" lisp-mode-syntax-table)
;;(modify-syntax-entry ?} "){" lisp-mode-syntax-table)
;;(modify-syntax-entry ?[ "(]" lisp-mode-syntax-table)
;;(modify-syntax-entry ?] ")[" lisp-mode-syntax-table)

;; (require 'parenface)

(defun slime-new-repl (&optional new-port)
  "Create additional REPL for the current Lisp connection."
  (interactive)
  (if (slime-current-connection)
      (let ((port (or new-port (slime-connection-port (slime-connection)))))
	(slime-eval `(swank::create-server :port ,port))
	(slime-connect slime-lisp-host port))
    (error "Not connected")))



;; scheme
(require 'quack)


;; ACL specific. Clashes w my Slime setup
;; (setq fi:common-lisp-host system-name)

;; (defvar *acl-version* "acl90-smp.64")
;; (defvar *acl-path* (concat "~/src/" *acl-version*))
;; (add-to-list 'load-path (concat *acl-path* "/eli") t)
;; (setq fi:common-lisp-buffer-name "*common-lisp*"
;;       fi:common-lisp-directory "~/git/ravenpack"
;;       fi:common-lisp-image-name (concat *acl-path* "/alisp")
;;       fi:common-lisp-image-file (concat *acl-path* "/alisp.dxl"))


;; ;;; Tell font-lock about the Franz modes
;; ;;; ====================================
;; (load "fi-site-init")
;; (put 'fi::def-auto-mode            'font-lock-defaults 'lisp-mode)
;; (put 'fi:common-lisp-mode          'font-lock-defaults 'lisp-mode)
;; (put 'fi:emacs-lisp-mode           'font-lock-defaults 'lisp-mode)
;; (put 'fi:franz-lisp-mode           'font-lock-defaults 'lisp-mode)
;; (put 'fi:inferior-common-lisp-mode 'font-lock-defaults 'lisp-mode)
;; (put 'fi:inferior-franz-lisp-mode  'font-lock-defaults 'lisp-mode)
;; (put 'fi:lisp-listener-mode        'font-lock-defaults 'lisp-mode)

;; (defvar lisp-font-lock-prompt
;;   (list (cons fi:common-lisp-prompt-pattern 'font-lock-keyword-face))
;;   "Expression to highlight prompt in lisp subprocess buffers.")

;; (add-hook 'fi:subprocess-mode-hook
;;           '(lambda ()
;;              (make-local-variable 'font-lock-defaults)
;;              (setq font-lock-defaults '(lisp-font-lock-prompt
;;                                         nil nil
;;                                         ((?: . "w") (?- . "w") (?* . "w"))))
;;              ;;           (define-key fi:inferior-common-lisp-mode-map
;;              ;;               (kbd "M-n") 'fi:push-input)
;;              ;;           (define-key fi:inferior-common-lisp-mode-map
;;              ;;               (kbd "M-p") 'fi:pop-input)
;;              (define-key fi:lisp-listener-mode-map
;;                (kbd "M-n") 'fi:push-input)
;;              (define-key fi:lisp-listener-mode-map
;;                (kbd "M-p") 'fi:pop-input)))

;; (defvar fi:lisp-process-via-file nil)

;; (defun start-lisp ()
;;   "Set up environment for the lisp implementation"
;;   (interactive)
;;   (setq lisp-indent-function 'common-lisp-indent-function)

;;   ;; Start up Lisp
;;   (case window-system
;;     ;; Franz Allegro Common Lisp using eli >= 7.0 on Windows
;;     ('w32 (if (and fi:lisp-process-via-file
;;                    (eq (process-status fi:lisp-process-via-file) 'open))
;;               (switch-to-buffer (process-buffer fi:lisp-process-via-file))
;;             (setq fi:lisp-process-via-file
;;                   (fi:start-interface-via-file "localhost"
;;                                                "*common-lisp*"
;;                                                "~/.eli-startup"))))
;;     ;; Franz Allegro Common Lisp on unix
;;     (t (fi:common-lisp fi:common-lisp-buffer-name
;;                        fi:common-lisp-directory
;;                        fi:common-lisp-image-name
;;                        fi:common-lisp-image-arguments
;;                        fi:common-lisp-host))))

