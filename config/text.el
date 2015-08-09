;; setting up style for general writing: poems, diatribes, youtube comments
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


(add-hook 'text-mode-hook
          (lambda () (whitespace-mode 1)))
