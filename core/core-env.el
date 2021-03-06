;;; core-env.el ---


;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; ensure environment variables inside Emacs look the same as in the user's shell.
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(defmacro when-osx (&rest body)
  (declare (indent 1) (debug t))
  (list 'if (eq system-type 'darwin) (cons 'progn body)))


;;; core-env.el ends here
