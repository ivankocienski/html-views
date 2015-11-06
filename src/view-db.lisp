(in-package :html-view)

(defparameter *view-db* nil)

(defun init-view-db ()
  (if (not *view-db*)
      (setf *view-db* (make-hash-table)))
  )

(defun nuke-views ()
  (setf *view-db* nil))

(defun register-view (name codepoint)
  (init-view-db)
  (setf (gethash name *view-db*) codepoint))

(defun render (name &optional locals)
  (with-output-to-string (s)
    (let ((codepoint (gethash name *view-db*)))
      (if codepoint
	  (funcall codepoint s locals)
	  (error (format nil "view \"~a\" not found" name)))))
  )

(defun list-views ()
  (maphash (lambda (n _)
	     (declare (ignore _))
	     (format t "  ~a~%" n))
	   *view-db*))
