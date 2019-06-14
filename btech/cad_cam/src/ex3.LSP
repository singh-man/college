(defun c:ex3()
  (setq r1(getint "\n enter the radius of first circle:"))
  (setq r2(getint "\n enter the radius of second circle:"))
  (setq c1(getpoint "\n center for the first circle:"))
  (setq c2(getpoint "\n center for the second circle:"))
  (command "circle" c1 r1 )
  (command "circle" c2 r2 )
  (command "line" c1 c2 "")
  (setq alpha(atan (- (cadr c2) (cadr c1)) (- (car c2) (car c1)))); centre line angle
  (setq c0(/ (- (cadr c2) (cadr c1)) (sin alpha)))                ; centre distance
  (setq sb(/ (+ r1 r2) c0))					  ; sin beta	
  (setq cb(sqrt (- 1 (* sb sb))))				  ; cos beta
  (setq beta(atan sb cb))					  ; angle beta
  (setq p21(polar c2 (+ alpha (/ pi 2) beta) r2))		  ; tangent pts on c2 
  (setq p12(polar c1 (+ alpha (/ pi 2) beta pi) r1))		  ; & on circles c1
  (command "osnap" "off")					 
  (command "line" p21 p12 "")
  (command "mirror" "l" "" c1 c2 "")
  ;(command "color" 20)
  ;(command "_dimradius" p1 p2 "" )
  (command "zoom" "all")
)