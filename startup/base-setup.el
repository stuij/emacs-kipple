
;;{{{ one-liners

(setq inhibit-startup-message t)
(setq display-time-day-and-date t)
(setq scroll-step 1)
(setq scroll-conservatively 5)

(setq font-lock-maximum-decoration t)                                                                                                                            

(set-face-attribute 'mode-line nil :box nil)
(display-time-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(blink-cursor-mode 0)


(setq default-frame-alist (append (list '(width  . 142) '(height . 51))
                                  default-frame-alist)) ;;was 142X51

(set-language-environment "UTF-8")

(setq suggest-key-bindings t)           ; turn on builtin pre-command hints

;; Make control+pageup/down scroll the other buffer
(global-set-key [C-next] 'scroll-other-window)
(global-set-key [C-prior] 'scroll-other-window-down)


;;; It is always better to know current line and column number
(column-number-mode t)
(line-number-mode t)

;;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p)


;;; indent files
(setq-default fill-column 116)
(setq-default indent-tabs-mode nil)

(defun trh-indent-whole-buffer ()
 "Indents the whole buffer.
Uses ``indent-region'' to indent the whole buffer."
  (interactive)
  (indent-region (point-min) (point-max) nil))

(global-set-key "\C-ci" 'trh-indent-whole-buffer)

;; comment region
(global-set-key "\C-cr" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

;;; Place Backup Files in Specific Directory

;; Enable backup files.
(setq make-backup-files t)

;; Saved my life more than once
(setq version-control t)
(setq kept-new-versions 7)
(setq delete-old-versions t)

;; Save all backup file in this directory.
(setq backup-directory-alist (quote (("." . "/home/zeno/.emacs.d/backups"))))

;; buffer menu shortcut
(global-set-key [(control tab)] 'buffer-menu)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(current-language-environment "UFT-8")
 '(global-font-lock-mode t nil (font-lock))
 '(php-file-patterns nil)
 '(show-paren-mode t nil (paren))
 '(speedbar-mode-specific-contents-flag t)
 '(speedbar-supported-extension-expressions (quote ("\\.\\(inc\\|php[s34]?\\)" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".g" ".s?html" "[Mm]akefile\\(\\.in\\)?" ".lisp" ".asd" ".php")))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(font-lock-builtin-face ((((type tty) (class color)) (:foreground "cyan" :weight light)))))

;; hieronder werkt zonder onderliggende x11 modificatie met xkeycaps,
;; alleen met x, anders gebruik slime-mode-map
(if window-system
    (progn 
      (keyboard-translate ?\( ?\[)
      (keyboard-translate ?\[ ?\()
      (keyboard-translate ?\) ?\])
      (keyboard-translate ?\] ?\)))
    (progn
      (define-key slime-mode-map (kbd "[") 'insert-parentheses)
      (define-key slime-mode-map (kbd "]") 'move-past-close-and-reindent)
      (define-key slime-mode-map (kbd "(") (lambda () (interactive) (insert "[")))
      (define-key slime-mode-map (kbd ")") (lambda () (interactive) (insert "]")))))

;;}}}
;;{{{ font cycler

;;(set-default-font "Bitstream Vera Sans Mono-8")

(setq my-fonts (list "-misc-fixed-medium-r-*-*-14-*-*-*-*-*-*-*"))

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

(my-font-set-default)    
(setq font-current my-fonts)

;;}}}
;;{{{ c stuff

;; Make Emacs automatically hit return for you after left curly braces,                                                                                            
;; right curly braces, and semi-colons.                                                                                                                            
                                                                                                                                                                  
;; Make Emacs use "newline-and-indent" when you hit the Enter key so                                                                                               
;; that you don't need to keep using TAB to align yourself when coding.                                                                                            
;; This is akin to setting autoindent in vi.                                                                                                                       

(global-set-key "\C-m" 'newline-and-indent)                                                                                                                       
                                                                                                                                                                  
(add-hook 'c-mode-hook 'turn-on-font-lock)                                                                                                                    

;; autofill in c 
(add-hook 'c-mode-hook 'turn-on-auto-fill)                                                                                                                      
                                                                                                                                                                  
(add-hook 'c-mode-hook
	  '(lambda () (local-set-key "\C-cc" 'compile)))

(add-hook 'c-mode-common-hook
	  '(lambda () (c-toggle-auto-hungry-state 1)))


;; To associate *.h files with c mode use the following line                                                                                                    
(add-to-list 'auto-mode-alist '("\\.h$" . c-mode))                                                                                                              

;;}}}
;;{{{ higher art

;; ------------------------------- escape lisp strings ------------------------

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

;; -------------------------------------------

(defun display-stuff (stuff)
  "ripped from folding.el. transformed it into a general printing function.
The prefix part doesnt do so much at the moment, but i leave it in for when i need it"
  (let* ((prefix "")
	 (re    (or comment-start-skip
		    (and comment-start
			 (concat "^[ \t]*" comment-start "+[ \t]*")))))
    (when re
      (save-excursion
	(beginning-of-line)
	(when (or (re-search-forward re nil t)
		  (progn
		    (goto-char (point-min))
		    (re-search-forward re nil t)))
	  (setq prefix (match-string 0)))))
    (beginning-of-line)
    (dolist (line stuff)
      (insert line))))

;; from Andreas Fuchs
(put 'package 'safe-local-variable 'symbolp)
(put 'Package 'safe-local-variable 'symbolp)
(put 'syntax 'safe-local-variable 'symbolp)
(put 'Syntax 'safe-local-variable 'symbolp)
(put 'Base 'safe-local-variable 'integerp)
(put 'base 'safe-local-variable 'integerp)

;; nuke line
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
(global-set-key [f9] 'nuke-line)

;;}}}
;;{{{ prior art;; (setq printer-name "ipp://192.168.0.144");; (setq default-major-mode 'text-mode);;use the windows-kind clipboard for copy/past in stead of the middle-mouse-button way;; (setq x-select-enable-clipboard t);; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value);; verwissel onderstaande toetsen wegens blsted x11 compose irritatie;;(keyboard-translate ?\; ?\');;(keyboard-translate ?\: ?\");;(keyboard-translate ?\' ?\;);;(keyboard-translate ?\" ?\:);; hoogte en breedte automatisch uitlezen werkt gloof ik niet zo:;; (and window-system;;     (setq screen-width (x-display-pixel-width);;        screen-height (x-display-pixel-height)));; size of emacs window 80*57 for 768*1024;;{{{ abbrev stuff nog uitzoeken;; M-x edit-abbrevs        allows editing of abbrevs;; M-x write-abbrev-file   will save abbrevs to file;; C-x a i l               allows us to define a local abbrev;; M-x abbrev-mode         turns abbrev-mode on/off;; set name of abbrev file with .el extension;;(setq abbrev-file-name "~/.emacs.d/abbrevs.el");;(setq-default abbrev-mode t);;(setq save-abbrevs t);; we want abbrev mode in all modes (does not seem to work);; (abbrev-mode 1);; quietly read the abbrev file;; (quietly-read-abbrev-file);;(if (file-exists-p  abbrev-file-name) (quietly-read-abbrev-file abbrev-file-name));;}}};;{{{ desktop persistency;; (setf save-place t);; (desktop-load-default);; save a list of open files in ~/.emacs.desktop;; save the desktop file automatically if it already exists;; (setq desktop-save 'if-exists);; save a bunch of variables to the desktop file;; for lists specify the len of the maximal saved data also;;(setq desktop-globals-to-save;;      (append '((extended-command-history . 30);;                (file-name-history        . 100);;                (grep-history             . 30);;                (compile-history          . 30);;                (minibuffer-history       . 50);;                (query-replace-history    . 60);;                (read-expression-history  . 60);;                (regexp-history           . 60);;                (regexp-search-ring       . 20);;                (search-ring              . 20);;                (shell-command-history    . 50);;                tags-file-name;;                register-alist)));;(desktop-read);;}}};;}}}