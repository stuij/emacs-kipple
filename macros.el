(fset 'control-comp
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([backspace backspace backspace backspace backspace backspace backspace backspace backspace backspace backspace backspace 6 67108896 67108908 134217847 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 2 67108910 return 25 2 32 118 53 84 69 45 116 104 117 109 98 67108908 67108908 67108908] 0 "%d")) arg)))

(global-set-key (kbd "C-c C-k 1") 'control-comp)