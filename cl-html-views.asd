(asdf:defsystem #:cl-html-views
  :description "HTML views gives you an HTML DSL like cl-who with complex nested views"
  :author "Ivan K. <ivan.kocienski@gmail.com>"
  :license "MIT License"
  :serial t
  ;;:depends-on ()
  :components ((:file "src/package")
	       (:file "src/util")
	       (:file "src/view-db")
	       (:file "src/tag-list")
	       (:file "src/doc-type")
	       (:file "src/html-views")))

