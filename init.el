;; global variables
(setq
 inhibit-startup-screen t;; no startup screen
 make-backup-files nil;; no backup files - I use git everywhere
 create-lockfiles nil;; will no create lock files
 column-number-mode t;; will display the column number in the mode line
 scroll-error-top-bottom t;;scroll to the farthest possible position before signaling an error
 show-paren-mode t;; will display matching parenthesis when highlighting a parenthesis
 show-paren-delay 0.5;; show matching parenthesis after 0.5
 use-package-always-ensure t;;install package if not already present
 sentence-end-double-space nil;;end of sentence period should not be followed by two spaces
)

;; buffer local variables
(setq-default
 indent-tabs-mode nil;;don't use tabs for indentation
 tab-width 4;;one tab = 4 spaces
 c-basic-offset 4);;basic indentation in Cc Mode



;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

;; this is only needed once, near the top of the file
(eval-when-compile (require 'use-package))



;; diminish modes: hide minor mode in the modeline
(use-package diminish)
(diminish 'abbrev-mode)
(diminish 'eldoc-mode)
(diminish 'auto-revert-mode)

;; page break lines: display horizontal lines instead of ^L (C-q C-l to insert such a line ; C-x [ and C-x ] to navigate back and forth.)
(use-package page-break-lines
  :diminish page-break-lines-mode)
(global-page-break-lines-mode)

;; https://github.com/bbatsov/solarized-emacs Solarized (dark) theme
(use-package solarized-theme)
(load-theme 'solarized-dark t)

;; to use package-utils-upgrade-all and more
(use-package package-utils)

;; which-key minor mode: display available keybindings
(use-package which-key
  :diminish which-key-mode)
(which-key-mode)

;; comp(lete)any(thing): completion engine
(use-package company
  :diminish company-mode
  :init
  (setq
   company-idle-delay 0))
(add-hook 'after-init-hook 'global-company-mode)

;; ivy: command completion engine
(use-package ivy
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  :config
  (ivy-mode 1))

;; counsel: enhances default emacs features with ivy
;; it remaps default emacs command to ivy enhanced version (counsel-*)
(use-package counsel
  :diminish counsel-mode
  :config
  (counsel-mode 1))

;; swiper: ivy-backed isearch replacement
(use-package swiper
  :config
  (global-set-key "\C-s" 'swiper))

;; projectile: project interaction library
(use-package projectile
  :diminish projectile-mode
  :pin melpa-stable
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; imenu popup to display file summary
(use-package popup-imenu)

;; https://magit.vc : git frontend
(use-package magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 3)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
(setq dashboard-startup-banner 'logo)

;; paren-mode
(show-paren-mode 1)
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; save place mode
(save-place-mode 1)

;; markdown-mode
(use-package markdown-mode)

;; treemacs
;; (use-package treemacs)
;; (use-package treemacs-projectile)

;; flycheck
;;(use-package flycheck)

;; java-dev
;;(use-package lsp-mode)
;;(use-package company-lsp)
;;(push 'company-lsp company-backends)
;;(use-package lsp-ui)
;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)
;;(use-package lsp-java :after lsp
;;  :init
;;  (setq lsp-java-save-action-organize-imports nil)
;;  (setq lsp-java-vmargs (list "-javaagent:/Users/j.champemont/.emacs.d/lombok.jar" "-Xbootclasspath/a:/Users/j.champemont/.emacs.d/lombok.jar"))
;;  :config (add-hook 'java-mode-hook 'lsp) (add-hook 'java-mode-hook 'flycheck-mode))
;;(use-package protobuf-mode)


;; use a custom file
(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)



;; global keybindings
(global-unset-key (kbd "C-z")) ;; unset C-z (which is hidding emacs)
(global-set-key (kbd "C-x C-k k") 'kill-this-buffer)


;; more customization
(tool-bar-mode 0)
(menu-bar-mode 0)
;; visual bell
(defun mode-line-visual-bell ()
  (setq visible-bell nil)
  (setq ring-bell-function 'mode-line-visual-bell--flash))

(defun mode-line-visual-bell--flash ()
  (let ((frame (selected-frame)))
    (invert-face 'header-line frame)
    (invert-face 'header-line-highlight frame)
    (invert-face 'mode-line frame)
    (invert-face 'mode-line-inactive frame)
    (run-with-timer
     0.1 nil
     #'(lambda (frame)
         (invert-face 'header-line frame)
         (invert-face 'header-line-highlight frame)
         (invert-face 'mode-line frame)
         (invert-face 'mode-line-inactive frame))
     frame)))
(mode-line-visual-bell)

;; Start the server mode (to allow emacs-client)
(server-start)
