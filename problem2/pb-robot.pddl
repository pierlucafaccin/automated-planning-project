(define (problem robot-pb) (:domain robot)
(:objects

    alice bob charles - person
    verona padova - location
    box1 box2 box3 - box
    medicine1 medicine2 - medicine
    food1 - food
    tool1 - tool
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at-person alice verona) (at-person bob padova) (at-person charles verona)
    (at-box box1 depot) (at-box box2 depot) (at-box box3 depot)
    (at-robot agent depot)
    (at-item medicine1 depot) (at-item medicine2 depot) (at-item food1 depot) (at-item tool1 depot)

    (empty box1) (empty box2) (empty box3)

    (free agent)

    (need-medicine alice) (need-medicine bob) (need-tool bob)

)

(:goal (and
    ;todo: put the goal condition here
    (not (need-medicine alice))
    (not (need-medicine bob))
    (not (need-tool bob))
    
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)