;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Section 13|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;#1

;(first (list 1 2 3))

1

;(rest (list 1 2 3))

(cons 2(cons 3 empty))

(list 2 3)

'(2 3)

;#2

;(list (symbol=? 'a 'b) (symbol=? 'c 'c) false)

(cons false(cons true (cons false empty)))

(list false true false)

'(#false #true #false)

;(list (+ 10 20) (* 10 20) (/ 10 20))

(cons 30(cons 200(cons .5 empty)))

(list 30 200 0.5)

'( 30 200 .05 )

;(list 'dana 'jane 'mary 'laura)

'(dana jane mary laura)

(list 'dana 'jane 'mary 'laura)

(cons 'dana (cons 'jane (cons 'mary (cons 'laura empty))))

;#3

;(cons 'a (list 0 false))

(cons 'a (cons 0 (cons false empty))) 

(list 'a 0 false)

'( a 0 false)

;(list (cons 1 (cons 13 empty)))

(cons (cons 1 (cons 13 empty))empty)

(list (list 1  13 ))

'( ( 1 13))

;(list empty empty (cons 1 empty))

(cons empty (cons empty (cons(cons 1 empty)empty)))

(list '() '() (list 1))

'( () () ( 1))

;(cons 'a (cons (list 1) (list false empty)))

(cons 'a (cons(cons 1 empty) (cons false (cons empty empty))))

(list 'a (list 1) false '())

'( a (1) #false empty)







;#4

;(cons 'a (cons 'b (cons 'c (cons 'd (cons 'e empty)))))

(list 'a 'b 'c 'd 'e)

(cons 'a (cons 'b (cons 'c (cons 'd (cons 'e empty)))))

'( a b c d e)

;(cons (cons 1 (cons 2 empty)) empty)

(list (list 1 2))

(cons (cons 1 (cons 2 empty)) empty)

'( (1 2))

;(cons 'a (cons (cons 1 empty) (cons false empty)))

(list 'a  (list 1 false))

(cons 'a (cons (cons 1 empty) (cons false empty)))

'(a (1 #false))

;(cons (cons 1 (cons 2 empty)) (cons (cons 2 (cons 3 empty)) empty))

(list(list 1 2) (list 2 3))

(cons (cons 1 (cons 2 empty)) (cons (cons 2 (cons 3 empty)) empty))

'( ( 1 2) (2 3))

;#5

;(list 0 1 2 3 4 5)

(cons 0(cons 1(cons 2(cons 3(cons 4(cons 5 empty))))))

(list 0 1 2 3 4 5)

'(0 1 2 3 4 5)

;(list (list 'adam 0) (list 'eve 1) (list 'louisXIV 2))

(cons(cons 'adam(cons 0 empty)) (cons(cons 'eve(cons 1 empty)) (cons(cons 'louisXIV (cons 2 empty))empty)))

(list (list 'adam 0) (list 'eve 1) (list 'louisXIV 2))

'( (adam 0) (eve 1) (louisXIV 2))

;(list 1 (list 1 2) (list 1 2 3))

(cons 1 (cons(cons 1(cons 2 empty)) (cons(cons 1(cons 2(cons 3 empty)))empty)))

(list 1 (list 1 2) (list 1 2 3))

'( 1 ( 1 2) ( 1 2 3)) 








