;; Minimal load file for literate programming configuration
(defvar root-dir
  (file-name-directory (or (buffer-file-name)
                           load-file-name))
  "Root directory of Emacs configuration (usually ~/.emacs.d/.")

(defvar core-file
  (expand-file-name "README.org" root-dir)
  "Main configuration file.")

(require 'org)
(require 'ob-tangle)

(org-babel-load-file core-file)
