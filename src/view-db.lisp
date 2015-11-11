(in-package :html-view)

(defparameter *view-db* nil)
(defparameter *layout-db* nil)
(defparameter *default-layout* nil)

;;
;; internal methods for dealing with the grunt work of storing views
;;

(defun init-view-db ()
  "(internal) does a quit sanity check of the view databases"
  (if (not *view-db*)
      (setf *view-db* (make-hash-table)))
  (if (not *layout-db*)
      (setf *layout-db* (make-hash-table)))
  )

(defun register-layout (name codepoint &optional (make-default nil))
  "(internal) store pointer to layout method with name"
  (init-view-db)
  (setf (gethash name *layout-db*)
	codepoint)
  (if (or make-default (null *default-layout*))
      (setf *default-layout* name)))

(defun register-view (name codepoint)
  "(internal) store pointer to view method with name"
  (init-view-db)
  (setf (gethash name *view-db*)
	codepoint))

(defun invoke-view (s name locals)
  "(internal) render method for a view"
  (let ((codepoint (gethash name *view-db*)))

    (if codepoint
	(funcall codepoint s locals)
	(error (format nil "view \"~a\" not found" name)))))

;;
;; public API to be used by upstream code
;;


(defun render (name &key (locals nil) (layout nil))
  "renders a given view with layout"
  (init-view-db)
  (if (null *default-layout*)
      (error "You have not set a default layout"))
  
  (with-output-to-string (s)
    
    (let* ((wants-layout (or layout *default-layout*))
	   (layout-codepoint (gethash wants-layout *layout-db*)))
	   
	   (if layout-codepoint
	       (funcall layout-codepoint s locals (lambda (s locals) (invoke-view s name locals)))
	       (error (format nil "layout \"~a\" not found" wants-layout)))))
  )

(defun list-views ()
  "dumps info about view databases"
  (maphash (lambda (n _)
	     (declare (ignore _))
	     (format t "layout ~a ~a~%" n (if (eq n *default-layout*) "(default)")))
	   *layout-db*)
  
  (maphash (lambda (n _)
	     (declare (ignore _))
	     (format t "view  ~a~%" n))
	   *view-db*))

(defun nuke-views ()
  "clear all the view databases"
  (setf *view-db* nil
	*layout-db* nil
	*default-layout* nil))


(defun escape-to-stream (s string)
  (loop for char across string
     do (case char
	  (#\< (write-sequence "&lt;"   s))
	  (#\> (write-sequence "&gt;"   s))
	  (#\& (write-sequence "&amp;"  s))
	  (#\' (write-sequence "&#039;" s))
	  (#\" (write-sequence "&quot;" s))
	  (t   (princ char s)))))



