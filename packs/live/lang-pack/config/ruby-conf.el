(live-add-pack-lib "ruby-mode")
(require 'ruby-mode)
(require 'inf-ruby)
(require 'custom-ruby)
(require 'ruby-electric)
(require 'rainbow-delimiters)

(add-hook 'ruby-mode-hook 'ruby-electric-mode)
(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

;;easy hash-rocket insertion
(define-key ruby-mode-map (kbd "C-c C-r") " => ")

(defun ruby-interpolate ()
  "In a double quoted string, interpolate."
  (interactive)
  (insert "#")
  (let ((properties (text-properties-at (point))))
    (when (and
           (memq 'font-lock-string-face properties)
           (save-excursion
             (ruby-forward-string "\"" (line-end-position) t)))
      (insert "{}")
      (backward-char 1))))

;;; enables outlining for ruby
;;; You may also want to bind hide-body, hide-subtree, show-substree
;;; show-all, show-children, ... to some keys easy folding and unfolding
(add-hook 'ruby-mode-hook
              '(lambda ()
                 (outline-minor-mode)
                 (setq outline-regexp " *\\(def \\|class\\|module\\|describe \\|it \\)")))

;;; Turn off commint-echo in IRB process
(defun kill-comint-echo-ruby-hook ()
  (setq comint-process-echoes t)
  (inf-ruby-keys)
  )

;;; Register Ruby Mode Hook
(add-hook 'ruby-mode-hook 'kill-comint-echo-ruby-hook)
