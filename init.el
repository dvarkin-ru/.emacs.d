(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(ispell-dictionary nil)
 '(package-selected-packages '(helm-projectile projectile helm magit company dashboard))
 '(tab-bar-mode t)
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
(add-hook 'after-init-hook 'global-company-mode)

(require 'dashboard)
(dashboard-setup-startup-hook)

(setq tab-bar-new-tab-choice "*dashboard*")
(setq native-comp-async-report-warnings-errors 'silent)

(defun close-tab-and-buffer()
  (interactive)
  (kill-buffer)
  (tab-close))
(keymap-global-set "C-x t w" 'close-tab-and-buffer)

(helm-mode 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
