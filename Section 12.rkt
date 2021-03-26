;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Section 12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)


;insert: n alon -> alon
(define(insert n alon)
  (cond
    [(empty? alon) (cons n alon)]
    [(cons? alon)
     (cond
       [(<= n (first alon)) (cons n alon)]
       [(> n (first alon)) (cons (first alon) (insert n (rest alon)))])]))


(insert 9 (cons 6(cons 9(cons 75(cons 90(cons 100 empty))))))
(insert 4 (cons 6(cons 9(cons 75 empty))))
(insert 7 (cons 5(cons 6(cons 75 empty))))


;sort: alon -> alon (sorted)
(define (sort alon)
  (cond
    [(empty? alon) empty]
    [else (insert (first alon) (sort (rest alon)))])) 

(sort empty)
(sort (cons 5(cons 8 empty)))
(sort (cons 5(cons 2(cons 15 empty))))
(sort (cons 5(cons 25(cons 12(cons 1 empty)))))
(sort (cons 9(cons 4(cons 17(cons 35 empty)))))


(define-struct mail (from date msg))


;insertbydate: alom alom -> alom
(define(insertbydate alom alom2)
  (cond
    [(empty? alom2) (cons alom alom2)]
    [(cons? alom2)
     (cond
       [(<= (mail-date alom) (mail-date(first alom2)))  (cons alom alom2)]
       [(> (mail-date alom) (mail-date(first alom2))) (cons (first alom2) (insertbydate alom (rest alom2)))])]))

(insertbydate (make-mail "Sebastian" 2014 "messageroni") (cons(make-mail "Sebastian" 2016 "Message")(cons(make-mail "August" 2017 "Messagerino")empty)))
(insertbydate (make-mail "Sebastian" 2016 "messageroni") (cons(make-mail "Sebastian" 2015 "Message")(cons(make-mail "August" 2017 "Messagerino")empty)))


;sortmailbydate: alom -> alom
(define(sortmailbydate alom)
 (cond
   [(empty? alom) empty]
   [else (insertbydate (first alom) (sortmailbydate (rest alom)))])) 
      


(sortmailbydate (cons(make-mail "Sebastian" 2015 "Ayylmao")(cons(make-mail "Person" 2016 "Mail") empty)))
(sortmailbydate (cons(make-mail "Sebastian" 2015 "Ayylmao")(cons(make-mail "Person" 2016 "Mail")(cons(make-mail "Peter" 2012 "What is Life") empty))))


;last: alon -> n
(define(last alon)
  (cond
    [(empty? alon) #false]
    [(empty? (rest alon)) (first alon)]
    [else (last (rest alon))]))


(last empty)
(last (cons 5(cons 7 empty)))
(last (cons 5(cons 25(cons 7 empty))))
(last (cons 7(cons 25(cons 57(cons 25(cons 2(cons 6(cons 9(cons 0(cons 12(cons 67(cons 68(cons 69(cons 5 empty))))))))))))))

;add-to-end : p alop -> alop
(define(add-to-end p alop)
  (cond
    [(empty? alop) (cons p empty)]
    [(cons? alop) (cons (first alop) (add-to-end p (rest alop)))]))
    


(add-to-end (make-posn 25 25) (cons(make-posn 175 125)(cons(make-posn 150 100)(cons(make-posn 125 100)(cons(make-posn 100 125)empty)))))

;replace-at-end : n alon -> alon
(define(replace-at-end n alon)
  (cond
    [(empty? alon) (cons n empty)]
    [(cons? (rest alon)) (cons (first alon) (replace-at-end n (rest alon)))]
    [(empty? (rest alon)) (replace-at-end n (rest alon))]))


(replace-at-end 5 empty)
(replace-at-end 6 (cons 5(cons 7 empty)))
(replace-at-end 5 (cons 7(cons 4(cons 8 empty))))


;add-at-end : n alon -> alon
(define(add-at-end n alon)
  (cond
    [(empty? alon) (cons n empty)]
    [(cons? alon) (cons (first alon) (add-at-end n (rest alon)))]))
    


(add-at-end 5 empty)
(add-at-end 6 (cons 5(cons 7 empty)))
(add-at-end 5 (cons 7(cons 4(cons 8 empty))))


;connect-the-dots : alop -> scene
(define(connect-the-dots alop)
  (cond
    [(empty? alop) (empty-scene 300 300)]
    [(empty? (rest alop)) (empty-scene 300 300)]
    [else (scene+line (connect-the-dots (rest alop)) (posn-x(first alop)) (posn-y(first alop)) (posn-x(first(rest alop))) (posn-y(first(rest alop))) 'black)]))

(connect-the-dots empty)
(connect-the-dots (cons(make-posn 150 125) (cons(make-posn 300 223)empty)))
(connect-the-dots (cons(make-posn 80 30)(cons(make-posn 40 30)(cons(make-posn 30 40)empty))))


;draw-polygon: alop -> scene
(define(draw-polygon alop)
  (connect-the-dots (add-at-end (first alop) alop)))



(draw-polygon (cons(make-posn 80 30)(cons(make-posn 70 50)empty)))
(draw-polygon (cons(make-posn 80 30)(cons(make-posn 40 30)(cons(make-posn 30 40)empty))))
(draw-polygon (cons(make-posn 100 150)(cons(make-posn 125 175)(cons(make-posn 150 175)(cons(make-posn 175 150)
              (cons(make-posn 175 125)(cons(make-posn 150 100)(cons(make-posn 125 100)(cons(make-posn 100 125)empty)))))))))




;search-sorted: n alon -> boolean
(define(search-sorted n alon)
  (cond
    [(empty? alon) false] 
    [(< n (first alon)) false]
    [(= n (first alon)) true]
    [(> n (first alon)) (search-sorted n (rest alon))]))

(search-sorted 1 empty) ;false
(search-sorted 5 (cons 1(cons 5 empty))) ;true
(search-sorted 5 (cons 1(cons 2(cons 3(cons 6 empty))))) ;false
(search-sorted 25(cons 16(cons 32(cons 64(cons 128(cons 256(cons 512(cons 1028 empty)))))))) ;false




 

























