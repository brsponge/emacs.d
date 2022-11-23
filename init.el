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
(use-package doom-themes :config (load-theme 'doom-gruvbox t))

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
  (setq company-idle-delay 0))

;; Setup flycheck
(use-package flycheck :config (global-flycheck-mode 1))

;; Setup projectile
(use-package projectile :config (projectile-mode 1))

;; Setup lsp-mode
(use-package lsp-mode
  :hook (
	 (java-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-enable-snippet nil)
  (setq lsp-headerline-breadcrumb-enable nil))

(use-package lsp-java :ensure t)

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

;; Some java specific commands
(defun java-compile-file ()
  "This function is meant for compiling the current Java file."
  (interactive)
  (lsp-format-buffer)
  (lsp-organize-imports)
  (save-buffer)
  (projectile-run-async-shell-command-in-root (concat
	 (concat "javac src/" (file-relative-name buffer-file-name projectile-project-root))
	 " -d out/")))

(defun java-run-file ()
  "This function is meant for running the last compiled version of the current Java file."
  (interactive)
  (projectile-run-async-shell-command-in-root (concat "java -cp out/ " (file-name-sans-extension (file-relative-name buffer-file-name projectile-project-root)))))

(defun java-compile-and-run-file ()
  "This function is meant for compiling and running the current Java file."
  (interactive)
  (lsp-format-buffer)
  (lsp-organize-imports)
  (save-buffer)
  (projectile-run-async-shell-command-in-root
   (concat
	(concat
	 (concat "javac src/" (file-relative-name buffer-file-name projectile-project-root))
	 " -d out/ && ")
	(concat "java -cp out/ " (file-name-sans-extension (file-relative-name buffer-file-name projectile-project-root))))))

(defun ascii-create ()
  (interactive)
  (setq input (thing-at-point 'line t))
  (kill-whole-line)
  (setq amount 0)
  (setq counting t)
  (setq index 0)
  (while (< index (length input))
	(setq c (substring input index (+ index 1)))
	(if counting
		(progn
		  (setq amount (string-to-number c))
		  (message c)
		 (when (eq amount 0) (insert "\n"))
		 )
	   (insert (make-string amount (string-to-char c)))
	   )
	(unless (eq amount 0) (if counting (setq counting nil) (setq counting t)))
	(setq index (+ index 1))
	))

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
