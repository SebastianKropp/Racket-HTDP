;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Draw-circles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)

;draw-circles: posn alon -> scene
(define(draw-circles alon p)
  (cond
    [(empty? alon) (empty-scene 300 300)]
    [else 
     (cond
      ((place-image(circle (first alon) 'outline 'red)(posn-x p)(posn-y p)(empty-scene 300 300))
      (draw-circles(rest alon)(posn-x p)(posn-y p))))]))


(draw-circles empty(make-posn  150 150)) (empty-scene 300 300)
(draw-circles (cons 10 empty) (make-posn 150 150)) (place-image(circle 10 'outline 'red)150 150)
(draw-circles (cons 10(cons 15 empty)) (make-posn 150 150)) (place-image(circle 10 'outline 'red)150 150(circle 15 'outline 'red))


































