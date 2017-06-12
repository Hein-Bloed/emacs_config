;;;neotree.el

(use-package neotree
  :ensure t
  :config

  (global-set-key [f8] 'neotree-toggle)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
  (use-package	all-the-icons
	:ensure t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

(provide 'neotree)
;;; neotree.el ends here
