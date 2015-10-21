(in-package :html-view)

(defun tag-attributes (s &rest opts)
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
	(if rest (apply #'tag-attributes s rest))))
  s)

(defun compose-tag (s name &key (args nil) (body nil) (closed nil))
  (labels ((output-body (b)
	     (cond
	       ((stringp   b) (format s "~a" b))
	       ((functionp b) (funcall b s))
	       ((listp     b) (dolist (bb b) (output-body bb)))))
	   
	   (tag-attributes (s &rest opts)
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
		   (if rest (apply #'tag-attributes s rest))))))
	   
    (format s "<~a" name)
    (if args (apply #'tag-attributes s args))
    
    (if closed
	(format s " />")
	
	(progn
	  (format s ">")
	  (output-body body)
	  (format s "</~a>" name))))
  s)

(defmacro with-my-html-output-to-string (&body body)
  `(labels ((div (&optional (args nil) (body nil))
	      (compose-tag t "div" :args args :body body)))

    (progn ,@body))
   
  )

(with-my-html-output-to-string ()
  (tag "p" '(:thing t) "yes"))

(tag t
     "p"
     :args '(:type "text" :name nil :value "a valuable thing")
     :body (list "hello " (lambda (s)
			    (tag s
				 "em"
				 :body "hey"))))

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

(defmacro maccy (s &body body)
  (let ((mappers (map 'list
		      (lambda (l)
			(let ((name (car l)) (closed (cdr l)))
			  (if closed
			      (list (intern (string-upcase name))
				    '(&key (args nil) (body nil))
				    (list 'compose-tag s name :args 'args :body 'body :closed t))
			  
			      (list (intern (string-upcase name))
				    '(&key (args nil) (body nil))
				    (list 'compose-tag s name :args 'args :body 'body)))))
		      
		      +TAG-NAMES+)))
    
    `(labels (,@mappers)
       ,@body)))


;        (dolist (tn '("div" "span" "p" "a" "form" "input"))
;      (push (list (intern (string-upcase tn)) (list 'tag t tn)) out))
;    out)

(defun mappers-for-tags (stream-arg)
  (map 'list
       (lambda (l)
	 (let ((name (car l)) (closed (cdr l)))
	   (if closed
	       (list (intern (string-upcase name))
		     '(&key (args nil) (body nil))
		     (list 'compose-tag stream-arg name :args 'args :body 'body :closed t))
	       
	       (list (intern (string-upcase name))
		     '(&key (args nil) (body nil))
		     (list 'compose-tag stream-arg name :args 'args :body 'body)))))
       
       +TAG-NAMES+))

(defmacro capture-to-string (&body body)
  (let ((mappers (mappers-for-tags 's)))
    
    `(with-output-to-string (s)
       (labels (,@mappers)
	 ,@body)))
  )
  


