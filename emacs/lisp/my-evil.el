(use-package evil
  :ensure t
  :config
  (progn
    (evil-mode 1)

    (defun artist-mode-toggle-emacs-state ()
      (if artist-mode
        (evil-emacs-state)
        (evil-exit-emacs-state)))

    (unless (string= evil-state "emacs")
      (add-hook 'artist-mode-hook #'artist-mode-toggle-emacs-state))))
    ;; (add-hook 'artist-mode-hook #'evil-normalize-keymaps)))

(use-package evil-commentary
  :ensure t
  :config
  (progn
    (evil-commentary-mode 1)))

(use-package evil-matchit
  :ensure t
  :config
  (progn
    (global-evil-matchit-mode 1)))

(use-package evil-surround
  :ensure t
  :config
  (progn
    (global-evil-surround-mode 1)))

(provide 'my-evil)
