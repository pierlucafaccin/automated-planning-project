(define (domain robot-simple)

;remove requirements that are not needed
(:requirements :strips :typing :negative-preconditions :equality :durative-actions)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    person - object
    robot - object
    location - object
    item - object
    food medicine tool - item
    box - object
    carrier - object
    cap_number - object
)

(:predicates ;todo: define predicates here

    (at_person ?p - person ?l - location)
    (at_box ?b - box ?l - location)
    (at_robot ?r - robot ?l - location)
    (at_item ?i - item ?l - location)
    (at_carrier ?c - carrier ?l - location)

    (empty ?b - box)
    (full ?b - box ?i - item)

    (loaded ?r - robot ?b - box)

    (need_food ?p - person)
    (need_medicine ?p - person)
    (need_tool ?p - person)


    (capacity ?c - carrier ?cap - cap_number)
    (capacity_predecessor ?cap1 ?cap2 - cap_number)

    ; otherwise two boxes can be filled with the same item at the same time
    (inbox ?i - item)
    (delivered ?b - box)

    (filling ?r - robot)
    (loading ?r - robot)

    (emptying ?r - robot)
    (unloading ?r - robot)

    (equalbox ?b1 ?b2 - box)


)

;define actions here
(:durative-action fill_item
    :parameters (?b - box ?r - robot ?l - location ?i - item)
    :duration (= ?duration 5)
    :condition (and ;(= ?l depot)
                    (over all(at_box ?b ?l))
                    (over all(at_robot ?r ?l))
                    (over all(at_item ?i ?l))
                    (at start(empty ?b))
                    (at start(not (full ?b ?i)))
                    (at start(not (inbox ?i)))
                    (at start(not (filling ?r)))
                    (at start(not (loading ?r)))
    )
    :effect (and (at start(full ?b ?i))
                 (at start(not (empty ?b)))
                 (at start(inbox ?i))
                 (at start(filling ?r))
                 ; This is because it fills two boxes at the same time with the same item
                 ; or it puts two items in the same box.
                 (at end (not (filling ?r)))
                 (at end(full ?b ?i))
                 (at end(not (empty ?b)))
                 (at end(inbox ?i))
    
    )
)

(:durative-action load_carrier
    :parameters (?r - robot ?b - box ?l - location ?i - item ?c - carrier ?cap1 ?cap2 - cap_number)
    :duration (= ?duration 4)
    :condition (and  (over all (full ?b ?i))
                     (over all(not (empty ?b)))
                     (over all(inbox ?i))
                     (at start(not (loaded ?r ?b)))
                     (over all(at_robot ?r ?l))
                     (over all(at_box ?b ?l))
                     (over all(at_carrier ?c ?l))
                     (over all(capacity_predecessor ?cap1 ?cap2))
                     (at start(capacity ?c ?cap2))
                     (at start(not (filling ?r)))

    )
    :effect (and (at start(loaded ?r ?b))
                 (at end(loaded ?r ?b))
                 (at start(capacity ?c ?cap1))
                 (at start(not (capacity ?c ?cap2)))
                 ; can load more than two boxes at the same time
                 (at start(loading ?r))
                 (at end(not (loading ?r)))
    )
)

(:durative-action move
    :parameters (?r - robot ?from ?to - location ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at_robot ?r ?from))
                    (at start(at_carrier ?c ?from))
    )
    :effect (and (at start(not (at_robot ?r ?from)))
                 (at start(not (at_carrier ?c ?from)))
                 (at end(at_robot ?r ?to))
                 (at end(at_carrier ?c ?to))
    )
)

(:durative-action move_with_box
    :parameters (?r - robot ?from ?to - location ?b - box ?i - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at_robot ?r ?from))
                    (at start(at_box ?b ?from))
                    (at start(at_item ?i ?from))
                    (at start(at_carrier ?c ?from))
                    (over all(full ?b ?i))
                    (over all(inbox ?i))
                    (over all(not (empty ?b)))
                    (over all(loaded ?r ?b))
                    
    )
    :effect (and (at end(at_robot ?r ?to))
                 (at end(at_box ?b ?to))
                 (at end(at_item ?i ?to))
                 (at end(at_carrier ?c ?to))
                 (at start(not (at_robot ?r ?from)))
                 (at start(not (at_box ?b ?from)))
                 (at start(not (at_item ?i ?from)))
                 (at start(not (at_carrier ?c ?from)))
    )
)

