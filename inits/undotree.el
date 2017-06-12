;;;undotree.el

(use-package undo-tree
  :ensure t
  :defer t
  :config

  (custom-set-variables
   '(undo-tree-history-directory-alist
	 (quote (("." . "~/.emacs.d/undo/")))))

  (evil-leader/set-key
	"u" 'undo-tree-visualize))



;;;undotree.el ends here
