;;;projectile.el

(use-package projectile
  :ensure t
  :defer t
  :diminish projectile-mode
  :config

  (setq projectile-completion-system 'helm
		projectile-create-missing-test-files t
		projectile-switch-project-action #'projectile-commander)

  (projectile-global-mode)

  (evil-leader/set-key
	"pp"    'projectile-switch-project
	"pf"    'projectile-find-file
	"pa"    'projectile-find-other-file
	"pc"    'projectile-compile-project))


(use-package helm-projectile
  :ensure t
  :defer t
  :init (progn
          (helm-projectile-on)
          (setq helm-for-files-preferred-list
                '(helm-source-buffers-list
                  helm-source-projectile-files-list
                  helm-source-recentf
                  helm-source-bookmarks
                  helm-source-file-cache
                  helm-source-files-in-current-dir
                  helm-source-locate))))


;;;projectile.el ends here
