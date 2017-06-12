;;;flycheck.el

(use-package flycheck
  :ensure t
  :defer t
  :config (add-hook 'after-init-hook #'global-flycheck-mode))


;;;flycheck.el ends here
