(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))

(setq create-lockfiles nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(xterm-mouse-mode 1)

(auto-fill-mode 80)

(use-package exec-path-from-shell
  :ensure exec-path-from-shell
  :config
  (progn
    (when (memq window-system '(mac ns))
      (exec-path-from-shell-initialize))))

(use-package wakatime-mode
  :ensure t
  :config
  (global-wakatime-mode))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)))

(use-package load-theme-buffer-local
  :ensure t)

(provide 'my-core)
