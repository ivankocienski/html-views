(in-package :html-view)

;;
;; 07 sub views
;;

;; views can be nested into each other
;; to encapsulate common page constructs

(defview (:inner-view)
  (h1 nil (str "post title"))
  (p '(:class "by-line") (str "by a person")))

;; just call render. it will have the same output
;; stream as the calling view.
(defview (:outer-view)
  (render :inner-view)

  (div '(:id "thing")
       (str "The usual content here")))

(render :outer-view)




;;
;; 08 sub views with local variables
;;

;; locals are automatically passed to sub views
(defview (:inner-view :locals (:title))
  (h1 nil (str title))
  (p '(:class "by-line") (str "by a person")))

(defview (:outer-view :locals (:body))
  (render :inner-view)

  (div '(:id "thing")
       (str body)))

(render :outer-view :locals '((:title . "A title")
			      (:body . "A body text")))




;;
;; 09 view local variable setting
;;

(defview (:inner-view :locals (:title :h1-id))
  (h1 (list :id h1-id) (str title))
  (p '(:class "by-line") (str "by a person")))

;; outer-view can set up specific locals to
;; pass to a sub view. this can include adding new
;; values to the list or overriding pre-set locals
;; that were set for the outer view.
(defview (:outer-view :locals (:body :title))
  (render :inner-view
	  (list (cons :h1-id "new-title")
		(cons :title (format nil "MAGIC: ~a" title))))

  (div '(:id "thing")
       (str body)))

(render :outer-view :locals '((:title . "A title")
			      (:body . "A body text")))
