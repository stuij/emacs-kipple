(setq load-path
      (append (list nil
                    "/home/zeno/.emacs.d/lib"
                    "/home/zeno/.emacs.d/lib/psgml-1.3.2"
                    "/home/zeno/.emacs.d/lib/mmm-mode-0.4.8"
                    "/home/zeno/.emacs.d/lib/darcsum"
                    "/home/zeno/.emacs.d/lib/color-theme-6.6.0"
                    "/home/zeno/.emacs.d/lib/color-theme-6.6.0/themes"
                    )
              load-path))

(require 'darcsum)
(require 'js-mode)
(require 'color-theme)
(load "color-theme-library")
(require 'password)
(require 'swbuff)
(require 'hungry)
(require 'folding)
(require 'htmlize)
(require 'mmm-mode)

(autoload 'css-mode "css-mode")
(autoload 'php-mode "php-mode" nil t)
(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
(autoload 'javascript-mode "javascript" nil t)

;;{{{ one-liners(add-hook 'javascript-mode-hook 'js-mode)(autoload 'js-mode "js-mode" nil t)(setq password-cache-expiry 3600)(autoload 'longlines-mode    "longlines.el"  "Minor mode for automatically wrapping long lines." t)(add-hook 'text-mode-hook 'longlines-mode)(add-hook 'text-mode-hook 'hungry)(setq swbuff-exclude-buffer-regexps      ;;'("\\(^ .+$\\|\\*Messages\\*\\|*Compile-Log\\*\\|*inferior-lisp\\*\\|*Completions\\*\\|*slime-events\\*\\)")      '("^ .*" "^\\*.*\\*"))(global-set-key [f11] 'swbuff-kill-this-buffer);;}}}
;;{{{ color theme switcher
 
;;(if window-system
;;    (color-theme-charcoal-black))

(defun color-theme-face-attr-construct (face frame)
  (if (atom face)
      (custom-face-attributes-get face frame)
      (if (and (consp face) (eq (car face) 'quote))
	  (custom-face-attributes-get (cadr face) frame)
	  (custom-face-attributes-get (car face) frame))))

(setq my-color-themes (list 'color-theme-charcoal-black
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
(setq color-theme-is-global nil) ;; Initialization

(if window-system
    (my-theme-set-default))

;; (global-set-key [f7] 'my-theme-cycle)

;;}}} 
;;{{{ erc stuff;;(require 'erc);;(require 'erc-dcc);;(require 'erc-stamp);;(require 'erc-match);; Add current time to every new line(erc-timestamp-mode t);; Notify me if someone calls me(erc-match-mode t);; (add-hook 'erc-text-matched-hook 'erc-beep-on-match);; (setq erc-beep-match-types '(current-nick keyword));; (add-hook 'erc-text-matched-hook;;          (lambda (match-type nickuserhost message);;            (cond;;              ((eq match-type 'current-nick);;               (play-sound-file "/usr/share/games/wesnoth/sounds/dart.wav"));;              ((eq match-type 'keyword);;               (play-sound-file "/usr/share/games/wesnoth/sounds/dart.wav")))));; only this one worked to be notified on username(defun erc-say-my-name (str)  "Play the Ni! sound file if STR contains Ni!"  (when (string-match "\\bwobbly" str)    (play-sound-file "/usr/share/games/wesnoth/sounds/wail-long.wav")))(add-hook 'erc-insert-pre-hook 'erc-say-my-name)(add-hook 'erc-send-pre-hook 'erc-say-my-name);; Some basic settings for erc package(setq erc-server "irc.eu.freenode.net"       erc-port 6667       erc-nick "wobbly"      ;;      erc-user-full-name user-full-name      ;;      erc-email-userid "zeno"      ;;      erc-prompt-for-password nil      ;;      erc-fill-prefix "      "      erc-auto-query t      erc-pals '("dhrdevis")      ;;      erc-keywords '("lisp")      erc-current-nick-highlight-type 'nick      erc-timestamp-only-if-changed-flag nil      erc-timestamp-format "%H:%M "      erc-insert-timestamp-function 'erc-insert-timestamp-left      ;;      erc-join-buffer (quote frame)      ;;      erc-kill-buffer-on-part t      ;;      erc-save-buffer-on-part t      erc-log-channels t      erc-log-channels-directory "~/.irclogs"      erc-log-insert-log-on-open t      erc-generate-log-file-name-function 'my-erc-generate-log-file-name-short);;}}}
;;{{{ folding(folding-mode-add-find-file-hook);;(setq folding-default-keys-function 'folding-bind-backward-compatible-keys)(defun fold-open ()  (interactive)  (display-stuff '(";;{{{ ")))(global-set-key [(f6)] 'fold-open);;   also works-->  (folding-kbd "\C-f"   'fold-open)(defun fold-close ()  (interactive)  (display-stuff '(";;}}}\n")))(global-set-key [(f7)] 'fold-close)(defun fold-uncomment ()  (interactive)  (folding-comment-fold 1))(folding-kbd "´"   'fold-uncomment);;}}}\
;;{{{ web stuff(setq sgml-set-face t)(setq sgml-auto-activate-dtd t)(setq sgml-indent-data t)(setq sgml-auto-activate-dtd t)(setq sgml-markup-faces '((start-tag . font-lock-keyword-face)                          (end-tag . font-lock-keyword-face)                          (comment . font-lock-comment-face)                          (pi . font-lock-constant-face) ;; <?xml?>                          (sgml . font-lock-type-face)                          (doctype . font-lock-emphasized-face)                          (entity . italic)                          (shortref . font-lock-reference-face)                          (ignored . font-lock-string-face)                          (ms-start . font-lock-other-type-face)                          (ms-end . font-lock-other-type-face)                          (sgml . font-lock-function-name-face)));; Not exactly related to editing HTML: enable editing help with mouse-3 in all sgml files(defun go-bind-markup-menu-to-mouse3 ()  (define-key sgml-mode-map [(down-mouse-3)] 'sgml-tags-menu));;(add-hook 'sgml-mode-hook 'go-bind-markup-menu-to-mouse3);;************************************************************;; configure HTML editing;;************************************************************;;;;(require 'php-mode);;;; configure css-mode(add-to-list 'auto-mode-alist (cons  "\\.js\\'" 'javascript-mode))(add-to-list 'auto-mode-alist (cons  "\\.php\\'" 'php-mode))(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))(setq cssm-indent-function #'cssm-c-style-indenter)(setq cssm-indent-level '2);;(add-hook 'php-mode-user-hook 'turn-on-font-lock);;(setq mmm-global-mode 'maybe);;;; set up an mmm group for fancy html editing(mmm-add-group 'fancy-html '(   (html-php-tagged    :submode php-mode    :face mmm-code-submode-face    :front "<[?]php"    :back "[?]>")   (html-css-attribute    :submode css-mode    :face mmm-declaration-submode-face    :front "style=\""    :back "\"")));;;; What files to invoke the new html-mode for?(add-to-list 'auto-mode-alist '("\\.inc\\'" . sgml-mode))(add-to-list 'auto-mode-alist '("\\.phtml\\'" . sgml-mode))(add-to-list 'auto-mode-alist '("\\.php[34]?\\'" . sgml-mode))(add-to-list 'auto-mode-alist '("\\.[sj]?html?\\'" . sgml-mode))(add-to-list 'auto-mode-alist '("\\.[sj]?tal?\\'" . sgml-mode))(add-to-list 'auto-mode-alist '("\\.jsp\\'" . sgml-mode));;;; What features should be turned on in this html-mode?(add-to-list 'mmm-mode-ext-classes-alist '(sgml-mode nil html-js))(add-to-list 'mmm-mode-ext-classes-alist '(sgml-mode nil embedded-css))(add-to-list 'mmm-mode-ext-classes-alist '(sgml-mode nil fancy-html));;(set-face-background 'mmm-default-submode-face "DarkBlue") ;; other color option : DarkSlateBlue;;}}}
;;{{{ prior art;;{{{ erlang;; (add-to-list 'load-path "/home/zeno/erlang/jungerl/lib/distel/elisp");; (require 'distel);; (distel-setup);;}}};; (load "keywiz");;(load-file "/home/zeno/.emacs.d/lib/cedet-1.0pre3/common/cedet.el");; ------------- buffer switchers -------------;;(when (require 'bubble-buffer nil t);;  (global-set-key [f2] 'bubble-buffer-next);;  (global-set-key [(shift f2)] 'bubble-buffer-previous));;(setq bubble-buffer-omit-regexp "\\(^ .+$\\|\\*Messages\\*\\|*Compile-Log\\*\\|*inferior-lisp\\*\\|*Completions\\*\\|*slime-events\\*\\)");;(require 'ebs);;(ebs-initialize);;(global-set-key [(f3)] 'ebs-switch-buffer);;}}}
