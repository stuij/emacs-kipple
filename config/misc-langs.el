;;--------------
;; bash
;;--------------
(defun sh-mode-tweak ()
  (interactive)
  (setq sh-basic-offset 4
        sh-indentation 4))

(add-hook 'sh-mode-hook 'sh-mode-tweak)

;;--------------
;; rust
;;--------------
;; (require 'rust-mode)

;; (add-to-list 'load-path "")
;; (autoload 'rust-mode "rust-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; (setq racer-rust-src-path "~/src/rustc-nightly/src/")
;; (setq racer-cmd "~/src/racer/target/release/racer")
;; (add-to-list 'load-path "~/src/racer/editors/emacs")
;; (eval-after-load "rust-mode" '(require 'racer))
;; (define-key rust-mode-map (kbd "M-,") 'pop-global-mark)

;;--------------
;; yang
;;--------------
(autoload 'yang-mode "yang-mode" "Major mode for editing YANG models." t)
(add-to-list 'auto-mode-alist '("\\.yang$" . yang-mode))

(autoload 'js2-mode "js2-20090723b" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;--------------
;; javascript
;;--------------
;;(require 'flymake-jslint)
;;(add-hook 'js2-mode-hook
;;	  (lambda () (flymake-mode t)))


;;(require 'js-mode)
;;(add-hook 'javascript-mode-hook 'js-mode)
;;(autoload 'js-mode "js-mode" nil t)
