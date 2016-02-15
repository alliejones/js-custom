;;; packages.el --- js-custom layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Allie Jones <allie@Allies-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `js-custom-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `js-custom/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `js-custom/pre-init-PACKAGE' and/or
;;   `js-custom/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst js-custom-packages
  '(
    flycheck
    js2-mode))

(defun js-custom/pre-init-flycheck ()
  (spacemacs|use-package-add-hook flycheck
    :post-config
    (progn
      (flycheck-add-mode 'javascript-eslint 'js2-mode))))

(defun js-custom/post-init-flycheck ()
  (spacemacs/add-flycheck-hook 'react-mode-hook))

(defun js-custom/init-js2-mode ()
  (use-package js2-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
      ;; required to make `<SPC> s l' to work correctly
      (add-hook 'js2-mode-hook 'js2-imenu-extras-mode))
    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "w" 'js2-mode-toggle-warnings-and-errors)

      (spacemacs/declare-prefix-for-mode 'js2-mode "mz" "folding")
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "zc" 'js2-mode-hide-element)
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "zo" 'js2-mode-show-element)
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "zr" 'js2-mode-show-all)
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "ze" 'js2-mode-toggle-element)
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "zF" 'js2-mode-toggle-hide-functions)
      (spacemacs/set-leader-keys-for-major-mode 'js2-mode "zC" 'js2-mode-toggle-hide-comments))))


;;; packages.el ends here
