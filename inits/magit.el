;;;magit.el


(use-package magit
  :ensure t
  :commands magit-status
  :config

  (setq async-bytecomp-allowed-packages nil)
  
  (evil-leader/set-key
	"ms"    'magit-status))

(use-package magithub
  :defer t
  :ensure t)

;;magit.el ends here
