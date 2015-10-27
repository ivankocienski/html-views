(in-package :html-view)

(defconstant +TAG-NAMES+
  ;; ( name . closed)
  '(("div"   . nil)
    ("input" . T )
    ("p"     . nil)
    ("br"    . T)
    ("hr"    . T)
    ("span"  . nil)
    ("a"     . nil)
    ("em"    . nil)
    ("h1"    . nil)))

(defparameter *tag-functions* nil)

(defun tag-attributes (s opts)
  (if opts
      (let ((name (string-downcase (car opts)))
	    (value (cadr opts))
	    (rest (cddr opts)))
	(if value
	    (format s
		    " \"~a\"=\"~a\""
		    name
		    (if (eq (type-of value) 'boolean)
			name
			value)))
	(if rest (tag-attributes s rest)))))

(setf *tag-functions*
      (loop for tag in +TAG-NAMES+ collect
	   (let* ((name (car tag))
		  (closed (cdr tag))
		  (method (if closed
			      ;; closed tag
			      (lambda (stream args body)
				(declare (ignore body))
				(format stream "<~a" name)
				(if args (tag-attributes stream args))		           
				(format stream " />"))

			      ;; tag with content
			      (lambda (stream args body)
				(format stream "<~a" name)
				(if args (tag-attributes stream args))
				(format stream ">")
				(dolist (b body)
				  (funcall b stream))
				(format stream "</~a>" name)))))
	     
	     (cons name method))))





(defun mappers-for-tags (stream-arg)
  (mapcar (lambda (tf)
	    
	    (let ((name   (car tf))
		  (method (cdr tf)))
	      
	      (list (intern (string-upcase name))
		    '(&key (args nil) (body nil))
		    (list 'funcall method stream-arg 'args 'body))))
	  
	  *tag-functions*))



 
(defmacro with-defined-tags (s &body body)
  (let ((mappers (mappers-for-tags s)))
    
    `(labels (,@mappers)
	 ,@body)))

(defmacro capture-to-string (&body body)
  (let ((s (gensym)))
    `(with-output-to-string (,s)
       (with-defined-tags ,s
	 ,@body))))
  

;;(defmacro capture-to-string (&body body)
;;  (let ((mappers (mappers-for-tags 's)))
    
;;    `(with-output-to-string (s)
;;       (labels (,@mappers)
;;	 ,@body))))
  


