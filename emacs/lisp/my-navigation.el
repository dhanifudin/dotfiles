(use-package dired
  :config
  (require 'dired-x)
  (setq dired-omit-files
    (concat dired-omit-files "\\|^\\..+$"))

  (add-hook 'dired-mode-hook
    (lambda ()
      (setq dired-omit-mode t)))


  (define-key evil-normal-state-map (kbd "-") 'dired-jump)
  (evil-define-key 'normal dired-mode-map "-" 'my-dired-up-directory)
  (evil-define-key 'normal dired-mode-map "h" 'my-dired-up-directory)
  (evil-define-key 'normal dired-mode-map "l" 'dired-find-file)
  (evil-define-key 'normal dired-mode-map "d" 'dired-create-directory)
  (evil-define-key 'normal dired-mode-map "%" 'dired-create-files)
  (evil-define-key 'normal dired-mode-map "/" 'evil-search-forward)
  (evil-define-key 'normal dired-mode-map "?" 'evil-search-backward)
  (evil-define-key 'normal dired-mode-map "n" 'evil-search-next)
  (evil-define-key 'normal dired-mode-map "N" 'evil-search-previous)
  (evil-define-key 'normal dired-mode-map "q" 'kill-this-buffer)

  (defun my-dired-up-directory ()
    "Take dired up one directory, but behave like dired-find-alternate-file"
    (interactive)
    (let ((old (current-buffer)))
      (dired-up-directory)
      (kill-buffer old))))

(use-package neotree
  :ensure t
  :config
  (progn
    (setq neo-theme (if (display-graphic-p) 'nerd 'arrow))
    (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)))

(use-package projectile
  :ensure t
  ;; :init
  ;; (setq projectile-keymap-prefix (kbd "s-!")
  ;;   projectile-mode-line '(:eval
  ;;                           (if
  ;;                             (file-remote-p default-directory)
  ;;                             "Projectile"
  ;;                             (format " Pj[%s]"
  ;;                               (projectile-project-name))))
  ;;   )
  :config
  (projectile-global-mode))

(provide 'my-navigation)
