(use-package tide
             :ensure t
             :mode ("\\.ts\\'" . typescript-mode)
             :config
             (add-hook 'typescript-mode-hook
                       (lambda ()
                         (tide-setup)
                         (company-mode on)
                         (add-hook 'before-save-hook 'tide-format-before-save nil t))
                       ))

(provide 'my-typescript)
