;;;python.el

(use-package python
  :ensure t
  :defer t
  :commands python-mode
  :init
  (add-hook 'python-mode-hook 'flycheck-mode))

(use-package anaconda-mode
  :after python
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'eldoc-mode))
  (setq anaconda-mode-eldoc-as-single-line t))

(use-package company-anaconda
  :after anaconda-mode
  :ensure t
  :defer t
  :init (add-to-list 'company-backends 'company-anaconda))


;;;python.el ends here
