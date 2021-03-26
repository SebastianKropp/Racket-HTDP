;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Section 18 Local|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(local ((define x 3)
        (define (f x) (+ x 5)))
        
  (f x))
          

(local ((define (f x) (+ x 5))
	(define (g alon)
	  (cond
	    [(empty? alon) empty]
	    [else (cons (f (first alon)) (g (rest alon)))])))
  (g (list 1 2 3)))


(local ((define CONST 100)
	(define (f x) (+ x CONST)))
  (f CONST))


(define y 10)
(+ y 
   (local ((define y 10)
	   (define z (+ y y)))
     z))


(local ((define (odd? n)
	       (cond
		 [(zero? n) false]
		 [else (even? (sub1 n))]))
	(define (even? n)
	       (cond
		 [(zero? n) true]
		 [else (odd? (sub1 n))])))
       (odd? 3))
       

(define (h n) 
       (cond
	 [(= n 0) empty]
	 [else (local ((define r (* n n)))
		 (cons r (h (- n 1))))]))
     (h 5)
       

(require 2htdp/image)


;Draw Polygons: alop -> scene
(define(draw-polygon alop)
  (local((define (draw-polygon alop) (connect-the-dots (add-at-end (first alop) alop)))
         (define (connect-the-dots alop)
           (cond
             [(empty? (rest alop)) (empty-scene 300 300)]
             [else (scene+line (connect-the-dots (rest alop)) (posn-x(first alop)) (posn-y(first alop)) (posn-x(first(rest alop))) (posn-y(first(rest alop))) 'black)]))
         (define (add-at-end n alon)
           (cond
             [(empty? alon) (cons n empty)]
             [(cons? alon) (cons (first alon) (add-at-end n (rest alon)))])))

    (draw-polygon alop))) 

;(draw-polygon (list (make-posn 100 150) (make-posn 125 175) (make-posn 150 175) (make-posn 175 150)   ;scene with an octagon
                    (make-posn 175 125) (make-posn 150 100) (make-posn 125 100) (make-posn 100 125)))


(define-struct parent (children name date eyes))

(define Person3 (make-parent empty 'person3 '2003 'blue))
(define Person4 (make-parent empty 'Person4 '2003 'Green))


(define Sebastian (make-parent (list Person3 Person4) 'Sebastian 2000 'green))
(define Person1 (make-parent empty 'Person1 2001 'green))
(define Person2 (make-parent empty 'Person2 2001 'brown))


(define Tatiana&Justus (list Sebastian))
(define Justus&David (list Person1 Person2))

(define hello (make-parent empty 'Meme 1990 'red))
(define Tatiana (make-parent (list Sebastian) 'Tatiana 1968 'green))
(define Justus (make-parent (list Person1 Person2) 'Justus 1961 'brown))


;Blue Eyed Descendants?: parent ->  boolean
(define(blue-eyed-descendant? parent)

  (local ((define (blue-eyed-descendant? parent)
            (or (symbol=? (parent-eyes parent) 'blue)
                (blue-eyed-children? (parent-children parent))))
          (define (blue-eyed-children? aloc)
            (cond
              [(empty? aloc) false]
              [(cons? aloc) (or (blue-eyed-descendant? (first aloc))
                                (blue-eyed-children? (rest aloc)))])))

(blue-eyed-descendant? parent)))

(blue-eyed-descendant? Tatiana) ;true
(blue-eyed-descendant? Justus)  ;false


(define-struct stars (name instrument))

;last-occurrence : symbol list-of-star  ->  star or false
(define (last-occurrence s alostars)
  (cond
    [(empty? alostars) false]
    [else (local ((define r (last-occurrence s (rest alostars))))
            (cond
              [(stars? r) r]
              [(symbol=? (stars-name (first alostars)) s) (first alostars)]
              [else false]))]))
              


(last-occurrence 'Matt
  (list (make-stars 'Matt 'violin)
        (make-stars 'Matt 'radio)
        (make-stars 'Matt 'lmao)))


;; maxi : non-empty-lon  ->  number
;; to determine the largest number on alon
(define (maxi alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (cond
	    [(> (first alon) (maxi (rest alon))) (first alon)]
	    [else (maxi (rest alon))])]))

;(maxi (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
;(maxi (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 20 19))
;max-local: alon -> n
(define(max-local alon)
  (cond
    [(empty? (rest alon)) (first alon)]
    [else (local ((define a (max-local (rest alon))))
            (cond
              [(> (first alon)a) (first alon)]
              [else a]))]))

 (time(maxi (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)))
 (time(max-local (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)))



;;A Direction is either

;; symbol 'father or

;; symbol 'mother.


;;A Path is either

;; empty or

;; (cons s los) where s is a direction and los is a path


   (define-struct child(name date ec mother father))


(define Sebastian (make-child 'Sebastian 2000 'green
                              (make-child 'Dank 1999 'green empty (make-child 'Maymays 1998 'green empty empty))
                              (make-child 'Memes 1999 'blue empty empty)))

(define Pepe(make-child 'Pepe 2007 'green empty empty))

(define Riperino(make-child 'Riperino 2005 'green empty
                            (make-child 'Dankmemes 1999 'green empty (make-child 'RonSwanson 0 'green
                                                                                 (make-child 'Rons 1 'blue empty empty)empty))))
 

;to-blue-eyed-ancestor: ftn -> path or false
(define(to-blue-eyed-ancestor ftn)
  (cond
    [(empty? ftn) false]
    [(symbol=? 'blue (child-ec ftn)) empty]
    [else (local ((define father? (to-blue-eyed-ancestor (child-father ftn)))
                  (define mother? (to-blue-eyed-ancestor (child-mother ftn))))
            (cond
              [(and (false? mother?)
                    (false? father?)) false]
              [(or  (false? mother?)
                    (false? father?))
               (cond      
                 [(boolean? mother?) (cons 'father father?)]
                 [(boolean? father?) (cons 'mother mother?)])]))]))
                  
              
(check-expect (to-blue-eyed-ancestor empty) false)        
(check-expect (to-blue-eyed-ancestor (make-child 'Sebastian 2000 'green empty empty)) false)
(check-expect (to-blue-eyed-ancestor (make-child 'Sebastian 2000 'blue empty empty)) empty)
(check-expect (to-blue-eyed-ancestor (make-child 'Sebastian 2000 'green (make-child 'lmao 2001 'blue empty empty))) '(mother))

 (to-blue-eyed-ancestor (make-child 'Sebastian 2000 'green
                              (make-child 'Dank 1999 'green empty (make-child 'Maymays 1998 'green empty empty))
                              (make-child 'Memes 1999 'blue empty empty)))

 (to-blue-eyed-ancestor (make-child 'Riperino 2005 'green empty
                            (make-child 'Dankmemes 1999 'green empty (make-child 'RonSwanson 0 'green
                            (make-child 'Rons 1 'blue empty empty)empty))))















     

       
