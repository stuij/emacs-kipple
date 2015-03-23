(require 'flyspell)

;; flyspell
;; needs linux? program ispell
(add-hook 'flyspell-mode-hook
	  '(lambda () (local-set-key [mouse-3] 'flyspell-correct-word)))

;;(autoload 'flyspell-delay-command "flyspell" "Delay on command." t) (autoload 'tex-mode-flyspell-verify "flyspell" "" t) 

(add-hook 'text-mode-hook 'flyspell-mode)

;;{{{ w3m stuff(require 'w3m)(require 'w3m-e23)(setq browse-url-browser-function 'w3m-browse-url)(global-unset-key [C-down-mouse-1])(add-hook 'w3m-mode-hook	  '(lambda () (local-set-key   [mouse-1] 'w3m-mouse-view-this-url)))(add-hook 'w3m-mode-hook	  '(lambda () (local-set-key  [C-mouse-1] 'w3m-mouse-view-this-url-new-session)))(add-hook 'w3m-mode-hook	  '(lambda () (local-set-key  "\C-w" 'w3m-delete-buffer)))(if window-system    (defcustom w3m-fill-column (+ (frame-width) 55)  "*Fill column of w3m."  :group 'w3m  :type 'integer))(add-hook 'dired-mode-hook	  (lambda ()	    (define-key dired-mode-map "\C-xm" 'dired-w3m-find-file)))(defun dired-w3m-find-file ()  (interactive)  (require 'w3m)  (let ((file (dired-get-filename)))    (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))	(w3m-find-file file))))(defun w3m-download-with-wget (loc)  (interactive "DSave to: ")  (let ((url (or (w3m-anchor) (w3m-image))))    (if url	(let ((proc (start-process "wget" (format "*wget %s*" url)				   "wget" "--passive-ftp" "-nv" 				   "-P" (expand-file-name loc) url)))	  (with-current-buffer (process-buffer proc)	    (erase-buffer))	  (set-process-sentinel proc (lambda (proc str)				       (message "wget download done"))))	(message "Nothing to get"))))(require 'w3m-type-ahead)(add-hook 'w3m-mode-hook 'w3m-type-ahead-mode)(defun w3m-new-buffer nil  "Opens a new, empty w3m buffer."  "As opposed to `w3m-copy-buffer', which opens a non-empty buffer. This ought to be snappier, as the old buffer needs not to be rendered. To be quite honest, this new function doesn't open a buffer completely empty, but visits the about: pseudo-URI that is going to have to suffice for now."  (interactive)  (w3m-goto-url-new-session "about://"));;}}}