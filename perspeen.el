;;; perspeen.el --- An Emacs package for multi-workspace  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Peng Li

;; Author: Peng Li <seudut@gmail.com>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package intend to combine perspective and elscreen, make each perspective
;; has its elscreen tab. To make it's much convenient to work multi-workspace at
;; the same time.

;;; Code:

(defvar perspeen-mode-map (make-sparse-keymap)
  "Keymap for perspeen-mode.")

(make-variable-frame-local
 (defvar perspeen-modestring nil
   "The string displayed in the modeline representing the perspeen-mode."))

(put 'persp-modestring 'risky-local-variable t)

(make-variable-frame-local
 (defvar perspeen-ws-hash nil
   "The hash storing all workspace in current frame "))


(cl-defstruct (perspeen-ws-struct
	       )
  name)

;;;###autoload
(define-minor-mode perspeen-mode
  "perspeen mode"
  :global t
  :keymap perspeen-mode-map
  (if perspeen-mode
      (progn
  	(setq perspeen-ws-hash (make-hash-table :test 'equal :size 10))
	(setq global-mode-string (or global-mode-string '("")))
	(let ((new-ws (make-perspeen-ws-struct :name "first")))
	  (puthash (perspeen-ws-struct-name new-ws) new-ws perspeen-ws-hash))
	(setq perspeen-modestring "first")
	(unless (memq 'perspeen-modestring global-mode-string)
	  (setq global-mode-string (append global-mode-string '(perspeen-modestring))))
	(run-hooks 'perspeen-mode-hook)
	
  	)
    (setq global-mode-string (delq 'perspeen-modestring global-mode-string))
    (setq perspeen-ws-hash nil)))
(provide 'perspeen)
;;; perspeen.el ends here