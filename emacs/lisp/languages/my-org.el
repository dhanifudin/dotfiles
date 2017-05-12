(use-package org
  :ensure org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  :config
  (progn
    (require 'ob-ditaa)
    (require 'ob-plantuml)

    (defun my-org-confirm-babel-evaluate (lang body)
      (not (member lang '("ditaa" "plantuml"))))

    (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

    (add-hook 'org-mode-hook
      (lambda ()
        (org-indent-mode t)))
    (add-hook 'org-mode-hook
      (lambda nil (load-theme-buffer-local 'leuven (current-buffer))))))

(setq org-ditaa-jar-path (expand-file-name "~/.java/ditaa.jar"))
(setq org-plantuml-jar-path (expand-file-name "~/.java/plantuml.jar"))

(org-babel-do-load-languages
  'org-babel-do-load-languages
  '((ditaa . t)
     (plantuml . t)))

(use-package plantuml-mode
  :ensure t
  :config
  (add-to-list
    'org-src-lang-modes '("plantuml" . plantuml)))

(use-package htmlize
  :ensure t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook
    (lambda ()
      (org-bullets-mode t))))

(provide 'my-org)
