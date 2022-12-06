#!emacs --script

;;; day03_1.el --- Day 3 Puzzle 1 of Advent of Code 2022
;; Copyright (C) 2022-present Curtis Hollibaugh
;; Author: Curtis Hollibaugh <curtis.hollibaugh@protonmail.ch>
;; Package-Requires: (dash)

;;; Commentary:
;; For this puzzle, we map each line to its priority and sum them up.
;; To find the priority of a line, we split it in half and find the first element in both halves.
;; We find the first element in both halves by looping through the characters in the first half
;; and checking if the second half contains each character.

;;; Code:

(package-initialize)
(require 'dash)
(load-file "common.el")

(defun split-in-half (line)
  "Split the given string LINE in half and return the halves."
  (let ((len (length line)) (halfway (/ (length line) 2)))
    (cons (substring line 0 halfway) (substring line halfway len))))

(defun common-element (first-half second-half)
  "Find the item that is common to both FIRST-HALF and SECOND-HALF."
  (let ((first-chars (string-to-list first-half)) (second-chars (string-to-list second-half)))
    (char-to-string (-first (lambda (c) (-contains? second-chars c)) first-chars))))

(defun get-priority (item)
  "Get the priority of the given item ITEM."
  (let ((c (string-to-char item)))
    (cond
     ((> c 95) (- c 96))
     (t (- c 38)))))

(defun calc-priority (line)
  "Calculate the priority of the given line LINE."
  (let ((halves (split-in-half line)))
    (get-priority (common-element (car halves) (cdr halves)))))

(defun day3 ()
  "Run the solution on the day 3 input."
  (-sum (-map
	 (lambda (line) (calc-priority line))
	 (-filter
	  (lambda (line) (not (string-empty-p line)))
	  (lines (file-as-string "day03_input"))))))

(message (number-to-string (day3)))

(provide 'day03_1)
;;; day03_1.el ends here
