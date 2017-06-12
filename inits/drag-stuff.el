(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  :bind(("M-<up>" . drag-stuff-up)
	("M-<down>" . drag-stuff-down)))
