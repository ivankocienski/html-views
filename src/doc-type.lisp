(in-package :html-views)

(defconstant +DOC-TYPES+
  '((:ver-1.1 . "html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\"")
    (:ver-1.0-frameset . "html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\"")
    (:ver-1.0-transitional . "html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"")
    (:ver-1.0-strict . "html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"")
    (:ver-4.01-framset . "HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\"")
    (:ver-4.01-transitional . "HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"")
    (:ver-4.01-strict . "HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\"")
    (:ver-5 . "html")))

(defparameter *doc-type* :ver-1.1)

(defun set-doctype (wants)
  (let ((type (car (assoc wants +DOC-TYPES+))))
    (if type
	(setf *doc-type* type)
	(error (format nil "set-doctype: error: could not find doctype '~a'" wants)))))

(defun write-doctype (s)
  (format s "<!DOCTYPE ~a>" (cdr (assoc *doc-type* +DOC-TYPES+))))
