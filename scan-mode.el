;;; scan-mode.el --- minor mode for viewing security scan results
;;
;; Copyright (C) 2016 Peter Mosmanas
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation version 3 or later.
;;
;; Author:  Peter Mosmans <support@go-forward.net>
;; Version: 0.1
;; Keywords: languages, nikto, nmap, security, testssl.sh
;; URL: https://github.com/PeterMosmans/scan-mode
;;
;;; Commentary:
;;
;; This is a mode for highlighting results from security scanners
;; like analyze_hosts, Nikto, nmap and testssl.sh.
;;
;;; Code:
(provide 'scan-mode)

(defvar scan-mode-hook nil "Hook run after `scan-mode`.")
(add-to-list 'auto-mode-alist '("\\-output.txt\\'" . scan-mode))

(defvar scan-mode-high-regexp
  (concat "Downgrade attack prevention NOT supported" "\\|"
    "NOT ok" "\\|"
    "Signature Algorithm[[:space:]]+SHA1 with RSA" "\\|"
    "TLS 1.2[[:space:]]+not offered" "\\|"
    "VULNERABLE" "\\|"
    "OSVDB\\-[[:digit:]]+"
    )
  "Regular expressions that match HIGH alerts.")

(defvar scan-mode-medium-regexp
  (concat "DEBUG HTTP verb may show server debugging information." "\\|"
    "Server leaks inodes via ETags" "\\|"
    "The anti-clickjacking X-Frame-Options header is not present." "\\|"
    "The site uses SSL and the Strict-Transport-Security HTTP header is not defined." "\\|"
    "The X-Content-Type-Options header is not set." "\\|"
    "The X-XSS-Protection header is not defined." "\\|"
    "[[:digit:]]+\\/tcp[[:blank:]]+open"
    )
  "Regular expressions that match MEDIUM alerts.")

(defvar scan-mode-information-regexp
  (concat "does not match certificate's names: [[:alpha:]]+" "\\|"
    "Cookie \\([[:alpha:]]+\\) created without the \\([[:alpha:]]+\\) flag" "\\|"
    "Target IP: \\([[:digit:]]+\\)" "\\|"
    "Target Hostname: \\([[:alpha:]]+\\)" "\\|"
    "Target Port:.\\([[:digit:]]+" "\\|"
    "Root page / redirects to: \\(.*\\)")
  "Regular expressions that match Informational items.")

(defvar scan-mode-keywords
  `((,scan-mode-high-regexp . font-lock-warning-face)
    (,scan-mode-medium-regexp . font-lock-type-face)
    (,scan-mode-information-regexp 1 font-lock-comment-face)
    ))

(define-derived-mode scan-mode fundamental-mode "scan"
  "Minor mode for highlighting security scan results from e.g. nikto, nmap and testssl.sh"
  (setq font-lock-defaults '((scan-mode-keywords))))

;;; scan-mode.el ends here
