;;
;; hacks.lisp
;;
;; where code snippets that aren't quite throwaway are
;; preserved
;;
;; this file probably won't make much sense and shouldn't be
;; compiled.

(capture-to-string
 (div :body "hello"))
 
(maccy t
  (div :args '(:id "container") :body
       (capture-to-string (h1 :body "This is the title")
			  (p :body (list "Here is some content" (capture-to-string (em :body "for you"))))))
  
  (div :args '(:id "footer") :body
       (capture-to-string (p :body "Copyright YourSite &copy; 2015"))))

(defun hack (thing)
  (format nil "~a" (type-of (car thing))))

(defmacro maccy2 (&body b)
  (format nil "~a" (type-of (car b))))




(defmacro maccy3 (&optional (args nil) &body body)
  (format t "args=~s~%" args)
  (format t "body=~s~%" body)
  )



(defun tags (&rest kids)
  (if kids
      (let ((tt (car kids))
	    (rest (rest kids)))
	(cons tt (apply #'tags rest))))
	
  )

(defmacro mtags (&rest nodes)
  `(list ,@(mapcar (lambda (n)
		     (if (stringp n)
			 n
			 (lambda ()
			   (with-defined-tags n))))
		   nodes))
  )



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


(defun encapsulate (&rest body)
  (mapcar (lambda (n)
		 (if (constantp n)
		     (lambda (_) (declare (ignore _)) (format t "~a" n))
		     n))
	       body))




#|
(defun encapsulate (&body body)
  (let ((functionified (mapcar (lambda (n)
		 (if (constantp n)
		     (lambda () (format t "~a" n))
		     n))
	       body)))
    (list
       ,@functionified)))
|#

(defun yeah ()
  (defun oh-fiddly ()
    (format t "Hello")))





(defmacro with-defined-tags (s &body body)
  (let ((mappers (mappers-for-tags s)))
    
    `(labels (,@mappers
	      (contains (&rest body)
		(mapcar (lambda (n)
			  (if (constantp n)
			      (lambda () (format ,s "~a" n))
			      n))
			body))
		)
	 ,@body)))



(defmacro hoi (s)
  `(format ,s "hello!~%"))

(defmacro hoihoi ()
  (let ((s (gensym)))
    `(with-output-to-string (,s)
       (hoi ,s))))

(defmacro xxx ((arg &key thing) &body body)
  `(progn
     (format t "~a  thing=~a~%" ,arg ,thing)
     ,@body))
