;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Section 14|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct child(name date ec mother father))


(define Sebastian (make-child 'Sebastian 2000 'green
                              (make-child 'Dank 1999 'green empty (make-child 'Maymays 1998 'green empty empty))
                              (make-child 'Memes 1999 'blue empty empty)))

(define Pepe(make-child 'Pepe 2007 'green empty empty))

(define Riperino(make-child 'Riperino 2005 'blue empty
                            (make-child 'Dankmemes 1999 'green empty (make-child 'RonSwanson 0 'green
                                                                                 (make-child 'Rons 1 'green empty empty)empty))))



;; Ftn is either
;empty or
;(make-child ... m f) where m and f are ftn



;blue-eyed-ancestor: ftn -> boolean 
(define(blue-eyed-ancestor ftn)
  (cond
    [(empty? ftn) false]
    [(child? ftn)
     (or
      (symbol=? (child-ec ftn) 'blue)
      (blue-eyed-ancestor(child-mother ftn))
      (blue-eyed-ancestor(child-father ftn)))]))



(blue-eyed-ancestor empty)
(blue-eyed-ancestor Sebastian)
(blue-eyed-ancestor Pepe)
(blue-eyed-ancestor Riperino)



;count: ftn -> number
(define(count ftn)
  (cond
    [(empty? ftn) 0]
    [(child? ftn) (+ (add1(count(child-mother ftn))) (count(child-father ftn)))]))


(count empty)
(count Sebastian)
(count Pepe) 
(count Riperino)




;eye-colors : ftn -> alos
(define(eye-colors ftn)
  (cond  
    [(empty? ftn) empty]
    [(child? ftn) (cons(child-ec ftn)  (append (eye-colors (child-mother ftn)) (eye-colors (child-father ftn))))]))

(eye-colors empty)
(eye-colors Sebastian)
(eye-colors Pepe) 
(eye-colors Riperino)


;how-far-removed: ftn -> n
(define(how-far-removed ftn)
  (cond
    [(empty? ftn) false]
    [(child? ftn)
     (cond
       [(symbol=? (child-ec ftn) 'blue)  0]
       [(blue-eyed-ancestor (child-father ftn)) (add1(how-far-removed(child-father ftn)))]
       ;[(blue-eyed-ancestor (child-mother ftn)) (add1(how-far-removed(child-mother ftn)))]
       [else false])]))


(how-far-removed empty)
(how-far-removed Pepe)  
(how-far-removed Sebastian)
(how-far-removed Riperino)
(how-far-removed (make-child 'Person1 1990 'blue empty empty))


;proper-blue-eyed-ancestor?: ftn -> boolean
(define(proper-blue-eyed-ancestor? ftn)
  (cond
    [(empty? ftn) false]
    [(child? ftn)
     (or
      (blue-eyed-ancestor (child-mother ftn))
      (blue-eyed-ancestor (child-father ftn)))]))


(proper-blue-eyed-ancestor? empty)
(proper-blue-eyed-ancestor? Sebastian)
(proper-blue-eyed-ancestor? Pepe)
(proper-blue-eyed-ancestor? Riperino)



(define-struct node (ssn name left right))

(define bt1            (make-node 50 'Sebastian
                                  (make-node 69 'August (make-node 90 'Peter (make-node 55 'Person empty empty) empty) empty)
                                  (make-node 41 'Augustinas empty (make-node 25 'Pdog empty (make-node 15 'Nosrep empty empty)))))


;contains-bt: n bt -> boolean
(define(contains-bt n bt)
  (cond
    [(empty? bt) false]
    [(node? bt) (or
                 (= (node-ssn bt) n)
                 (contains-bt n(node-left bt))
                 (contains-bt n(node-right bt)))]))

(contains-bt 2 empty) ;false
(contains-bt 50 bt1) ;true
(contains-bt 25 bt1) ;true
(contains-bt 41 bt1) ;true
(contains-bt 79 bt1) ;false


;search-bt: n bt -> boolean
(define(search-bt n bt)
  (cond
    [(empty? bt) false]
    [(node? bt)
     (cond
       [(= (node-ssn bt) n) (node-name bt)]
       [(contains-bt n (node-left bt))  (search-bt n (node-left bt))]
       [(contains-bt n (node-right bt)) (search-bt n (node-right bt))]
       [else false])]))



(search-bt 2 empty) ;false
(search-bt 50 bt1) ;Sebastian
(search-bt 25 bt1) ;Pdog
(search-bt 41 bt1) ;Augustinas
(search-bt 90 bt1) ;Peter
(search-bt 79 bt1)



;; Binary Search Tree is a Binary Tree

;; False is always a Binary Search Tree

;; (make-node soc pn left right) is a BST if left or right are bst's
;; All ssn in the left branch are smaller than the right iff

(define bst (make-node 55 'Person55
                       (make-node 24 'Person24 (make-node 23 'Person23 empty empty) (make-node 25 'Person25 empty empty))
                       (make-node 60 'Person60 empty (make-node 72 'Person72 (make-node 65 'Person65 empty empty) (make-node 75 'Person75 empty empty)))))




;inorder: bt -> alon
(define(inorder bt)
  (cond
    [(empty? bt) empty]
    [(node? bt)
     (append
      (inorder(node-left bt))
      (cons (node-ssn bt)
            (inorder (node-right bt))))]))


(inorder bt1) ;(list 55 90 69 50 41 25 15)
(inorder (make-node 5 'Person5 (make-node 2 'Person2 (make-node 1 'Person empty empty) empty)(make-node 7 'Person7 empty empty))) ;(list 1 2 5 7]
(inorder bst) ;(list 23 24 25 55 60 65 72 75)


;search-bst: n bst -> boolean
(define(search-bst n bst)
  (cond
    [(empty? bst) false]
    [(node? bst) 
     (cond
       [(= n (node-ssn bst)) (node-name bst)]
       [(> n (node-ssn bst)) (search-bst n(node-right bst))]
       [(< n (node-ssn bst)) (search-bst n(node-left bst))])]))


(search-bst 22 empty) ;false
(search-bst 55 bst) ;Person55
(search-bst 25 bst) ;Person25
(search-bst 78 bst) ;false
(search-bst 23 bst) ;Person23

;create-bst: bst n s -> bst
(define(create-bst bst n s)
  (cond
    [(boolean? bst) (make-node n s false false )]
    [(node? bst)
     (cond
       [(< n (node-ssn bst))
        (make-node (node-ssn bst) (node-name bst) (create-bst(node-left bst)n s) (node-right bst))]
       [(< (node-ssn bst) n)
        (make-node (node-ssn bst) (node-name bst) (node-left bst) (create-bst(node-right bst)n s))])]))




(create-bst false 24 'Node1) ; (make-node 24 'Node1 false false)
(create-bst(create-bst false 24 'Node1) 25 'Node2) ;(make-node 24 'Node1 false (make-node 25 'Node2 false false))
(create-bst(create-bst(create-bst false 24 'Node1) 23 'Node2) 22 'Node3) ;(make-node 24 'Node1 (make-node 23 'Node2 (make-node 22 'Node 3 false) false))
(create-bst(create-bst(create-bst(create-bst false 55 'Node1) 67 'Node2)45 'Node3)68 'Node4) ;(make-node 55 'Node1 (make-node 45 'Node3 #false #false) (make-node 67 'Node2 #false (make-node 68 'Node4 #false #false)))


;create-bst-from-list: alon -> bst
(define(create-bst-from-list alon)
  (cond
    [(empty? alon) false]
    [else  (create-bst (create-bst-from-list(rest alon)) (first(first alon)) (first(rest(first alon))))]))





(create-bst-from-list empty) ;false
(create-bst-from-list (list (list 5 'Node5) (list 7 'Node7))) ;(make-node 5 'Node5 false false)
(create-bst-from-list (list (list 1 'Node1) (list 5 'Node5))) ;(make-node 1 'Node1 false (make-node 5 'Node5 false false))
(create-bst-from-list (list (list 5 'Node5) (list 7 'Node7) (list 2 'Node2))) ;(make-node 5 'Node5 (make-node 2 'Node2 false false) (make-node 7 'Node7 false false))
(create-bst-from-list (list (list 25 'Node25) (list 20 'Node20) (list 30 'Node 30) (list 15 'Node15) (list 10 'Node10))) ;(make-node 25 'Node25


;;A Web-page (short: WP) is either

;;empty;

;;(cons s wp) 
;;where s is a symbol and wp is a Web page; or

;;(cons ewp wp) 
;;where both ewp and wp are Web pages


;size: wp -> n
(define(size wp)
  (cond
    [(empty? wp) 0]
    [(symbol? (first wp)) (add1 (size (rest wp)))]
    [else (+ (size(first wp)) (size(rest wp)))]))


(size empty)
(size '(pepe))
(size '(One Two Three Four
            (Embedded Web-Page)))


;occurs1: wp s -> n
(define(occurs1 wp s)
  (cond
    [(empty? wp) 0]
    [(symbol? (first wp))
     (cond
       [(symbol=? (first wp) s) (add1 (occurs1(rest wp)s))]
       [else (occurs1(rest wp)s)])]
    [(cons? wp) (occurs1 (rest wp)s)]))



(occurs1 empty 'Wow)
(occurs1 '(This is a webpage for my example) 'word)
(occurs1 '(This is another webpage created for an example 2nd example) 'example)
(occurs1 '(this is a special webpage (Embedded webpage) another (Embedded webpage webpage)) 'webpage)


;occurs2: wp s -> n
(define(occurs2 wp s)
  (cond
    [(empty? wp) 0]
    [(symbol? (first wp))
     (cond
       [(symbol=? (first wp) s) (add1 (occurs2(rest wp)s))]
       [else (occurs2(rest wp)s)])]
    [else (+ (occurs2(first wp)s) (occurs2(rest wp)s))]))



(occurs2 empty 'Wow)
(occurs2 '(This is a webpage for my example) 'word)
(occurs2 '(This is another webpage created for an example 2nd example) 'example)
(occurs2 '(this is a special webpage (Embedded webpage) another (Embedded webpage webpage)) 'webpage)


;replace: new old wp -> wp
(define(replace new old wp)
  (cond
    [(empty? wp) empty]
    [(symbol? (first wp))
     (cond
       [(symbol=?(first wp)old) (cons new(replace new old(rest wp)))]
       [else (cons(first wp) (replace new old(rest wp)))])]
    [else (cons(replace new old (first wp)) (replace new old (rest wp)))]))


(replace 'webpage 'example '(This is a webpage for my example))
(replace 'no 'hello '(hello hello hello hello hello hello hello hello hello hello))
(replace 'embedded 'notanymorelmao '(this is a special webpage (Embedded webpage) another (Embedded webpage webpage)))

;max1: list -> n
(define(max1 alon)
  (cond
    [(empty? alon) 0]
    [(>= (first alon) (max1(rest alon))) (first alon)]
    [else (max1 (rest alon))]))


(max1 (list 8 4 8 90))
;depth: wp -> n
(define(depth wp)
  (cond
    [(empty? wp) 0]
    [(symbol?(first wp))(depth (rest wp))]        
    [else (max1 (list(add1(depth (first wp))) (depth (rest wp))))]))



(depth '(hello hello hello)) ;0
(depth '(hello (hello hello))) ;1
(depth '(hello (hello(hello(hello))))) ;3
(depth '(hello (hello(hello)) (hello))) ;2
(depth '(hello (hello) (hello(hello)))) ;2


(define-struct add (left right))
(define-struct mul (left right))




;; A Scheme Expression is either

;; a symbol 'symbol

;; a number 1

;; (make-add l r) where l and r are scheme expressions
;; (make-mul l r) where l and r are scheme expressions


;1. (make-add 10 -10)
;2. (make-add (make-mul 20 3) 33)
;3. (make-mul 3.14 (make-mul 'r 'r))
;4. (make-add (make-mul 9/5 c) 32)
;5. (make-add (make-mul 3.14 (make-mul 'o 'o)) (make-mul 3.14 (make-mul 'i 'i)))



;numeric?: Scheme expression -> Boolean
(define(numeric? exp)
  (cond
    [(symbol? exp) false]
    [(number? exp) true]
    [(add? exp) (and
                 (numeric? (add-left exp))
                 (numeric? (add-right exp)))]
    [(mul? exp) (and
                 (numeric? (mul-right exp))
                 (numeric? (mul-left exp)))])) 

(numeric? (make-add 10 -10))            ;true
(numeric? (make-mul 10 -10))            ;true
(numeric? (make-mul 5 (make-add 2 'x))) ;false


;evaluate-expression: Scheme Expression -> n or false 
(define(evaluate-expression exp)
  (cond
    [(number? exp) exp]
    [(numeric? exp)
     (cond
       [(mul? exp) (* (evaluate-expression(mul-left exp)) (evaluate-expression(mul-right exp)))]
       [(add? exp) (+ (evaluate-expression(add-left exp)) (evaluate-expression(add-right exp)))])]
    [else false]))
       

;evaluate-expression: Scheme Expression -> n or false 
(define(eval-expr exp)
  (cond
    [(not (numeric? exp)) false]
    ;[(number? exp) exp]
    [(mul? exp) (* (evaluate-expression(mul-left exp)) (evaluate-expression(mul-right exp)))]
    [(add? exp) (+ (evaluate-expression(add-left exp)) (evaluate-expression(add-right exp)))]))


(eval-expr (make-add 10 -10))            ;0          
(eval-expr (make-mul 10(make-mul 5 7)))  ;350
(eval-expr (make-mul 5 (make-add 2 'x))) ;false

(evaluate-expression (make-mul 5 (make-add 2 3)))  ;25
(evaluate-expression (make-mul 5 (make-add 2 'x))) ;false


;subst: v n scheme expression(exp) ->  scheme expression where all occurrences of v are now n
(define(subst v n exp)
  (cond
    [(number? exp) exp]
    [(symbol? exp)
       (cond
         [(symbol=? exp v) n]
         [else exp])]
    [(mul? exp) (make-mul(subst v n(mul-left exp))
                         (subst v n(mul-right exp)))]
    [(add? exp) (make-add(subst v n(add-left exp))
                         (subst v n(add-right exp)))]))

(subst 'x 5 (make-add 'h 2))              ;(make-add 'h 2)
(subst 'x 5 (make-add 5 2))               ;(make-add 5 2)
(subst 'x 5 (make-mul 'x 2))              ;(make-mul 5 2)
(subst 'x 5 (make-mul 5 (make-mul 'x 2))) ;(make-mul 5 (make-mul 5 2))
(subst 'x 5 (make-mul 5 (make-add 5 'x))) ;(make-mul 5 (make-mul 5 5))
        









































