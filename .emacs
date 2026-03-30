; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

;; theme
(load-theme 'tango-dark t)
;;(load-theme 'dichromacy t)

;; ui style
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
;; Hide Titlebar
;; (add-to-list 'default-frame-alist '(undecorated . t))

;; c/c++
(setq compilation-scroll-output t)
;; (setq-default c-basic-offset 2)
(setq c-default-style "gnu" c-basic-offset 2)


;; (load-file "emacs-mods/lsp-mod.el")
(load-file "emacs-mods/cmake-mod.el")
(load-file "emacs-mods/bazel.el")
(add-to-list 'auto-mode-alist '("\\.BUILD\\'" . bazel-mode))

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
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"
				      "--background-index"
				      "--clang-tidy"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-common-hook	  
          (lambda () (add-hook 'before-save-hook 'eglot-format-buffer nil t)))

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


(require 'autoinsert)
(auto-insert-mode)
(setq auto-insert-query nil) ; Insert without prompting

(define-auto-insert
  '("\\.\\([Cc]\\|cc\\|cpp\\|hpp\\|h\\)\\'" . "C/C++ AGPL Header")
  '(""
    "/* Copyright (C) " (format-time-string "%Y") "  Yishak <yishak@merkaatoo.com>" "\n"
    "\n"
    "   This file is part of " (setq v1 (read-string "Project Name: ")) "." "\n"
    "\n"
    "   " v1 " is free software: you can redistribute it and/or modify" "\n"
    "   it under the terms of the GNU Affero General Public License as published" "\n"
    "   by the Free Software Foundation, either version 3 of the License, or" "\n"
    "   (at your option) any later version." "\n"
    "\n"
    "   " v1 " is distributed in the hope that it will be useful," "\n"
    "   but WITHOUT ANY WARRANTY; without even the implied warranty of" "\n"
    "   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the" "\n"
    "   GNU Affero General Public License for more details." "\n"
    "\n"
    "   You should have received a copy of the GNU Affero General Public License" "\n"
    "   along with this program.  If not, see <https://www.gnu.org/licenses/>. */" "\n"
    "\n"
    "\n"
    _))




;; For built-in asm-mode
(add-hook 'asm-mode-hook
          (lambda ()
            (setq asm-comment-char ?\;) ; Use semicolon for comments
            (setq fill-column 80)
            (local-set-key (kbd "RET") 'newline-and-indent)))

(defun my-asm-format-buffer ()
  (interactive)
  (when (derived-mode-p 'asm-mode 'nasm-mode)
    (shell-command-on-region (point-min) (point-max) "asmfmt" nil t)))

(add-hook 'asm-mode-hook
          (lambda () (add-hook 'before-save-hook 'my-asm-format-buffer nil t)))
