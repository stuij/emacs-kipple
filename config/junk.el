;; this is the filthy stuff that should be sifted and mashed into gold

;;{{{ loadup/misc

(require 'uniquify)

(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;; (global-set-key "\C-h" 'backward-delete-char-untabify)

;; (keyboard-translate ?\; ?\ )
(global-set-key [(control ?\;)] 'set-mark-command)
;; (keyboard-translate ?\| ?\;)

(setq uniquify-buffer-name-style 'post-forward)


(require 'ess-site)
;; (require 'inv-19)


;; auto-complete
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)



(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; (autoload 'gtags-mode "gtags" "" t)
;; (setq c-mode-hook
;;       '(lambda ()
;;          (gtags-mode 1)))
;; (setq c++-mode-hook
;;       '(lambda ()
;;          (gtags-mode 1)))

;; (add-hook 'gtags-mode-hook
;;           (lambda()
;;             (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
;;             (local-set-key (kbd "M-,") 'gtags-pop-stack)))  ; reverse tag

;; (add-hook 'gtags-select-mode-hook
;;           (lambda()
;;             (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
;;             (local-set-key (kbd "M-,") 'gtags-pop-stack)))  ; reverse tag

;; (defun gtags-root-dir ()
;;   "Returns GTAGS root directory or nil if doesn't exist."
;;   (with-temp-buffer
;;     (if (zerop (call-process "global" nil t nil "-pr"))
;;         (buffer-substring (point-min) (1- (point-max)))
;;       nil)))

;; (defun gtags-update ()
;;   "Make GTAGS incremental update"
;;   (call-process "global" nil nil nil "-u"))

;; (defun gtags-update-hook ()
;;   (when (gtags-root-dir)
;;     (gtags-update)))

;; (add-hook 'after-save-hook #'gtags-update-hook)


;;(load "redo")
;;(global-set-key "\C-\\" 'redo)

(when (string-match "XEmacs\\|Lucid" emacs-version)
  (require 'mic-paren) ;; loading
  (paren-activate)     ;; activating
  ;; set here any of the customizable variables of mic-paren:
  (setf paren-priority 'close)
  (setf paren-highlight-offscreen t))

;;(require 'ebs)
;;(ebs-initialize)
;;(global-set-key [(f3)] 'ebs-switch-buffer)

;;}}}
;;{{{ aangepast door emacs, soort van



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun trh-indent-whole-buffer ()
  "Indents the whole buffer.
Uses ``indent-region'' to indent the whole buffer."
  (interactive)
  (indent-region (point-min) (point-max) nil))

(defun lisp-indent-toplevel ()
  (interactive)
  (save-excursion
    (slime-beginning-of-defun)
    (indent-pp-sexp)))


;;(global-set-key "\C-ci" 'trh-indent-whole-buffer)
(global-set-key "\C-ci" 'lisp-indent-toplevel)

;;}}}
;;{{{ lisp

;;}}}
;;{{{ c stuff

;; Make Emacs automatically hit return for you after left curly braces,
;; right curly braces, and semi-colons.

;; Make Emacs use "newline-and-indent" when you hit the Enter key so
;; that you don't need to keep using TAB to align yourself when coding.
;; This is akin to setting autoindent in vi.
(require 'cc-mode)

;; In versions of Emacs greater than 23.2, do the following

(when (or (> emacs-major-version 23)
          (and (= emacs-major-version 23)
               (>= emacs-minor-version 2)))

  ;; Use the GDB visual debugging mode
  (setq gdb-many-windows t)


  ;; add semantic options
  (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)

  ;; Class suggest improvement
  ;;(defun my-c-mode-cedet-hook ()
  ;;  (local-set-key "." 'semantic-complete-self-insert)
  ;;  (local-set-key ">" 'semantic-complete-self-insert))
  ;;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

  ;; Turn Semantic on
  (semantic-mode 1)
  (require 'semantic/ia)
  (require 'semantic/bovine/gcc)
  (require 'gtags)

  (global-set-key [(control ?\,)] 'pop-global-mark)
  (global-set-key [(control ?\.)] 'semantic-ia-fast-jump)

  (defun my-semantic-hook ()
    (semantic-add-system-include "/home/zeno/teclo/code/clibs" 'c-mode)
    (semantic-add-system-include "/home/zeno/teclo/code/clibs" 'c++-mode))
  (add-hook 'semantic-init-hooks 'my-semantic-hook)

  ;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)

  ;; if you want to enable support for gnu global
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode)

  ;; enable ctags for some languages:
  ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
  ;; (semantic-load-enable-primary-exuberent-ctags-support)


  ;; Try to make completions when not typing
  (global-semantic-idle-completions-mode 1)

  ;; Use the Semantic speedbar additions
  (add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb))))


(global-set-key "\C-m" 'newline-and-indent)
(add-hook 'c-mode-hook 'turn-on-font-lock)


;; autofill in c
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook
	  '(lambda () (local-set-key "\C-c\C-k" 'compile)
                      (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
                      (local-set-key (kbd "M-,") 'pop-global-mark)
                      (setq c-basic-offset 2)))

(add-hook 'c++-mode-hook
	  '(lambda () (local-set-key "\C-ck" 'compile)
                      (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
                      (local-set-key (kbd "M-,") 'pop-global-mark)
                      (setq c-basic-offset 2)))


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
(add-to-list 'auto-mode-alist '("\\.h$" . c-mode))

;;(setq tags-table-list
;;           '("~/hack/c" "/usr/src/linux"))

;;}}}
;;{{{ erlang

;; ;; This is needed for Erlang mode setup
;; (setq erlang-root-dir "/usr/lib/erlang")
;; (setq load-path (cons "/usr/lib/erlang/lib/tools-2.5.1/emacs" load-path))
;; (setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
;; (require 'erlang-start)

;; (require 'distel)
;; (distel-setup)

;; ;; Some Erlang customizations
;; (add-hook 'erlang-mode-hook
;; 	  (lambda ()
;; 	    ;; when starting an Erlang shell in Emacs, default in the node name
;; 	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
;; 	    ;; add Erlang functions to an imenu menu
;; 	    (imenu-add-to-menubar "imenu")))

;; ;; A number of the erlang-extended-mode key bindings are useful in the shell too
;; (defconst distel-shell-keys
;;   '(("\C-\M-i"   erl-complete)
;;     ("\M-?"      erl-complete)
;;     ("\M-."      erl-find-source-under-point)
;;     ("\M-,"      erl-find-source-unwind)
;;     ("\M-*"      erl-find-source-unwind)
;;     )
;;   "Additional keys to bind when in Erlang shell.")

;; (add-hook 'erlang-shell-mode-hook
;; 	  (lambda ()
;; 	    ;; add some Distel bindings to the Erlang shell
;; 	    (dolist (spec distel-shell-keys)
;; 	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;;}}}
;;{{{ wat layout modificaties

;; ===== Function to delete a line =====

;; First define a variable which will store the previous column position
(defvar previous-column nil "Save the column position")

;; Define the nuke-line function. The line is killed, then the newline
;; character is deleted. The column which the cursor was positioned at is then
;; restored. Because the kill-line function is used, the contents deleted can
;; be later restored by usibackward-delete-char-untabifyng the yank commands.
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)

  ;; Store the current column position, so it can later be restored for a more
  ;; natural feel to the deletion
  (setq previous-column (current-column))

  ;; Now move to the end of the current line
  (end-of-line)

  ;; Test the length of the line. If it is 0, there is no need for a
  ;; kill-line. All that happens in this case is that the new-line character
  ;; is deleted.
  (if (= (current-column) 0)
      (delete-char 1)

    ;; This is the 'else' clause. The current line being deleted is not zero
    ;; in length. First remove the line by moving to its start and then
    ;; killing, followed by deletion of the newline character, and then
    ;; finally restoration of the column position.
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))

;; Now bind the delete line function to the F8 key
(global-set-key [f11] 'nuke-line)

;; verwissel onderstaande toetsen wegens blsted x11 compose irritatie
;;(keyboard-translate ?\; ?\')
;;(keyboard-translate ?\: ?\")
;;(keyboard-translate ?\' ?\;)
;;(keyboard-translate ?\" ?\:)

;; hieronder werkt zonder onderliggende x11 modificatie met xkeycaps, alleen met x, anders gebruik slime-mode-map
;;---------------------------------------------------------------------------------------------------

;;(keyboard-translate ?\( ?\[)
;;(keyboard-translate ?\[ ?\()
;;(keyboard-translate ?\) ?\])
;;(keyboard-translate ?\] ?\))

;;(define-key key-translation-map (kbd "(") (kbd "["))
;;(define-key key-translation-map (kbd ")") (kbd "]"))
;;(define-key key-translation-map (kbd "[") (kbd "("))
;;(define-key key-translation-map (kbd "]") (kbd ")"))

;; (if window-system
;;     (progn
;;       (keyboard-translate ?\( ?\[)
;;       (keyboard-translate ?\[ ?\()
;;       (keyboard-translate ?\) ?\])
;;       (keyboard-translate ?\] ?\)))
;;   (progn
;;     (define-key slime-mode-map (kbd "[") 'insert-parentheses)
;;     (define-key slime-mode-map (kbd "]") 'move-past-close-and-reindent)
;;     (define-key slime-mode-map (kbd "(") (lambda () (interactive) (insert "[")))
;;     (define-key slime-mode-map (kbd ")") (lambda () (interactive) (insert "]")))))

;;---------------------------------------------------------------------------------------------------




;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(when (and (getenv "DISPLAY")
           (not window-system)
           (not (eq system-type 'darwin)))
  ;; Callback for when user cuts
  (defun xsel-cut-function (text &optional push)
    ;; Insert text to temp-buffer, and "send" content to xsel stdin
    (with-temp-buffer
      (insert text)
      ;; I prefer using the "clipboard" selection (the one the
      ;; typically is used by c-c/c-v) before the primary selection
      ;; (that uses mouse-select/middle-button-click)
      (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
  ;; Call back for when user pastes
  (defun xsel-paste-function()
    ;; Find out what is current selection by xsel. If it is different
    ;; from the top of the kill-ring (car kill-ring), then return
    ;; it. Else, nil is returned, so whatever is in the top of the
    ;; kill-ring will be used.
    (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
      (unless (string= (car kill-ring) xsel-output)
	xsel-output )))
  ;; Attach callbacks to hooks
  (setq interprogram-cut-function 'xsel-cut-function)
  (setq interprogram-paste-function 'xsel-paste-function)
  ;; Idea from
  ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
  ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
  )





(defun insert-semicolon (&optional n)
  (interactive)
  (insert ";"))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd ";")
       'insert-semicolon)))

(global-set-key "\C-q" 'slime-selector)
(global-set-key [f8] 'slime-selector)

(global-set-key (kbd "C-M-p") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "C-M-n") 'swbuff-switch-to-next-buffer)

(global-set-key [(control tab)] 'buffer-menu)

;;}}}
;;{{{ abbrev stuff nog uitzoeken

;; M-x edit-abbrevs        allows editing of abbrevs
;; M-x write-abbrev-file   will save abbrevs to file
;; C-x a i l               allows us to define a local abbrev
;; M-x abbrev-mode         turns abbrev-mode on/off

;; set name of abbrev file with .el extension
;;(setq abbrev-file-name "~/.emacs.d/abbrevs.el")

;;(setq-default abbrev-mode t)
;;(setq save-abbrevs t)
;; we want abbrev mode in all modes (does not seem to work)
;; (abbrev-mode 1)
;; quietly read the abbrev file
;; (quietly-read-abbrev-file)
;;(if (file-exists-p  abbrev-file-name) (quietly-read-abbrev-file abbrev-file-name))

;;}}}
;;{{{ appearance stuff

(setq font-lock-maximum-decoration t)

(set-face-attribute 'mode-line nil :box nil)
(display-time-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)
;; (scroll-bar-mode -1)
(blink-cursor-mode 0)

(when window-system
  (scroll-bar-mode -1))


;; -------------------------------- color theme switcher --------------------------------------------------------------------------------

;;(if window-system
;;    (color-theme-charcoal-black))


(defun color-theme-face-attr-construct (face frame)
  (if (atom face)
      (custom-face-attributes-get face frame)
    (if (and (consp face) (eq (car face) 'quote))
        (custom-face-attributes-get (cadr face) frame)
      (custom-face-attributes-get (car face) frame))))

(require 'color-theme)

(load "calm-charcoal")

(setq my-color-themes (list 'color-theme-calm-charcoal
                            'color-theme-charcoal-black
			    'color-theme-emacs-21
			    'color-theme-blue-sea  'color-theme-calm-forest
			    'color-theme-gray30  'color-theme-late-night
			    'color-theme-word-perfect  'color-theme-blue-mood
			    'color-theme-classic))

(defun my-theme-set-default () ;; Set the first row
  (interactive)
  (setq theme-current my-color-themes)
  (funcall (car theme-current)))

(defun my-describe-theme () ;; Show the current theme
  (interactive)
  (message "%s" (car theme-current)))

;; Set the next theme (fixed by Chris Webber - tanks)
(defun my-theme-cycle ()
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (funcall (car theme-current))
  (message "%S" (car theme-current)))

(setq theme-current my-color-themes)
(setq color-theme-is-global t) ;; Initialization

(if window-system
    (my-theme-set-default))

(global-set-key [f7] 'my-theme-cycle)



;;------------------------------------------------------- font switcher --------------------------------------------


;;(set-default-font "Bitstream Vera Sans Mono-8")

(setq my-fonts (list "-misc-fixed-medium-r-*-*-16-*-*-*-*-*-*-*"
                     "-misc-fixed-medium-r-*-*-72-*-*-*-*-*-*-*"))

(defun my-font-set-default () ;; Set the first row
  (interactive)
  (setq font-current my-fonts)
  (set-default-font (car font-current)))

(defun my-describe-font () ;; Show the current theme, no font
  (interactive)
  (message "%s" (car font-current)))

;; Set the next theme, ehh font i mean (fixed by Chris Webber - tanks)
(defun my-font-cycle ()
  (interactive)
  (setq font-current (cdr font-current))
  (if (null font-current)
      (setq font-current my-fonts))
  (set-default-font (car font-current))
  (message "%S" (car font-current)))

;;(my-font-set-default)
(setq font-current my-fonts)

;; ;;}}}
;; ;;{{{ erc stuff

;; (require 'erc)
;; (require 'erc-dcc)
;; (require 'erc-stamp)
;; (require 'erc-match)

;; ;; Add current time to every new line
;; (erc-timestamp-mode t)
;; ;; Notify me if someone calls me
;; (erc-match-mode t)
;; ;; (add-hook 'erc-text-matched-hook 'erc-beep-on-match)
;; ;; (setq erc-beep-match-types '(current-nick keyword))

;; ;; (add-hook 'erc-text-matched-hook
;; ;;          (lambda (match-type nickuserhost message)
;; ;;            (cond
;; ;;              ((eq match-type 'current-nick)
;; ;;               (play-sound-file "/usr/share/games/wesnoth/sounds/dart.wav"))
;; ;;              ((eq match-type 'keyword)
;; ;;               (play-sound-file "/usr/share/games/wesnoth/sounds/dart.wav")))))

;; ;; only this one worked to be notified on username
;; (defun erc-say-my-name (str)
;;   "Play the Ni! sound file if STR contains Ni!"
;;   (when (string-match "\\bwobbly" str)
;;     (play-sound-file "/usr/share/games/wesnoth/sounds/wail-long.wav")))

;; (add-hook 'erc-insert-pre-hook 'erc-say-my-name)
;; (add-hook 'erc-send-pre-hook 'erc-say-my-name)

;; ;; Some basic settings for erc package
;; (setq erc-server "irc.eu.freenode.net"
;;       erc-port 6667
;;       erc-nick "wobbly"
;;       ;;      erc-user-full-name user-full-name
;;       ;;      erc-email-userid "zeno"
;;       ;;      erc-prompt-for-password nil
;;       ;;      erc-fill-prefix "      "
;;       erc-auto-query t
;;       erc-pals '("dhrdevis")
;;       ;;      erc-keywords '("lisp")
;;       erc-current-nick-highlight-type 'nick
;;       erc-timestamp-only-if-changed-flag nil
;;       erc-timestamp-format "%H:%M "
;;       erc-insert-timestamp-function 'erc-insert-timestamp-left
;;       ;;      erc-join-buffer (quote frame)
;;       ;;      erc-kill-buffer-on-part t
;;       ;;      erc-save-buffer-on-part t
;;       erc-log-channels t
;;       erc-log-channels-directory "~/.irclogs"
;;       erc-log-insert-log-on-open t
;;       erc-generate-log-file-name-function 'my-erc-generate-log-file-name-short)

;; ;;}}}
;; ;;{{{ w3m stuff

(require 'w3m)
(require 'w3m-e23)

(defun w3m-browse-url-other-window (url &optional newwin)
  (interactive
   (browse-url-interactive-arg "w3m URL: "))
  (let ((pop-up-frames nil))
    (switch-to-buffer-other-window
     (w3m-get-buffer-create "*w3m*"))
    (w3m-browse-url url)))


;; The ftp stuff is irrelevant for this discussion. I left it in anyhow.
(setq browse-url-browser-function
      (list (cons "^ftp:/.*"  (lambda (url &optional nf)
                                (call-interactively #'find-file-at-point url)))
            (cons "."  #'w3m-browse-url-other-window)))

;;(setq browse-url-browser-function 'w3m-browse-url)

(global-unset-key [C-down-mouse-1])
(add-hook 'w3m-mode-hook
	  '(lambda () (local-set-key   [mouse-1] 'w3m-mouse-view-this-url)))
(add-hook 'w3m-mode-hook
	  '(lambda () (local-set-key  [C-mouse-1] 'w3m-mouse-view-this-url-new-session)))
(add-hook 'w3m-mode-hook
	  '(lambda () (local-set-key  "\C-w" 'w3m-delete-buffer)))


(if window-system
    (defcustom w3m-fill-column (+ (frame-width) 55)
      "*Fill column of w3m."
      :group 'w3m
      :type 'integer))

(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map "\C-xm" 'dired-w3m-find-file)))

(defun dired-w3m-find-file ()
  (interactive)
  (require 'w3m)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))
	(w3m-find-file file))))

(defun w3m-download-with-wget (loc)
  (interactive "DSave to: ")
  (let ((url (or (w3m-anchor) (w3m-image))))
    (if url
	(let ((proc (start-process "wget" (format "*wget %s*" url)
				   "wget" "--passive-ftp" "-nv"
				   "-P" (expand-file-name loc) url)))
	  (with-current-buffer (process-buffer proc)
	    (erase-buffer))
	  (set-process-sentinel proc (lambda (proc str)
				       (message "wget download done"))))
      (message "Nothing to get"))))

(require 'w3m-type-ahead)
(add-hook 'w3m-mode-hook 'w3m-type-ahead-mode)

(defun w3m-new-buffer nil
  "Opens a new, empty w3m buffer."
  "As opposed to `w3m-copy-buffer', which opens a non-empty buffer.
 This ought to be snappier, as the old buffer needs not to be rendered.
 To be quite honest, this new function doesn't open a buffer completely
 empty, but visits the about: pseudo-URI that is going to have to
 suffice for now."
  (interactive)
  (w3m-goto-url-new-session "about://"))

(setq common-lisp-hyperspec-root (concat *emacs-base* "docs/HyperSpec/"))
;; or wherever you installed the HyperSpec

;; ;;}}}
;; ;;{{{ folding

;; (if (load "folding" 'nomessage 'noerror)
;;     (folding-mode-add-find-file-hook))

;; ;;(setq folding-default-keys-function 'folding-bind-backward-compatible-keys)

;; (defun fold-open ()
;;   (interactive)
;;   (display-stuff '(";;{{{ ")))

;; (global-set-key [(f6)] 'fold-open)
;; ;;   also works-->  (folding-kbd "\C-f"   'fold-open)

;; (defun fold-close ()
;;   (interactive)
;;   (display-stuff '(";;}}}\n")))

;; ;;(global-set-key [(f7)] 'fold-close)

;; (defun fold-uncomment ()
;;   (interactive)
;;   (folding-comment-fold 1))

;; (folding-kbd "´"   'fold-uncomment)

;; ;;}}}
;; ;;{{{ emacs over tramp

;; ;;(require 'tramp)
;; ;; ssh -L 4005:localhost:4005 backend1@208.100.2.107

;; ;; (defvar *my-box-tramp-path*
;; ;;   "/ssh:sprakkel@fallenfrukt.com:")

;; ;; (defun asf-hack-slime-remotely (host)
;; ;;   (interactive "sHost: ")
;; ;;   (setq slime-translate-to-lisp-filename-function
;; ;;         `(lambda (file-name)
;; ;;            (if (string-match (concat "^/" ,host ":") file-name)
;; ;;                (subseq file-name (length (concat "/" ,host ":")))
;; ;;                file-name))
;; ;;         slime-translate-from-lisp-filename-function
;; ;;         `(lambda (file-name)
;; ;;            (concat "/" ,host ":" file-name))))

;; ;; (defun asf-hack-slime-locally ()
;; ;;   (interactive)
;; ;;   (setq slime-translate-to-lisp-filename-function 'identity
;; ;;         slime-translate-from-lisp-filename-function 'identity))

;; ;; (defun my-box-slime ()
;; ;;   (interactive)
;; ;;   (connect-to-host *my-boxtramp-path* *target-swank-port*))
;; ;;-----------------------------------------------------------------------
;; ;; (interactive "sReplace string: \nsReplace string %s with: ")

;; ;; real stuff temprarily moved to ~/stix/stix/misc/emacs/stix-swank.el

;; (require 'stix-swank)

;; ;;}}}
;; ;;{{{ generieke functie(s)

;; ;; ------------------------------- escape lisp strings ------------------------

;; Highlight "FIXME" comments
(defface fixme-face '((t (:weight bold :box (:line-width 2 :color "orange"))))
  "The faced used to show FIXME lines.")

 (defun show-fixme-lines (&optional arg)
  "Emphasise FIXME comments. If ARG is positive, enable highlighting. If ARG is negative, disable highlighting. Otherwise, toggle highlighting."
  (interactive)
  (if (or (and (not arg) (assoc "FIXME" hi-lock-interactive-patterns))
          (and arg (minusp arg)))
      (unhighlight-regexp "FIXME")
    (highlight-phrase "FIXME" 'fixme-face)))
 (defun escape-lisp-string-region (start end)
  "Escape special characters in the region as if a CL string.
Inserts backslashes in front of special characters (namely backslash
and double quote) in the region, according to the Common Lisp string
escape requirements.
 Note that region should only contain the characters actually
comprising the string, without the surrounding quotes."
  (interactive "*r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char start)
      (while (search-forward "\\" nil t)
        (replace-match "\\\\" nil t))
      (goto-char start)
      (while (search-forward "\"" nil t)
        (replace-match "\\\"" nil t)))))
(defun unescape-lisp-string-region (start end)
  "Unescape special characters from the CL string specified by the region.
This amounts to removing preceeding backslashes from the characters
they escape.
 Note that region should only contain the characters actually
comprising the string, without the surrounding quotes."
  (interactive "*r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char start)
      (while (search-forward "\\" nil t)
        (replace-match "" nil t)
        (forward-char)))))
;; ;; ---------------------------------------------------------------------------------------
;; (defun display-stuff (stuff)
;;   "ripped from folding.el. transformed it into a general printing function.
;; The prefix part doesnt do so much at the moment, but i leave it in for when i need it"
;;   (let* ((prefix "")
;; 	 (re    (or comment-start-skip
;; 		    (and comment-start
;; 			 (concat "^[ \t]*" comment-start "+[ \t]*")))))
;;     (when re
;;       (save-excursion
;; 	(beginning-of-line)
;; 	(when (or (re-search-forward re nil t)
;; 		  (progn
;; 		    (goto-char (point-min))
;; 		    (re-search-forward re nil t)))
;; 	  (setq prefix (match-string 0)))))
;;     (beginning-of-line)
;;     (dolist (line stuff)
;;       (insert line))))

;; ;; from Andreas Fuchs
;; (put 'package 'safe-local-variable 'symbolp)
;; (put 'Package 'safe-local-variable 'symbolp)
;; (put 'syntax 'safe-local-variable 'symbolp)
;; (put 'Syntax 'safe-local-variable 'symbolp)
;; (put 'Base 'safe-local-variable 'integerp)
;; (put 'base 'safe-local-variable 'integerp)

;; (defun eval-whenify (&optional n)
;;   (interactive "*p")
;;   (save-excursion
;;     (if (and (boundp 'slime-repl-input-start-mark)
;;              slime-repl-input-start-mark)
;;         (slime-repl-beginning-of-defun)
;;       (beginning-of-defun))
;;     (paredit-wrap-sexp n)
;;     (insert "eval-when (:compile-toplevel :load-toplevel :execute)\n")
;;     (slime-reindent-defun)))
;; (define-key lisp-mode-map [(control c) ?e] 'asf-eval-whenify)

;; ;;}}}
;; ;;{{{ web stuff

;; (load "htmlize")

;; (autoload 'css-mode "css-mode")
;; (setq auto-mode-alist
;;       (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;; ;;(add-to-list 'auto-mode-alist (cons  "\\.js\\'" 'javascript-mode))
;; (autoload 'javascript-mode "javascript" nil t)

;; (add-to-list 'auto-mode-alist (cons  "\\.php\\'" 'php-mode))
;; (autoload 'php-mode "php-mode" nil t)

;; (autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
;; (autoload 'xml-mode "psgml" "Major mode to edit XML files." t)

;; (setq sgml-set-face t)
;; (setq sgml-auto-activate-dtd t)
;; (setq sgml-indent-data t)
;; (setq sgml-auto-activate-dtd t)
;; (setq sgml-markup-faces '((start-tag . font-lock-keyword-face)
;;                           (end-tag . font-lock-keyword-face)
;;                           (comment . font-lock-comment-face)
;;                           (pi . font-lock-constant-face) ;; <?xml?>
;;                           (sgml . font-lock-type-face)
;;                           (doctype . font-lock-emphasized-face)
;;                           (entity . italic)
;;                           (shortref . font-lock-reference-face)
;;                           (ignored . font-lock-string-face)
;;                           (ms-start . font-lock-other-type-face)
;;                           (ms-end . font-lock-other-type-face)
;;                           (sgml . font-lock-function-name-face)))



;; ;; Not exactly related to editing HTML: enable editing help with mouse-3 in all sgml files
;; (defun go-bind-markup-menu-to-mouse3 ()
;;   (define-key sgml-mode-map [(down-mouse-3)] 'sgml-tags-menu))
;; ;;
;; (add-hook 'sgml-mode-hook 'go-bind-markup-menu-to-mouse3)

;; ;;************************************************************
;; ;; configure HTML editing
;; ;;************************************************************
;; ;;
;; ;;(require 'php-mode)
;; ;;
;; ;; configure css-mode
;; (autoload 'css-mode "css-mode")
;; (add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
;; (setq cssm-indent-function #'cssm-c-style-indenter)
;; (setq cssm-indent-level '2)
;; ;;
;; (add-hook 'php-mode-user-hook 'turn-on-font-lock)
;; ;;
;; (require 'mmm-mode)
;; (setq mmm-global-mode 'maybe)
;; ;;
;; ;; set up an mmm group for fancy html editing
;; (mmm-add-group
;;  'fancy-html
;;  '(
;;    (html-php-tagged
;;     :submode php-mode
;;     :face mmm-code-submode-face
;;     :front "<[?]php"
;;     :back "[?]>")
;;    (html-css-attribute
;;     :submode css-mode
;;     :face mmm-declaration-submode-face
;;     :front "style=\""
;;     :back "\"")))
;; ;;
;; ;; What files to invoke the new html-mode for?
;; (add-to-list 'auto-mode-alist '("\\.inc\\'" . sgml-mode))
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . sgml-mode))
;; (add-to-list 'auto-mode-alist '("\\.php[34]?\\'" . sgml-mode))
;; (add-to-list 'auto-mode-alist '("\\.[sj]?html?\\'" . sgml-mode))
;; (add-to-list 'auto-mode-alist '("\\.[sj]?tal?\\'" . sgml-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . sgml-mode))
;; ;;
;; ;; What features should be turned on in this html-mode?
;; (add-to-list 'mmm-mode-ext-classes-alist '(sgml-mode nil html-js))
;; (add-to-list 'mmm-mode-ext-classes-alist '(sgml-mode nil embedded-css))
;; (add-to-list 'mmm-mode-ext-classes-alist '(sgml-mode nil fancy-html))
;; ;;

;; (set-face-background 'mmm-default-submode-face "DarkBlue")
;; ;; other color option : DarkSlateBlue

;; ;;}}}
;; ;;{{{ desktop persistency

;; ;; (setf save-place t)

;; ;; (desktop-load-default)

;; ;; save a list of open files in ~/.emacs.desktop
;; ;; save the desktop file automatically if it already exists
;; ;; (setq desktop-save 'if-exists)

;; ;; save a bunch of variables to the desktop file
;; ;; for lists specify the len of the maximal saved data also
;; ;;(setq desktop-globals-to-save
;; ;;      (append '((extended-command-history . 30)
;; ;;                (file-name-history        . 100)
;; ;;                (grep-history             . 30)
;; ;;                (compile-history          . 30)
;; ;;                (minibuffer-history       . 50)
;; ;;                (query-replace-history    . 60)
;; ;;                (read-expression-history  . 60)
;; ;;                (regexp-history           . 60)
;; ;;                (regexp-search-ring       . 20)
;; ;;                (search-ring              . 20)
;; ;;                (shell-command-history    . 50)
;; ;;                tags-file-name
;; ;;                register-alist)))

;; ;;(desktop-read)

;; ;;}}}
;; ;;{{{ erlang

;; ;; (add-to-list 'load-path "~/erlang/jungerl/lib/distel/elisp")
;; ;; (require 'distel)
;; ;; (distel-setup)

;; ;;}}}

;; (global-set-key [f11] 'swbuff-kill-this-buffer)

;; (setq-default display-buffer-reuse-frames t)

;; (defun word-count nil "Count words in buffer" (interactive)
;;   (shell-command-on-region (point-min) (point-max) "wc -w"))


(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;;(run-with-idle-timer 0.1 nil 'fullscreen)

;; (defun fullscreen (&optional f)
;;   (interactive)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;; 	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;; 	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
;; (fullscreen)


;; hoogte en breedte automatisch uitlezen werkt gloof ik niet zo:
;; (and window-system
;;      (setq screen-width (x-display-pixel-width)
;;            screen-height (x-display-pixel-height)))

;; size of emacs window 80*57 for 768*1024
;;(setq default-frame-alist (append (list '(width  . 200) '(height . 51)) default-frame-alist)) ;;was 142X51

;; (defun switch-full-screen ()
;;       (interactive)
;;       (shell-command "wmctrl -r :ACTIVE: -btoggle,maximize_vert,maximize_horz"))

;; (switch-full-screen)
(put 'downcase-region 'disabled nil)
