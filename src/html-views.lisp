(in-package :html-views)


    
(defun tag-attributes (s opts)
  (if opts
      (let ((name  (string-downcase (car opts)))
	    (value (cadr opts))
	    (rest  (cddr opts)))
	
	(if value
	    (format s
		    " ~a=\"~a\""
		    name
		    (if (eq (type-of value) 'boolean)
			name
			value)))
	
	(if rest (tag-attributes s rest)))))

(defmethod tag-definitions (s tag-list)
  (mapcar (lambda (tl)
	    (let* ((name (car tl))
		   (name-symbol (intern (format nil "~a" name) *package*))
		   (name-s (string-downcase (format nil "~a" name)))
		   (closed (cdr tl)))

	      (list name-symbol `(&optional (args nil) &body body)
		    (if closed `(declare (ignore body)))

		    ;; TODO FIXME: er- for some reason if you
		    ;; use double back quotes they turn into a regular
		    ;; single quote if used more than once. aint
		    ;; lisp magical?
		    ;;``(progn
			;;(princ ,',(format nil "<~a" name-s) ,',s))
			;;(tag-attributes ,',s ,args))
		    
		    (if closed

			``(progn	       
			    (princ ,',(format nil "<~a" name-s) ,',s)
			    (tag-attributes ,',s ,args)
			    (princ "/>" ,',s))
			
			``(progn
			    (princ ,',(format nil "<~a" name-s) ,',s)
			    (tag-attributes ,',s ,args)
			    (princ ">" ,',s)
			    (progn ,@body)
			    (princ ,',(format nil "</~a>" name-s) ,',s)
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
		    (declare (ignorable local-vars)
			     (ignorable html-output-stream))
		    
		    (macrolet ((,(intern "STR" *package*) (text) `(princ ,text html-output-stream))
			       (,(intern "STR-ESC" *package*) (text) `(escape-to-stream html-output-stream ,text))
			       (,(intern "RENDER" *package*) (name &optional local-overides) `(invoke-view html-output-stream ,name (append ,local-overides local-vars))))
		      (with-defined-local-pullouts ,locals local-vars
			(with-defined-tags-for-stream html-output-stream ,+TAG-NAMES+
			  ,@body))))))



(defmacro deflayout ((name &key locals default) &body body)
  `(register-layout ,name
		    (lambda (html-output-stream local-vars yield-function)
		      (declare (ignorable local-vars)
			       (ignorable html-output-stream)
			       (ignorable yield-function))
		      
		      (macrolet ((,(intern "STR" *package*) (text) `(princ ,text html-output-stream))
				 (,(intern "STR-ESC" *package*) (text) `(escape-to-stream html-output-stream ,text))
				 (,(intern "YIELD" *package*)  () `(funcall yield-function html-output-stream local-vars))
				 (,(intern "RENDER" *package*) (name &optional local-overides) `(invoke-view html-output-stream ,name (append ,local-overides local-vars))))
			
			(with-defined-local-pullouts ,locals local-vars
			  (with-defined-tags-for-stream html-output-stream ,+LAYOUT-TAG-NAMES+
			    (with-defined-tags-for-stream html-output-stream ,+TAG-NAMES+
			      (write-doctype html-output-stream)
			      ,@body)))))
		    ,default))


