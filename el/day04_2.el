#!emacs --script

(package-initialize)
(require 'dash)

(defun file-as-string (filename)
  (let ((buffer (find-file-noselect filename)))
    (set-buffer buffer)
    (buffer-string)))

(defun lines (s) (split-string s "\n"))

(defun to-pair (line)
  "Convert the given LINE to a pair of pairs of numbers."
  (-map
   (lambda (half) (-map
		   'string-to-number
		   (split-string half "-")))
   (split-string line ",")))

(defun range-contains (range value)
  "Check if RANGE contain VALUE."
  (and (<= (car range) value) (>= (cadr range) value)))

(defun range-overlaps (range-a range-b)
  "Check if RANGE-A overlaps with RANGE-B."
  (or
   (range-contains range-a (car range-b))
   (range-contains range-a (cadr range-b))
   (range-contains range-b (car range-a))
   (range-contains range-b (cadr range-a))))

(defun is-target-pair (pair)
  "Check whether the given PAIR has one assignment contained by the other."
  (range-overlaps (car pair) (cadr pair)))

(defun day4 ()
  (-count
	 (lambda (pair) (is-target-pair pair))
	 (-map
	  (lambda (line) (to-pair line))
	  (-filter
	   (lambda (line) (not (string-empty-p line)))
	   (lines (file-as-string "day04_input"))))))

(message (number-to-string (day4)))
