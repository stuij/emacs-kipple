(require 'flyspell)

;; flyspell
;; needs linux? program ispell
(add-hook 'flyspell-mode-hook
	  '(lambda () (local-set-key [mouse-3] 'flyspell-correct-word)))

;;(autoload 'flyspell-delay-command "flyspell" "Delay on command." t) (autoload 'tex-mode-flyspell-verify "flyspell" "" t) 

(add-hook 'text-mode-hook 'flyspell-mode)

;;{{{ w3m stuff