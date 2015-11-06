(in-package :html-view)

(defconstant +TAG-NAMES+
  ;; ( name . closed)
  '((div   . nil)
    (input . T )
    (p     . nil)
    (br    . T)
    (hr    . T)
    (span  . nil)
    (a     . nil)
    (em    . nil)
    (h1    . nil)
    (ul    . nil)
    (li    . nil)
    (h3    . nil)))

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

(defmacro with-defined-tags-for-stream (s &body body)
  `(macrolet (,@(mapcar (lambda (tl)
			  (let* ((name (car tl))
				 (name-s (string-downcase (format nil "~a" name)))
				 (closed (cdr tl)))

			    (list name `(&optional (args nil) &body body)
				  (if closed `(declare (ignore body)))
				  
				  (if closed

				      ``(progn
					  (format ,',s ,',(format nil "<~a" name-s))
					  (tag-attributes ,',s ,args)
					  (format ,',s " />"))
				      
				      ``(progn
					  (format ,',s ,',(format nil "<~a" name-s))
					  (tag-attributes ,',s ,args)
					  (format ,',s ">")
					  (progn ,@body)
					  (format ,',s ,',(format nil "</~a>" name-s))
					  )))))
			
			+TAG-NAMES+))
     ,@body))

(defmacro render (&body body)
  (let ((s (gensym)))
    `(with-output-to-string (,s)
       (macrolet ((str (text) `(format ,',s "~a" ,text)))
	 (with-defined-tags-for-stream ,s
	   ,@body))))
  )
