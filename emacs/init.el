(setq debug-on-error t)

;; (setenv "PATH" (concat (getenv "PATH") ":/Users/dhanifudin/.node/bin"))
;; (setq exec-path (append exec-path '("/Users/dhanifudin/.node/bin")))

;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
;; (setq exec-path (append exec-path '("/usr/local/bin")))

;; (setenv "PATH" (concat (getenv "PATH") ":/Library/Tex/texbin"))
;; (setq exec-path (append exec-path '("/Library/Tex/texbin")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/languages" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(setq package-archives
  '(("melpa" . "http://melpa.org/packages/")
     ("org" . "http://orgmode.org/elpa/")))

(require 'package)
(package-initialize)

(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(require 'my-core)
(require 'my-eyecandy)
(require 'my-evil)
(require 'my-navigation)
(require 'my-completion)

(require 'my-java)
(require 'my-javascript)
(require 'my-json)
(require 'my-less)
(require 'my-org)
(require 'my-typescript)
(require 'my-web)
