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



