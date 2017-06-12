;;; pdftools.el --- this file enusres that pdf tools are installed in emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2017

;; Author:  <lukas@GentooPad>
;; Keywords: internal, multimedia

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

;; bla bla bla
;;; Code:

(use-package pdf-tools
  :ensure t
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :config
  (setq-default pdf-view-display-size 'fit-page)
  (pdf-tools-install))


(provide 'pdftools)
;;; pdftools.el ends here
