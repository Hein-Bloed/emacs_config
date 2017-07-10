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
  (defun indent-buffer ()
    "Indent an entire buffer using the default intenting scheme."
    (interactive)
  (point-to-register 'o)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (jump-to-register 'o))

    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      
      ;;windows(the good type of windows)
      "wd"    'delete-window
      "wh"    'split-window-horizontally
      "wv"    'split-window-vertically
      "ww"    'other-window
	  "wo"    'delete-other-windows

      ;;files
      "fs"    'save-buffer
      "ff"    'helm-find-files
      "fd"    'dired

      ;;shit
      "cc"    'comment-line
	  "TAB"    'indent-buffer

      ;;exit emacs
      "qq"    'save-buffers-kill-terminal
	  
      ;; buffers
      "bx"    'eval-buffer
      "bf"    'switch-to-buffer
      "bd"    'kill-this-buffer


)))
