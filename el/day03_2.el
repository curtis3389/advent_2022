#!emacs --script

(package-initialize)
(require 'dash)

(defun file-as-string (filename)
  (let ((buffer (find-file-noselect filename)))
    (set-buffer buffer)
    (buffer-string)))

(defun lines (s) (split-string s "\n"))

(defun common-element (group)
  (let ((chars (-map 'string-to-list group)))
    (char-to-string (-first
     (lambda (c) (-all? (lambda (chars) (-contains? chars c)) (cdr chars)))
     (car chars)))))

(defun get-priority (item)
  (let ((c (string-to-char item)))
    (cond
     ((> c 95) (- c 96))
     (t (- c 38)))))

(defun calc-priority (group)
  (get-priority (common-element group)))

(defun day3 ()
  (-sum (-map
	 (lambda (group) (calc-priority group))
	 (-partition-all
	  3
	  (-filter
	   (lambda (line) (not (string-empty-p line)))
	   (lines (file-as-string "day03_input")))))))

(message (number-to-string (day3)))
