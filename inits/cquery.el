;;; cquery.el --- lsp mode for equery                -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author:  <lukas@GentooPad>
;; Keywords: languages, tools

;;; Commentary:

;;; Code:

(use-package cquery
  :load-path
  "/home/lukas/emacs-cquery/"
  :config
  (setq cquery-executable "/home/lukas/Binarys/cquery")
  (add-hook 'c-mode-hook 'lsp-cquery-enable)
  (add-hook 'c++-mode-hook 'lsp-cquery-enable))


;;; cquery.el ends here
