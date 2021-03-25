#lang racket

(define (sod2 n i)
  (if (< i 2) 0
    (+ (if (= (modulo n i) 0) i 0)
        (sod2 n (- i 1)))))
 
(define (sod n)
  (if (< n 0) (- (sod (- n))) (sod2 n (exact-round (/ n 2)))))

#|
(define (sod n)
  (letrec ([f (lambda (i)
              (if (< i 2) 0
                (+ (if (= (modulo n i) 0) i 0)
                   (f (- i 1)))))])
    (if (< n 0) (- (sod (- n))) (f (exact-round (/ n 2))))))
|#


