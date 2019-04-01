; Library files for Exploring Computer Science with Scheme
; Oliver Grillmeyer
; Revised April 2002 by Brian R. Gaeke
; Version 2.02.0 2002/04/26 02:22:06
;
; Contents
; truncate (redefined to give exact number)
; round (redefined to give exact number)
; first, second, third, fourth, fifth, rest
; subseq
; position, remove, count (all use equal? for comparison)
; atom?
; find-if, find-if-not, count-if, count-if-not, remove-if, keep-if
; rassoc (uses equal? for comparison)
; every, any, some
; accumulate, accumulate-tail, reduce, reduce-tail
; intersection, union, set-difference, subset?, adjoin
; random, init-random (now using STk builtins)
; Removed redefinitions of define/set!
; 

;; Tells us which file's (simply or explorin) definitions take precedence 
;; if they conflict

(define (explorinOrSimply)
   "explorin")


; Assumptions - function error exists
; Add the following code if error does not exist in your version of LISP
; (define error-setup 'init)
;
; (call-with-current-continuation
;   (lambda (stop)
;     (set! error-setup stop)))
;
; Print an error message made up of the arguments to the function.
; (define error
;   (let ((newline newline) (display display) (car car) (cdr cdr)
;          (for-each for-each) (error-setup error-setup))
;     (lambda vals
;       (newline)
;       (display "Error: ")
;       (display (car vals))
;       (for-each (lambda (val) (display " ") (display val)) (cdr vals))
;       (error-setup '.))))

; Redefine truncate to return an exact integer.
(set! truncate
  (let ((truncate truncate) (inexact->exact inexact->exact))
    (lambda (number)
      (inexact->exact (truncate number)))))

; Redefine round to return an exact integer.
(set! round
  (let ((round round) (inexact->exact inexact->exact))
    (lambda (number)
      (inexact->exact (round number)))))

; Return the first element of a list.
(define first car)

; Return the second element of a list.
(define second cadr)

; Return the third element of a list.
(define third caddr)

; Return the fourth element of a list.
(define fourth cadddr)

; Return the fifth element of a list.
(define fifth
  (let ((car car) (cddddr cddddr))
    (lambda (lst)
      (car (cddddr lst)))))

; Return the rest of a list.
(define rest cdr)

; Returns list without last num elements (like butlast in Common LISP).
(define list-head
  (let ((>= >=) (length length) (= =) (cons cons) (car car) (cdr cdr))
    (lambda (lst num)
      (cond ((>= num (length lst)) '())
            ((= num 0) lst)
            (else (cons (car lst) (list-head (cdr lst) num)))))))

; Returns subsection of lst from positions start to end-1.
(define subseq
  (let ((length length) (null? null?) (not not) (<= <=)
         (error error) (list-head list-head) (list-tail list-tail))
    (lambda (lst start . args)
      (let* ((len (length lst))
              (end (if (null? args) len (car args))))
        (cond ((not (<= 0 start len))
                  (error "Improper start value for subseq:" start))
              ((not (<= 0 start end len))
                  (error "Improper end value for subseq:" end))
              (else
                  (list-head (list-tail lst start) (- len end))))))))

; Returns the position (base 0) of the first occurrence of elt in lst.
(define position-helper
  (let ((null? null?) (equal? equal?) (car car) (cdr cdr) (+ +))
    (lambda (elt lst num)
      (cond ((null? lst) #f)
            ((equal? elt (car lst)) num)
            (else (position-helper elt (cdr lst) (+ num 1)))))))

(define position
  (let ((position-helper position-helper))
    (lambda (elt lst)
      (position-helper elt lst 0))))

; Returns new list with all occurrences of elt removed.
(define remove
  (let ((null? null?) (equal? equal?) (car car) (cdr cdr) (cons cons))
    (lambda (elt lst)
      (cond ((null? lst) '())
            ((equal? elt (car lst)) (remove elt (cdr lst))) 
            (else (cons (car lst) (remove elt (cdr lst))))))))

; Returns the number of times elt occurs in lst.
(define count
  (let ((null? null?) (equal? equal?) (car car) (cdr cdr) (+ +))
    (lambda (elt lst)
      (cond ((null? lst) 0)
            ((equal? elt (car lst))  (+ 1 (count elt (cdr lst))))
            (else (count elt (cdr lst)))))))

; Returns #t if item is a symbol or a number, #f otherwise.
(define atom?
  (let ((symbol? symbol?) (number? number?))
    (lambda (item)
      (or (symbol? item) (number? item)))))

; Returns the first element in lst that satisfies func, #f if no elements
; satisfy func.
(define find-if
  (let ((null? null?) (car car) (cdr cdr))
    (lambda (func lst)
      (cond ((null? lst) #f)
            ((func (car lst)) (car lst))
            (else (find-if func (cdr lst)))))))

; Returns the first element in lst that does not satisfy func, #f if all
; elements satisfy func.
(define find-if-not
  (let ((null? null?) (not not) (car car) (cdr cdr))
    (lambda (func lst)
      (cond ((null? lst) #f)
            ((not (func (car lst))) (car lst))
            (else (find-if-not func (cdr lst)))))))

; Returns the number of elements in lst that satisfy func.
(define count-if
  (let ((null? null?) (car car) (cdr cdr) (+ +))
    (lambda (func lst)
      (cond ((null? lst) 0)
            ((func (car lst)) (+ 1 (count-if func (cdr lst))))
            (else (count-if func (cdr lst)))))))

; Returns the number of elements in lst that do not satisfy func.
(define count-if-not
  (let ((null? null?) (not not) (car car) (cdr cdr) (+ +))
    (lambda (func lst)
      (cond ((null? lst) 0)
            ((not (func (car lst))) (+ 1 (count-if-not func (cdr lst))))
            (else (count-if-not func (cdr lst)))))))

; Returns new list with all elements satisfying func removed.
(define remove-if
  (let ((null? null?) (car car) (cdr cdr) (cons cons))
    (lambda (func lst)
      (cond ((null? lst) '())
            ((func (car lst))
                 (remove-if func (cdr lst)))
            (else
                 (cons (car lst) (remove-if func (cdr lst))))))))

; Returns new list with all elements satisfying func.
(define keep-if
  (let ((null? null?) (not not) (car car) (cdr cdr) (cons cons))
    (lambda (func lst)
      (cond ((null? lst) '())
            ((not (func (car lst)))
                 (keep-if func (cdr lst)))
            (else
                 (cons (car lst) (keep-if func (cdr lst))))))))

; Like assoc but returns the first pair whose cdr matches elt.
; 2.0: Uses equal? for comparison, by analogy with assoc.
(define rassoc
  (let ((find-if find-if) (equal? equal?) (cdr cdr))
    (lambda (elt assoc-list)
      (find-if (lambda (dotted-pair)
                 (equal? (cdr dotted-pair) elt))
        assoc-list))))

; every and any each take a variable number of lists as arguments and
; apply the function to those N lists using apply and map.  To make the
; recursive call, apply is used to convert a list of argument lists into
; separate arguments.

; Returns #t if all successive elements in lists satisfy func, #f otherwise.
(define every
  (let ((null? null?) (car car) (cdr cdr) (apply apply) (map map) (cons cons)
        (member member))
    (lambda (func . lists)
       (cond ((member #t (map null? lists)) #t)
             ((member #t (map (lambda (lst) (null? (cdr lst))) lists))
                 (apply func (map car lists)))
             (else
                 (and (apply func (map car lists))
                      (apply every (cons func (map cdr lists)))))))))

; Return the first true value from applying func to successive
; elements in lists, or #f if no elements satisfy func.
;
; 2.0: some is another name for any.
(define any
  (let ((null? null?) (car car) (cdr cdr) (apply apply) (map map) (cons cons)
        (member member))
    (lambda (func . lists)
      (if (member #t (map null? lists))
          #f
          (or (apply func (map first lists))
              (apply any (cons func (map rest lists))))))))
(define some any)

; Returns result of applying func to elements of lst in the following manner:
; func is applied to the first two elements of lst then to that result and the
; third element, then to that result and the fourth element, and so on until
; all elements have been applied.
;
; 2.0: accumulate-tail is a helper function for accumulate.  reduce and
; reduce-tail are the old-school COMMON LISP names for these functions.
(define accumulate-tail
  (let ((null? null?) (car car) (cdr cdr))
    (lambda (func lst answer)
       (if (null? lst)
           answer
           (accumulate-tail func (cdr lst) (func answer (car lst)))))))
(define reduce-tail accumulate-tail)

(define accumulate
  (let ((null? null?) (car car) (cdr cdr) (accumulate-tail accumulate-tail))
    (lambda (func lst)
       (if (null? lst)
           (func)
           (accumulate-tail func (cdr lst) (car lst))))))
(define reduce accumulate)

; Returns the elements that set1 and set2 have in common.
(define intersection
  (let ((null? null?) (member member) (car car) (cdr cdr) (cons cons))
    (lambda (set1 set2)
       (cond ((or (null? set1) (null? set2))
                  '())
             ((member (car set1) set2)
                  (cons (car set1) (intersection (cdr set1) set2)))
             (else
                  (intersection (cdr set1) set2))))))

; Returns the elements that exist in either set1 or set2.
(define union
  (let ((null? null?) (member member) (car car) (cdr cdr) (cons cons))
    (lambda (set1 set2)
       (cond ((null? set1)
                  set2)
             ((member (car set1) set2)
                  (union (cdr set1) set2))
             (else
                  (cons (car set1) (union (cdr set1) set2)))))))

; Returns the elements that exist in set1 but not in set2.
(define set-difference
  (let ((null? null?) (member member) (car car) (cdr cdr) (cons cons))
    (lambda (set1 set2)
       (cond ((null? set2)
                  set1)
             ((null? set1)
                  '())
             ((member (car set1) set2)
                  (set-difference (cdr set1) set2))
             (else
                  (cons (car set1) (set-difference (cdr set1) set2)))))))

; Returns #t if all the elements in set1 exist in set2.
(define subset?
  (let ((null? null?) (member member) (car car) (cdr cdr))
    (lambda (set1 set2)
       (cond ((null? set1)
                  #t)
             ((null? set2)
                  #f)
             (else
                  (and (member (car set1) set2)
                       (subset? (cdr set1) set2)))))))

; Returns a new set of item and the elements in set if item does not exist
; in set, otherwise returns set.
(define adjoin
  (let ((member member) (cons cons))
    (lambda (item set)
       (if (member item set)
           set
           (cons item set)))))

; 2.0: STk has random built in. It takes a single argument.
; (random N) returns a pseudorandom number between 0 and N-1 inclusive.
; It needs a little initialization in order to give interesting numbers:

(require "posix")
(set-random-seed! (posix-time))

; 2.0: STk has init-random built in, but under a different name.
(define (init-random seed)
    (set-random-seed! seed))

(define remove!
  (let ((null? null?)
        (cdr cdr)
        (eq? eq?)
        (set-cdr! set-cdr!)
        (car car))
    (lambda (thing lst)
      (define (r! prev)
        (cond ((null? (cdr prev)) lst)
              ((eq? thing (car (cdr prev)))
               (set-cdr! prev (cdr (cdr prev)))
               lst)
              (else (r! (cdr prev)))))
      (cond ((null? lst) lst)
            ((eq? thing (car lst)) (cdr lst))
            (else (r! lst))))))

(provide "explorin")
