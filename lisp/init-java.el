;;; init-java.el --- Setup of lsp for java and initiates some utility methods.
;;; Commentary:
;;; Code:
(use-package lsp-mode
  :hook (
	 (java-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-enable-snippet nil)
  (setq lsp-headerline-breadcrumb-enable nil))

(use-package lsp-java :ensure t)

;; Some java specific commands
(defun java-compile-file ()
  "Compiles the current Java file."
  (interactive)
  (lsp-format-buffer)
  (lsp-organize-imports)
  (save-buffer)
  (projectile-run-async-shell-command-in-root (concat
	 (concat "javac src/" (file-relative-name buffer-file-name projectile-project-root))
	 " -d out/")))

(defun java-run-file ()
  "Run the last compiled version of the current Java file."
  (interactive)
  (projectile-run-async-shell-command-in-root (concat "java -cp out/ " (file-name-sans-extension (file-relative-name buffer-file-name projectile-project-root)))))

(defun java-compile-and-run-file ()
  "Compiles and run the current Java file."
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
"Takes the line your cursor is on and feed it through an interperter that outputs
ascii art. The algorithm of the interperter are as follows:
It will first take a number N between 0-9.
If N is 0, a new line character will be placed.
Else the next character will be placed N times.
For example, '5.01.3 1.01.3 1.01.3 1.05.' will output this.
.....
.   .
.   .
.   .
....."
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
		 (when (eq amount 0) (insert "\n")))
	   (insert (make-string amount (string-to-char c))))
	(unless (eq amount 0) (if counting (setq counting nil) (setq counting t)))
	(setq index (+ index 1))))

(provide 'init-java)
;;; init-java.el ends here
