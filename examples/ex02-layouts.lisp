(in-package :html-view)

(nuke-views)

;;
;; 05 basic layout
;;

;; layouts are like views (they have the same tags) but they
;; also have a few other tags. implicitly they will emit a doctype
;; decleration. layouts encapsulate view output through the 'yield'
;; method. they have the same method of declaring local variables
;; as a view. the first layout defined will be the layout that is
;; used for all subsequent renders.
(deflayout (:app-layout)
  (html nil
	(head nil
	      (title nil (str "A page title"))
	      (meta '(:encoding "utf-8"))
	      (link '(:href "/css/site.css")))

	(body nil
	      (div '(:id "main")
		   (yield))

	      (div '(:id "footer")
		   (p nil (str "Copyright &copy; YourSite"))))))


(defview (:basic)
  (h1 nil (str "hello?")))

;; this will now list the layouts as well. note the '(default)'
;; text indicating that the indicated layout will be used if none
;; is specified by the render call
(list-views)

;; then render it, this will return the view content
;; encapsulated in the layout markup
(render :basic)

;; if you want just the view html you can override this
(render :basic :layout nil)




;;
;; 06 layout switching
;;

(deflayout (:app-layout-2 :default t)
    (html nil
	(head nil
	      (title nil (str "alternate layout"))
	      (meta '(:encoding "utf-8"))
	      (link '(:href "/css/site.css")))

	(body nil
	      (div '(:id "main")
		   (h1 nil "A page title")
		   (yield))

	      (div '(:id "footer")
		   (p nil (str "Copyright &copy; YourSite"))))))

;; then render it using the app-layout-2
(render :basic)

;; or render it with just :app-layout
(render :basic :layout :app-layout)
