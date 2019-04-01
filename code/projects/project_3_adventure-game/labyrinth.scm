;;; To make a labyrinth underneath sproul-plaza, say
;;; (instantiate labyrinth sproul-plaza)
;;; now go down from sproul to enter

;;; You might also want your character to maintain a list of rooms visited on
;;; its property list so you can find your way back to the earth's surface.

(define-class (labyrinth connect-place)
  (instance-vars (places (make-populated-places 100 60 4 'underground-room)))
  (initialize
    (can-go connect-place 'down (car places))
    (can-go (car places) 'up connect-place)
    (connect-places places)
    'okay))

;;; You may find this helpful for moving around
;;; You may want to modify it so that you can look around
;;; in nearby rooms before entering so that you can avoid thieves. 
(define (fancy-move-loop who)
  (newline)
  (let ((things (ask who 'look-around)))
    (if things
	(begin (print "You see")
	       (for-each (lambda (thing)
			   (display thing)
			   (display " "))
			 things))))
  (newline)
  (print (ask who 'exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (ask who 'go dir)
	       (fancy-move-loop who)))))



(define (make-places count name)
  (define (iter n)
    (if (> n count)
	'()
	(cons (instantiate place (word name '- n))
	      (iter (+ n 1)) )))
  (iter 1))

(define *object-types* '(gold lead pizza potstickers burritos))

(define (make-populated-places n-places n-objects n-thieves place-name)
  (let ((places (make-places n-places place-name)))
    (dotimes n-objects
	     (lambda (count)
	       (ask (pick-random places)
		    'appear
		    (instantiate thing (pick-random *object-types*)))))
    (dotimes n-thieves
	     (lambda (count)
	       (instantiate thief
			    (word 'Nasty '- count)
			    (pick-random places))))
    places))

(define direction-pairs '((north . south) (south . north)
			  (east . west) (west . east)
			  (up . down) (down . up)))

(define (connect-places places)
  (for-each (lambda (place)
	      (connect-pair place (pick-random places)))
	    places))

(define (connect-pair place1 place2)
  (define (c-p-helper place1 place2 dir-pairs)
    (cond ((null? dir-pairs) 'done)
     	  ((and (can-connect? place1 (caar dir-pairs))
	     	(can-connect? place2 (cdar dir-pairs)))
	   (can-go place1 (caar dir-pairs) place2)
	   (can-go place2 (cdar dir-pairs) place1))
	  (else (c-p-helper place1 place2 (cdr dir-pairs)))))
  (c-p-helper place1 place2 direction-pairs))

(define (can-connect? place direction)
  (not (member? direction (ask place 'exits))))

(define (dotimes limit f)
  ;; dotimes calls the procedure f on the numbers from 1 to the limit
  ;; dotimes is for side effect only
  (define (dotimes-iter count)
    (if (> count limit)
	'done ;; dotimes is for side-effect
	(begin (f count)
	       (dotimes-iter (+ count 1)))))
  (dotimes-iter 1))
