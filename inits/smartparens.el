;;; smartparens.el --- provides smartparens support  -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author:  <lukas@GentooPad>
;; Keywords: extensions, languages, tools
;;; Commentary: this file provides smartparens mode

;;; Code:
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1))


(provide 'smartparens)
;;; smartparens.el ends here
