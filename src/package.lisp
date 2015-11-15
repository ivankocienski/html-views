(in-package :cl-user)

(defpackage :html-views
  (:use :cl)
  (:export :render
	   :list-views
	   :nuke-views
	   :set-doctype
	   :deflayout
	   :defview))
