(define (problem problemname) (:domain robot)
(:objects
    l - location
    b1 - box
    b2 - box
    b3 - box
    banana - food
    med - medicine
    screw - tool
)

(:init
    ;todo: put the initial state's facts and numeric values here

    (atrobot agent l)
    (free agent)

    (atfood banana depot)
    (atbox b1 depot)
    (empty b1)
    (not (full b1))
    (not (loaded agent b1))
    (not (infood banana b1))

    (atmedicine med depot)
    (atbox b2 depot)
    (empty b2)
    (not (full b2))
    (not (loaded agent b2))
    (not (inmedicine med b2))

    (attool screw depot)
    (atbox b3 depot)
    (empty b3)
    (not (full b3))
    (not (loaded agent b3))
    (not (intool screw b3))

    
)

(:goal (and
    ;todo: put the goal condition here

    (atbox b1 l)
    (infood banana b1)
    (full b1)

    (atbox b2 l)
    (inmedicine med b2)
    (full b2)

    (atbox b3 l)
    (intool screw b3)
    (full b3)

    
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