(:durative-action move_with_box2
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 - box ?i1 ?i2 - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at_robot ?r ?from))
                    (at start(at_box ?b1 ?from))
                    (at start(at_box ?b2 ?from))
                    (at start(at_item ?i1 ?from))
                    (at start(at_item ?i2 ?from))
                    (at start(at_carrier ?c ?from))
                    (over all(full ?b1 ?i1))
                    (over all(full ?b2 ?i2))
                    (over all(inbox ?i1))
                    (over all(inbox ?i2))
                    (over all(not (empty ?b1)))
                    (over all(not (empty ?b2)))
                    (over all(loaded ?r ?b1))
                    (over all(loaded ?r ?b2))
                    (over all(not (equalbox ?b1 ?b2)))
                    ;(not (= ?from ?to))
                    
    )
    :effect (and (at end(at_robot ?r ?to))
                 (at end(at_box ?b1 ?to))
                 (at end(at_box ?b2 ?to))
                 (at end(at_item ?i1 ?to))
                 (at end(at_item ?i2 ?to))
                 (at end(at_carrier ?c ?to))
                 (at start(not (at_robot ?r ?from)))
                 (at start(not (at_box ?b1 ?from)))
                 (at start(not (at_box ?b2 ?from)))
                 (at start(not (at_item ?i1 ?from)))
                 (at start(not (at_item ?i2 ?from)))
                 (at start(not (at_carrier ?c ?from)))
    )
)

(:durative-action move_with_box3
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 ?b3 - box ?i1 ?i2 ?i3 - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at_robot ?r ?from))
                    (at start(at_box ?b1 ?from))
                    (at start(at_box ?b2 ?from))
                    (at start(at_box ?b3 ?from))
                    (at start(at_item ?i1 ?from))
                    (at start(at_item ?i2 ?from))
                    (at start(at_item ?i3 ?from))
                    (at start(at_carrier ?c ?from))
                    (over all(full ?b1 ?i1))
                    (over all(full ?b2 ?i2))
                    (over all(full ?b3 ?i3))
                    (over all(inbox ?i1))
                    (over all(inbox ?i2))
                    (over all(inbox ?i3))
                    (over all(not (empty ?b1)))
                    (over all(not (empty ?b2)))
                    (over all(not (empty ?b3)))
                    (over all(loaded ?r ?b1))
                    (over all(loaded ?r ?b2))
                    (over all(loaded ?r ?b3))
                    (over all(not (equalbox ?b1 ?b2)))
                    (over all(not (equalbox ?b1 ?b2)))
                    (over all(not (equalbox ?b2 ?b3)))
                    ;(not (= ?from ?to))
                    
    )
    :effect (and (at end(at_robot ?r ?to))
                 (at end(at_box ?b1 ?to))
                 (at end(at_box ?b2 ?to))
                 (at end(at_box ?b3 ?to))
                 (at end(at_item ?i1 ?to))
                 (at end(at_item ?i2 ?to))
                 (at end(at_item ?i3 ?to))
                 (at end(at_carrier ?c ?to))
                 (at start(not (at_robot ?r ?from)))
                 (at start(not (at_box ?b1 ?from)))
                 (at start(not (at_box ?b2 ?from)))
                 (at start(not (at_box ?b3 ?from)))
                 (at start(not (at_item ?i1 ?from)))
                 (at start(not (at_item ?i2 ?from)))
                 (at start(not (at_item ?i3 ?from)))
                 (at start(not (at_carrier ?c ?from)))
    )
)

(:durative-action move_with_box4
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 ?b3 ?b4 - box ?i1 ?i2 ?i3 ?i4 - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at_robot ?r ?from))
                    (at start(at_box ?b1 ?from))
                    (at start(at_box ?b2 ?from))
                    (at start(at_box ?b3 ?from))
                    (at start(at_box ?b4 ?from))
                    (at start(at_item ?i1 ?from))
                    (at start(at_item ?i2 ?from))
                    (at start(at_item ?i3 ?from))
                    (at start(at_item ?i4 ?from))
                    (at start(at_carrier ?c ?from))
                    (over all(full ?b1 ?i1))
                    (over all(full ?b2 ?i2))
                    (over all(full ?b3 ?i3))
                    (over all(full ?b4 ?i4))
                    (over all(inbox ?i1))
                    (over all(inbox ?i2))
                    (over all(inbox ?i3))
                    (over all(inbox ?i4))
                    (over all(not (empty ?b1)))
                    (over all(not (empty ?b2)))
                    (over all(not (empty ?b3)))
                    (over all(not (empty ?b4)))
                    (over all(loaded ?r ?b1))
                    (over all(loaded ?r ?b2))
                    (over all(loaded ?r ?b3))
                    (over all(loaded ?r ?b4))
                    (over all(not (equalbox ?b1 ?b2)))
                    (over all(not (equalbox ?b2 ?b3)))
                    (over all(not (equalbox ?b2 ?b4)))
                    (over all(not (equalbox ?b1 ?b3)))
                    (over all(not (equalbox ?b1 ?b4)))
                    (over all(not (equalbox ?b3 ?b4)))
                    ;(not (= ?from ?to))
                    
    )
    :effect (and (at end(at_robot ?r ?to))
                 (at end(at_box ?b1 ?to))
                 (at end(at_box ?b2 ?to))
                 (at end(at_box ?b3 ?to))
                 (at end(at_box ?b4 ?to))
                 (at end(at_item ?i1 ?to))
                 (at end(at_item ?i2 ?to))
                 (at end(at_item ?i3 ?to))
                 (at end(at_item ?i4 ?to))
                 (at end(at_carrier ?c ?to))
                 (at start(not (at_robot ?r ?from)))
                 (at start(not (at_box ?b1 ?from)))
                 (at start(not (at_box ?b2 ?from)))
                 (at start(not (at_box ?b3 ?from)))
                 (at start(not (at_box ?b4 ?from)))
                 (at start(not (at_item ?i1 ?from)))
                 (at start(not (at_item ?i2 ?from)))
                 (at start(not (at_item ?i3 ?from)))
                 (at start(not (at_item ?i4 ?from)))
                 (at start(not (at_carrier ?c ?from)))
    )
)

