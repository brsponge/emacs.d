;;; init-general.el --- General keybinding setup
;;; Commentary:
;;; Code:

(general-auto-unbind-keys)

(general-create-definer leader :prefix "SPC")

(leader
 :states '(normal visual motion)
 :keymaps 'override

 "SPC" '(execute-extended-command :which-key "M-x")
 "e" '(:ignore t :which-key "emacs")
 "eq" '(delete-frame :which-key "quit")
 "ek" '(kill-emacs :which-key "kill")
 
 "f" '(:ignore t :which-key "file")
 "fs" '(save-buffer :which-key "save")
 "ff" '(find-file :which-key "open")
 "fw" '(write-file :which-key "write")
 "fd" '(delete-file :which-key "delete")

 "b" '(:ignore t :which-key "buffer")
 "bs" '(switch-to-buffer :which-key "switch")
 "bn" '(switch-to-next-buffer :which-key "next")
 "bp" '(switch-to-prev-buffer :which-key "previous")
 "bk" '(kill-current-buffer :which-key "kill")
 "be" '(eval-buffer :which-key "evaluate")

 "w" '(:ignore t :which-key "window")
 "wh" '(split-window-horizontally :which-key "h-split")
 "wv" '(split-window-vertically :which-key "v-split")
 "wo" '(other-window :which-key "switch")
 "wd" '(delete-window :which-key "delete")
 "wt" '(treemacs :which-key "treemacs")

 "j" '(:ignore t :which-key "java")
 "ji" '(lsp-organize-imports :which-key "import")
 "jf" '(lsp-format-buffer :which-key "format")
 "jr" '(java-run-file :which-key "run")
 "jc" '(java-compile-file :which-key "compile")
 "jj" '(java-compile-and-run-file :which-key "compile+run")
 "ja" '(ascii-create :which-key "ascii-create"))

(provide 'init-general)
;;; init-general.el ends here
