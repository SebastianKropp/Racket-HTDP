;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define zero (lambda(f) (lambda(x) x)))
(define one  (lambda(f) (lambda(x) (f x))))
(define two  (lambda(f) (lambda(x) (f (f x)))))
(define three(lambda(f) (lambda(x) (f (f (f x))))))

((zero add1)0)

((one add1)0)

((two add1)0)

((three add1)0)


;succesor: λ -> n
(define succesor (λ(n) (λ(f) (λ(x) (f ((n f) x))))))

(((succesor one)add1)0)

;add
(define add (λ(n) (λ(m) ((n succesor) m))))

((((add one) two) add1) 0)
((((add two) two) add1) 0)

((((add two)(succesor two))add1)0)

  

;multiplication
(define multiplication (λ(n) (λ(m) (((n add) m)))))
((((multiplication two)two)add1)0)


























