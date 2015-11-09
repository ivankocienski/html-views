(in-package :html-view)

(defview :basic ()
  (h1 nil (str "hello?")))

(render :basic)



(defview :with-vars (:name)
  (h1 nil (str (format nil "Hello ~s!" name))))

(render :with-bars '((:names . "alpha")))



(deflayout :application ()
  (html nil
	(head nil
	      (title nil (str "An application"))
	      (link '(:src "/css/app.css")))
	
	(body nil
	      (h1 nil (str "An application here"))
	      (yield)
	      (div '(:id "footer")
		   (p nil (str "Copyright &copy; Me, Inc. 2015."))))))





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
