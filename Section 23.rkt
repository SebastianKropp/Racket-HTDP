;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Section 23|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; make-even : N  ->  N[even]
;; to compute the i-th even number
(define (make-even i)
  (* 2 i))

;; make-odd : N  ->  N[odd]
;; to compute the i-th odd number
(define (make-odd i)
  (+ (* 2 i) 1))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
             (series (- n 1) a-term))]))


(series 5  (lambda(x) (* 2 x)))

;series-local : a-term -> sum of n 
(define(series-local a-term)
  (local ((define (series n a-term)
            (cond
              [(= n 0) (a-term n)]
              [else (+ (a-term n)
                       (series (- n 1) a-term))])))
    
    (lambda(n) (series n a-term ))))

((series-local make-even) 5)
((series-local make-odd) 5)
(+ 2 4 6 8 10)

;a-fives: n series -> function
(define(a-fives n)
  (cond
    [(= n 0) 3]
    [else (+ 5 (a-fives (sub1 n)))]))

(a-fives 3)


;a-fives-closed
(define(a-fives-closed n)
  (+ (* 5 n) n))


(a-fives-closed 0)
(a-fives-closed 3)

(build-list 22 add1)


;seq-a-fives: n -> sequence of a-fives
(define(seq-a-fives n)
  (build-list n (lambda (x) (a-fives x))))

(seq-a-fives 22)


;arithmetic-series: start s -> function
(define(arithmetic-series start s)
  (lambda (x) (+ (* s x) start)))

((arithmetic-series 3 5) 0)
((arithmetic-series 3 5) 1)

((arithmetic-series 3 5)2)
(a-fives-closed 2)


((arithmetic-series 3 5)5)
(a-fives-closed 5)



;g-fives: n -> n
(define(g-fives n)
  (cond
    [(= n 0) 3]
    [else (* 5 (g-fives (sub1 n)))])) 

(g-fives 0)
(g-fives 1)
(g-fives 2)
(g-fives 3)

;g-fives-closed: n -> n
(define(g-fives-closed n)
  (* (expt 5 n) 3))

(g-fives-closed 0)
(g-fives-closed 1)
(g-fives-closed 2)
(g-fives-closed 3)

;seq-g-fives: n -> alon
(define(seq-g-fives n)
  (build-list n (lambda (x) (g-fives x))))

(seq-g-fives 5)

;geometric-series: start s -> function
(define(geometric-series start factor)
  (lambda (x) (* (expt factor x) start)))

((geometric-series 3 5)2)
((geometric-series 1 2) 2)


 
(seq-g-fives 3)


(series 3 (lambda (x) (* (expt .1 x) 1)))
(+ ((geometric-series 1 .1)1) ((geometric-series 1 .1) 2) ((geometric-series 1 .1) 3))

;e-power
(define (e-power x)
  (local ((define (e-taylor i)
	    (/ (expt x i) (! i)))
	  (define (! n)
	    (cond
	      [(= n 0) 1]
	      [else (* n (! (sub1 n)))])))
    (series 3 e-taylor)))

(e-power 1)


;ln: n -> n
(define(ln x)
  (local ((define (ln-taylor i)
            (* 2 (+ (expt (/ (- x 1) (+ x 1)) i) (/ 1 (func i)))))
          (define (func n)
            (cond
              [(= n 0) 3]
              [else (+ 3 (func (sub1 n)))])))
    (series 1 ln-taylor)))
            


(log 12)
(exact->inexact(ln 12))















                            