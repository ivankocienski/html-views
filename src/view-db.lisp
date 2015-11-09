(in-package :html-view)

(defparameter *view-db* nil)
(defparameter *layout* nil)

(defun init-view-db ()
  (if (not *view-db*)
      (setf *view-db* (make-hash-table)))
  )

(defun set-layout (codepoint)
  (setf *layout* codepoint))

(defun nuke-views ()
  (setf *view-db* nil))

(defun register-view (name codepoint)
  (init-view-db)
  (setf (gethash name *view-db*) codepoint))

(defun render (name &optional locals)
  (with-output-to-string (s)
    (let ((codepoint (gethash name *view-db*)))
      (if codepoint
	  (funcall *layout* s locals codepoint)
	  (error (format nil "view \"~a\" not found" name)))))
  )

(defun list-views ()
  (if *layout*
      (format t "layout defined~%")
      (format t "layout not defined~%"))
  (maphash (lambda (n _)
	     (declare (ignore _))
	     (format t "  ~a~%" n))
	   *view-db*))
