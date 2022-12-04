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

(defun range-contains (range-a range-b)
  "Check if RANGE-A completely contains RANGE-B."
  (and (<= (car range-a) (car range-b)) (>= (cadr range-a) (cadr range-b))))

(defun is-target-pair (pair)
  "Check whether the given PAIR has one assignment contained by the other."
  (or (range-contains (car pair) (cadr pair)) (range-contains (cadr pair) (car pair))))

(defun day4 ()
  (-count
	 (lambda (pair) (is-target-pair pair))
	 (-map
	  (lambda (line) (to-pair line))
	  (-filter
	   (lambda (line) (not (string-empty-p line)))
	   (lines (file-as-string "day04_input"))))))

(message (number-to-string (day4)))
