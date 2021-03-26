;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Section 15|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


     
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



     
   

    
     
     
     
     
     



