(menu-bar-mode -1) ; Disable menu bar
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
(add-to-list 'load-path "~/.emacs.d/lisp/") ; Set lisp load path
(setq default-frame-alist '((font . "JetBrainsMono-14"))) ; Set font

;; Disable scroll bar
(scroll-bar-mode -1) ; Disable scroll bar
(add-hook 'after-make-frame-functions #'(lambda (frame)
					  (select-frame frame)
					  (scroll-bar-mode -1)))

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

;; Setup theme
(use-package doom-themes :config (load-theme 'doom-henna t))

;; Setup tree-sitter
(use-package tree-sitter)
(use-package tree-sitter-langs)
(add-hook 'java-mode-hook #'tree-sitter-mode)
(add-hook 'java-mode-hook #'tree-sitter-hl-mode)

;; Setup undo-fu
(use-package undo-fu)

;; Setup evil
(use-package evil
  :config (evil-mode 1)
  :init (setq evil-undo-system 'undo-fu))

;; Setup ivy
(use-package ivy :config (ivy-mode 1))

;; Setup smartparens
(use-package smartparens
  :config
  (require 'smartparens-config)
  (add-hook 'java-mode-hook #'smartparens-mode)
  (sp-local-pair 'java-mode "{" nil :post-handlers '(("|| " "SPC") ("||\n[i]" "RET"))))
;; Setup general
(use-package general
  :init
  (setq general-override-states
		'(insert emacs hybrid normal visual motion operator replace))
  (require 'keybindings))

;; Set custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(message "Startup finished.")
;;; init.el ends here
