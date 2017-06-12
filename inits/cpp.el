;;;cpp.el
;;; Code:
   

  ;add pragma once to new added header files
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
   
;add my own c++ style
(c-add-style "my-cpp-style"
			 '("stroustrup"
			   (indent-tabs-mode . nil)        ; use spaces rather than tabs
			   (c-basic-offset . 4)          ; indent by four spaces
			   (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
								   (brace-list-open . 0)
								   (statement-case-open . +)
								   (innamespace . [0])))))


(use-package irony
  :ensure t
  :defer t
  :preface
    ;add own hook function
   (defun my-irony-mode-hook ()
	 "This is my irony mode hook."
	 (c-set-style "my-cpp-style"); adjust style
     (define-key irony-mode-map [remap completion-at-point]
	   'irony-completion-at-point-async)
	 (define-key irony-mode-map [remap complete-symbol]
	   'irony-completion-at-point-async))
  :config
	;add some hooks to c/c++-modes
    (add-hook 'irony-mode-hook 'electric-pair-mode)
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands))

	;install company-irony
(use-package company-irony
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony))

	;install this for header completion
(use-package company-irony-c-headers
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony-c-headers))

;;add this for on the fly code checking
(use-package flycheck-irony
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

;;install rtags to enable jumping arround in c++ code/projects
(use-package rtags
  :ensure t
  :config
  (evil-leader/set-key
	"rtr" 'rtags-rename-symbol))

 ;install cmake-ide for setting up rtags
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
	  

;this takes care that new compilation buffers is verticaly
(defadvice compile (around split-horizontally activate)
  "This takes care that new compilation buffers is verticaly."
  (let ((split-width-threshold nil)
        (split-height-threshold 10)
		(compilation-window-height 15))
    ad-do-it))

;;;cpp.el ends here
