(in-package :html-view)

(defview (:basic)
  (h1 nil (str "hello?"))
  (hr))

(render :basic)



(defview (:with-vars :locals (:name))
  (h1 nil (str (format nil "Hello ~a!" name))))

(render :with-vars :locals '((:name . "alpha")))



(defview (:call-sub-view)
  (div '(:id "container") (render :basic)))
	 


(deflayout (:application :default t)
  (html nil
	(head nil
	      (title nil (str "An application"))
	      (link '(:src "/css/app.css")))
	
	(body nil
	      (h1 nil (str "An application here"))
	      (yield)
	      (div '(:id "footer")
		   (p nil (str "Copyright &copy; Me, Inc. 2015."))))))


(deflayout (:app-2)
  (html nil
	(head nil
	      (title nil (str "Another thingie here")))

	(body nil
	      (yield)
	      (div '(:id "footer")
		   (p nil (str "Bla bla"))))))


(defun escape-to-stream (s string)
  (loop for char across string
     do (case char
	  (#\< (write-sequence "&lt;"   s))
	  (#\> (write-sequence "&gt;"   s))
	  (#\& (write-sequence "&amp;"  s))
	  (#\' (write-sequence "&#039;" s))
	  (#\" (write-sequence "&quot;" s))
	  (t   (princ char s)))))



#|
(defun used-in (posts)
  (render

    (h1 nil (str "hello"))
    
    (p nil
       (a '(:href "/things") (str "back"))
       (str " to the main page"))

    (if posts
	(ul '(:id "story-post-list")
	    (dolist (sp posts)
	      (li '(:class "story-post")
		  (h3 nil (str (format nil "post title ~a" sp))))))
	
	(p nil (str "Sorry, there are no posts"))))
  )
|#
