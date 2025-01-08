(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(setq x-alt-keysym 'meta)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(yasnippert rust-mode magit timu-macos-theme flycheck company company-lsp lsp-ui lsp-mode evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Ensure that `evil` is installed
(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))




(require 'evil)
(evil-mode 1)

(unless (package-installed-p 'lsp-mode)
  (package-refresh-contents)
  (package-install 'lsp-mode))

;; set up lsp for c/c++
(require 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)

;; Optional: Set clangd path if not in your PATH
;; (setq lsp-clients-clangd-executable "/path/to/clangd")

(use-package lsp-ui
	:ensure t
	:after lsp-mode)

(unless (package-installed-p 'lsp-ui)
  (package-refresh-contents)
  (package-install 'lsp-ui))

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(global-display-line-numbers-mode)

(unless (package-installed-p 'company)
  (package-refresh-contents)
  (package-install 'company))
(require 'company)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-lsp))
(add-hook 'after-init-hook 'global-company-mode)

(unless (package-installed-p 'flycheck)
  (package-refresh-contents)
  (package-install 'flycheck))

(require 'flycheck)
(add-hook 'lsp-mode-hook 'flycheck-mode)
(setq lsp-prefer-flymake nil)

(setq lsp-clients-clangd-args '("--background-index" "--clang-tidy" "--completion-style=detailed"))
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)

(set-face-attribute 'default nil :height 200)

(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))

(unless (package-installed-p 'timu-macos-theme)
  (package-refresh-contents)
  (package-install 'timu-macos-theme))

(load-theme 'timu-macos t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(add-hook 'python-mode-hook #'lsp)

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp)
  :config
  (setq lsp-rust-server 'rust-analyzer))  ;; Add rust lsp configuration here

(use-package yasnippet
             :ensure t
             :config
             (yas-global-mode 1))
(use-package company
             :ensure t
             :config
             (setq company-backends '((company-yasnippet company-capf company-dabbrev)))
             (global-company-mode 1))
(use-package lsp-mode
             :ensure t
             :config
             (setq lsp-enable-snippet t))
