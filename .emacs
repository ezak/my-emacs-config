; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

;; theme
;; (load-theme 'tango-dark t)
(load-theme 'dichromacy t)

;; ui style
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; c/c++
(setq compilation-scroll-output t)
;; (setq-default c-basic-offset 2)
(setq c-default-style "gnu" c-basic-offset 2)

;; (load-file "emacs-mods/lsp-mod.el")
(load-file "emacs-mods/cmake-mod.el")
(load-file "emacs-mods/bazel.el")

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;(add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)

(set-face-attribute 'default nil :height 90)

;; Turn on spell checking.
(add-hook 'rcirc-mode-hook (lambda () (flyspell-mode 1)))
;; Turn on logging everything to a special buffer, for debugging.
(setq rcirc-debug-flag t)

;; eglot 
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; helm
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(groovy-mode helm lua-mode treemacs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-set-key (kbd "C-c s") 'helm-semantic)

;; backip and autosave
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosv" t)))
;; (setq auto-save-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backup/")))

