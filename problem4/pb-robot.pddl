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
    (at_person alice verona) (at_person bob padova) (at_person charles verona)
    (at_box box1 depot) (at_box box2 depot) (at_box box3 depot)
    (at_robot agent depot)
    (at_item medicine1 depot) (at_item medicine2 depot) (at_item food1 depot) (at_item tool1 depot)
    (at_carrier elicopter depot)

    (empty box1) (empty box2) (empty box3)

    (free agent)

    (need_medicine alice) (need_food bob) (need_tool bob)

    (capacity_predecessor capacity0 capacity1) (capacity_predecessor capacity1 capacity2)
    (capacity_predecessor capacity2 capacity3)

    (capacity elicopter capacity3)

)

(:goal (and
    ;todo: put the goal condition here
    (not (need_medicine alice))
    (not (need_food bob))
    (not (need_tool bob))
    
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)