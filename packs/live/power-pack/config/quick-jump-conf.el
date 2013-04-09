(require 'quick-jump)
(quick-jump-default-keybinding)
(if (boundp 'ace-jump-mode)
  (if 'ace-jump-mode
      (add-hook 'ace-jump-mode-before-jump-hook (lambda ()
                                                  (quick-jump-push-marker)))))
