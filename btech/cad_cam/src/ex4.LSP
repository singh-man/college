(defun c:ex4()
  (setq r(getint "enter the radius of the circle"))
  (setq c0(getpoint "get centre point of circle"))
  (setq si(getint "enter the number of sides of polygon"))
  (setq c1(list (+ (car c0) r) (cadr c0)))		;radial distance
  (command "circle" c0 c1 )				;circle
  (command "polygon" si c0 "" r "")			;using polygon for triangle
  (setq p11(- (car c0) (* r (sin (/ pi 3)))))		;calculating three
  (setq p12(- (cadr c0) (* r (cos (/ pi 3)))))		;points p1 p2 p3 of the
  (setq p1(list p11 p12))				;equilateral triangle
  (setq p2(list (+ (car c0) (* r (sin (/ pi 3)))) (cadr p1)))
  (setq p3(list (car c0) (+ (cadr c0) r)))
  ;(command "line" c0 p1 p2 p3 c0 "c")
  ;(command "line" p1 p3 "c")
  (command "line" p1 c0 p2 "")
  (command "line" c0 p3 "")
  (command "zoom" "all")
  )
  