(use-package meghanada
  :ensure t
  :config
  (progn
    (add-hook 'java-mode-hook
      (lambda ()
        (meghanada-mode t)
        (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
    ))

(provide 'my-java)
