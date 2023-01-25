(define (problem robot-pb) (:domain robot-simple)
(:objects

    alice bob charles - person
    verona padova - location
    box1 box2 - box ; box3 - box
    medicine1 medicine2 - medicine
    ;food1 - food
    tool1 - tool
    elicopter - carrier
    capacity0 capacity1 capacity2 capacity3 capacity4 - cap_number
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at-person alice verona) (at-person bob padova);(at-person charles verona)
    (at-box box1 depot) (at-box box2 depot) ;(at-box box3 depot)
    (at-robot agent depot)
    (at-item medicine1 depot) (at-item medicine2 depot) ;(at-item food1 depot)
    (at-item tool1 depot)
    (at-carrier elicopter depot)

    (empty box1) (empty box2) ;(empty box3)
    (equalbox box1 box1)
    (equalbox box2 box2)

    ;(free agent)

    (need-medicine alice) (need-tool bob) ;(need-food bob)

    (capacity-predecessor capacity0 capacity1) (capacity-predecessor capacity1 capacity2)
    (capacity-predecessor capacity2 capacity3) (capacity-predecessor capacity3 capacity4)

    (capacity elicopter capacity4)

)

(:goal (and
    ;todo: put the goal condition here
    (not (need-medicine alice))
    ;(not (need-food bob))
    (not (need-tool bob))
))

;un-comment the following line if metric is needed
(:metric minimize (total-time))
)