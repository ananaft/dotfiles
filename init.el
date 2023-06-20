;;;;;;;;;;;;;;;;;;;
;; Package setup ;;
;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
	(package-refresh-contents))		;; Refresh packages
;; Setup use-package
(unless (package-installed-p 'use-package)
	(package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)	;; Ensure packages are installed

;;;;;;;;;;;;;;;;;;
;; Visual stuff ;;
;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)    ;; Disable startup message

(scroll-bar-mode -1)    ;; Disable visible scrollbar
(tool-bar-mode -1)      ;; Disable toolbar
(tooltip-mode -1)       ;; Disable tooltips
(set-fringe-mode 10)    ;; Give some breathing room
(menu-bar-mode -1)      ;; Disable menu bar
;; (setq visible-bell t)    ;; Screen flash
(use-package gruvbox-theme
    :init (load-theme 'gruvbox-dark-hard t))

(column-number-mode)
(display-time-mode)
(setq display-time-24hr-format t)
;; Display line numbers
(require 'display-line-numbers)
(defcustom display-line-numbers-exempt-modes '(vterm-mode
                           eshell-mode
                           shell-mode
                           term-mode
                           ansi-term-mode
                           dired-mode
                           ibuffer-mode)
  "Major modes on which to disable the linum mode, exempts them from global requirement"
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "turn on line numbers but excempting certain majore modes defined in `display-line-numbers-exempt-modes'"
  (if (and
       (not (member major-mode display-line-numbers-exempt-modes))
       (not (minibufferp)))
      (display-line-numbers-mode)))

(global-display-line-numbers-mode)

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;
(use-package diminish)  ;; Hide minor modes

;; Better M-x
(use-package smex)

;; Better search and auto-completion
(use-package ivy
    :bind (
        :map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-l" . ivy-alt-done)
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line)
        :map ivy-switch-buffer-map
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line)
        ("C-l" . ivy-done)
        ("C-d" . ivy-switch-buffer-kill))
    :config
    (ivy-mode 1))

(use-package swiper
    :bind (("C-s" . swiper))
    )
(use-package counsel
  :config
  (setq ivy-initial-inputs-alist nil))  ;; Don't start searches with ^
(setq-default counsel-mode t)
(diminish 'counsel-mode)
(setq ivy-use-selectable-prompt t)  ;; Make direct input selectable
(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  )  ;; More information within ivy
(diminish 'ivy-mode)

(use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

;; Key help
(use-package which-key
    :init (which-key-mode)
    :config
    (setq which-key-idle-delay 0.5))
(diminish 'which-key-mode)

;; Better help documentation
(use-package helpful
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command] . helpful-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key] . helpful-key))

;; Better window navigation
(use-package winum
    :init
    (winum-mode)
    :bind (
    :map winum-keymap
    ("M-1" . winum-select-window-1)
    ("M-2" . winum-select-window-2)
    ("M-3" . winum-select-window-3)
    ("M-4" . winum-select-window-4)
    ("M-5" . winum-select-window-5)
    ("M-6" . winum-select-window-6)
    ("M-7" . winum-select-window-7)
    ("M-8" . winum-select-window-8)
    ("M-9" . winum-select-window-9))
    )

(use-package buffer-move
  :bind
  ("M-<up>" . buf-move-up)
  ("M-<down>" . buf-move-down)
  ("M-<left>" . buf-move-left)
  ("M-<right>" . buf-move-right)
  )

;; Ibuffer
(use-package ibuffer
    :bind ("C-x C-b" . ibuffer)
    )
(setq ibuffer-expert t)
(add-hook 'ibuffer-mode-hook
      (lambda () (ibuffer-auto-mode 1)))
(setq ibuffer-saved-filter-groups
      (quote (("default"
           ("code" (or
            (mode . emacs-lisp-mode)
            (mode . cperl-mode)
                        (mode . c-mode)
                        (mode . java-mode)
                        (mode . idl-mode)
                        (mode . web-mode)
                        (mode . lisp-mode)
                        (mode . js2-mode)
                        (mode . c++-mode)
                        (mode . lua-mode)
                        (mode . cmake-mode)
                        (mode . ruby-mode)
                        (mode . scss-mode)
                        (mode . css-mode)
                        (mode . objc-mode)
                        (mode . sql-mode)
                        (mode . python-mode)
                        (mode . php-mode)
                        (mode . sh-mode)
                        (mode . json-mode)
                        (mode . scala-mode)
                        (mode . go-mode)
                        (mode . erlang-mode)
            (mode . ess-r-mode)
            ))
           ("html/xml" (or
                (mode . html-mode)
                (mode . mhtml-mode)
                (mode . nxml-mode)
                ))
           ("latex" (or
             (mode . plain-TeX-mode)
             (mode . TeX-latex-mode)
             (mode . LaTeX-mode)
             (mode . latex-mode)
             (mode . ams-tex-mode)
             (mode . tex-mode)
             (mode . bibtex-mode)
             (mode . ConTeXt-mode)
             (mode . docTeX-mode)
             (mode . Texinfo-mode)
             ))
           ("shell" (or
             (name . "^\\*terminal\\*$")
             (name . "^\\*Python\\*$")
             (mode . inferior-ess-r-mode)
             ))
           ("dired" (mode . dired-mode))
           ("org" (mode . org-mode))
           ("emacs" (or
             (name . "^\\*scratch\\*$")
             (name . "^\\*Messages\\*$")
             (name . "^\\*Help\\*$")
             (name . "^\\*Flymake log\\*$")
             (name . "\\*Async Shell Command\\*.*")
             (name . "^\\*helpful .+")
             (name . "^\\*info\\*$")
             (name . "^\\*Apropos\\*$")
             (name . "^\\*epc ")
             (name . "^\\*ESS\\*$")
             ))
           ("magit" (name . "^magit"))
           ))))
(add-hook 'ibuffer-mode-hook
      (lambda ()
        (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-show-empty-filter-groups nil)

;; Scrollbar for modeline
(use-package sml-modeline)
(sml-modeline-mode 1)
;; (add-hook 'magit-mode-hook
      ;; (lambda () (sml-modeline-mode -1)))

;; Undo tree
(use-package undo-tree
  :bind
  ("C-x C-u" . undo-tree-visualize)
  :diminish
  )
(global-undo-tree-mode)
(setq undo-tree-auto-save-history nil)

;; Python
(setq py-install-directory "/home/lukas/.emacs.d/elpa/python-mode-20230515.722/")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

;; Elpy
(use-package elpy
  :init
  (elpy-enable)
  :hook
  (inferior-python-mode-hook . (lambda () (set (make-local-variable
						'eldoc-documentation-function)
                                               'elpy-eldoc-documentation)
                                 (eldoc-mode)))
  
  :bind
  (:map inferior-python-mode-map
        ("C-c C-d" . elpy-doc))
  )
(setq elpy-get-info-from-shell t)
(setq python-indent-guess-indent-offset nil)
(setq python-indent-offset 4)
(add-hook 'elpy-mode-hook
	  (lambda () (flymake-mode-off)))

;; Auto-completion
(use-package company
  :diminish
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  )

;; Emacs Speaks Statistics
(use-package ess
  :init
  (require 'ess-site)
  :config
  (setq ess-use-flymake nil))

;; Magit
(use-package magit
  :bind
  ("C-x g" . magit-status))
(use-package forge
  :after magit)
(use-package keychain-environment)
(keychain-refresh-environment)

;; AucTeX
(use-package auctex
  :defer t)

;;;;;;;;;;;;;;;;;
;; Adjustments ;;
;;;;;;;;;;;;;;;;;

;; Save sessions
(desktop-save-mode 1)

;; Dired improvements
(add-hook 'dired-mode-hook 'auto-revert-mode)
(diminish 'auto-revert-mode)
(setq auto-revert-verbose nil)
(setq dired-deletion-confirmer #'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "^")
                        (lambda () (interactive) (find-alternate-file "..")))))
(setq dired-dwim-target t) ;; copy to next dired window
(setq async-shell-command-buffer 'new-buffer) ;; don't ask when opening new commands
(diminish 'dired-async-mode)
(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message "Size of all marked files: %s"
               (progn 
                 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
                  (match-string 1))))))
(define-key dired-mode-map (kbd "?") 'dired-get-size)

;; Choose programs for file types
(require 'dired-x)
(setq dired-guess-shell-alist-user
      '(
	("\\.[Jj][Pp][Ee]?[Gg]$" "viewnior")
	("\\.[Pp][Nn][Gg]$" "viewnior")
	("\\.pdf$" "zathura")
	("\\.md$" "okular")
	("\\.docx?$" "libreoffice")
	("\\.odf$" "libreoffice")
	("\\.xls.?$" "libreoffice")
	("\\.ipynb$" "jupyter notebook")
	))

;; Don't show async shell buffers
(add-to-list 'display-buffer-alist
  '("\\*Async Shell Command\\*.*" display-buffer-no-window))

;; Fast terminal access
(global-set-key (kbd "C-x C-t") 'term)

;; Automatic saving
(setq auto-save-interval 20)
(auto-save-visited-mode 1)

;; Save backup files in home directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; Automatic bracket closing
(electric-pair-mode 1)
(diminish electric-pair-mode)

;; Comment shortcut
(global-set-key (kbd "M-;") 'comment-line)

;; Show parentheses
(global-set-key (kbd "C-x C-p") 'show-paren-mode)

;; Switch windows
(global-set-key (kbd "C-x o") 'previous-window-any-frame)
(global-set-key (kbd "C-x p") 'other-window)

;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Copy file path to clipboard
(defun my-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-list '(("Zathura" ("zathura --page=%(outpage) %o") "zathura")))
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Zathura")
     (output-html "xdg-open")))
 '(custom-safe-themes
   '("7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" default))
 '(package-selected-packages '(buffer-move use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

