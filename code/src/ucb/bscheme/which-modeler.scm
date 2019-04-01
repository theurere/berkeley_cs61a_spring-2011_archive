
;; This file is used to replace cs3-modeler.stk and cs3s-modeler.stk
;; The cs3 modeler needs using-berkeley-scm to be true while for the
;; cs3s modeler needs using-berkeley-scm to be false

;;explorin = cs3s
(if (string=? (explorinOrSimply) "explorin")
    (define (using-berkeley-scm?) #f)
    ;; else simply = cs3
    (define (using-berkeley-scm?) #t)
    )

(define *harvey+wright* (using-berkeley-scm?))
(define *grillmeyer* (not (using-berkeley-scm?)))
(define *they-know-lambda* #f)
