;;; hungry.el --- hungry (minor) mode. Electric deletion of white spaces.

;; Copyright (C) 1995-1997  Georges Brun-Cottan

;; Author:  Georges Brun-Cottan <Georges.Brun-Cottan@inria.fr>
;; Maintainer:  Georges Brun-Cottan <Georges.Brun-Cottan@inria.fr>
;; $Revision: 1.9 $

;;; Copyright:
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of version 2 of the GNU General Public
;; License as published by the Free Software Foundation.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If you did not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave., Cambridge, MA 02139, USA.

;;; Commentary:
;;
;; Define hungry-mode, a minor mode for smart deletion of white spaces.
;; 
;; When hungry mode is on, the delete key gobbles all preceding
;; whitespaces except the last.  See the `hungry::electric-delete'
;; documentation.
;;
;; The variable `hungry-white-space-chars' defines the chars to be
;; considered as ``white''.
;;
;; `hungry-delete-function' variable is called whenever a single char
;; as to be deleted. By default it is set to
;; `delete-backward-char'. See the `hungry-delete-function'
;; documentation for more a complete documentation.
;;

(require 'easy-mmode)

(defvar hungry-delete-function 'delete-backward-char
  "*Function called by `hungry-electric-delete' when deleting a single char.")
(make-local-variable 'hungry-delete-function)

(defvar hungry-last-white-char " "
  "*String replacing the last white char.
When `hungry-electric-delete' keep a white char, it is replaced by
`hungry-last-white-char'.")
(make-local-variable 'hungry-last-white-char)

(defvar hungry-white-space-chars  " \t\n"
  "*Chars to gobble when deleting.
Must be a string suitable for the `skip-chars-backward' function")
(make-local-variable 'hungry-white-space-chars)


(easy-mmode-define-minor-mode
 hungry
 "Toggle the hungry-mode.
No argument toggles the mode. 
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

When `hungry-mode' is t, the control delete key
gobbles all preceding whitespace except the last, 
see the 'hungry-electric-delete' doc, in one fell swoop."
 nil
 " hungry"
 '(([C-backspace] . hungry-electric-delete)
   ([C-M-delete] .
    (lambda () 
      (interactive)
      (hungry-electric-delete t))))) 


(defun hungry-electric-delete (&optional arg)
  "Electric delete.
When deleting a *non* white space character, acts as 
the `hungry-delete-function'. Default is to call
`backward-delete-char-untabify'.

A white space character is a character defined by `hungry-white-space-chars'.

When deleting a white space character, acts as follow:
With arg, delete all previous whitespaces.
With no arg, delete all previous whitespaces except the last.
  Replace the last white char by `hungry-replace-last-white' if non nil."
  (interactive "P")
  (let ((here (point))
	(distance (skip-chars-backward hungry-white-space-chars)))
    (if (< distance 0)
	(cond ((and (not arg)
		    hungry-last-white-char
		    (char-or-string-p hungry-last-white-char))
	       (delete-region (point) here)
	       (insert hungry-last-white-char))
	      (t 
	       (delete-region (if arg
				  (point) 
				(goto-char (1+ (point))))
			      here)))
      (funcall hungry-delete-function 1))))

(provide 'hungry)
;;; hungry.el ends here
