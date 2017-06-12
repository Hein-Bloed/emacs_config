(use-package evil                       ; Evil - VI for Emacs
  :ensure t
  :init
  (evil-mode 1)
  :config
  (setq evil-shift-width 2)
  (use-package linum-relative           ; Relative Line Numbers
    :ensure t
    :config
    (add-hook 'evil-insert-state-entry-hook 'linum-relative-toggle)
    (add-hook 'evil-insert-state-exit-hook 'linum-relative-toggle))
  (use-package evil-matchit             ; vi-% for more than {[""]}
    :ensure t
    :init
    (global-evil-matchit-mode 1))
  (use-package evil-nerd-commenter      ; Nerdcommenter for emacs
    :ensure t)
  (use-package evil-surround            ; Exactly like tpopes vim-surround
    :ensure t
    :init
    (global-evil-surround-mode))
  (use-package evil-leader              ; Leader key for evil
    :ensure t
    :init
    (global-evil-leader-mode)
    :config
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      
      ;;windows(the good type of windows)
      "wd"    'delete-window
      "wh"    'split-window-horizontally
      "wv"    'split-window-vertically
      "ww"    'other-window

      ;;files
      "fs"    'save-buffer
      "ff"    'helm-find-files
      "fd"    'dired

      ;;shit
      "cc"    'comment-line

      ;;exit emacs
      "qq"    'save-buffers-kill-terminal
	  
      ;; buffers
      "bx"    'eval-buffer
      "bf"    'switch-to-buffer
      "bd"    'kill-this-buffer
)))
