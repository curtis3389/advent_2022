#!emacs --script

(package-initialize)
(require 'dash)

(setq result (let ((buffer (find-file-noselect "day01_input")))
  (set-buffer buffer)
  (-max (-map
	 (lambda (sublist) (-sum (-map 'string-to-number sublist)))
	 (-split-on "" (split-string (buffer-string) "\n"))))))
(message (number-to-string result))
