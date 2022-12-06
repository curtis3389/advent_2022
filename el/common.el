;;; common.el --- Library of shared functions for Advent of Code 2022
;; Copyright (C) 2022-present Curtis Hollibaugh
;; Author: Curtis Hollibaugh <curtis.hollibaugh@protonmail.ch>

;;; Commentary:

;;; Code:

(defun file-as-string (filename)
  "Get the contents of the file with the given FILENAME as a string."
  (let ((buffer (find-file-noselect filename)))
    (set-buffer buffer)
    (buffer-string)))

(defun lines (s)
  "Get the lines in the given string S."
  (split-string s "\n"))

(provide 'common)
;;; common.el ends here
