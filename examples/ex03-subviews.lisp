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
