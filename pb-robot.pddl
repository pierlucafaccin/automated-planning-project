(define (problem problemname) (:domain robot)
(:objects
    l - location
    b - box
    banana - food
)

(:init
    ;todo: put the initial state's facts and numeric values here

    (atrobot agent l)
    (atfood banana depot)
    (atbox b depot)
    (empty b)
    (not (full b))
    (not (loaded agent b))
    (not (infood banana b))
    (free agent)

    
)

(:goal (and
    ;todo: put the goal condition here

    (atbox b l)
    (infood banana b)
    (full b)

    
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
