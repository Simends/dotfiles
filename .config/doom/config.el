(setq user-full-name "Simen Dager Sneve"
      user-mail-address "smndagersneve@gmail.com")

(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 16 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))
      ;; doom-big-font (font-spec :family "SauceCodePro Nerd Font" :size 24 :weight 'Regular'))

(setq display-line-numbers-type `relative)

(setq doom-theme 'doom-palenight
      +doom-dashboard-banner-file (expand-file-name "banner.png" doom-private-dir)
      ;;doom-modeline-icon (display-graphic-p)
      ;;doom-modeline-major-mode-icon t
      doom-modeline-major-mode-color-icon t)
(after! doom-modeline
  (setq doom-modeline-icon (display-graphic-p)
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t))
;; (display-time-24hr-format t)
;; (display-time-day-and-date t)
(display-time-mode 1)

;; (map! :leader
;;       :desc "Read News"
;;       "o n" #'elfeed
;;       :leader
;;       :desc "Fetch a password"
;;       "o w" #'ivy-pass
;;       :leader
;;       :desc "Calendar"
;;       "o c" #'cfw:open-org-calendar
;;       :leader
;;       :desc "Browse the web"
;;       "o W" #'eww
;;       :leader
;;       :desc "Calculator"
;;       "o C" #'calc
;;       :leader
;;       :desc "Chat on IRC"
;;       "o i" #'circe)

;; (map! :leader
;;       :desc "Run make task"
;;       "e m" #'evil-make
;;       :leader
;;       :desc "Chmod"
;;       "e c" #'chmod)
;; (map! :leader
;;       :desc "Open ranger"
;;       "f x" #'ranger)

(setq org-directory "~/Documents/Org/")

(load-library "find-lisp")
(setq org-agenda-files
   (find-lisp-find-files "~/Documents/Org" "\.org$"))

(add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)

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
      (:prefix ("r" . "Org Roam")
      :desc "Insert new roam file" "i" #'org-roam-insert
      :desc "Find roam file" "f" #'org-roam-find-file
      :desc "Graph org roam" "g" #'org-roam-server-mode
      :desc "Start org roam buffer" "b" #'org-roam-buffer-toggle-display
      :desc "Write about today" "d" #'org-roam-dailies-find-today))

(setq projectile-project-search-path '("~/Documents/Projects" "~/.local/src"))

;; (map! :map elfeed-search-mode-map
;;       :after elfeed-search
;;       [remap kill-this-buffer] "q"
;;       [remap kill-buffer] "q"
;;       :n doom-leader-key nil
;;       :n "q" #'+rss/quit
;;       :n "e" #'elfeed-update
;;       :n "r" #'elfeed-search-untag-all-unread
;;       :n "u" #'elfeed-search-tag-all-unread
;;       :n "s" #'elfeed-search-live-filter
;;       :n "RET" #'elfeed-search-show-entry
;;       :n "o" #'elfeed-search-show-entry
;;       :n "p" #'elfeed-show-pdf
;;       :n "+" #'elfeed-search-tag-all
;;       :n "-" #'elfeed-search-untag-all
;;       :n "S" #'elfeed-search-set-filter
;;       :n "b" #'elfeed-search-browse-url
      ;; :n "y" #'elfeed-search-yank)

;; (use-package mu4e
;;   :ensure nil
;;   :load-path "/usr/share/emacs/site-lisp/mu4e/"
;;   ;; :defer 20 ; Wait until 20 seconds after startup
;;   :config

;;   ;; This is set to 't' to avoid mail syncing issues when using mbsync
;;   (setq mu4e-change-filenames-when-moving t)

;;   ;; Refresh mail using isync every 10 minutes
;;   (setq mu4e-update-interval (* 10 60))
;;   (setq mu4e-sent-messages-behavior 'delete)
;;   (setq mu4e-get-mail-command "mbsync -c ~/.config/Mail/mbsyncrc -a")
;;   (setq mu4e-root-maildir "~/Documents/Mail")
;;   (setq mu4e-contexts
;;         (list
;;          ;; Gmail
;;          (make-mu4e-context
;;           :name "Gmail"
;;           :match-func
;;             (lambda (msg)
;;               (when msg
;;                 (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
;;           :vars '((user-mail-address . "smndagersneve@gmail.com")
;;                   (user-full-name    . "Simens Gmail")
;;                   (mu4e-drafts-folder  . "/Gmail/[Gmail]/Drafts")
;;                   (mu4e-sent-folder  . "/Gmail/[Gmail]/Sent Mail")
;;                   (mu4e-refile-folder  . "/Gmail/[Gmail]/All Mail")
;;                   (mu4e-trash-folder  . "/Gmail/[Gmail]/Trash")))
;;        ;; Hotmail
;;        (make-mu4e-context
;;         :name "Hotmail"
;;         :match-func
;;           (lambda (msg)
;;             (when msg
;;               (string-prefix-p "/Hotmail" (mu4e-message-field msg :maildir))))
;;         :vars '((user-mail-address . "simends@hotmail.no")
;;                 (user-full-name    . "Simens Hotmail")
;;                 (mu4e-drafts-folder  . "/Hotmail/Drafts")
;;                 (mu4e-sent-folder  . "/Hotmail/Sent")
;;                 (mu4e-refile-folder  . "/Hotmail/Archive")
;;                 (mu4e-trash-folder  . "/Hotmail/Trash")))
;;        ;; Studmail
;;        (make-mu4e-context
;;         :name "Studmail"
;;         :match-func
;;           (lambda (msg)
;;             (when msg
;;               (string-prefix-p "/Studmail" (mu4e-message-field msg :maildir))))
;;         :vars '((user-mail-address . "simends@stud.ntnu.no")
;;                 (user-full-name    . "Simens Studmail")
;;                 (mu4e-drafts-folder  . "/Studmail/Drafts")
;;                 (mu4e-sent-folder  . "/Studmail/Sent")
;;                 (mu4e-refile-folder  . "/Studmail/Archive")
;;                 (mu4e-trash-folder  . "/Studmail/Trash")))))

;;   (setq mu4e-maildir-shortcuts
;;         '(("/Gmail/Inbox"             . ?i)
;;           ("/Gmail/[Gmail]/Sent Mail" . ?s)
;;           ("/Gmail/[Gmail]/Trash"     . ?t)
          ;; ("/Gmail/[Gmail]/Drafts"    . ?d)
          ;; ("/Gmail/[Gmail]/All Mail"  . ?a))))

;; (emms-all)
;; (emms-default-players)
;; (emms-mode-line 1)
;; (emms-playing-time 1)
;; (setq emms-source-file-default-directory "~/Multimedia/Music"
;;       emms-playlist-buffer-name "*Music*"
;;       emms-info-asynchronously t
;;       emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)
;; (map! :leader
;;       (:prefix ("a" . "EMMS audio player")
;;        :desc "Go to emms playlist" "a" #'emms-playlist-mode-go
;;        :desc "Emms pause track" "x" #'emms-pause
;;        :desc "Emms stop track" "s" #'emms-stop
;;        :desc "Emms play previous track" "p" #'emms-previous
;;        :desc "Emms play next track" "n" #'emms-next))

;;(require 'smtpmail)
;;(setq message-send-mail-function 'smtpmail-send-it
;;   starttls-use-gnutls t
;;   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;   smtpmail-auth-credentials
;;     '(("smtp.gmail.com" 587 "smndagersneve@gmail.com" nil))
;;   smtpmail-default-smtp-server "smtp.gmail.com"
;;   smtpmail-smtp-server "smtp.gmail.com"
;;   smtpmail-smtp-service 587)

;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)
;; (require 'exwm-randr)
;; (setq exwm-randr-workspace-output-plist '(0 "DisplayPort-0" 1 "HDMI-A-0"))
;; (add-hook 'exwm-randr-screen-change-hook
;;          (lambda ()
;;            (start-process-shell-command
;;             "xrandr" nil "xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x240 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x0 --rotate right
;; ")))
;; (exwm-randr-enable)
;; (require 'exwm-systemtray)
;; (exwm-systemtray-enable)
