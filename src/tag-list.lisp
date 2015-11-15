(in-package :html-views)

(defconstant +TAG-NAMES+
  ;; ( name . closed)
  '((a          . nil)
    (abbr       . nil)
    (address    . nil)
    (area       . nil)
    (b          . nil)
    (base       . nil)
    (bdo        . nil)
    (blockquote . nil)
    (br         . t)
    (button     . t)
    (caption    . nil)
    (cite       . nil)
    (code       . nil)
    (col        . nil)
    (colgroup   . nil)
    (dd         . nil)
    (del        . nil)
    (dfn        . nil)
    (div        . nil)
    (dl         . nil)
    (dt         . nil)
    (em         . nil)
    (fieldset   . nil)
    (form       . nil)
    (h1         . nil)
    (h2         . nil)
    (h3         . nil)
    (h4         . nil)
    (h5         . nil)
    (h6         . nil)
    (hr         . t)
    (i          . nil)
    (iframe     . nil)
    (img        . t)
    (input      . t)
    (ins        . nil)
    (kbd        . nil)
    (label      . nil)
    (legend     . nil)
    (li         . nil)
;;  (map        . nil)
    (menu       . nil)
    (noscript   . nil)
    (object     . nil)
    (ol         . nil)
    (optgroup   . nil)
    (option     . nil)
    (p          . nil)
    (param      . nil)
    (pre        . nil)
    (q          . nil)
    (s          . nil)
    (samp       . nil)
    (script     . nil)
    (select     . nil)
    (small      . nil)
    (span       . nil)
    (strong     . nil)
    (style      . nil)
    (sub        . nil)
    (sup        . nil)
    (table      . nil)
    (tbody      . nil)
    (td         . nil)
    (textarea   . nil)
    (tfoot      . nil)
    (th         . nil)
    (thead      . nil)
    (tr         . nil)
    (u          . nil)
    (ul         . nil)
    (var        . nil)

    ;; obsolete tags
    (acronym    . nil)
    (basefont   . nil)
    (big        . nil)
    (center     . nil)
    (dir        . nil)
    (frame      . nil)
    (frameset   . nil)
    (noframes   . nil)
    (strike     . nil)
    (tt         . nil)
    
    ;; fancy HTML 5 tags
    (article    . nil)
    (aside      . nil)
    (audio      . nil)
    (bdi        . nil)
    (canvas     . nil)
    (datalist   . nil)
    (details    . nil)
    (dialog     . nil)
    (embed      . nil)
    (figcaption . nil)
    (figure     . nil)
    (footer     . nil)
    (header     . nil)
    (keygen     . nil)
    (main       . nil)
    (mark       . nil)
    (menuitem   . nil)
    (meter      . nil)
    (nav        . nil)
    (output     . nil)
    (progress   . nil)
    (rp         . nil)
    (rt         . nil)
    (ruby       . nil)
    (section    . nil)
    (source     . nil)
    (summary    . nil)
;;  (time       . nil)
    (track      . nil)
    (video      . nil)
    (wbr        . nil)))




    
(defconstant +LAYOUT-TAG-NAMES+
  '((html  . nil)
    (link  . T)
    (meta  . T)
    (title . nil)
    (head  . nil)
    (body  . nil)))
    
