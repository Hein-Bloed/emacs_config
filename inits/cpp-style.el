;;; cpp-stype.el --- provides my default c++ stype   -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author:  <lukas@GentooPad>
;; Keywords: languages, tools

;;; Commentary:

;;; Code:

(c-add-style "my-cpp-style"
             '("stroustrup"
               (indent-tabs-mode . nil)        ; use spaces rather than tabs
               (c-basic-offset . 4)          ; indent by four spaces
               (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
                                   (brace-list-open . 0)
                                   (statement-case-open . +)
                                   (innamespace . [0])))))

(add-hook 'c++-mode-hook (lambda ()
                           (c-set-style "my-cpp-style")))

;;; cpp-stype.el ends here
