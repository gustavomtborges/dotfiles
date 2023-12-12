;;; init.el --- Emacs init file
;;; Commentary:
;;; Code:

;; Remove start screen
(setq inhibit-startup-message t)

;; Remove menus
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 1)

;; Packages
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 2.0 which-key-idle-secondary-delay 1.0)
  :config (which-key-mode))

;; Vim Mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(require 'key-chord)
(setq key-chord-two-keys-delay 0.3)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)


;; File Project Explorer
(use-package all-the-icons
  :if (display-graphic-p))

(use-package treemacs
  :ensure t
  :defer t
  :init
  :config
  (progn
    (setq treemacs-position 'right))
  :bind(:map global-map
	     ("s-\\" . treemacs-select-window)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (progn
    (setq projectile-project-search-path '("~/repos"))
    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))
  (projectile-mode +1))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)


;; Auto complete, error check
(use-package company
  :ensure t
  :hook (emacs-lisp-mode . company-mode))
(global-company-mode)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))


;; LSP
(use-package lsp-mode
  :init
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

(use-package hover
  :ensure t)

(use-package dap-mode
  :ensure t)

(use-package dart-mode
  :ensure t)

(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp)
  :config
  (progn
    (setq lsp-dart-dap-flutter-hot-reload-on-save t
	  lsp-dart-sdk-dir "$FLUTTER_HOME/bin/cache/dart-sdk"))
  :init)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1)

;; Packages stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "78e9a3e1c519656654044aeb25acb8bec02579508c145b6db158d2cfad87c44e" "7178dc309d5bb89e9de6feddd71058ddf8cb947bbf08ea6c7799a03ae690449e" default))
 '(package-selected-packages
   '(doom-modeline treemacs-projectile projectile hover powerline-evil powerline moe-theme dap-mode dart-mode company-mode solarized-theme zenburn-theme treemacs flycheck rebecca-theme which-key use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Styles
(when window-system
      (set-frame-position (selected-frame) 0 0)
      (set-frame-size (selected-frame) 128 100))

(global-display-line-numbers-mode)
(global-hl-line-mode t)
(set-face-attribute 'default nil :font "Source Code Pro" :height 180)
(load-theme 'rebecca t)

(use-package rebecca-theme
  :ensure t)

(use-package solarized-theme
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))


;; Emacs configs
(setq vc-follow-symlinks t)

;;; init.el ends here
