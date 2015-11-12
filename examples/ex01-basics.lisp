(in-package :html-view)

;; reset the view database. clears
;; all rendered views and layouts
(nuke-views)

;;
;; 01 real simple
;;

;; first define a view like so
(defview (:basic)
  (h1 nil (str "hello?")))

;; see a list of views that are currently defined
(list-views)

;; then render it, this will return a string
(render :basic)




;;
;; 02 more complex
;;

;; nesting tags is real simple
(defview (:basic2)
  (div '(:id "content" :class "container")
       (h1 nil (str "hello"))
       (p nil (str "This is a paragraph")))
  
  (div '(:id "footer")
       (p nil (str "copyright &copy; 2015 me"))))

(render :basic2)
       



;;
;; 03 with view variables
;;

;; pass in variables. if you don't use
;; them then the compiler will complain, but
;; you can ignore those.
(defview (:with-vars :locals (:name))
  (h1 nil (str (format nil "hello ~a!" name))))

(render :with-vars :locals '((:name . "Human")))




;;
;; 04 more complex variables
;;

;; a view with loops and conditionals. as its just
;; lisp more complex constructs can be used. but it
;; is advised strongly to keep your views simple and
;; put any hairy logic in your controlers. i know you
;; won't listen to me as in the real world things
;; have a tendancy to grow out of control.
;; just a warning.
(defview (:with-vars2 :locals (:post-title :post-public :post-body :replies))
  (div '(:id "post")
       (h1 nil (str post-title))

       ;; str-esc will html escape <, >, &, and '/" 
       (div '(:id "post-content") (str-esc post-body))

       ;; conditionals
       (if post-public
	   (p nil (str "This post is public"))
	   (div '(:id "private")
		(p nil (str "This post is private"))))
       
       (ol '(:id "post-replies")
	   ;; loops
	   (dolist (rep replies)
	     (li nil (str rep))))))

(render :with-vars2
	:locals '((:post-title . "10 Things you won't believe about $THING")
		  (:post-body . "<p>Bad things &here;")
		  (:replies . ("one" "two" "three"))))

