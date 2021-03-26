;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |section 21|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Godzilla: foldr

;Mothra: map

;King-Kong: build-list

;King-Ghidora: filter

(filter (lambda (x) (< x 5)) '(1 2 3 6 7 9))

;#1

(build-list 4 (lambda (x) (+ x 0))) ;'(0 1 2 3)

(build-list 4 (lambda (x) (+ x 1))) ;'(1 2 3 4)

;#2

(build-list 3 (lambda (x) (expt .1 (+ 1 x)))) ;'(.1 .01 .001. 0001)

;#3

;evens: n -> alon (even numbers)
(define(evens n)
  (filter (lambda (y) (<= y n)) (build-list n (lambda (x) (* 2 x)))))

(evens 5)
(evens 10)

(build-list 10 sin)

;#4

;tabulate: function natural number -> tabulated function
(define(tabulate f n)
  (build-list n f))

(tabulate sin 10)



(build-list 3 (lambda (x) (build-list 3 (lambda (y) (+ x y)))))

;#5

;diagonal: n -> alol
(define(diagonal n)
  (build-list n
              (lambda (row)
                (build-list n
                            (lambda (column)
                              (cond
                                [(= row column) 1]
                                [else 0]))))))


(diagonal 7)

;'(1 0 0)
;'(0 1 0)
;'(0 0 1)

;#6

(map (lambda (x) (* x 1.22)) (list 1 2 5 4))

;#7

(map (lambda (x) (* 5/9 (- x 32))) (list 76 98 80))

;#8

(map (lambda (x) (make-posn (+ (posn-x x) 3) (posn-y x))) (list (make-posn 50 500) (make-posn 150 150) (make-posn 300 300)))

;Exercise 21.2.3

;#1

(define-struct toy (name price))

;eliminate-exp  ua alos -> alot (whose price is below ua)
(define(eliminate-exp ua alos)
  (filter (lambda (x) (< (toy-price x) ua)) alos))


(eliminate-exp 7 (list (make-toy 'name 5) (make-toy 'name2 6) (make-toy 'name5 8) (make-toy 'toy 10) (make-toy 'robot 11)))

;#2

;recall: ty alos -> alos
(define(recall ty alos)
  (filter (lambda (x) (not(symbol=? x ty))) alos))

(recall 'toy '(toy robot toys toy))

;#3

;selection: lon alon -> alon (all copies are added)
(define(selection lon alon)
  (filter (lambda (x) (ormap (lambda (y) (symbol=? x y))lon))alon)) 
        
(selection '(ayy lmao) '(lmao))
(selection '(ayy lmao dank memes) '(ayy lmao dank memes - sebastian))


            
            
                                                                                         
            
            
            