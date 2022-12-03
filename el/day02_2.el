#!emacs --script

(package-initialize)
(require 'dash)

(defun file-as-string (filename)
  (let ((buffer (find-file-noselect filename)))
    (set-buffer buffer)
    (buffer-string)))

(defun lines (s) (split-string s "\n"))

(defun shape-wins (them us)
  (cond
   ((and (string-equal them "A") (string-equal us "Y")) t)
   ((and (string-equal them "B") (string-equal us "Z")) t)
   ((and (string-equal them "C") (string-equal us "X")) t)
   (t ())))

(defun shape-score (shape)
  (cond
   ((string-equal shape "A") 1)
   ((string-equal shape "B") 2)
   ((string-equal shape "C") 3)
   ((string-equal shape "X") 1)
   ((string-equal shape "Y") 2)
   ((string-equal shape "Z") 3)
   (t 0)))

(defun defeats (shape)
  (cond
   ((string-equal shape "A") "B")
   ((string-equal shape "B") "C")
   ((string-equal shape "C") "A")))

(defun defeated-by (shape)
  (cond
   ((string-equal shape "A") "C")
   ((string-equal shape "B") "A")
   ((string-equal shape "C") "B")))

(defun select-shape (them outcome)
  (cond
   ((string-equal outcome "X") (defeated-by them))
   ((string-equal outcome "Y") them)
   ((string-equal outcome "Z") (defeats them))))

(defun outcome-score (outcome)
  (cond
     ((string-equal outcome "Z") 6)
     ((string-equal outcome "Y") 3)
     (t 0)))

(defun calc-score (them outcome)
  (+ (shape-score (select-shape them outcome)) (outcome-score outcome)))

(defun day2 ()
  (-sum (-map
	 (lambda (pair) (calc-score (car pair) (car (cdr pair))))
	 (-map
	  (lambda (line) (split-string line " "))
	  (-filter
	   (lambda (line) (not (string-empty-p line)))
	   (lines (file-as-string "day02_input")))))))

(message (number-to-string (day2)))
