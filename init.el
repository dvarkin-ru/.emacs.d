(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(compile-command "make -j3 ")
 '(custom-enabled-themes '(wombat))
 '(gdb-debuginfod-enable-setting t)
 '(global-tab-line-mode t)
 '(ispell-dictionary "russian")
 '(mode-line-percent-position nil)
 '(mode-line-position-column-line-format '("L%l C%c"))
 '(package-selected-packages
   '(eglot-inactive-regions helm-projectile projectile helm company dashboard))
 '(tab-line-close-tab-function 'kill-buffer)
 '(tab-line-new-button-show nil)
 '(tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-line ((t (:height 0.9 :foreground "white" :background "grey20" :inherit variable-pitch))))
 '(tab-line-highlight ((t (:background "grey85" :foreground "black" :box (:line-width (1 . 1) :style released-button)))))
 '(tab-line-tab ((t (:inherit tab-line))))
 '(tab-line-tab-current ((t (:inherit tab-line-tab :background "gray14"))))
 '(tab-line-tab-inactive ((t (:inherit tab-line-tab :background "grey20")))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'after-init-hook 'global-company-mode)

(setq dashboard-projects-backend 'projectile)
(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5)))
(require 'dashboard)
(dashboard-setup-startup-hook)

(setq native-comp-async-report-warnings-errors 'silent)

(helm-mode 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(speedbar 1)

(when (file-directory-p "~/.emacs.d/stm32")
  (add-to-list 'load-path "~/.emacs.d/stm32")
  (require 'stm32))

(global-auto-revert-mode t)

(use-package eglot-inactive-regions
  :custom
  (eglot-inactive-regions-style 'darken-foreground)
  (eglot-inactive-regions-opacity 0.4)
  :config
  (eglot-inactive-regions-mode 1))

(global-set-key (kbd "<C-tab>") 'previous-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") 'next-buffer)

(defun python-shell-run ()
  (interactive)
  (if (get-buffer-process "*Python*")
      (python-shell-restart)
    (run-python))
  (sleep-for 0.1)
  (python-shell-send-buffer t))

(eval-after-load "python"
  '(define-key python-mode-map (kbd "C-c C-c") 'python-shell-run))

(c-add-style "1tbs"
             '("java"
               (c-hanging-braces-alist
		(defun-open after)
		(class-open after)
		(inline-open after)
		(block-close . c-snug-do-while)
		(statement-cont)
		(substatement-open after)
		(brace-list-open)
		(brace-entry-open)
		(extern-lang-open after)
		(namespace-open after)
		(module-open after)
		(composition-open after)
		(inexpr-class-open after)
		(inexpr-class-close before)
		(arglist-cont-nonempty))
               (c-offsets-alist
		(access-label . -))))
(setq c-default-style "1tbs")
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
