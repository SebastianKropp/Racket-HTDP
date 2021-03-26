;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Section 23 Math|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; make-even : N  ->  N[even]
;; to compute the i-th even number
(define (make-even i)
  (* 2 i))

;; make-odd : N  ->  N[odd]
;; to compute the i-th odd number
(define (make-odd i)
  (+ (* 2 i) 1))
;
;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
             (series (- n 1) a-term))]))

;
;(series 5  (lambda(x) (* 2 x)))
;
;;series-local : a-term -> sum of n 
;(define(series-local a-term)
;  (local ((define (series n a-term)
;            (cond
;              [(= n 0) (a-term n)]
;              [else (+ (a-term n)
;                       (series (- n 1) a-term))])))
;    
;    (lambda(n) (series n a-term ))))
;
;((series-local make-even) 5)
;((series-local make-odd) 5)
;(+ 2 4 6 8 10)
;
;;a-fives: n series -> function
;(define(a-fives n)
;  (cond
;    [(= n 0) 3]
;    [else
;     (+ 5 (a-fives (sub1 n)))]))
;
;(a-fives 3)
;
;
;;a-fives-closed
;(define(a-fives-closed n)
;  (+ (* 5 n) 3))
;
;
;(a-fives-closed 0)
;(a-fives-closed 3)
;
;
;(series 3 (lambda (x) (+ (* 5 x) 3)))
;(series 7 (lambda (x) (+ (* 5 x) 3)))
;(series 88 (lambda (x) (+ (* 5 x) 3)))
;
;
;;seq-a-fives: n -> alon
;(define(seq-a-fives n)
;  (build-list n (lambda (x) (+ (* 5 x) 3))))
;
;(seq-a-fives 5)
;
;;arithmetic-series: start s -> function
;(define(arithmetic-series start s)
;  (lambda (x) (+ (* s x) start)))
;
;((arithmetic-series 3 5)0)
;((arithmetic-series 3 5)1)
;((arithmetic-series 3 5)2)
;((arithmetic-series 3 5)3)
;
;;g-fives: n -> n
;(define(g-fives n)
;  (cond
;    [(= n 0) 3]
;    [else (* 5 (g-fives (sub1 n)))]))
;
;(g-fives 0)
;(g-fives 1)
;(g-fives 2)
;(g-fives 3)
;
;;g-fives-closed: n -> n
;(define(g-fives-closed n)
;  (*(expt 5 n) 3))
;
;(g-fives-closed 0)
;(g-fives-closed 1)
;(g-fives-closed 2)
;(g-fives-closed 3)
;
;
;;seq-g-fives: n -> alon
;(define(seq-g-fives n)
;  (build-list n (lambda (x) (*(expt 5 x) 3))))
;
;(seq-g-fives 5)
;
;
;;geometric-series: start s -> function
;(define(geometric-series start s)
;  (lambda (n) (*(expt s n) start)))
;
;
;((geometric-series 3 5)0)
;((geometric-series 3 5)1)
;((geometric-series 3 5)2)
;((geometric-series 3 5)3)
;
;(series 3 (lambda (x) (*(expt 5 x) 3)))
;(series 7 (lambda (x) (*(expt 5 x) 3)))
;(series 88 (lambda (x) (*(expt 5 x) 3)))
;
;
;(define (e-power x)
;  (local ((define (e-taylor i)
;	    (/ (expt x i) (! i)))
;	  (define (! n)
;	    (cond
;	      [(= n 0) 1]
;	      [else (* n (! (sub1 n)))])))
;    (series 10 e-taylor)))
;
;(e-power 2)

;sinex: a-term -> n
(define(sinex x)
  (local ((define(taylor n)
            (local ((define od (make-odd n))
                    (define operator (minus-or-plus n)))
             (operator (/ (expt x od) (factorial od)))))
          (define(factorial x)
            (cond
              [(= x 0) 1]
              [else (* x (factorial (sub1 x)))]))
          (define (make-odd x)
            (+ (* 2 x) 1))
          (define (minus-or-plus n)
                      (cond
                        [(even? n) +]
                        [(odd? n) -])))
             
    (series 100 taylor)))                              
 
;(sinex 2)
;(sinex 6)
;(sinex 4)
;(sinex 8)
(sinex (/ pi 4))
(sinex (* 3 (/ pi 4)))
(sinex (/ pi 6))

;(sinex 3)

;(cos x) = 1 - x^2/2! + x^4/4! - X^6/6! ....

;cosinex: a-term -> n
(define(cosinex x)
  (local ((define(taylor n)
            (local ((define ev (make-even n))
                    (define operator (minus-or-plus n)))
             (operator (/ (expt x ev) (factorial ev)))))
          (define(factorial x)
            (cond
              [(= x 0) 1]
              [else (* x (factorial (sub1 x)))]))
          (define (make-even x)
            (* 2 x))
          (define (minus-or-plus n)
                      (cond
                        [(even? n) +]
                        [(odd? n) -])))
             
    (series 100 taylor)))

(cosinex 2)
(cosinex 3)
(cosinex 4)
(cosinex (/ pi 4))




(exp (*(sqrt -1) pi))
(+ (cosinex pi) (* (sqrt -1) (sinex pi)))


(define(a-line x)
  (+ (* 3 x) 1))

;d/dx: (num -> num) -> (num -> num)
(define(d/dx f)
  (local ((define (fprime x)
            (/ (- (f (+ x ϵ)) (f(- x ϵ)))
               (* 2 ϵ)))
          (define ϵ (exp 1)))
    fprime))



((d/dx a-line)2)
((d/dx a-line)15)

(define g sqr)

((d/dx g) 10)

(define(yx x)
  (+ (- (sqr x) (* 4 x)) 7))

((d/dx yx)2)
((d/dx yx)3)


  














               

