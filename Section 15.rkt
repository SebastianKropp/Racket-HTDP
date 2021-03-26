;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Section 15|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(define-struct parent (children name date eyes))
;
;(define Person3 (make-parent empty 'Person3 '2003 'blue))
;(define Person4 (make-parent empty 'Person4 '2003 'Green))
;
;
;(define Sebastian (make-parent (list Person3 Person4) 'Sebastian 2000 'green))
;(define Person1 (make-parent empty 'Person1 2001 'green))
;(define Person2 (make-parent empty 'Person2 2001 'brown))
;
;
;(define Tatiana&Justus (list Sebastian))
;(define Justus&Adopted (list Person1 Person2))
;
;(define Meme (make-parent empty 'Meme 1990 'red))
;(define Tatiana (make-parent (list Sebastian) 'Tatiana 1968 'green))
;(define Justus (make-parent (list Person1 Person2) 'Justus 1961 'brown))
;
;
;;blue-eyed-descendant? : parent  ->  boolean
;(define (blue-eyed-descendant? parent)
;  (or (symbol=? (parent-eyes parent) 'blue)
;      (blue-eyed-children? (parent-children parent))))
;
;;blue-eyed-children? : list-of-children  ->  boolean
;(define (blue-eyed-children? aloc)
;  (cond
;    [(empty? aloc) false]
;    [(cons? aloc) (or (blue-eyed-descendant? (first aloc))
;              (blue-eyed-children? (rest aloc)))]))
;
;
;(blue-eyed-children? empty)
;(blue-eyed-descendant? Tatiana)
;(blue-eyed-descendant? Justus)
;(blue-eyed-children? (list Person1 Person2))
;
;
;;;how-far-removed-descendant: parent -> n
;;(define(how-far-removed-descendant parent)
;;  (cond
;;    [(symbol=? (parent-eyes parent) 'blue) 0]
;;    [(blue-eyed-children?(parent-children parent)) (add1(how-far-removed-children (parent-children parent)))]
;;    [else false]))
;;
;;;how-far-removed-children: aloc -> boolean
;;(define(how-far-removed-children aloc)
;;  (cond
;;    [(empty? aloc) 0]
;;    [(blue-eyed-descendant? (first aloc)) (how-far-removed-descendant (first aloc))]))
;;    [(blue-eyed-children? (rest aloc)) (how-far-removed-children (rest aloc))]))
;;
;;
;;
;;
;;(how-far-removed-descendant Tatiana)
;;(how-far-removed-descendant Justus)
;;(how-far-removed-descendant Sebastian)
;;(how-far-removed-descendant Person3)
;;(how-far-removed-children (list Person3 Person4))
;
;
;
;;count-descendants: parent -> n
;(define(count-descendants parent)
;  (add1(count-children (parent-children parent))))
;
;;count-children: aloc -> n
;(define(count-children aloc)
;  (cond
;    [(empty? aloc) 0]
;    [(cons? aloc) (+ (count-descendants (first aloc)) (count-children (rest aloc)))]))
;
; (count-descendants Meme)     ;1
; (count-descendants Tatiana)  ;4
; (count-descendants Justus)   ;3
; (count-descendants Sebastian);3
;     
; 
; 
; 
;;proper-count-descendants: parent -> n
;(define(proper-count-descendants parent)
;  (cond
;    [(empty? (parent-children parent)) 0]
;    [else (proper-count-children (parent-children parent))]))
;
;
;;proper-count-children: aloc -> n
; (define(proper-count-children aloc)
;   (cond
;     [(empty? aloc) 0]
;     [else (+ (add1(proper-count-descendants (first aloc))) (proper-count-children (rest aloc)))]))
; 
; (proper-count-descendants Tatiana)  ;3
; (proper-count-descendants Meme)     ;0
; (proper-count-descendants Justus)   ;2
; (proper-count-descendants Sebastian);2
;     
; 
;;eye-colors-descendant: parent -> alos
;(define(eye-colors-descendant parent)
;  (cons (parent-eyes parent) (eye-colors-children (parent-children parent))))
;  
; 
;;eye-colors-children: aloc -> eye color
; (define(eye-colors-children aloc)
;   (cond
;     [(empty? aloc) empty]
;     [else (append (eye-colors-descendant (first aloc)) (eye-colors-children (rest aloc)))]))
; 
;     
;    
;(eye-colors-descendant Justus)    ;(list 'brown 'green 'brown)
;(eye-colors-descendant Tatiana)   ;(list 'green 'green 'blue 'Green)
;(eye-colors-descendant Sebastian) ;(list 'green 'blue 'Green)
;(eye-colors-descendant Meme)      ;(list 'red)
;

(define-struct wp (header body))


     
 ;; A Web Document is either

;; empty

;; (cons s p) where s is a symbol and p is a document 

;;  or

;; (cons w p) where w is a webpage and p is a document 
     
(define Webpage (make-wp 'Header
                          '(wow this is the webpage to the header for my find)))

(define Webpage1 (make-wp 'Header1 (list 'this 'is 'another Webpage 'that 'im 'using 'for 'my 'original)))

(define Webpage2 (make-wp 'Header2 (list 'This 'Is 'The Webpage1 'To 'The 'Header 'For 'My Webpage))) ;;<- Embedded webpage had to change format for it to not recognize as sym
                                                                                                        ;; From '(Webpage) -> (list 'example Webpage)

;size-wp: wp -> n
(define(size-wp wp)
  (+ (size-header (wp-header wp)) (size-document (wp-body wp))))
  
;size-document: document -> n
(define(size-document document)
  (cond
    [(empty? document) 0]
    [(symbol? (first document)) (add1(size-document (rest document)))]
    [else (size-document (rest document))]))

;size-header: header -> n
(define(size-header header)
  (cond
    [(symbol? header) 1]
    [(not(symbol? header)) (size-wp header)]))


;(size-wp Webpage)  ;12
;(size-wp Webpage1) ;12
;(size-wp Webpage2) ;19    
     
     
;wp-to-file: wp -> alos  
 (define(wp-to-file wp)
    (document-to-file (wp-body wp)))
     
     
;document-to-file: document -> alos
 (define(document-to-file document)
   (cond
     [(empty? document) empty]
     [(symbol? (first document)) (cons (first document) (document-to-file (rest document)))]
     [else (cons (wp-header (first document))  (document-to-file (rest document)))]))
     


;(wp-to-file Webpage)
;(wp-to-file Webpage1)   
;(wp-to-file Webpage2)   


;occurs: s wp -> boolean
 (define(occurs s wp)
   (occurs-document s (wp-body wp)))
      

;occurs-document: s document -> boolean
(define(occurs-document s document)
  (cond
    [(empty? document) false]
    [(symbol? (first document))
     (or (symbol=? s (first document))
         (occurs-document s(rest document)))]
    [else (occurs s(first document))]))


;(occurs 'wow  Webpage)
;(occurs 'find Webpage2)
;(occurs 'find Webpage1)



;find: s wp -> false or (wp-header wp)
(define(find s wp)
  (cond
    [(occurs-document s (wp-body wp)) (find-document s (wp-body wp))]
    [else false]))

;find-document: s wp -> alos
(define(find-document s document) 
  (cond
    [(symbol? (first  document))
      (cond 
        [(symbol=? s (first  document)) empty]
        [else (find-document s(rest  document))])]
    [else (cons (wp-header (first document)) (find s (first document)))]))

  
 (find 'wow (make-wp 'header empty)) ;false                     
 (find 'find Webpage)                ;'(empty)
 (find 'find Webpage1)               ;'(Header1 Header)
 (find 'find Webpage2)               ;'( Header1 Header)
 (find 'lmao Webpage1)               ;false



     
   

    
     
     
     
     
     



