
;geometric-series: start s -> function
(define(geometric-series start s)
  (lambda (n) (*(expt s n) start)))


((geometric-series 3 5)0)
((geometric-series 3 5)1)
((geometric-series 3 5)2)
((geometric-series 3 5)3)

(series 3 (lambda (x) (*(expt 5 x) 3)))
(series 7 (lambda (x) (*(expt 5 x) 3)))
(series 88 (lambda (x) (*(expt 5 x) 3)))


(define (e-power x)
  (local ((define (e-taylor i)
	    (/ (expt x i) (! i)))
	  (define (! n)
	    (cond
	      [(= n 0) 1]
	      [else (* n (! (sub1 n)))])))
    (series 10 e-taylor)))

(e-power 2)

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


  














               

