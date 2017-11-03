;;;cpp.el
;;; Code:


(define-auto-insert
  (cons "\\.\\([Hh]\\|hh\\|hpp\\)\\'" "My C / C++ header")
  '(nil
    "// " (file-name-nondirectory buffer-file-name) "\n"
    "//\n"
    "// last-edit-by: <>\n"
    "//\n"
    "// Description:\n"
    "// TODO:\n"
    "//\n"
    (make-string 70 ?/) "\n\n"
    "#pragma once\n\n"))

(define-auto-insert
  (cons "\\.\\([cC]\\|cc\\|c\\|cpp\\)\\'" "My C / C++ Source File")
  '(nil
    "// " (file-name-nondirectory buffer-file-name) "\n"
    "//\n"
    "// last-edit-by: <>\n"
    "//\n"
    "// Description:\n"
    "// TODO:\n"
    "//\n"
    (make-string 70 ?/) "\n\n"))

(defun my-doxygen-return ()
  "Advanced for Javadoc multiline comments.
Inserts `*' at the beggining of the new line if
unless return was pressed outside the comment"
  (interactive)
  (setq last (point))
  (setq is-inside
        (if (search-backward "*/" nil t)
            ;; there are some comment endings - search forward
            (search-forward "/*" last t)
          ;; it's the only comment - search backward
          (goto-char last)
          (search-backward "/*" nil t)
          )
        )
  ;; go to last char position
  (goto-char last)
  ;; the point is inside some comment, insert `* '
  (if is-inside
      (progn
        (insert "\n* ")
        (indent-for-tab-command))
    ;; else insert only new-line
    (newline-and-indent)))

(defun delete-ws-forward ()
  (interactive)
  (delete-region (point)
                 (progn
                   (while (or (equal (char-after) ? )
                              (eolp))
                     (forward-char))
                   (point))))

(defun delete-ws-backward ()
  (interactive)
  (delete-region (point)
                 (progn
                   (while (or (equal (char-before) ? )
                              (eolp))
                     (backward-char))
                   (point))))

(defun my-super-return ()
  "My super return check for c like languages.
if we are in an sexp and dont have a , before the cursor
we delete ws before and after the cursor and then jump out of the sexp
if not we just trigger my-doxygen-return"
  (interactive)
  (progn
    (if (and
         (looking-at-p "[[:space:]]*[)>]")
         (not
          (looking-back ",[[:space:]]*")))
        (progn
          (delete-ws-forward)
          (delete-ws-backward)
          (sp-up-sexp))
      (my-doxygen-return))))

(c-add-style "my-cpp-style"
             '("stroustrup"
               (indent-tabs-mode . nil)        ; use spaces rather than tabs
               (c-basic-offset . 4)          ; indent by four spaces
               (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
                                   (brace-list-open . 0)
                                   (statement-case-open . +)
                                   (innamespace . [0])))))

(use-package cmake-mode
  :mode (("/CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode))
  :ensure t
  :defer t)

;; (use-package irony
;;   :ensure t
;;   :defer t
;;   :preface
;;                                         ;add own hook function
;;   (defun my-irony-mode-hook ()
;;     "This is my irony mode hook."
;;     (c-set-style "my-cpp-style"); adjust style
;;     (define-key irony-mode-map [remap completion-at-point]
;;       'irony-completion-at-point-async)
;;     (define-key irony-mode-map [remap complete-symbol]
;;       'irony-completion-at-point-async))
;;   :config
;;                                         ;add some hooks to c/c++-modes
;;   (add-hook 'irony-mode-hook 'electric-pair-mode)
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;   (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;;   (add-hook 'irony-mode-hook (lambda ()
;;                                (local-set-key (kbd "<RET>") 'my-super-return))))
(use-package rtags
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'electric-pair-mode)

  (add-hook 'c++-mode-hook (lambda ()
                             (c-set-style "my-cpp-style")))
  (add-hook 'c++-mode-hook (lambda ()
                             (local-set-key (kbd "<RET>") 'my-super-return)))
  (evil-leader/set-key
    "rtr" 'rtags-rename-symbol
    "ri"  'rtags-symbol-info))

(use-package company-rtags
  :ensure t
  :config
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)
  (add-to-list 'company-backends 'company-rtags))

(use-package company-irony-c-headers
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony-c-headers))

(use-package flycheck-rtags
  :ensure t
  :preface
  (defun my-flycheck-rtags-setup ()
    (flycheck-select-checker 'rtags)
    (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
    (setq-local flycheck-check-syntax-automatically nil))

  :config
  (add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
  (add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
  (add-hook 'objc-mode-hook #'my-flycheck-rtags-setup))


(use-package helm-rtags
  :ensure t
  :defer t)

(use-package cmake-ide
  :ensure t
  :config
  (cmake-ide-setup)

  (evil-leader/set-key
    "cir" 'cmake-ide-run-cmake)

  (defun compileFunc ()
    "Prompt user to enter a file name, with completion and history support."
    (interactive)
    (let ((x (read-string "Enter compile target:")))
      (setq cmake-ide-compile-command
            (concat "make --directory=" cmake-ide-build-dir " " x))
      (cmake-ide-compile)))

  (add-hook 'irony-mode-hook
            (lambda()
              (local-set-key (kbd "<f9>")  'compileFunc))))

(defadvice compile (around split-horizontally activate)
  "This takes care that new compilation buffers is verticaly."
  (let ((split-width-threshold nil)
        (split-height-threshold 10)
        (compilation-window-height 15))
    ad-do-it))

;;;cpp.el ends here
