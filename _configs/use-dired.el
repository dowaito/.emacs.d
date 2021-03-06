;;; use-dired --- initialize dired
;;; Commentary:
;;; Code:
(require 'use-package)

(use-package dired
  :init
  (progn
    (use-package dired-details+)
    (use-package dirtree)

    (bind-key "C-x C-d" 'ido-dired)

    (setq dired-details-initially-hide t)

    (defun my-dired-find-file (&optional arg)
      "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
      (interactive "P")
      (let* ((fn-list (dired-get-marked-files nil arg)))
        (mapc 'find-file fn-list)))

    (add-hook 'dired-after-readin-hook #'(lambda () (dired-details-activate)))

    (add-hook 'dired-mode-hook #'(lambda ()
                                   (visual-line-mode 0)
                                   (linum-mode 0)
                                   (auto-revert-mode))))
  :bind (:map dired-mode-map
              ("W" . wdired-change-to-wdired-mode)
              ("F" . my-dired-find-file)))

(provide 'use-dired)
;;; use-dired ends here
