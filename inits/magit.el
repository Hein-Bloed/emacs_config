;;; magit.el --- provides the magit package          -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author: ;;;magit.el <lukas@GentooPad>
;; Keywords: tools, languages

;;; Commentary:
;; this file adds the magit package to my Emacs config
;;; Code:


(use-package magit
  :ensure t
  :commands magit-status
  :config
  (setq async-bytecomp-allowed-packages nil)

  :init
  (evil-leader/set-key
	"gs"    'magit-status
	"gp"    'magit-push))

(provide 'magit)
;;; magit.el ends here
