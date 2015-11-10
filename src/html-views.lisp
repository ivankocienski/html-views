(in-package :html-view)


    
(defun tag-attributes (s opts)
  (if opts
      (let ((name  (string-downcase (car opts)))
	    (value (cadr opts))
	    (rest  (cddr opts)))
	
	(if value
	    (format s
		    " \"~a\"=\"~a\""
		    name
		    (if (eq (type-of value) 'boolean)
			name
			value)))
	
	(if rest (tag-attributes s rest)))))

(defmethod tag-definitions (s tag-list)
  (mapcar (lambda (tl)
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
	  tag-list))

(defmacro with-defined-tags-for-stream (s tag-list &body body)
  `(macrolet (,@(tag-definitions s tag-list))
     ,@body))

(defmacro with-defined-local-pullouts (locals locals-var &body body)
  (if locals
      `(let (,@(mapcar (lambda (n) (list (intern (format nil "~a" n))
					 (list 'cdr (list 'assoc n locals-var)))) locals))
	 ,@body)
      `(progn ,@body))
  )

(defmacro defview ((name &key locals) &body body)
  `(register-view ,name
		  (lambda (html-output-stream local-vars)
		    (macrolet ((str (text) `(format html-output-stream "~a" ,text))
			       (render (name) `(invoke-view html-output-stream ,name local-vars)))
		      (with-defined-local-pullouts ,locals local-vars
			(with-defined-tags-for-stream html-output-stream ,+TAG-NAMES+
			  ,@body))))))



(defmacro deflayout ((name &key locals default) &body body)
  `(register-layout ,name
		    (lambda (html-output-stream local-vars yield-function)
		 
		      (macrolet ((str (text) `(format html-output-stream "~a" ,text))
				 (yield () `(funcall yield-function html-output-stream local-vars)))
			
			(with-defined-local-pullouts ,locals local-vars
			  (with-defined-tags-for-stream html-output-stream ,+LAYOUT-TAG-NAMES+
			    (with-defined-tags-for-stream html-output-stream ,+TAG-NAMES+
			      ,@body)))))
		    ,default))


