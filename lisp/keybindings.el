;;; keybindings.el --- Keybinding setup
;;; Commentary:
;;; Code:

(general-create-definer leader :prefix "SPC")

(leader
 :states '(normal visual motion)
 :keymaps 'override

 "SPC" 'execute-extended-command

 "ek" 'delete-frame
 "eq" 'kill-emacs

 "fs" 'save-buffer
 "ff" 'find-file
 "fw" 'write-file
 "fd" 'delete-file

 "bs" 'switch-to-buffer
 "bk" 'kill-current-buffer
 "be" 'eval-buffer

 "wh" 'split-window-horizontally
 "wv" 'split-window-vertically
 "wo" 'other-window
 "wd" 'delete-window)

(provide 'keybindings)
;;; keybindings.el ends here
