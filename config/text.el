(add-hook 'text-mode-hook
          (lambda () (whitespace-mode 1)))

(load "flyspell")
(add-hook 'flyspell-mode-hook
	  '(lambda () (local-set-key [mouse-3] 'flyspell-correct-word)))

;;(autoload 'flyspell-delay-command "flyspell" "Delay on command." t) (autoload 'tex-mode-flyspell-verify "flyspell" "" t)


;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook 'longlines-mode)
;; (add-hook 'text-mode-hook 'hungry)


;;--------------
;; markdown
;;--------------
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.mdml$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.md$" . markdown-mode) auto-mode-alist))


;;--------------
;; setting up style for general writing: poems, diatribes, youtube comments
;;--------------
(defun blog-post (prefix)
  (interactive "P")
  (insert (format-time-string "- created: %Y-%m-%d %H:%M:%S
- format: markdown
- type: post
- tags:
- title:
- body:")))

(defun recipe (prefix)
  (interactive "P")
  (insert (format-time-string "- created: %Y-%m-%d %H:%M:%S
- format: markdown
- type: post
- tags:
- title:
- body:")))

(defun story (prefix)
  (interactive "P")
  (insert (format-time-string "- created: %Y-%m-%d %H:%M:%S
- format: markdown
- type: post
- tags: story
- title:
- body:")))

(defun note (prefix)
  (interactive "P")
  (insert (format-time-string "- created: %Y-%m-%d %H:%M:%S
- format: markdown
- type: post
- tags: note
- title:
- body:")))


