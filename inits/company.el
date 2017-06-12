;;;complany.el

(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-auto-complete nil)
  (setq company-require-match nil)
  :config
  (delete 'company-dabbrev company-backends)
  (delete 'company-clang company-backends)
  (delete 'company-bbdb company-backends)
  (delete 'company-css company-backends)
  (delete 'company-semantic company-backends))

;;;company.el ends here
