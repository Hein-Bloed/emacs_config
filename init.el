;;; init.el ---



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar local-dir user-emacs-directory
  "The root dir of the Emacs configuration.")

(defun local-file-name (file-name)
  (let* ((file-path (expand-file-name file-name local-dir))
         (parent-dir (file-name-directory file-path)))
    (unless (or (not parent-dir)
                (file-exists-p parent-dir))
      (make-directory parent-dir))
    file-path))

(setq load-prefer-newer t)

;;load core
(load (local-file-name "core/core-packages"))
(load (local-file-name "core/core-env"))

(load (local-file-name "inits/evil.el"))
(load (local-file-name "inits/helm.el"))

;;load the rest of this motherfucker
(load (local-file-name "inits/ui-config"))
(load (local-file-name "inits/drag-stuff.el"))
;(load (local-file-name "inits/functions"))
(load (local-file-name "inits/hideshow.el"))
(load (local-file-name "inits/which-key.el"))
(load (local-file-name "inits/flycheck"))
(load (local-file-name "inits/yasnippet"))
(load (local-file-name "inits/company"))
(load (local-file-name "inits/projectile"))
(load (local-file-name "inits/magit"))
(load (local-file-name "inits/cpp"))
;(load (local-file-name "inits/pdftools.el"))
(load (local-file-name "inits/elisp"))
;(load (local-file-name "inits/haskell"))
(load (local-file-name "inits/neotree"))
(load (local-file-name "inits/python"))
(load (local-file-name "inits/config"))
(load (local-file-name "inits/undotree"))
(load (local-file-name "inits/rainbow.el"))
(load (local-file-name "inits/smartparens.el"))


;;custom.el bullshit
(setq custom-file (local-file-name "custom.el"))
(load custom-file t)


;;; init.el ends here
