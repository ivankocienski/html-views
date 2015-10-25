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


(capture-to-string
  (div :args '(:id "container") :body
       (lambda ()
	 (h1 :body "A title")
	 (p :body "A things' body"))))
       



(defun used-in (paths)
  (capture-to-string
    (mtags
     (h1 :body "Story post used in paths")

     (p :body "back to $thing"))))

;;     (lambda ()
;;       (if (null paths)
;;	   (p :body "This post has not been used in any paths")
;;	   (div :args '( :class "list-of-story-paths" )
;;		:body "path body"))))))
		
;;		:body (list
;;		       (lambda () (h3 :body "path title"))
;;		       (lambda () (a :body "
;;	   (dolist (p paths)
	     
;;	    ))

;;(capture-to-string
;; (mtags 
 
