;; python mode
(require 'python-mode)
(require 'jedi)
(require 'pyflakes)
(require 'elpy)

;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(add-hook 'python-mode-hook
          (lambda () (whitespace-mode 1)))

;; ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(elpy-enable)

(defun show-python-repl ()
  (interactive)
  (display-buffer (process-buffer (elpy-shell-get-or-create-process))
                  nil
                  'visible))

(define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)
(define-key elpy-mode-map (kbd "C-q r") 'show-python-repl)

;; (require 'ipython)

;;(setq-default py-shell-name "ipython")
;;(setq-default py-which-bufname "IPython")

;; use IPython
;;(setq py-shell-name "ipython"
;;      py-which-bufname "IPython"
;;      python-shell-interpreter "ipython"
;;      py-force-py-shell-name-p t
;;      python-shell-interpreter-args ""
;;      py-complete-function 'ipython-complete
;;      py-shell-complete-function 'ipython-complete
;;      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;      python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
;;      python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
;;      python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
;;      py-shell-switch-buffers-on-execute-p t
;;      py-switch-buffers-on-execute-p t
;;      py-smart-indentation t
;;      py-split-windows-on-execute-p nil
;;      )
