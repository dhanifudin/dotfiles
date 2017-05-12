(set-default-font "Fantasque Sans Mono 12")

(global-hl-line-mode t)
(show-paren-mode 1)
(visual-line-mode 1)

(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(use-package all-the-icons
  :ensure t
  :config
  (progn
    (use-package all-the-icons-dired
      :ensure t)))

;; (use-package gruvbox-theme
;;   :ensure t)

;; (use-package zenburn-theme
;;   :ensure t)

(use-package leuven-theme
  :ensure t
  :config
  (progn
    (load-theme 'leuven t)))

(use-package telephone-line
  :ensure t
  :config
  (progn
    (setq telephone-line-lhs
      '((evil . (telephone-line-evil-tag-segment))
         (accent . (telephone-line-vc-segment telephone-line-process-segment))
         (nil . (telephone-line-buffer-segment))))
    (setq telephone-line-rhs
      '((nil . (telephone-line-misc-info-segment))
         (accent . (telephone-line-major-mode-segment))
         (evil . (telephone-line-airline-position-segment))))
    (telephone-line-mode t)))

(provide 'my-eyecandy)
