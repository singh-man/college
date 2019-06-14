(defun c:ex1()
  (setq pt1 (getpoint "Pick first corner of table: "))	      ;table top          
  (setq pt3 (getcorner pt1 "Pick opposite corner of table: "));table top		
  (setq pt2 (list (car pt3) (cadr pt1)))		      ;table top
  (setq pt4 (list (car pt1) (cadr pt3)))		      ;table top
  (command "color" 100)
  (command "line" pt1 pt2 pt3 pt4 "c" )			      ;making table top
  (setq th(getint "Enter the thickness of table"))
  (command "pedit" "l" "" "j" "all" "" "")		      ;pedit table top
  (command "extrude" "l" "" th "" "")			      ;thickness to table
  (setq t2(/ (- (car pt2) (car pt1)) 2))		      ;t2 t3 are used for image
  (setq t3(/ (- (cadr pt3) (cadr pt2)) 2))
  (setq p1(list (+ (car pt1) t2) (cadr pt1)))		      ;p1 p3 for mirror line
  (setq p3(list (car p1) (cadr pt4)))
  (setq p2(list (car pt2) (+ (cadr pt2) t3)))		      ;p2 p4 for mirror line
  (setq p4(list (car pt1) (cadr p2)))
  (setq t1(* 0.1 (- (car pt2) (car pt1))))		      ;thickness of table's leg
  (setq l1(getint "Enter the length of table's leg"))
  (setq l1(- 0 l1))					      ;negative leg length
  (setq pt12(polar pt1 0 t1))				      ;setting pt12 pt13
  (setq pt13(polar pt12 (/ pi 2) t1))			      ;pt14 for making leg	
  (setq pt14(polar pt1 (/ pi 2) t1))			      ;of table
  (command "-osnap" "off")
  (command "color" 2)
  (command "pline" pt1 pt14 pt13 pt12 "c")		      ;pline for table leg
  (command "extrude" "l" "" l1 "" "")			      ;extruding table leg
  (command "mirror" "l" "" p3 p1 "" "")			      ;making three mirror
  (command "mirror" "l" "" p4 p2 "" "")			      ;image of the table's	
  (command "mirror" "l" "" p1 p3 "" "")			      ;leg
  (command "zoom" "all" "")				      ;zoom
  (command "union" "w" pt1 pt3 "")			      ;union of table & leg
  (command "color" 10)
  ;(command "_dimlinear" pt1 pt2 "" (getpoint))
  ;(command "_dimlinear" pt2 pt3 "" (getpoint))
  (command "_shademode" "g")				      ;gouraud shade
  (command "_3dorbit")					      ;3-d orbit
  )