#!emacs --script

(package-initialize)
(require 'dash)

(defun file-as-string (filename)
  (let ((buffer (find-file-noselect filename)))
    (set-buffer buffer)
    (buffer-string)))

(defun lines (s) (split-string s "\n"))

(defun split-in-half (line)
  (let ((len (length line)) (halfway (/ (length line) 2)))
    (cons (substring line 0 halfway) (substring line halfway len))))

(defun common-element (first-half second-half)
  (let ((first-chars (string-to-list first-half)) (second-chars (string-to-list second-half)))
    (char-to-string (-first (lambda (c) (-contains? second-chars c)) first-chars))))

(defun get-priority (item)
  (let ((c (string-to-char item)))
    (cond
     ((> c 95) (- c 96))
     (t (- c 38)))))

(defun calc-priority (line)
  (let ((halves (split-in-half line)))
    (get-priority (common-element (car halves) (cdr halves)))))

(defun day3 ()
  (-sum (-map
	 (lambda (line) (calc-priority line))
	 (-filter
	  (lambda (line) (not (string-empty-p line)))
	  (lines (file-as-string "day03_input"))))))

(message (number-to-string (day3)))
