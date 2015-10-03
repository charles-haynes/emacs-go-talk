;;; init.el --- emacs init file                      -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Charles Haynes

;; Author: Charles Haynes <ceh@ceh.bz>
;; Keywords: internal, local, extensions

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Simple init.el file for demonstrating Go development in emacs
;; just loads pallet in order to load dependent packages as specified in
;; the Cask file
;; 

;;; Code:
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my-lisp"))

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'custom)
(require 'hooks)

(provide 'init)
;;; init.el ends here
