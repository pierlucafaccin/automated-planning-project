
(define (problem robot-pb) (:domain robot-fluents)
(:objects

    alice bob charles mallory - person
    verona padova vicenza - location
    box1 box2 box3 box4 box5 box6 - box
    medicine1 medicine2 - medicine
    food1 food2 food3 - food
    tool1 tool2 tool3 - tool
    elicopter - carrier
)

(:init

    
    (at-person alice verona)
    (at-person bob padova)
    (at-person charles verona)
    (at-person mallory vicenza)

    (at-box box1 depot)
    (at-box box2 depot)
    (at-box box3 depot)
    (at-box box4 depot)
    (at-box box5 depot)
    (at-box box6 depot)

    (at-robot agent depot)
    (at-carrier elicopter depot)

    (at-item medicine1 depot) (at-item medicine2 depot)
    (at-item food1 depot) (at-item food2 depot) (at-item food3 depot)
    (at-item tool1 depot) (at-item tool2 depot) (at-item tool3 depot)

    (empty box1) (empty box2) (empty box3)
    (empty box4) (empty box5) (empty box6)

    (need-medicine alice)
    (need-medicine bob)
    (need-tool bob)
    (need-tool mallory)
    (need-food alice)

    (= (carrier-capacity elicopter) 4)
    (= (carrier-load elicopter) 0)
    (= (battery-amount agent) 10000)

)

(:goal (and
    ;todo: put the goal condition here
    (not (need-food alice))
    (not (need-medicine alice))
    (not (need-tool bob))
    (not (need-medicine bob))
    (not (need-tool mallory))
    
))

(:metric maximize (battery-amount))

)
