(setq load-path
      (append (list "/home/zeno/.emacs.d/lib" "/home/zeno/stix/lisp/site/slime")
              load-path))

(load "paredit")
(require 'slime)
(require 'hungry)

(when (string-match "XEmacs\\|Lucid" emacs-version)
  (require 'mic-paren) ;; loading
  (paren-activate)     ;; activating
  ;; set here any of the customizable variables of mic-paren:
  (setf paren-priority 'close)
  (setf paren-highlight-offscreen t))

;;{{{ one-liners

;; enable lisp mode for .asd files
(add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.el$" . lisp-mode))

;; hyperspec config appended to w3c config
;; don't know why but that gets around bug of hyperspec lookup not working

;;}}}
;;{{{ paredit tweaks

;; so you can enter in the repl:
(define-key paredit-mode-map (kbd "RET") nil)
(define-key lisp-mode-shared-map (kbd "RET") 'paredit-newline)

(add-hook 'slime-repl-mode-hook 'paredit-mode)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode 'paredit-mode)

(defun insert-semicolon (&optional n)
  (interactive)
  (insert ";"))

(eval-after-load 'paredit
  '(progn
    (define-key paredit-mode-map (kbd ";")
     'insert-semicolon)))

;;}}}
;;{{{ slime tweaks

(slime-setup)

(setq inferior-lisp-program "sbcl"
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      lisp-indent-function 'common-lisp-indent-function)

(setq slime-net-coding-system 'utf-8-unix)
(setq slime-startup-animation nil)

(add-hook 'slime-repl-mode-hook 'hungry)
(add-hook 'lisp-mode-hook 'hungry)
(add-hook 'emacs-lisp-mode 'hungry)

(define-key slime-mode-map [(tab)] 'slime-complete-symbol)
(add-hook 'inferior-lisp-mode-hook 'inferior-slime-mode)

(modify-syntax-entry ?{ "(}" lisp-mode-syntax-table)
(modify-syntax-entry ?} "){" lisp-mode-syntax-table)
(modify-syntax-entry ?[ "(]" lisp-mode-syntax-table)
(modify-syntax-entry ?] ")[" lisp-mode-syntax-table)

(define-key slime-mode-map (kbd "C-M-;") (lambda () (interactive) (insert "(")))
(define-key slime-mode-map (kbd "C-M-'") (lambda () (interactive) (insert ")")))

(define-key slime-repl-mode-map (kbd "C-M-[") (lambda () (interactive) (insert "(")))
(define-key slime-repl-mode-map (kbd "C-M-]") (lambda () (interactive) (insert ")")))

;; (define-key slime-mode-map [(control ?\])] 'paredit-close-parenthesis-and-newline)

(define-key slime-mode-map (kbd "C-]") 'paredit-close-parenthesis)


(define-key slime-mode-map (kbd "C-t") 'transpose-sexps)
(define-key slime-mode-map (kbd "C-M-t") 'transpose-chars)
(define-key slime-mode-map (kbd "C-,") 'backward-sexp)
(define-key slime-mode-map (kbd "C-.") 'forward-sexp)
(define-key slime-mode-map (kbd "C-M-k") 'paredit-kill)
(define-key slime-mode-map (kbd "C-k") 'kill-sexp)
(define-key slime-mode-map (kbd "M-k") 'backward-kill-sexp)


(define-key slime-mode-map (kbd "C-i") 'backward-up-list)
(define-key slime-mode-map (kbd "C-j") 'backward-down-list)
(define-key slime-mode-map (kbd "C-o") 'down-list)
(define-key slime-mode-map (kbd "C-l") 'up-list)

;; (define-key slime-mode-map (kbd "C-M-p") 'previous-line)
(define-key slime-mode-map (kbd "C-M-l") 'recenter)


(define-key slime-mode-map (kbd "C-'") 'paredit-splice-sexp-killing-backward)
(define-key slime-mode-map (kbd "C-\\") 'paredit-splice-sexp-killing-forward)

(define-key slime-mode-map (kbd "C-;") 'paredit-raise-sexp)

(define-key slime-mode-map (kbd "M-]") 'paredit-forward-slurp-sexp)
(define-key slime-mode-map (kbd "M-[") 'paredit-forward-barf-sexp)
(define-key slime-mode-map (kbd "M-'") 'paredit-backward-slurp-sexp)
(define-key slime-mode-map (kbd "M-\\") 'paredit-backward-barf-sexp)

(global-set-key "\C-q" 'slime-selector)
(global-set-key [f8] 'slime-selector)

(global-set-key (kbd "C-M-p") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "C-M-n") 'swbuff-switch-to-next-buffer)
;; function territory

(defmacro defslime-start (name lisp)
  `(defun ,name ()
     (interactive)
     (slime ,lisp)))

(defslime-start cmucl "/usr/local/cmucl/bin/lisp")

;;}}}

;;{{{ scheme

(require 'quack)

;;}}}
;;{{{ emacs over tramp

;;(require 'tramp)
;; ssh -L 4005:localhost:4005 backend1@208.100.2.107

(setq tramp-default-method "scp")

(defun asf-hack-slime-remotely (host)
  (interactive "sHost: ")
  (setq slime-translate-to-lisp-filename-function
        `(lambda (file-name)
           (if (string-match (concat "^/" ,host ":") file-name)
               (subseq file-name (length (concat "/" ,host ":")))
               file-name))
        slime-translate-from-lisp-filename-function
        `(lambda (file-name)
           (concat "/" ,host ":" file-name))))

(defun asf-hack-slime-locally ()
  (interactive)
  (setq slime-translate-to-lisp-filename-function 'identity
        slime-translate-from-lisp-filename-function 'identity))

;-----------------------------------------------------------------------

(defvar *my-box-tramp-path*
  "/ssh:sprakkel@fallenfrukt.com:")

(defvar *current-tramp-path* nil)

(setq *backend* "backend1")
(setq *stix-swank-port* "33706")
(setq *remote-host* "208.100.2.107")

;; (interactive "sReplace string: \nsReplace string %s with: ")

(defun stix-flip-backend ()
  (interactive)
  (if (string-equal *backend* "backend1")
      (progn (setq *backend* "backend2")
             (setq *stix-swank-port* "34706"))
      (progn (setq *backend* "backend1")
             (setq *stix-swank-port* "33706"))))

(defun my-box-slime ()
  (interactive)
  (connect-to-host *my-boxtramp-path* *stix-swank-port*))

(defun stix-start-bridge ()
  (interactive)
  (start-process "bridge" nil "ssh" "-L" (concat *stix-swank-port* ":localhost:" *stix-swank-port*) (concat *backend* "@208.100.2.107")))

(defun stix-process ()
  (connect-to-process *backend* "208.100.2.107" *stix-swank-port*))
 
(defun stix-filename-translations ()
  (interactive)
    (push (slime-create-filename-translator :machine-instance "chi-050-33.nozonenet.com"
                                            :remote-host "208.100.2.107"
                                            :username *backend*)
          slime-filename-translations))

(defun stix-remove-remote-filename-lookup ()
  (interactive)
  (setf slime-filename-translations nil))

(defun stix-dir ()
  (interactive)
  (find-file  (concat "/ssh:" *backend* "@208.100.2.107:/home/" *backend* "/stix/stix/src/")))

;;----------

(defun connect-to-lisp (user server port)
  (stix-start-bridge)
  (sleep-for 6)
  (connect-to-host (concat "/ssh:" user "@" server) port))

(defun connect-to-host (path port)
  (setq *current-tramp-path* path)
  (setq slime-translate-from-lisp-filename-function
        (lambda (f)
          (concat *current-tramp-path* f)))
  (setq slime-translate-to-lisp-filename-function
        (lambda (f)
          (substring f (length *current-tramp-path*))))
  (slime-connect "localhost" port))


(defvar find-file-root-prefix (if (featurep 'xemacs)
                                  (concat "/[ssh/" *backend* "@208.100.2.107]")
                                  (concat "/ssh:" *backend* "@208.100.2.107:" ))
  ;;"*The filename prefix used to open a file with `find-file-root'."
  )

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
   	 ;; use a separate history list for "root" files.
   	 (file-name-history find-file-root-history)
   	 (name (or buffer-file-name default-directory))
   	 (tramp (and (tramp-tramp-file-p name)
   		     (tramp-dissect-file-name name)))
   	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-path tramp)
   	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

(global-set-key [(control x) (control r)] 'find-file-root)

;;}}}
;;{{{ higher art

(defun eval-whenify (&optional n)
  (interactive "*p")
  (save-excursion
    (if (and (boundp 'slime-repl-input-start-mark)
             slime-repl-input-start-mark)
        (slime-repl-beginning-of-defun)
        (beginning-of-defun))
    (paredit-wrap-sexp n)
    (insert "eval-when (:compile-toplevel :load-toplevel :execute)\n")
    (slime-reindent-defun)))
(define-key lisp-mode-map [(control c) ?e] 'asf-eval-whenify)

;;}}}
;;{{{ prior art;;(setq inferior-lisp-program "sbcl";;      slime-enable-evaluate-in-emacs t;;      slime-outline-mode-in-events-buffer t;;      slime-repl-return-behaviour :send-only-if-after-complete;;      slime-autodoc-use-multiline-p t;;      slime-highlight-compiler-notes t;;      slime-fuzzy-completion-in-place t;;      slime-complete-symbol-function 'slime-fuzzy-complete-symbol;;      lisp-indent-function 'common-lisp-indent-function);;(eval-after-load 'paredit;;  '(progn;;    (define-key paredit-mode-map (kbd "");;     'paredit-close-parenthesis);;    (define-key paredit-mode-map (kbd "M-)");;     'paredit-close-parenthesis-and-newline)));;(define-key slime-repl-mode-map [(?\()] 'insert-parentheses);;(define-key slime-repl-mode-map [(?\))] 'move-past-close-and-reindent);;(define-key slime-mode-map [(return)] 'newline-and-indent);; (require 'parenface);;}}}
