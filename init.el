(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(gdb-debuginfod-enable-setting t)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(clangd-inactive-regions helm-projectile projectile helm company dashboard s friendly-shell-command))
 '(package-vc-selected-packages
   '((clangd-inactive-regions :vc-backend Git :url "https://github.com/fargiolas/clangd-inactive-regions.el")))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-bar ((t (:inherit variable-pitch :background "gray20"))))
 '(tab-bar-tab ((t (:inherit tab-bar :background "gray14"))))
 '(tab-bar-tab-inactive ((t (:inherit tab-bar-tab :background "gray20")))))

(require 'package)
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
(setq tab-bar-new-tab-choice "*dashboard*")
(setq native-comp-async-report-warnings-errors 'silent)

;; (defun close-tab-and-buffer()
;;   (interactive)
;;   (kill-buffer)
;;   (tab-close))
;; (keymap-global-set "C-x t w" 'close-tab-and-buffer)

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

(unless (package-installed-p 'clangd-inactive-regions)
  (package-vc-install "https://github.com/fargiolas/clangd-inactive-regions.el"))

(use-package clangd-inactive-regions
  :init
  (add-hook 'eglot-managed-mode-hook #'clangd-inactive-regions-mode)
  :config
  (clangd-inactive-regions-set-method "darken-foreground")
  (clangd-inactive-regions-set-opacity 0.55))
(put 'dired-find-alternate-file 'disabled nil)

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