(:durative-action unloadrobot
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?cap1 ?cap2 - cap_number)
    :duration (= ?duration 2)
    :condition (and (at start(loaded ?r ?b))
                    (at start(not (empty ?b)))
                    (over all(at_robot ?r ?l))
                    (over all(at_box ?b ?l))
                    (over all(at_carrier ?c ?l))
                    (over all(capacity_predecessor ?cap1 ?cap2))
                    (at start(capacity ?c ?cap1))
                    (at start(not (delivered ?b)))
                    (over all(not (emptying ?r)))
    )
    :effect (and (at end(not (loaded ?r ?b)))
                 (at end(delivered ?b))
                 (at start(capacity ?c ?cap2))
                 (at start(not (capacity ?c ?cap1)))
                 (at start(unloading ?r))
                 (at end(not (unloading ?r)))

    )
)

(:durative-action empty_box_food
    :parameters (?r - robot ?b - box ?l - location ?f - food ?p - person)
    :duration (= ?duration 3)
    :condition (and (over all(at_robot ?r ?l))
                    (over all(at_box ?b ?l))
                    (over all(at_person ?p ?l))
                    (over all(at_item ?f ?l))
                    (at start(full ?b ?f))
                    (over all(not (loaded ?r ?b)))
                    (at start(need_food ?p))
                    (at start(inbox ?f))
                    (at start(not (emptying ?r)))
                    (over all(not (unloading ?r)))

    )
    :effect (and (at start(not (need_food ?p)))
                 (at start(not (inbox ?f)))
                 (at start(not (full ?b ?f)))
                 (at start(emptying ?r))
                 (at end(not (need_food ?p)))
                 (at end(not (inbox ?f)))
                 (at end(not (full ?b ?f)))
                 (at end (not(emptying ?r)))
    )
)

(:durative-action empty_box_medicine
    :parameters (?r - robot ?b - box ?l - location ?m - medicine ?p - person)
    :duration (= ?duration 3)
    :condition (and (over all(at_robot ?r ?l))
                    (over all(at_box ?b ?l))
                    (over all(at_person ?p ?l))
                    (over all(at_item ?m ?l))
                    (at start(full ?b ?m))
                    (over all(not (loaded ?r ?b)))
                    (at start(need_medicine ?p))
                    (at start(inbox ?m))
                    (at start(not (emptying ?r)))
                    (over all(not (unloading ?r)))

    )
    :effect (and (at start(not (need_medicine ?p)))
                 (at start(not (inbox ?m)))
                 (at start(not (full ?b ?m)))
                 (at start(emptying ?r))
                 (at end(not (need_medicine ?p)))
                 (at end(not (inbox ?m)))
                 (at end(not (full ?b ?m)))
                 (at end (not(emptying ?r)))
    )
)

(:durative-action empty_box_tool
    :parameters (?r - robot ?b - box ?l - location ?t - tool ?p - person)
    :duration (= ?duration 3)
    :condition (and (over all(at_robot ?r ?l))
                    (over all(at_box ?b ?l))
                    (over all(at_person ?p ?l))
                    (over all(at_item ?t ?l))
                    (at start(full ?b ?t))
                    (over all(not (loaded ?r ?b)))
                    (at start(need_tool ?p))
                    (at start(inbox ?t))
                    (at start(not (emptying ?r)))
                    (over all(not (unloading ?r)))

    )
    :effect (and (at start(not (need_tool ?p)))
                 (at start(not (inbox ?t)))
                 (at start(not (full ?b ?t)))
                 (at start(emptying ?r))
                 (at end(not (need_tool ?p)))
                 (at end(not (inbox ?t)))
                 (at end(not (full ?b ?t)))
                 (at end (not(emptying ?r)))
    )
)

)