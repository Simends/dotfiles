;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Simen Dager Sneve"
      user-mail-address "smndagersneve@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "SourceCodePro" :size 15 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'org-roam-protocol)
(setq org-roam-directory "~/Documents/Org/Roam/")
(setq org-roam-graph-viewer "firefox")
(setq org-roam-dailies-directory "~/Documents/Org/Roam/Dailies")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         #'org-roam-capture--get-point
         "* %?"
         :file-name "daily/%<%Y-%m-%d>"
         :head "#+title: %<%Y-%m-%d>\n\n")))
(map! :leader
      :desc "Insert new roam file"
      "r i" #'org-roam-insert
      :leader
      :desc "Find roam file"
      "r f" #'org-roam-find-file
      :leader
      :desc "Graph org roam"
      "r g" #'org-roam-server-mode
      :leader
      :desc "Start org roam buffer"
      "r b" #'org-roam-buffer-toggle-display
      :leader
      :desc "Skriv om dagen idag"
      "r d" #'org-roam-dailies-find-today)

;; Collect all .org from my Org directory and subdirs
;(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'") ; default value
;(defun load-org-agenda-files-recursively (dir) "Find all directories in DIR."
;    (unless (file-directory-p dir) (error "Not a directory `%s'" dir))
;    (unless (equal (directory-files dir nil org-agenda-file-regexp t) nil)
;      (add-to-list 'org-agenda-files dir)
;    )
;    (dolist (file (directory-files dir nil nil t))
;        (unless (member file '("." ".."))
;            (let ((file (concat dir file "/")))
;                (when (file-directory-p file)
;                    (load-org-agenda-files-recursively file)
;                )
;            )
;        )
;    )
;)
;(load-org-agenda-files-recursively "~/Cloud/Dropbox/Org/" ) ; trailing slash required

(load-library "find-lisp")
(setq org-agenda-files
   (find-lisp-find-files "~/Documents/Org" "\.org$"))

(map! :map elfeed-search-mode-map
      :after elfeed-search
      [remap kill-this-buffer] "q"
      [remap kill-buffer] "q"
      :n doom-leader-key nil
      :n "q" #'+rss/quit
      :n "e" #'elfeed-update
      :n "r" #'elfeed-search-untag-all-unread
      :n "u" #'elfeed-search-tag-all-unread
      :n "s" #'elfeed-search-live-filter
      :n "RET" #'elfeed-search-show-entry
      :n "o" #'elfeed-search-show-entry
      :n "p" #'elfeed-show-pdf
      :n "+" #'elfeed-search-tag-all
      :n "-" #'elfeed-search-untag-all
      :n "S" #'elfeed-search-set-filter
      :n "b" #'elfeed-search-browse-url
      :n "y" #'elfeed-search-yank)

(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 20 ; Wait until 20 seconds after startup
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-sent-messages-behavior 'delete)
  (setq mu4e-get-mail-command "mbsync -c ~/.config/Mail/mbsyncrc -a")
  (setq mu4e-root-maildir "~/Documents/Mail")
  (setq mu4e-contexts
        (list
         ;; Gmail
         (make-mu4e-context
          :name "Gmail"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "smndagersneve@gmail.com")
                  (user-full-name    . "Simens Gmail")
                  (mu4e-drafts-folder  . "/Gmail/[Gmail]/Drafts")
                  (mu4e-sent-folder  . "/Gmail/[Gmail]/Sent Mail")
                  (mu4e-refile-folder  . "/Gmail/[Gmail]/All Mail")
                  (mu4e-trash-folder  . "/Gmail/[Gmail]/Trash")))
       ;; Hotmail
       (make-mu4e-context
        :name "Hotmail"
        :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/Hotmail" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "simends@hotmail.no")
                (user-full-name    . "Simens Hotmail")
                (mu4e-drafts-folder  . "/Hotmail/Drafts")
                (mu4e-sent-folder  . "/Hotmail/Sent")
                (mu4e-refile-folder  . "/Hotmail/Archive")
                (mu4e-trash-folder  . "/Hotmail/Trash")))
       ;; Studmail
       (make-mu4e-context
        :name "Studmail"
        :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/Studmail" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "simends@stud.ntnu.no")
                (user-full-name    . "Simens Studmail")
                (mu4e-drafts-folder  . "/Studmail/Drafts")
                (mu4e-sent-folder  . "/Studmail/Sent")
                (mu4e-refile-folder  . "/Studmail/Archive")
                (mu4e-trash-folder  . "/Studmail/Trash")))))

  (setq mu4e-maildir-shortcuts
        '(("/Gmail/Inbox"             . ?i)
          ("/Gmail/[Gmail]/Sent Mail" . ?s)
          ("/Gmail/[Gmail]/Trash"     . ?t)
          ("/Gmail/[Gmail]/Drafts"    . ?d)
          ("/Gmail/[Gmail]/All Mail"  . ?a))))

;;(require 'smtpmail)
;;(setq message-send-mail-function 'smtpmail-send-it
;;   starttls-use-gnutls t
;;   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;   smtpmail-auth-credentials
;;     '(("smtp.gmail.com" 587 "smndagersneve@gmail.com" nil))
;;   smtpmail-default-smtp-server "smtp.gmail.com"
;;   smtpmail-smtp-server "smtp.gmail.com"
;;   smtpmail-smtp-service 587)

(require 'exwm)
(require 'exwm-config)
(exwm-config-default)
(require 'exwm-randr)
(setq exwm-randr-workspace-output-plist '(0 "DisplayPort-0" 1 "HDMI-A-0"))
(add-hook 'exwm-randr-screen-change-hook
          (lambda ()
            (start-process-shell-command
             "xrandr" nil "xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x240 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x0 --rotate right
")))
(exwm-randr-enable)
(require 'exwm-systemtray)
(exwm-systemtray-enable)
