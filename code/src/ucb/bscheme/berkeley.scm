;;; berkeley.scm 4.03.01 Tue Jul 22 17:22:59 2003
;
; NOTE: THE MASTER COPY OF THIS FILE IS MAINTAINED BY EECS INSTRUCTIONAL
; SUPPORT. IF YOU MAKE CHANGES HERE THEY WILL GO AWAY.
;
;; Compatibility library for UCB Scheme (STk 4.0.1 derivative) as used
;; in CS61A and CS3. Over-hauled in May 2000 and April 2003 for 
;; STk compatibility and to remove dead code.
;;

(define nil '())
(define true #t)
(define false #f)

;; 4.0: STk already has a time program, so I nuked time
;; 4.0: STk load already has glob built in, so I nuked redef. of load
;; 4.02.01: Remove definition of read.

;; Removed 

;;; SICP stuff:

(define (print x)
  (write x)
  (newline))

;; Define tagged data ADT:

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

;;For Section 3.1.2 -- written as suggested in footnote,
;; though the values of a, b, m may not be very "appropriately chosen"
(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

;;For Section 3.3.4, used by and-gate
;;Note: logical-and should test for valid signals, as logical-not does
(define (logical-and x y)
  (if (and (= x 1) (= y 1))
      1
      0))

;; concurrency stuff

;; 4.0: Simplified these somewhat -- removed tests for scm
;;  and added alarm-signal-handler stuff

; For timer interrupts in STk:
(define (alarm-signal-handler sig) (alarm-interrupt))
(add-signal-handler! 14 alarm-signal-handler)

(require 'process)

(define test-and-set!
	     (let ((arb (make-arbiter 'scratchnsniff)))
	       (lambda (cell)
		 (if (try-arbiter arb)
		     (begin (process:schedule!)
			    (test-and-set! cell))
		     (let ((result (car cell)))
		       (set-car! cell #t)
		       (release-arbiter arb)
		       result)))))

(define (parallel-execute . thunks)
	     (for-each (lambda (thunk) (add-process! (lambda (foo) (thunk))))
		       thunks)
	     (alarm-interrupt)
	     (process:schedule!))

(define (stop) (alarm 0) (set! process:queue (make-queue)))

;;For Section 3.5.2, to check power series (exercises 3.59-3.62)
;;Evaluate and accumulate n terms of the series s at the given x
;;Uses horner-eval from ex 2.34
(define (eval-power-series s x n)
  (horner-eval x (first-n-of-series s n)))
(define (first-n-of-series s n)
  (if (= n 0)
      '()
      (cons (stream-car s) (first-n-of-series (stream-cdr s) (- n 1)))))

;; Streams:
;; 4.0: We do not redefine promises as procedures anymore.

; Restrict the domain of FORCE to include only promises.
(define force
  (let ((force force))
    (lambda (p)
      (if (not (promise? p))
          (error "Not a promise: " p)
          (force p)))))

(define-macro (cons-stream . args) 
              `(cons ,(car args) (delay ,(cadr args))))

(define (stream-car stream) (car stream))

(define (stream-cdr st)
  (force (cdr st)))

(define the-empty-stream '())

(define (stream-null? stream) (eq? stream the-empty-stream))

(define (stream? obj)
  (or (stream-null? obj)
      (and (pair? obj) (promise? (cdr obj)))))

(define (stream-accumulate combiner initial-value stream)
  (if (stream-null? stream)
      initial-value
      (combiner (stream-car stream)
		(stream-accumulate combiner
				   initial-value
				   (stream-cdr stream)))))

(define (accumulate-delayed combiner initial-value stream)
  (if (stream-null? stream)
      initial-value
      (combiner (stream-car stream)
                (delay
                 (accumulate-delayed combiner
                                     initial-value
                                     (stream-cdr stream))))))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (interleave-delayed s1 delayed-s2)
  (if (stream-null? s1)
      (force delayed-s2)
      (cons-stream (stream-car s1)
                   (interleave-delayed (force delayed-s2)
                                       (delay (stream-cdr s1))))))

(define (stream-flatten stream)
  (accumulate-delayed interleave-delayed
                      the-empty-stream
                      stream))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc . s)
  (if (stream-null? (car s))
      the-empty-stream
      (cons-stream (apply proc (map stream-car s))
                   (apply stream-map proc (map stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin
       (proc (stream-car s))
       (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each
   (lambda (element) (newline) (display element))
   s))

(define (stream-flatmap f s)
  (stream-flatten (stream-map f s)))

(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (stream-append (stream-cdr s1) s2))))

(define (list->stream l)
  (if (null? l)
      the-empty-stream
      (cons-stream (car l) (list->stream (cdr l))) ))

(define (make-stream . elements)
  (list->stream elements))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low (stream-enumerate-interval (+ low 1) high))))

(define range stream-enumerate-interval)

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
	((pred (stream-car stream))
	 (cons-stream (stream-car stream)
		      (stream-filter pred (stream-cdr stream))))
	(else (stream-filter pred (stream-cdr stream)))))

(define (show-stream strm . args)
  (if (null? args)
      (ss1 strm 10 10)
      (ss1 strm (car args) (car args))))

(define ss show-stream)

(define (ss1 strm this all)
  (cond ((null? strm) '())
	((= this 0) '(...))
	((and (pair? strm) (promise? (cdr strm)))
	 (cons (ss1 (stream-car strm) all all)
	       (ss1 (stream-cdr strm) (- this 1) all)))
	(else strm)))

(define div quotient)

(define /
  (let ((old/ /))
    (lambda args
      (let ((quo (apply old/ args)))
	(if (integer? quo)
	    quo
	    (exact->inexact quo))))))

;; 4.0: STk has the RRRS 1+ and -1+ built in; we removed their definitions
;; from here.

(define (nth n l) (list-ref l n))

;; This is a debugging aid for programs with parenthesis problems,
;; according to bh.
(define (load-noisily file-name)
  (define (iter port)
    (let ((the-expression (read port)))
      (cond ((eof-object? the-expression) #t)
	    (else
	     (display (eval the-expression))
	     (newline)
	     (iter port)))))
  (let ((port (open-input-file file-name)))
    (iter port)
    (close-input-port port)
    'ok))


;;;  Get and put for section 2.3

(define (get key1 key2)
  (let ((subtable (assoc key1 (cdr the-get/put-table))))
	(if (not subtable)
		#f
		(let ((record (assoc key2 (cdr subtable))))
		  (if (not record)
			  #f
			  (cdr record))))))

(define (put key1 key2 value)
  (let ((subtable (assoc key1 (cdr the-get/put-table))))
    (if (not subtable)
        (set-cdr! the-get/put-table
                  (cons (list key1
                              (cons key2 value))
                        (cdr the-get/put-table)))
        (let ((record (assoc key2 (cdr subtable))))
          (if (not record)
              (set-cdr! subtable
                        (cons (cons key2 value)
                              (cdr subtable)))
              (set-cdr! record value)))))
  'ok)

(define the-get/put-table (list '*table*))

;; Error is like LISP FORMAT in STk:

(define error
  (let ((stk-error error))
    (lambda args
      (if (and (not (null? args)) (string-find? "~" (car args)))
	  (apply stk-error args)
	  (stk-error "~A" 
		     (with-output-to-string
		       (lambda ()
			 (for-each (lambda (x) (display x)) args))))))))

;; ROUND returns an inexact integer if its argument is inexact,
;; but we think it should always return an exact integer.
;; (It matters because some Schemes print inexact integers as "+1.0".)
;; The (exact 1) test is for PC Scheme, in which nothing is exact.
(if (and (inexact? (round (sqrt 2))) (exact? 1))
    (let ((old-round round)
	  (inexact->exact inexact->exact))
      (set! round
	    (lambda (number)
	      (inexact->exact (old-round number)))))
    'no-problem)

;; Remainder and quotient blow up if their argument isn't an integer.
;; Unfortunately, in SCM, (* 365.25 24 60 60) *isn't* an integer.

(if (inexact? (* .25 4))
    (let ((rem remainder)
	  (quo quotient)
	  (inexact->exact inexact->exact)
	  (integer? integer?))
      (set! remainder
	    (lambda (x y)
	      (rem (if (integer? x) (inexact->exact x) x)
		   (if (integer? y) (inexact->exact y) y))))
      (set! quotient
	    (lambda (x y)
	      (quo (if (integer? x) (inexact->exact x) x)
		   (if (integer? y) (inexact->exact y) y)))))
    'done)

;; Random
;; 4.0: STk has RANDOM, but it needs a little initialization in order
;; to give interesting numbers.

(require "posix")
(set-random-seed! (posix-time))

(define-macro (repeat . args)
	     `(repeat-helper ,(car args) (lambda () . ,(cdr args))))

(define (repeat-helper num thunk)
  (if (<= num 0)
      'done
      (begin (thunk) (repeat-helper (- num 1) thunk))))

(define call/cc call-with-current-continuation)

(define *old-repl-display-result* repl-display-result)

(define repl-display-result print)

(define (infinite-print flag)
  (if flag
      (set! repl-display-result *old-repl-display-result*)
      (set! repl-display-result print)))

;Added this because keywords should be symbols according to BH.
(define symbol? 
  (let ((old-symbol? symbol?))
    (lambda (x) (or (old-symbol? x) (keyword? x)))))

;; 02/02/2005 : Added as requested by Professors
(define (1+ n) (+ n 1))
(define (-1+ n) (- n 1))

;
; NOTE: THE MASTER COPY OF THIS FILE IS MAINTAINED BY EECS INSTRUCTIONAL
; SUPPORT. IF YOU MAKE CHANGES HERE THEY WILL GO AWAY.
;

(provide "berkeley")
