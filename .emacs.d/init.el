;; -*- Mode:Emacs-Lisp ; Coding:utf-8 -*-

;;===================================
;;All about settings
;;===================================

(global-linum-mode t)
(defface my-hl-face
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    (((class color) (background light))
     (:background "LightGoldenYellow" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-face)
(global-hl-line-mode t)
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(setq initial-scratch-message "")
(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format "%b")
(setq-default truncate-lines t)
(menu-bar-mode -1)
;(load-theme 'deeper-blue)
;(load-theme 'tsdh-dark)
(load-theme 'manoj-dark)
(setq auto-save-timeout 30)
;fullscreen
;(set-frame-parameter nil 'fullscreen 'fullboth)
(set-frame-parameter nil 'fullscreen 'maximized)
(if window-system
    (progn
         (set-frame-parameter nil 'alpha 60)))

;(electric-pair-mode t)

;;===================================
;;Essential keybindings
;;===================================

(global-set-key "\C-w" 'other-window)
(global-set-key "\M-g" 'goto-line)
(setq indent-line-function 'indent-relative-maybe)
(global-set-key "\C-m" 'indent-new-comment-line)
(global-set-key "\C-j" 'newline)
(define-key global-map (kbd "M-C-g") 'grep)
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "C-x h") 'help-command)
(define-key global-map (kbd "C-x t") 'shell)

;;===================================
;;Emacs Lisp package
;;===================================

;;load-path function
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")

;;ELPA / Marmalade
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;;auto-install
(add-to-list 'load-path "~/.emacs.d/auto-install/")
(require 'auto-install)
;;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)


;;;open-junk-file
(require 'open-junk-file)
;;C-x C-z open junkfile
(global-set-key (kbd"C-x C-z") 'open-junk-file)
;;;lispxmp
(require 'lispxmp)

(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)
;;;paredit
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(show-paren-mode 1)
;;;auto-async-byte-compile
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;;; (setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

(require 'scala-mode2)

;;========================================
;;Skk
;;========================================
(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))

;;=======================================
;;Python
;;=======================================
(load "__init__py")
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;======================================
;;Helm
;;======================================
(require 'helm-migemo)
(eval-after-load "helm-megimo"
  '(defun helm-compile-source--candidates-in-buffer (source)
     (helm-aif (assoc 'candidates-in-buffer source)
	 (append source
		 '((candidates
		    .,(or (cdr it)
			  (lambda ()
			    (helm-candidates-in-buffer (helm-get-current-source)))))
		   (volatile) (match indentity)))
       source)))

;;=====================================
;;Neotree-setting
;;=====================================
(require 'neotree)
(global-set-key (kbd "C-x n") 'neotree)
(global-set-key (kbd "C-x d") 'neotree-hide)

;;=====================================
;;Auto complete
;;=====================================
(require 'auto-complete-config)
(require 'auto-complete)
(ac-config-default)
(ac-set-trigger-key "TAB")
(setq ac-use-fuzzy t)

;;=====================================
;;Macros
;;=====================================
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)


;;=====================================
;;Ruby
;;=====================================
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$latex " . ruby-mode))
(require 'ruby-electric)
(add-hook 'ruby-mode-hook
	  '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;;=====================================
;;Anything
;;=====================================
(require 'anything)
; (setq recentf-max-saved-items 500)
;(recentf-mode 1)

