(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node")

(use-package company-tern
  :ensure t
  :init
  (add-to-list 'company-backends 'company-tern))

(use-package tern
  :ensure t
  :defer t
  :diminish tern-mode
  :config
  (progn
    (add-hook 'js2-mode-hook 'tern-mode)))

(provide 'my-javascript)
