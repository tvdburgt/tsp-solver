;;; Exact dynamic programming approach for the travelling salesman problem.
;;;
;;; Time complexity: O(2^n * n^2)
;;; Space complexity: O(2^n * n)

(defconstant +dbl-inf+ most-positive-double-float
	     "Default (sub)distance")

(defvar *n* (read)
  "Number of cities")

(defvar *nset* (ash 1 *n*)
  "Number of subsets")

(defvar *dist* (make-array (list *n* *n*) :element-type 'double-float)
  "Distance matrix")

(defvar *subdist* (make-array (list *nset* *n*)
			      :element-type 'double-float
			      :initial-element +dbl-inf+)
  "Subsets array")

;; Read distances from stdin
(dotimes (i *n*)
  (let ((line (read-line)))
    (with-input-from-string (s line)
      (loop for x = (read s nil nil)
	    for j from 0
	    while x
	    do (setf (aref *dist* i j) x)))))

(setf (aref *subdist* 1 0) 0)

;; Build subsets
(loop for s from 3 below *nset* by 2 ; Iterate each subset s that includes our begin city
      do (loop for j from 1 below *n* ; Iterate each potential ending city j for s
	       when (logbitp j s) ; Skip cities outside subset s
	       do (let ((u (dpb 0 (byte 1 j) s))) ; Exclude j from subset u

		    ; Minimize subdistance for j by finding closest city i
		    ; (read: least distance) in u
		    (loop for i below *n*
			  when (and (/= i j)
				    (logbitp i s)
				    (< (aref *subdist* u i) +dbl-inf+)
				    (< (+ (aref *subdist* u i) (aref *dist* i j)) (aref *subdist* s j)))
			  do (setf (aref *subdist* s j)
				   (+ (aref *subdist* u i) (aref *dist* i j)))))))


;; Build shortest cycle
(let ((cycle (list 0))

      ; Use a bit array for keeping track of visited cities 
      (visited (make-array *n* :element-type 'bit :initial-element 0))

      ; Start with full subset
      (s (- *nset* 1)))

  ; Mark starting city as visited
  (setf (aref visited 0) 1)

  ; Determine remaining n-2 cities
  (loop for i below (- *n* 1)
	with best-j
	with min-dist = +dbl-inf+

	; Find closest city to previous one in the cycle
	do (loop for j below *n*
		 when (and (not (plusp (bit visited j)))
			   (< (+ (aref *subdist* s j) (aref *dist* (first cycle) j)) min-dist))
		 do (setf best-j j
			  min-dist (+ (aref *subdist* s j)
				      (aref *dist* (first cycle) j))))

	; Add closest city to cycle
	(push best-j cycle)

	; Exclude closest city from subset and mark it visited
	(setf (aref visited best-j) 1
	      s (dpb 0 (byte 1 best-j) s)))

  ; Complete cycle by adding starting city
  (push 0 cycle)

  ; Print (reversed) city cycle
  (format t "~{~a~^ ~}~%" (reverse cycle))

  ; Print accumulated cycle cost
  (format t "~$~%" (loop for (a b) on cycle while b sum (aref *dist* a b))))
