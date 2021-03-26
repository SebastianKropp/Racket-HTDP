;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname circles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)

;draw-circles: alon posn -> scene
(define (draw-circles alon posn)
  (cond
    [(empty? alon) (empty-scene 300 300)]
    [else (place-image(circle (first alon) 'outline 'red)(posn-x posn)(posn-y posn)(draw-circles (rest alon)posn))]))


  (draw-circles empty(make-posn 100 100)) (empty-scene 300 300)
  (draw-circles (cons 5 empty)(make-posn 150 150)) (place-image(circle 5 'outline 'red)150 150 (empty-scene 300 300))
  (draw-circles (cons 25(cons 50 empty))(make-posn 150 150)) (place-image(circle 5 'outline 'red)150 150(place-image(circle 25 'outline 'red)150 150(empty-scene 300 300)))
  (draw-circles (cons 25(cons 50(cons 75 empty)))(make-posn 150 150)) (place-image(circle 5 'outline 'red)150 150(place-image(circle 25 'outline 'red)150 150(place-image(circle 75 'outline 'red)150 150(empty-scene 300 300))))
  
  
  
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  