;;; Theme
(load-theme 'tsdh-dark)

;;; Emacs
(use-package emacs
  :defer 0.1
  :bind*
  ("C-<return>" . other-window)
  ("C-c e" . eshell)
  ("C-c m" . man)
  ("C-c t" . typit-advanced-test)
  ("C-x k" . kill-this-buffer)
  ("C-c d" . (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
  ("C-c b" . (lambda () (interactive) (find-file "~/.emacs.d/backup/backup.org")))
  :custom			  
  (initial-buffer-choice t)
  (tool-bar-mode nil)
  (menu-bar-mode nil)
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message "Hello fellow, Emacs users!\nGood time using powerfull Emacs!\n")
  :config
  (setq trash-directory "~/.trash/")
  (setq delete-by-moving-to-trash t)
  (setq history-delete-duplicates t)
  (setq show-paren-delay 0)
  (setq history-length t)
  (setq enable-recursive-minibuffers t)
  (minibuffer-electric-default-mode 1)
  (blink-cursor-mode -1)
  (fset 'yes-or-no-p 'y-or-n-p))

;;; Package
(use-package package
  :defer t
  :config
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
		           ("org" . "https://orgmode.org/elpa/")
		           ("Elpa" . "https://elpa.gnu.org/packages/"))))
;;; Isearch
(use-package isearch
  :custom (isearch-repeat-on-direction-change t))

;;; Dired
(use-package dired
  :commands dired
  :hook (dired-mode . dired-hide-details-mode)
  :custom
  (dired-hide-details-hide-information-lines nil)
  (dired-hide-details-hide-symlink-targets nil)
  (dired-listing-switches "--group-directories-first -lah"))

(use-package treemacs-icons-dired
  :commands dired
  :hook (dired-mode . treemacs-icons-dired-enable-once))

(use-package treemacs
  :commands treemacs 
  :bind ("C-x t t" . treemacs))

;;; Garbage collections
(add-hook 'after-init-hook #'garbage-collect t)

;;; Term
(use-package term  
    :commands term  
    :config  
    (setq explicit-shell-file-name "bash"))

;;; Vterm
(use-package vterm
  :commands vterm
  :bind ("C-c v" . vterm)
  :config
  (setq vterm-max-scrollback 10000))

;;; Multi-vterm
(use-package multi-vterm
  :defer t)

;;; Repeat mode
(use-package repeat
  :defer 0.1
  :config (repeat-mode 1)
  (setq native-comp-async-report-warnings-errors nil))

;;; Autorevert
(use-package autorevert
  :unless noninteractive
  :custom (global-auto-revert-non-file-buffers t)
  :config (global-auto-revert-mode 1))

;;; Savehist
(use-package savehist
  :unless noninteractive
  :config (savehist-mode +1))

;;; Saveplace
(use-package saveplace
  :unless noninteractive
  :config (save-place-mode 1))

;;; Electric-pair-mode
(use-package elec-pair
  :defer 0.1 ;:hook (prog-mode . electric-pair-mode)
  :init (electric-pair-mode 1)
  :config
  (global-visual-line-mode +1)
  (global-goto-address-mode +1))

;;; Auctex
(use-package tex
  :defer 1
  :init
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))

;;; Memory Usage
(use-package memory-usage
  :commands memory-usage)

;;; Company
(use-package company 
  ;:defer 0.1
  :hook ((prog-mode LaTeX-mode) . company-mode)
        ((prog-mode LaTeX-mode) . company-statistics-mode)
  ;; :init (global-company-mode 1)
  ;; (company-statistics-mode 1)
  ;; :init
  ;; (setq         ;company-tooltip-idle-delay 10
  ;;               ;company-require-match nil
  ;;               company-frontends
  ;;               '(;company-pseudo-tooltip-unless-just-one-frontend-with-delay
  ;;                 company-preview-frontend
  ;;                 company-echo-metadata-frontend)
  ;;               company-backends '(company-capf))
  :config
  (setq company-idle-delay 0
	company-frontends
                '(company-pseudo-tooltip-unless-just-one-frontend-with-delay
                  company-preview-frontend
                  company-echo-metadata-frontend)
                company-backends '(company-capf)
	company-minimum-prefix-length 1
	company-tooltip-align-annotations t
	company-tooltip-annotation-padding 1
	company-selection-wrap-around t)
  (setq company-clang-executable "/usr/bin/clang")
  ;; (add-to-list 'company-backends 'company-dabbrev-code-everywhere)
  (add-to-list 'company-backends 'company-files)
  (add-to-list 'company-backends 'company-keywords)
  (add-to-list 'company-backends 'company-clang)
  (add-to-list 'company-backends 'company-elisp)
  (add-to-list 'company-backends 'company-jedi))

;;   :after company
;;   :config
;;   (setq company-quickhelp-delay 0.5)
;;   (company-quickhelp-mode 1))

;;; Org capture
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(define-key global-map (kbd "C-c j")
       (lambda () (interactive) (org-capture nil "j")))
(add-hook 'org-mode-hook #'turn-on-font-lock)
(setq org-capture-templates
           '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
              "* TODO %?\n  %i\n  %a")
             ("r" "Record" plain (file "~/org/records.org")
              "* %^{title}  :%^{Tags}:\n%U%i\n%?\n")
             ("j" "Journal" entry (file+datetree "~/org/journal.org")
              "* %?\nEntered on %U\n  %i\n  %a")))

;;; Hl-line
(use-package hl-line
  :commands hl-line-mode
  :bind ("M-o h" . hl-line-mode))

;;; Orgmode
(use-package org
  :defer 1
  :config
  (setq org-clock-sound "~/Downloads/file_example_WAV_1MG.wav")
  (add-to-list 'org-modules 'org-tempo t)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))
    


;;; Org-roam
;; (use-package org-roam
;;   :defer 0.5
;;   :init
;;   (setq org-roam-v2-ack t)
;;   (setq org-roam-dailies-directory "journals/")
;;   :custom
;;   (org-roam-directory "~/RoamNotes")
;;   (org-roam-completion-everywhere t)
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;; 	 ("C-c n f" . org-roam-node-find)
;; 	 ("C-c n i" . org-roam-node-insert)
;; 	 ("C-c n d n" . org-roam-dailies-caputre-today)
;; 	 ;; :map org-roam-map
;; 	 ("C-M-i" . completion-at-point))
;;   :config (org-roam-setup))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ffba0482d3548c9494e84c1324d527f73ea4e43fff8dfd0e48faa8fc6d5c2bc7" "d0fd069415ef23ccc21ccb0e54d93bdbb996a6cce48ffce7f810826bb243502c" "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" "e7ce09ff7426c9a290d06531edc4934dd05d9ea29713f9aabff834217dbb08e4" default))
 '(package-selected-packages
   '(aircon-theme magit use-package typit treemacs-icons-dired projectile multi-vterm memory-usage eglot dash-docs company-statistics company-math company-jedi auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
