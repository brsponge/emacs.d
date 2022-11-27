;;; init.el --- The main elisp config file
;;; Commentary:
;;; Code:
(menu-bar-mode -1) ; Disable menu bar
(scroll-bar-mode -1) ; Disable scroll bar
(tool-bar-mode -1) ; Disable tool bar
(tooltip-mode -1) ; Disable tooltip
(setq inhibit-startup-message t) ; Disable startup message
(setq initial-scratch-message "") ; Disable scratch buffer message
(setq default-directory "~/") ; Set default directory as home
(setq auto-save-default nil) ; Disable auto save
(setq make-backup-files nil) ; Disable backups
(set-default 'truncate-lines t) ; Disable auto wrap
(global-display-line-numbers-mode) ; Enable line numbers
(setq display-line-numbers-type 'relative) ; Enable relative line numbers
(define-key key-translation-map (kbd "ESC") (kbd "C-g")) ; Escape is set to C-g
(setq initial-major-mode 'org-mode) ; Set scratch buffer to be org mode
(add-to-list 'load-path "~/.config/emacs/lisp/") ; Set lisp load path

;; Set font
(setq default-frame-alist '((font . "JetBrainsMono")))
(set-face-attribute 'default nil :height 140) ; Set font size

;; Setup package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Setup use-package
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Setup tab-width
(setq-default tab-width 4)

;; Setup undo-fu
(use-package undo-fu)

;; Setup evil
(use-package evil
  :config (evil-mode 1)
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-want-keybinding nil))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;; Setup theme
(use-package base16-theme :config (load-theme 'base16-ayu-dark t))

;; Setup ivy
(use-package ivy :config (ivy-mode 1))

;; Setup which-key
(use-package which-key :config (which-key-mode 1))

;; Setup treemacs
(use-package treemacs :config (setq treemacs-no-png-images t))

;; Setup company
(use-package company
  :config
  (global-company-mode 1)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 1))

;; Setup flycheck
(use-package flycheck :config (global-flycheck-mode 1))

;; Setup projectile
(use-package projectile :config (projectile-mode 1))

;; Setup yasnippet
(use-package yasnippet
  :config (yas-global-mode 1))

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "RET") yas-maybe-expand)

;; Setup smartparens
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)
  (sp-local-pair 'java-mode "{" nil :post-handlers '(("|| " "SPC") ("||\n[i]" "RET")))
  (electric-indent-mode 1))

(require 'init-java)

;; Setup general
(use-package general
  :init
  (setq general-override-states
		'(insert emacs hybrid normal visual motion operator replace))
  (require 'init-general))

;; Set custom file
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)
(message "Startup finished.")
;;; init.el ends here
