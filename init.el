;; ==============================
;; MELPA Package support
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; ==============================
;; Manage load path
(add-to-list 'load-path "~/.emacs.d/xtofadditional/")

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(require 'org-install)
(require 'org-capture)

;; ==============================
;; Initialise Package System
(package-initialize)

;; ==============================
;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
(package-refresh-contents))

;; ==============================
;; Installs packages
;; myPackages contains a list of package names
(defvar myPackages
  '(elpy                 ;; emacs Lisp Python Environment
    flycheck             ;; on the fly syntax checking
    py-autopep8          ;; Run autopep8 on save   
    )
)
;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
           (unless (package-installed-p package)
            (package-install package)))
      myPackages)

 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-safe-themes
   (quote
    ("55c2c0d811cdecd311ebe27f82b24a5410d38c1ff6117c91e5ba88031829ee06" "fa3bdd59ea708164e7821574822ab82a3c51e262d419df941f26d64d015c90ee" "845103fcb9b091b0958171653a4413ccfad35552bc39697d448941bcbe5a660d" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" default)))
 '(display-time-mode t)
 '(org-agenda-files (quote ("~/onedrive/OrgMode")))
 '(package-selected-packages
   (quote
    (auto-complete exec-path-from-shell go-mode org-bullets htmlize)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))


;; ==============================
;; Basic Customization
;; ==============================
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(desktop-save-mode 1)
(display-time-mode 1)
(visual-line-mode 1) ;;to do soft line break
(ido-mode 1)
(setq visible-bell 1) ;;to stop annoying default sound
(setq backup-directory-alist '(("." . "~/.emacs.d/.saves"))) ;;collecting all backups files into one directory

;; ==============================
;; OrgMode Customization
;; ==============================
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)
(setq org-hide-emphasis-markers t) ;;hide markup
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;; ==============================
;; Dev Environment Setup
;; ==============================
(elpy-enable) ;;enabling elpy Python package

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;Wind Move enablement
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Make windmove work in Org mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Making tabulation / indentation 4 spaces instead of 2
(setq tab-width 4)
