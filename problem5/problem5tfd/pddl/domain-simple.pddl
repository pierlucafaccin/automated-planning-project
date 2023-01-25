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

(:constants
    depot - location
    agent - robot
)
; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here

    (at-person ?p - person ?l - location)
    (at-box ?b - box ?l - location)
    (at-robot ?r - robot ?l - location)
    (at-item ?i - item ?l - location)
    (at-carrier ?c - carrier ?l - location)

    (empty ?b - box)
    (full ?b - box ?i - item)

    (loaded ?r - robot ?b - box)

    (need-food ?p - person)
    (need-medicine ?p - person)
    (need-tool ?p - person)


    (capacity ?c - carrier ?cap - cap_number)
    (capacity-predecessor ?cap1 ?cap2 - cap_number)

    ; otherwise two boxes can be filled with the same item at the same time
    (inbox ?i - item)
    (delivered ?b - box)

    (filling ?r - robot)
    (loading ?r - robot)

    (emptying ?r - robot)
    (unloading ?r - robot)

    (equalbox ?b1 ?b2 - box)


)


(:functions ;todo: define numeric functions here
)

;define actions here
(:durative-action fill-item
    :parameters (?b - box ?r - robot ?l - location ?i - item)
    :duration (= ?duration 5)
    :condition (and ;(= ?l depot)
                    (over all(at-box ?b ?l))
                    (over all(at-robot ?r ?l))
                    (over all(at-item ?i ?l))
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


(:durative-action load-carrier
    :parameters (?r - robot ?b - box ?l - location ?i - item ?c - carrier ?cap1 ?cap2 - cap_number)
    :duration (= ?duration 4)
    :condition (and  (over all (full ?b ?i))
                     (over all(not (empty ?b)))
                     (over all(inbox ?i))
                     (at start(not (loaded ?r ?b)))
                     (over all(at-robot ?r ?l))
                     (over all(at-box ?b ?l))
                     (over all(at-carrier ?c ?l))
                     (over all(capacity-predecessor ?cap1 ?cap2))
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

(:durative-action move-with-box
    :parameters (?r - robot ?from ?to - location ?b - box ?i - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at-robot ?r ?from))
                    (at start(at-box ?b ?from))
                    (at start(at-item ?i ?from))
                    (at start(at-carrier ?c ?from))
                    (over all(full ?b ?i))
                    (over all(inbox ?i))
                    (over all(not (empty ?b)))
                    (over all(loaded ?r ?b))
                    
    )
    :effect (and (at end(at-robot ?r ?to))
                 (at end(at-box ?b ?to))
                 (at end(at-item ?i ?to))
                 (at end(at-carrier ?c ?to))
                 (at start(not (at-robot ?r ?from)))
                 (at start(not (at-box ?b ?from)))
                 (at start(not (at-item ?i ?from)))
                 (at start(not (at-carrier ?c ?from)))
    )
)


(:durative-action move-with-box2
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 - box ?i1 ?i2 - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at-robot ?r ?from))
                    (at start(at-box ?b1 ?from))
                    (at start(at-box ?b2 ?from))
                    (at start(at-item ?i1 ?from))
                    (at start(at-item ?i2 ?from))
                    (at start(at-carrier ?c ?from))
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
    :effect (and (at end(at-robot ?r ?to))
                 (at end(at-box ?b1 ?to))
                 (at end(at-box ?b2 ?to))
                 (at end(at-item ?i1 ?to))
                 (at end(at-item ?i2 ?to))
                 (at end(at-carrier ?c ?to))
                 (at start(not (at-robot ?r ?from)))
                 (at start(not (at-box ?b1 ?from)))
                 (at start(not (at-box ?b2 ?from)))
                 (at start(not (at-item ?i1 ?from)))
                 (at start(not (at-item ?i2 ?from)))
                 (at start(not (at-carrier ?c ?from)))
    )
)

(:durative-action unloadrobot
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?cap1 ?cap2 - cap_number)
    :duration (= ?duration 2)
    :condition (and (at start(loaded ?r ?b))
                    (at start(not (empty ?b)))
                    (over all(at-robot ?r ?l))
                    (over all(at-box ?b ?l))
                    (over all(at-carrier ?c ?l))
                    (over all(capacity-predecessor ?cap1 ?cap2))
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

(:durative-action empty-box-food
    :parameters (?r - robot ?b - box ?l - location ?f - food ?p - person)
    :duration (= ?duration 3)
    :condition (and (over all(at-robot ?r ?l))
                    (over all(at-box ?b ?l))
                    (over all(at-person ?p ?l))
                    (over all(at-item ?f ?l))
                    (at start(full ?b ?f))
                    (over all(not (loaded ?r ?b)))
                    (at start(need-food ?p))
                    (at start(inbox ?f))
                    (at start(not (emptying ?r)))
                    (over all(not (unloading ?r)))

    )
    :effect (and (at start(not (need-food ?p)))
                 (at start(not (inbox ?f)))
                 (at start(not (full ?b ?f)))
                 (at start(emptying ?r))
                 (at end(not (need-food ?p)))
                 (at end(not (inbox ?f)))
                 (at end(not (full ?b ?f)))
                 (at end (not(emptying ?r)))
    )
)

(:durative-action empty-box-medicine
    :parameters (?r - robot ?b - box ?l - location ?m - medicine ?p - person)
    :duration (= ?duration 3)
    :condition (and (over all(at-robot ?r ?l))
                    (over all(at-box ?b ?l))
                    (over all(at-person ?p ?l))
                    (over all(at-item ?m ?l))
                    (at start(full ?b ?m))
                    (over all(not (loaded ?r ?b)))
                    (at start(need-medicine ?p))
                    (at start(inbox ?m))
                    (at start(not (emptying ?r)))
                    (over all(not (unloading ?r)))

    )
    :effect (and (at start(not (need-medicine ?p)))
                 (at start(not (inbox ?m)))
                 (at start(not (full ?b ?m)))
                 (at start(emptying ?r))
                 (at end(not (need-medicine ?p)))
                 (at end(not (inbox ?m)))
                 (at end(not (full ?b ?m)))
                 (at end (not(emptying ?r)))
    )
)

(:durative-action empty-box-tool
    :parameters (?r - robot ?b - box ?l - location ?t - tool ?p - person)
    :duration (= ?duration 3)
    :condition (and (over all(at-robot ?r ?l))
                    (over all(at-box ?b ?l))
                    (over all(at-person ?p ?l))
                    (over all(at-item ?t ?l))
                    (at start(full ?b ?t))
                    (over all(not (loaded ?r ?b)))
                    (at start(need-tool ?p))
                    (at start(inbox ?t))
                    (at start(not (emptying ?r)))
                    (over all(not (unloading ?r)))

    )
    :effect (and (at start(not (need-tool ?p)))
                 (at start(not (inbox ?t)))
                 (at start(not (full ?b ?t)))
                 (at start(emptying ?r))
                 (at end(not (need-tool ?p)))
                 (at end(not (inbox ?t)))
                 (at end(not (full ?b ?t)))
                 (at end (not(emptying ?r)))
    )
)

(:durative-action move
    :parameters (?r - robot ?from ?to - location ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at-robot ?r ?from))
                    (at start(at-carrier ?c ?from))
    )
    :effect (and (at start(not (at-robot ?r ?from)))
                 (at start(not (at-carrier ?c ?from)))
                 (at end(at-robot ?r ?to))
                 (at end(at-carrier ?c ?to))
    )
)

)