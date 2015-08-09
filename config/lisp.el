


(add-hook 'emacs-lisp-mode-hook
          (lambda () (whitespace-mode 1)))

(add-hook 'lisp-mode-hook
          (lambda () (whitespace-mode 1)))


;; slime
;; (setq slime-net-coding-system 'utf-8-unix)


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

