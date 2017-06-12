;;;magit.el


(use-package magit
  :ensure t
  :commands magit-status
  :config
  (setq async-bytecomp-allowed-packages nil)

  :init
  (evil-leader/set-key
	"gs"    'magit-status
	"gp"    'magit-push))

(use-package magithub
  :defer t
  :ensure t)

;;magit.el ends here
