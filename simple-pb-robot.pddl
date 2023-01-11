(define (problem robot-pb-simple) (:domain robot-simple)
(:objects

    alice bob charles - person
    verona padova - location
    box1 box2 box3 - box
    medicine1 - medicine
    food1 - food
    tool1 - tool
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at-person alice verona) (at-person bob padova) (at-person charles verona)
    (at-box box1 depot) (at-box box2 depot) (at-box box3 depot)
    (at-robot agent depot)
    (at-item medicine1 depot) (at-item food1 depot) (at-item tool1 depot)

    (empty box1) (empty box2) (empty box3)

    (free agent)

    (need alice medicine1) (need bob food1) (need charles tool1)

)

(:goal (and
    ;todo: put the goal condition here
    (delivered medicine1 alice)
    (delivered food1 bob)
    (delivered tool1 charles)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)