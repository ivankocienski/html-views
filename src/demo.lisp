(in-package :html-view)


#|
;; constant
(div "a thing")

;; code
(div (em "a thing"))

;; list
(div
 (h1 "the title")
 (p "hello "
    (em "a thing")))
|#


(with-defined-tags t
  (div :args '(:id "container") :body
       (lambda ()
	 (h1 :body "A title")
	 (p :body "A things' body"))))
       



(defun used-in (paths)
  (capture-to-string
     (h1 :body "Story post used in paths")

     (p :body "back to $thing")

     (capture-to-string
       (if paths
	   (progn
	     (format t "1:paths='~s'~%" paths)

	     (div ;;:args '( :class "list-of-story-paths" )
		  :body "path body"))

	   (progn
	     (format t "2:paths='~s'~%" paths)

	     (p :body "This post has not been used in any paths"))
))))






		:body (list
		       (lambda () (h3 :body "path title"))
		       (lambda () (a :body "
;;	   (dolist (p paths)
	     
;;	    ))

;;(capture-to-string
;; (mtags 
 
