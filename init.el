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

;; global keybindings
(global-unset-key (kbd "C-z")) ;; unset C-z (which is hidding emacs)

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

;; diminish modes
(use-package diminish)

;; https://github.com/bbatsov/solarized-emacs
(use-package solarized-theme)
(setq solarized-distinct-fringe-background t)
(setq solarized-high-contrast-mode-line t)
(load-theme 'solarized-light t)

;; to use package-utils-upgrade-all and more
(use-package package-utils)

;; which-key minor mode
(use-package which-key
  :diminish which-key-mode)
(which-key-mode)

;; comp(lete)any(thing)
(use-package company
  :diminish company-mode
  :init
  (setq
   company-idle-delay 0))
(add-hook 'after-init-hook 'global-company-mode)

;; ivy/counsel/swiper
(use-package ivy
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  :config
  (ivy-mode 1))
(use-package counsel
  :diminish counsel-mode
  :config
  (counsel-mode 1))
(use-package swiper
  :config)

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

;; imenu index in a popup windows
(use-package popup-imenu)

;; https://magit.vc
(use-package magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; scala dev
(use-package ensime
  :ensure t
  :pin melpa-stable
  :init
  (setq ensime-search-interface 'ivy)
  (setq ensime-startup-notification nil))
(add-to-list 'exec-path "/usr/local/bin") ;; add system path to exec path, for emacs to find sbt

;; use a custom file
(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)
