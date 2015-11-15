(in-package :html-views)

(defun hash-keys (table)
  "returns a list of keys for a hash"
  (loop for key being the hash-keys of table collect key))

(defun keyword<= (kw-a kw-b)
  "compares the string portions of two keywords"
  (string<=
   (format nil "~s" kw-a)
   (format nil "~s" kw-b)))

(defun escape-to-stream (s string)
  "given a string and a stream, write string to stream replacing
non-html compliant characters (<>&'\") with their &__; equivalant"
  (loop for char across string
     do (case char
	  (#\< (write-sequence "&lt;"   s))
	  (#\> (write-sequence "&gt;"   s))
	  (#\& (write-sequence "&amp;"  s))
	  (#\' (write-sequence "&#039;" s))
	  (#\" (write-sequence "&quot;" s))
	  (t   (princ char s)))))

(defun escape-string (string)
  "wrapper around escape-to-stream to be used in non-stream
circumstances"
  (with-output-to-string (s)
    (escape-to-stream s string)))

(defun intern (thing)
  (intern thing *package*)
  )
