(define (problem robot-pb-simple) (:domain robot-simple)
(:objects

    alice bob charles - person
    verona padova - location
    box1 box2 box3 - box
    medicine food tool - item
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at-person alice padova) (at-person bob padova) (at-person charles verona)
    (at-box box1 depot) (at-box box2 depot) (at-box box3 depot)
    (at-robot agent depot)
    (at-item medicine depot) (at-item food depot) (at-item deepot)

    (empty box1) (empty box2) (empty box3)

    (free agent)

    (need alice medicine) (need bob food) (need charles tool)

)

(:goal (and
    ;todo: put the goal condition here
    (delivered medicine alice)
    (delivered food bob)
    (delivered tool charles)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
