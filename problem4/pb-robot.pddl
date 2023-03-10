(define (problem robot-pb) (:domain robot)
(:objects

    alice bob charles - person
    verona padova - location
    box1 box2 box3 - box
    medicine1 medicine2 - medicine
    food1 - food
    tool1 - tool
    elicopter - carrier
    capacity0 capacity1 capacity2 capacity3 - cap_number
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at-person alice verona) (at-person bob padova) (at-person charles verona)
    (at-box box1 depot) (at-box box2 depot) (at-box box3 depot)
    (at-robot agent depot)
    (at-item medicine1 depot) (at-item medicine2 depot) (at-item food1 depot) (at-item tool1 depot)
    (at-carrier elicopter depot)

    (empty box1) (empty box2) (empty box3)

    (free agent)

    (need-medicine alice) (need-food bob) (need-tool bob)

    (capacity-predecessor capacity0 capacity1) (capacity-predecessor capacity1 capacity2)
    (capacity-predecessor capacity2 capacity3)

    (capacity elicopter capacity3)

)

(:goal (and
    ;todo: put the goal condition here
    (not (need-medicine alice))
    (not (need-food bob))
    (not (need-tool bob))
    
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)