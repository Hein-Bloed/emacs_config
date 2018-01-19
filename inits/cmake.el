;;; cmake.el --- packages for cmake                -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author:  <lukas@GentooPad>
;; Keywords: languages, tools

;;; Commentary:

;;; Code:
(use-package cmake-mode
  :mode (("/CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode))
  :ensure t)

;;TODO: get rid of cmake-ide
(use-package cmake-ide
  :ensure t
  :config

  (evil-leader/set-key
    "cir" 'cmake-ide-run-cmake)

  (add-hook 'c++-mode-hook
            (lambda()
              (local-set-key (kbd "<f9>")  'compileFunc))))

;;custom compile function
(defun compileFunc ()
  "Prompt user to enter a file name, with completion and history support."
  (interactive)
  (let ((x (read-string "Enter compile target:")))
    (setq cmake-ide-compile-command
          (concat "make --directory=" cmake-ide-build-dir " " x))
    (cmake-ide-compile)))

;;compilation buffer should be vertical
(defadvice compile (around split-horizontally activate)
  "This takes care that new compilation buffers is verticaly."
  (let ((split-width-threshold nil)
        (split-height-threshold 10)
        (compilation-window-height 15))
    ad-do-it))

;;; cmake.el ends here
