;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Section 11|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;;hellos: natnumber  ->  alos
;(define(hellos n)
;  (cond
;    [(zero? n) empty]
;    [else (cons 'hello(hellos (sub1 n)))]))
;
;(hellos 0)
;(hellos 2)
;(hellos 3)
;
;;hellos2: natnumber symbol -> alos
;(define(hellos2 sym  n)
;  (cond
;    [(zero? n) empty]
;    [else (cons sym(hellos2 sym(sub1 n)))]))
;
;(hellos2 'ayylmao  0)
;(hellos2 'ayylmao 5)
;
;
;; f: number  ->  number
;(define (f x)
;  (+ (* 3 (* x x)) (+ (* -6 x) -1)))
;
;
;;tabulate-f: natnumber -> alonn
;(define(tabulate-f n)
; (cond
;   [(zero? n) empty]
;   [else (cons n (+ (* 3 (* n n)) (+ (* -6 n) -1))) (tabulate-f (sub1 n))]))    
;      
;
;(tabulate-f empty)
;(tabulate-f 3)
;
;;depth: dl - > natnumber
;(define(depth dl)
;  (cond
;    [(symbol? dl) 0]
;   [else (add1 (depth(first dl)))]))
;
;
;(depth (cons(cons 'robot empty)empty))
;(depth(cons(cons(cons 'robot empty)empty)empty))
;
;;make-deep: symbol natnumber -> deeplist
;(define(make-deep s n)
;  (cond
;    [(zero? n) s]
;    [else (cons  (make-deep s (sub1 n)) empty)]))
;
;(make-deep 'robot 0)
;(make-deep 'robot 2)
;(make-deep 'robot 5)

;random-n-m: integer integer -> integer
(define(random-n-m m n)
  (+(random(- m n)) n))
(random-n-m 5 2)

;tie-dyed: natnumber -> alon
(define(tie-dyed n)
  (cond
    [(zero? n) empty]
    [else (cons (random-n-m 120 20) (tie-dyed (sub1 n)))]))   

(tie-dyed 1)
(tie-dyed 5)
(tie-dyed 7)

;draw-circles: posn alon -> scene
(define(draw-circles alon p)
  (cond
    [(empty? alon) (empty-scene 300 300)]
    [else (place-image(circle (first alon) 'outline (make-color(random 256)(random 256)(random 256))) (posn-x p)(posn-y p)(draw-circles (rest alon)p))]))


(draw-circles empty (make-posn  150 150))
(draw-circles (tie-dyed 25) (make-posn 150 150))
(draw-circles (tie-dyed 75)  (make-posn 150 150))
(draw-circles (tie-dyed 150) (make-posn 150 150))




