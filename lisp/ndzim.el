;;; ndzim.el --- Lookup ZIM file front-end  -*- lexical-binding: t -*-
;; Copyright (c) KAWABATA, Taichi

;; Author: KAWABATA, Taichi <kawabata.taichi_at_gmail.com>
;; Description: Lookup OpenZIM agent
;; Created: 2013/03/07
;; Keywords: OpenZIM, Wikipedia
;; Version: 0.0.1
;; Package-version: 0.0.1
;; URL: http://lookup2.github.com/

;;; Commentary:

;; This agent provides searching capabilities for OpenZIM file.
;; for details of OpenZIM format, see http://www.openzim.org/

;; Specify the location of XXX.zim in lookup-search-agents variable.
;; e.g.
;; (setq lookup-search-agents
;;       '(...
;;         (ndzim "/path/to/dir")
;;         ...))

;;; Code:

(eval-when-compile (require 'cl))
(eval-when-compile (require 'cl-lib))
(require 'lookup)

(defconst ndzim-version "0.1")

(defvar ndzim-search         "zimsearch")
(defvar ndzim-search-options '("--weight-dist" "0"))
(defvar ndzim-dump           "zimdump")
(defvar ndzim-w3m            "w3m")
(defvar ndzim-w3m-options    '("-halfdump"
                               "-o" "ext_halfdump=1"
                               "-o" "fix_width_conv=1"
                               "-o" "ucs_conv=1"
                               "-O" "UTF-8"))

(defface ndzim-bold-face
  '((t (:weight bold)))
  "Face used to bold text."
  :group 'ndzim
  :group 'lookup-faces)

(defface ndzim-italic-face
  '((t (:slant italic)))
  "Face used to italic text."
  :group 'ndzim
  :group 'lookup-faces)

(put 'ndzim :methods '(exact prefix))

;;;
;:: Interface functions
;;;
(put 'ndzim :list 'ndzim-list)
(defun ndzim-list (agent)
  (ndzim--check-environment)
  (let* ((dir (lookup-agent-location agent)))
    (when (file-directory-p dir)
      (loop for file in (directory-files dir nil "\\.zim$")
            collect (lookup-new-dictionary agent file)))))

(put 'ndzim :title 'ndzim-title)
(defun ndzim-title (dictionary)
  (or (lookup-dictionary-option dictionary :title)
      (file-name-sans-extension
       (lookup-dictionary-name dictionary))))

(put 'ndzim :search 'ndzim-dictionary-search)
(defun ndzim-dictionary-search (dictionary query)
  (ndzim--check-environment)
  (let* ((string  (lookup-query-string query))
         (method  (lookup-query-method query))
         (file    (expand-file-name
                   (lookup-dictionary-name dictionary)
                   (lookup-agent-location
                    (lookup-dictionary-agent dictionary)))))
    (loop for (code head) in (ndzim-search string method file)
          do (message "debug: code=%s head=%s" code head)
          collect (lookup-new-entry 'regular dictionary code head))))
    
(put 'ndzim :content 'ndzim-dictionary-content)
(defun ndzim-dictionary-content (entry)
  (ndzim--check-environment)
  (let* ((dictionary (lookup-entry-dictionary entry))
         (agent      (lookup-dictionary-agent dictionary))
         (file       (expand-file-name
                      (lookup-dictionary-name dictionary)
                      (lookup-agent-location agent)))
         (heading    (lookup-entry-heading entry)))
    (ndzim-content heading file)))

(put 'ndzim :arrange-table '((reference ndzim-arrange-references
                                        ndzim-arrange-image
                                        ndzim-arrange-tags)
                             (fill      lookup-arrange-nofill)))

;;; Supplementary Functions

(defun ndzim--dictionary-file (dictionary)
  (let ((agent (lookup-dictionary-agent dictionary)))
    (expand-file-name
     (lookup-dictionary-name dictionary)
     (lookup-agent-location agent))))

(defun ndzim--check-environment ()
  (dolist (exec (list ndzim-search ndzim-dump ndzim-w3m))
    (unless (executable-find exec)
      (error "ndzim: required application `%s' can not be found." exec))))

;;;
;;; Internal Functions
;;; 

(defun ndzim-extract (url file)
  (unless (string-match "^[AI]/" url) (error "Improper ZIM URL!"))
  (let* ((url-file (concat temporary-file-directory "/" url))
         (directory (file-name-directory url-file)))
    (unless (file-directory-p directory) (make-directory directory))
    (message "url-file=%s" url-file)
    (unless (file-exists-p url-file)
      (call-process ndzim-dump nil (list :file url-file) nil
                    "-u" url "-d" (file-truename file)))
    url-file))

(defun ndzim-search (string method file)
  (with-temp-buffer
    (call-process ndzim-search nil (current-buffer) nil 
                  (file-truename file) string)
    (let (result (count 0) (max (if (equal method 'exact) 1 lookup-max-hits)))
      (goto-char (point-min))
      (while (and (re-search-forward "^article \\([0-9]+\\).*\t:\t\\(.+\\)" nil t)
                  (< count max))
        (push (list (match-string 1) (match-string 2)) result)
        (incf count))
      (nreverse result))))

(defun ndzim-content (heading file)
  (let ((url-file (ndzim-extract (concat "A/" heading ".html") file)))
    (setq args (append ndzim-w3m-options (list url-file)))
    (with-temp-buffer
      ;;(lookup-debug-message "w3m args=%s" args)
      (apply 'call-process ndzim-w3m nil (current-buffer) nil args)
      (buffer-string))))

;;;
;;; Arrange Functions
;;;

(defun ndzim-arrange-references (entry)
  (let ((dictionary (lookup-entry-dictionary entry))
        (case-fold-search t))
    (while (re-search-forward "<a .*?href=\"\\(.+?\\)\".*?>\\(.+?\\)</a>" nil t)
      (let* ((href (match-string 1))
             (ref (save-match-data
                    (if (string-match "^/A/\\(.+\\)\\.html" href)
                        (match-string 1 href)))))
        (lookup-set-link (match-beginning 2) (match-end 2)
                         (if ref (lookup-new-entry 'regular dictionary ref ref)
                           (lookup-new-entry 'url dictionary href href)))
        (delete-region (match-end 2) (match-end 0))
        (delete-region (match-beginning 0) (match-beginning 2))))
    (goto-char (point-min))))

(defun ndzim-arrange-image (entry)
  (let* ((dictionary (lookup-entry-dictionary entry))
         (file (ndzim--dictionary-file dictionary))
         (case-fold-search t))
    (while (re-search-forward
            "<img_alt .*?src=\"/\\(.+?\\)\".*?>\\(.+?\\)</img_alt>" nil t)
      (let* ((img-url (match-string 1))
             (img-file (save-match-data (ndzim-extract img-url file))))
        (lookup-img-file-insert img-file 'png (match-beginning 0) (match-end 0))))))

(defun ndzim-arrange-tags (ignored)
  (let ((case-fold-search t))
    (goto-char (point-min))
    (while (re-search-forward "<b>\\(.+?\\)</b>" nil t)
      (add-text-properties (match-beginning 1) (match-end 1)
                           '(face ndzim-bold-face))
      (delete-region (match-end 1) (match-end 0))
      (delete-region (match-beginning 0) (match-beginning 1)))
    (goto-char (point-min))
    (while (re-search-forward "<i>\\(.+?\\)</i>" nil t)
      (add-text-properties (match-beginning 1) (match-end 1)
                           '(face ndzim-italic-face))
      (delete-region (match-end 1) (match-end 0))
      (delete-region (match-beginning 0) (match-beginning 1)))
    (goto-char (point-min))
    (while (re-search-forward "<i>\\(.+?\\)</i>" nil t)
      (add-text-properties (match-beginning 1) (match-end 1)
                           '(face ndzim-italic-face))
      (delete-region (match-end 1) (match-end 0))
      (delete-region (match-beginning 0) (match-beginning 1)))
    (goto-char (point-min))
    (while (re-search-forward "</?span.*?>" nil t)
      (replace-match ""))
    (goto-char (point-min))
    (while (re-search-forward "</?_SYMBOL.*?>" nil t)
      (replace-match ""))
    (goto-char (point-min))
    (while (re-search-forward "<.+?>" nil t)
      (replace-match "")
      )))

(provide 'ndzim)
