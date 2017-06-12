;;; haskell.el

(use-package haskell-mode
  :mode (("\\.hs\\(c\\|-boot\\)?\\'" . haskell-mode)
         ("\\.lhs\\'" . literate-haskell-mode)
         ("\\.cabal\\'" . haskell-cabal-mode))
  :ensure t
  :preface
  (defvar interactive-haskell-mode-map)
  (defun snippet (name)
    (interactive "sName: ")
    (find-file (expand-file-name (concat name ".hs") "~/src/notes"))
    (haskell-mode)
    (goto-char (point-min))
    (when (eobp)
      (insert "hdr")
      (yas-expand)))


  (defun insert-scc-at-point ()
    "Insert an SCC annotation at point."
    (interactive)
    (if (or (looking-at "\\b\\|[ \t]\\|$") (and (not (bolp))
                                                (save-excursion
                                                  (forward-char -1)
                                                  (looking-at "\\b\\|[ \t]"))))
        (let ((space-at-point (looking-at "[ \t]")))
          (unless (and (not (bolp)) (save-excursion
                                      (forward-char -1)
                                      (looking-at "[ \t]")))
            (insert " "))
          (insert "{-# SCC \"\" #-}")
          (unless space-at-point
            (insert " "))
          (forward-char (if space-at-point -5 -6)))
      (error "Not over an area of whitespace")))

  (defun kill-scc-at-point ()
    "Kill the SCC annotation at point."
    (interactive)
    (save-excursion
      (let ((old-point (point))
            (scc "\\({-#[ \t]*SCC \"[^\"]*\"[ \t]*#-}\\)[ \t]*"))
        (while (not (or (looking-at scc) (bolp)))
          (forward-char -1))
        (if (and (looking-at scc)
                 (<= (match-beginning 1) old-point)
                 (> (match-end 1) old-point))
            (kill-region (match-beginning 0) (match-end 0))
          (error "No SCC at point")))))

  (defvar haskell-prettify-symbols-alist
    '(("::"     . ?∷)
      ("forall" . ?∀)
      ("exists" . ?∃)
      ("->"     . ?→)
      ("<-"     . ?←)
      ("=>"     . ?⇒)
      ("~>"     . ?⇝)
      ("<~"     . ?⇜)
      ("."      . ?∘)
      ("<>"     . ?⨂)
      ("msum"   . ?⨁)
      ("\\"     . ?λ)
      ("not"    . ?¬)
      ("&&"     . ?∧)
      ("||"     . ?∨)
      ("/="     . ?≠)
      ("<="     . ?≤)
      (">="     . ?≥)
      ("<<<"    . ?⋘)
      (">>>"    . ?⋙)

      ("`elem`"             . ?∈)
      ("`notElem`"          . ?∉)
      ("`member`"           . ?∈)
      ("`notMember`"        . ?∉)
      ("`union`"            . ?∪)
      ("`intersection`"     . ?∩)
      ("`isSubsetOf`"       . ?⊆)
      ("`isProperSubsetOf`" . ?⊂)
      ("undefined"          . ?⊥)))

  :config
  (require 'haskell-font-lock)

  (bind-key "C-c C-u" (lambda () (interactive) (insert "undefined")) haskell-mode-map)

  (unbind-key "M-s" haskell-mode-map)
  (unbind-key "M-t" haskell-mode-map)


  (defun my-haskell-mode-hook ()
    (haskell-indentation-mode)
    (interactive-haskell-mode)
    (unbind-key "C-c c" interactive-haskell-mode-map)
    (flycheck-mode)
    (setq-local prettify-symbols-alist haskell-prettify-symbols-alist)
    (prettify-symbols-mode))
  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

  (use-package flycheck-haskell
    :config
    (flycheck-haskell-setup))

  (use-package haskell-edit
    :config (bind-key "C-c M-q" #'haskell-edit-reformat haskell-mode-map)))

(provide 'haskell)
;;; haskell.el ends here
