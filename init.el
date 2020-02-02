(require 'package)

(setq package-archives
      '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
        ("melpa" . "http://elpa.emacs-china.org/melpa/")
        ("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")))

;;helm
;;helm-projectile
;; M 是格式化多行, O变成一行, m选中表达式
(setq package-selected-packages
      '(ivy
        cider
        clojure-mode
        smartparens
        projectile
        company
        ag
        counsel-projectile
        monokai-theme
        lispy
        multiple-cursors
        easy-kill
        yasnippet
        company-posframe
        clj-refactor
        magit
        neotree
        multi-term
        exec-path-from-shell
        vterm
        doom-themes
        use-package))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-selected-packages)
  (when (and (assq package package-archive-contents)
             (not (package-installed-p package)))
    (package-install package t)))

;; my setting
(load-theme 'doom-molokai t)


(windmove-default-keybindings)

;; (global-company-mode -1) ;;在mutil-term下面不用company补全
(add-hook 'prog-mode-hook 'company-mode)

;;(helm-mode 1)
(ivy-mode 1)

(counsel-projectile-mode 1)

;;(require 'helm-config)

;;(helm-projectile-on)

;; global:
;; Better Defaults
(setq-default
 inhibit-x-resources t
 ;; inhibit-splash-screen t
 ;; inhibit-startup-screen t
 initial-scratch-message ""
 ;; Don't highlight line when buffer is inactive
 hl-line-sticky-flag nil
 ;; Prefer horizental split
 split-height-threshold nil
 split-width-threshold 120
 ;; Don't create lockfiles
 create-lockfiles nil
 ;; UTF-8
 buffer-file-coding-system 'utf-8-unix
 default-file-name-coding-system 'utf-8-unix
 default-keyboard-coding-system 'utf-8-unix
 default-process-coding-system '(utf-8-unix . utf-8-unix)
 default-sendmail-coding-system 'utf-8-unix
 default-terminal-coding-system 'utf-8-unix
 ;; Add final newline
 require-final-newline t
 ;; Larger GC threshold
 gc-cons-threshold (* 100 1024 1024)
 ;; Backup setups
 backup-directory-alist `((".*" . ,temporary-file-directory))
 auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 ;; Xref no prompt
 xref-prompt-for-identifier nil
 ;; Mouse yank at point instead of click position.
 mouse-yank-at-point t
 ;; This fix the cursor movement lag
 auto-window-vscroll nil
 ;; Don't wait for keystrokes display
 echo-keystrokes 0
 show-paren-style 'parenthese
 ;; Overline no margin
 overline-margin 0
 tab-width 4
 ;; Don't show cursor in non selected window.
 cursor-in-non-selected-windows nil
 comment-empty-lines t)

(setq-default indent-tabs-mode nil)

(prefer-coding-system 'utf-8)

;; Show matched parens
(setq show-paren-delay 0.01)
(show-paren-mode 1)

;; Always use dir-locals.
(defun safe-local-variable-p (sym val) t)

;; Auto revert when file change.
(global-auto-revert-mode 1)

;; Delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Custom file path
;; Actually we don't need custom file, this file can be generated
;; accidentally, so we add this file to .gitignore and never load it.
(setq custom-file "~/.emacs.d/custom.el")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(projectile-global-mode 1)

;; steve
(define-key global-map (kbd "C-x C-o") 'counsel-projectile-switch-project)
;; 需要在*scratch*的buffer下才能执行成功
(define-key global-map (kbd "C-x C-a") 'counsel-projectile-ag)

(define-key global-map (kbd "C-p") 'counsel-projectile-find-file)
;; 关闭所有buffer: 针对project来的
(define-key global-map (kbd "C-c C-q") 'projectile-kill-buffers)

;; M-> & M-< 跳到最后;;*
(global-set-key (kbd "C-c m") 'end-of-buffer)
(global-set-key (kbd "M-g") 'goto-line)
;; "M-@"的当前选择光标开始选择
(global-set-key (kbd "M-2") 'set-mark-command)

;; 运行上一条执行的命令
(global-set-key (kbd "M-p") 'ivy-resume)

;; C-x C-v
(global-set-key (kbd "C-c k") 'find-alternate-file) ;; C-x k 是kill-buffer

(global-set-key (kbd "C-s") 'swiper)


;; M-w w 复制一个单词 和表达式
(global-set-key (kbd "M-w") 'easy-kill)

;; 多光标编辑: C-@选中 => C-> 下一个 ... => 回车退出
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/skip-to-next-like-this)

;; d 是 %, j下一个表达式 k上一个表达式, e是执行
;; s和w可以交换表达式, 大于号吞表达式,小于号吐出来表达式 ;; c克隆
;; 注释掉就可以避免lispy的编辑模式了, M-@ 一直按下去会向下选中
;; m 是选中一个s表达式: https://github.com/abo-abo/lispy ;; M-w 复制单行
;; M格式化多行, i是缩进
;; 删除单个括号的办法: M-@选中单个括号就能删除它了
(add-hook 'emacs-lisp-mode-hook 'lispy-mode)
(add-hook 'clojure-mode-hook 'lispy-mode)

;; 用 `emacs --daemon` => `emacsclient -c`
(require 'server)
(unless (server-running-p)
  (server-start))

(setq-default cider-default-cljs-repl 'shadow)
(setq cider-offer-to-open-cljs-app-in-browser nil)

(setq cider-prompt-for-symbol nil)

;; TODO: 在mutil-term下面不需要这个补全,不然会导致zsh的补齐不了
;; (eval-after-load
;;     'company-mode
;;   (progn
;;     (define-key company-mode-map (kbd "<tab>")
;;       'company-indent-or-complete-common)
;;     (define-key company-mode-map (kbd "TAB")
;;       'company-indent-or-complete-common)))
;; 补全列表的中文错位问题
;; (company-posframe-mode 1)
;; C-c C-c执行顶级表达式:忽略掉(comment (+ 1 2))

(use-package company :bind
  (("<tab>" . 'company-indent-or-complete-common)
   ("TAB" . 'company-indent-or-complete-common)))

(setq clojure-toplevel-inside-comment-form t)
;; 去掉强化的js补全,会导致很卡 => t是打开
(setq cider-enhanced-cljs-completion-p t)

(require 'hideshow)
(define-key global-map (kbd "C-x C-h") 'hideshow-toggle-hidding)

;; C-2出来用法注释
(defun user/clojure-hide-comment (&rest args)
  (save-mark-and-excursion
    (while (search-forward "(comment" nil t)
      (hs-hide-block))))
(add-hook 'clojure-mode-hook 'user/clojure-hide-comment)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)


(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; M-. cider定义跳转, M-, cider定义返回

;; M-x magit-status => TODO: d 是 diff, a是add, c是checkout, #  按下修改的文件就会打印出来

(global-set-key [f8] 'neotree-toggle)

;; 在Emacs启动的mutil-term是zsh # 在外面终端启动的是closh
(defun zsh ()
  (interactive)
  (multi-term))

;; 解决Mac上面直接启动Emacs,而不是终端启动Emacs的PATH问题
(exec-path-from-shell-initialize)

(defun swich-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))
