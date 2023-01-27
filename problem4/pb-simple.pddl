(define (problem robot-pb) (:domain robot-simple)
(:objects

    alice bob - person
    verona padova - location
    box1 box2 - box
    medicine1 medicine2 - medicine
    tool1 - tool
    elicopter - carrier
    capacity0 capacity1 capacity2 capacity3 capacity4 - cap_number
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at_person alice verona) (at_person bob padova)
    (at_box box1 depot) (at_box box2 depot)
    (at_robot agent depot)
    (at_item medicine1 depot) (at_item medicine2 depot)
    (at_item tool1 depot)
    (at_carrier elicopter depot)

    (empty box1) (empty box2)
    (equalbox box1 box1)
    (equalbox box2 box2)

    (need_medicine alice) (need_tool bob)

    (capacity_predecessor capacity0 capacity1) (capacity_predecessor capacity1 capacity2)
    (capacity_predecessor capacity2 capacity3) (capacity_predecessor capacity3 capacity4)

    (capacity elicopter capacity4)

)

(:goal (and
    ;todo: put the goal condition here
    (not (need_medicine alice))
    (not (need_tool bob))
))
)