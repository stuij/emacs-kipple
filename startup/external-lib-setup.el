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

;;{{{ one-liners
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
;;{{{ erc stuff
;;{{{ folding
;;{{{ web stuff
;;{{{ prior art