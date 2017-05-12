(use-package web-mode
  :ensure t
  :init
  (setq web-mode-engines-alist
    '(("blade" . "\\.blade\\."))
    )
  (setq web-mode-extra-auto-pairs
    '(("php" . (("beg" "end")
                 ("beg" "end")))))
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode)))
  )

(provide 'my-web)
