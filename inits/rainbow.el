;;this is retarded!
;; (use-package rainbow-identifiers
  ;; :ensure t
  ;; :init
  ;; (add-hook 'prog-mode-hook 'rainbow-identifiers-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
