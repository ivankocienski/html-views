;;;; sokoban.asd

(asdf:defsystem #:cl-html-views
  :description "HTML views gives you an HTML DSL like cl-who with complex nested views like Rails"
  :author "Ivan K. <your.name@example.com>"
  :license "not yet"
  :serial t
  ;;:depends-on ()
  :components ((:file "src/package")
	       (:file "src/view-db")
	       (:file "src/html-views")
	       (:file "src/demo")))

