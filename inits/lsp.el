;;; lsp.el --- provides packages for working with the language server protocol  -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author:  <lukas@GentooPad>
;; Keywords: languages, tools

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

;;

;;; Code:

(use-package lsp-mode
  :ensure t)

(use-package company-lsp
  :ensure t
  :after company lsp-mode
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-cache-candidates nil)
  (setq company-lsp-async t)
  (setq company-lsp-enable-snippet t))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-sideline-show-symbol t)
  (setq lsp-ui-sideline-enable t))

;;; lsp.el ends here
