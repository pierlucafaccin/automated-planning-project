;Header and description

(define (domain robot-fluents)

;remove requirements that are not needed
(:requirements :strips :typing :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    person
    robot
    location
    food medicine tool - item
    box
    carrier
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
    (free ?r - robot)

    (need-food ?p - person)
    (need-medicine ?p - person)
    (need-tool ?p - person)

    ; otherwise two boxes can be filled with the same item at the same time
    (inbox ?i - item)


)


(:functions ;todo: define numeric functions here
    ; How many boxes are in the carrier right now
    (carrier-load ?c - carrier)
    ; Total number of boxes supported by the carrier
    (carrier-capacity ?c - carrier)
    (battery-amount ?r - robot)
)

;define actions here

(:action fill-item
    :parameters (?b - box ?r - robot ?l - location ?i - item)
    :precondition (and (= ?l depot)
                       (at-box ?b ?l)
                       (at-robot ?r ?l)
                       (at-item ?i ?l)
                       (empty ?b)
                       (not (full ?b ?i))
                       (not (inbox ?i))
    )
    :effect (and (full ?b ?i)
                 (not (empty ?b))
                 (inbox ?i)
    
    )
)

(:action load-carrier
    :parameters (?r - robot ?b - box ?l - location ?i - item ?c - carrier)
    :precondition (and (full ?b ?i)
                       (not (empty ?b))
                       (inbox ?i)
                       (not (loaded ?r ?b))
                       (free ?r)
                       (at-robot ?r ?l)
                       (at-box ?b ?l)
                       (at-carrier ?c ?l)
                       (not (= (carrier-load ?c) (carrier-capacity ?c)))

    )
    :effect (and (loaded ?r ?b)
                 (not (free ?r))
                 (increase (carrier-load ?c) 1)
                       
    )
)

; can be improved by adding the person who needs the item
(:action move-with-box
    :parameters (?r - robot ?from ?to - location ?b - box ?i - item ?c - carrier)
    :precondition (and (at-robot ?r ?from)
                       (at-box ?b ?from)
                       (at-item ?i ?from)
                       (at-carrier ?c ?from)
                       (not (at-robot ?r ?to))
                       (not (at-box ?b ?to))
                       (not (at-item ?i ?to))
                       (not (at-carrier ?c ?to))
                       (full ?b ?i)
                       (inbox ?i)
                       (not (empty ?b))
                       (loaded ?r ?b)
                       (not (free ?r))
                       ; If it goes to depot, carrier capacity should be 0
                       (or (not (= ?to depot)) (= (carrier-capacity ?c) 0))
    )
    :effect (and (at-robot ?r ?to)
                 (at-box ?b ?to)
                 (at-item ?i ?to)
                 (at-carrier ?c ?to)
                 (not (at-robot ?r ?from))
                 (not (at-box ?b ?from))
                 (not (at-item ?i ?from))
                 (not (at-carrier ?c ?from))
                 (decrease (battery-amount ?r) 1)
    )
)

(:action move-with-box2
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 - box ?i1 ?i2 - item ?c - carrier)
    :precondition (and (at-robot ?r ?from)
                       (at-box ?b1 ?from)
                       (at-box ?b2 ?from)
                       (at-item ?i1 ?from)
                       (at-item ?i2 ?from)
                       (at-carrier ?c ?from)
                       (not (= ?from ?to))
                       (full ?b1 ?i1)
                       (full ?b2 ?i2)
                       (inbox ?i1)
                       (inbox ?i2)
                       (not (empty ?b1))
                       (not (empty ?b2))
                       (loaded ?r ?b1)
                       (loaded ?r ?b2)
                       (not (= ?b1 ?b2))
                       ; If it goes to depot, carrier capacity should be 0
                       (or (not (= ?to depot)) (= (carrier-capacity ?c) 0))
    )
    :effect (and (at-robot ?r ?to)
                 (at-box ?b1 ?to)
                 (at-box ?b2 ?to)
                 (at-item ?i1 ?to)
                 (at-item ?i2 ?to)
                 (at-carrier ?c ?to)
                 (not (at-robot ?r ?from))
                 (not (at-box ?b1 ?from))
                 (not (at-box ?b2 ?from))
                 (not (at-item ?i1 ?from))
                 (not (at-item ?i2 ?from))
                 (not (at-carrier ?c ?from))
                 (decrease (battery-amount ?r) 1)
    )
)

(:action move-with-box3
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 ?b3 - box ?i1 ?i2 ?i3 - item ?c - carrier)
    :precondition (and (at-robot ?r ?from)
                       (at-box ?b1 ?from)
                       (at-box ?b2 ?from)
                       (at-box ?b3 ?from)
                       (at-item ?i1 ?from)
                       (at-item ?i2 ?from)
                       (at-item ?i3 ?from)
                       (at-carrier ?c ?from)
                       (not (= ?from ?to))
                       (full ?b1 ?i1)
                       (full ?b2 ?i2)
                       (full ?b3 ?i3)
                       (inbox ?i1)
                       (inbox ?i2)
                       (inbox ?i3)
                       (not (empty ?b1))
                       (not (empty ?b2))
                       (not (empty ?b3))
                       (loaded ?r ?b1)
                       (loaded ?r ?b2)
                       (loaded ?r ?b3)
                       (not (= ?b1 ?b2))
                       (not (= ?b3 ?b1))
                       (not (= ?b3 ?b2))
                       ; If it goes to depot, carrier capacity should be 0
                       (or (not (= ?to depot)) (= (carrier-capacity ?c) 0))
    )
    :effect (and (at-robot ?r ?to)
                 (at-box ?b1 ?to)
                 (at-box ?b2 ?to)
                 (at-box ?b3 ?to)
                 (at-item ?i1 ?to)
                 (at-item ?i2 ?to)
                 (at-item ?i3 ?to)
                 (at-carrier ?c ?to)
                 (not (at-robot ?r ?from))
                 (not (at-box ?b1 ?from))
                 (not (at-box ?b2 ?from))
                 (not (at-box ?b3 ?from))
                 (not (at-item ?i1 ?from))
                 (not (at-item ?i2 ?from))
                 (not (at-item ?i3 ?from))
                 (not (at-carrier ?c ?from))
                 (decrease (battery-amount ?r) 1)
    )
)

(:action move-with-box4
    :parameters (?r - robot ?from ?to - location ?b1 ?b2 ?b3 ?b4 - box ?i1 ?i2 ?i3 ?i4 - item ?c - carrier)
    :precondition (and (at-robot ?r ?from)
                       (at-box ?b1 ?from)
                       (at-box ?b2 ?from)
                       (at-box ?b3 ?from)
                       (at-box ?b4 ?from)
                       (at-item ?i1 ?from)
                       (at-item ?i2 ?from)
                       (at-item ?i3 ?from)
                       (at-item ?i4 ?from)
                       (at-carrier ?c ?from)
                       (not (= ?from ?to))
                       (full ?b1 ?i1)
                       (full ?b2 ?i2)
                       (full ?b3 ?i3)
                       (full ?b4 ?i4)
                       (inbox ?i1)
                       (inbox ?i2)
                       (inbox ?i3)
                       (inbox ?i4)
                       (not (empty ?b1))
                       (not (empty ?b2))
                       (not (empty ?b3))
                       (not (empty ?b4))
                       (loaded ?r ?b1)
                       (loaded ?r ?b2)
                       (loaded ?r ?b3)
                       (loaded ?r ?b4)
                       (not (= ?b1 ?b2))
                       (not (= ?b3 ?b1))
                       (not (= ?b3 ?b2))
                       (not (= ?b4 ?b1))
                       (not (= ?b4 ?b2))
                       (not (= ?b4 ?b3))
                       ; If it goes to depot, carrier capacity should be 0
                       (or (not (= ?to depot)) (= (carrier-capacity ?c) 0))
    )
    :effect (and (at-robot ?r ?to)
                 (at-box ?b1 ?to)
                 (at-box ?b2 ?to)
                 (at-box ?b3 ?to)
                 (at-box ?b4 ?to)
                 (at-item ?i1 ?to)
                 (at-item ?i2 ?to)
                 (at-item ?i3 ?to)
                 (at-item ?i4 ?to)
                 (at-carrier ?c ?to)
                 (not (at-robot ?r ?from))
                 (not (at-box ?b1 ?from))
                 (not (at-box ?b2 ?from))
                 (not (at-box ?b3 ?from))
                 (not (at-box ?b4 ?from))
                 (not (at-item ?i1 ?from))
                 (not (at-item ?i2 ?from))
                 (not (at-item ?i3 ?from))
                 (not (at-item ?i4 ?from))
                 (not (at-carrier ?c ?from))
                 (decrease (battery-amount ?r) 1)
    )
)


; Control of full box is unecessary because if the robot has a box,
; it must be full
(:action unloadrobot
    :parameters (?r - robot ?b - box ?l - location ?c - carrier)
    :precondition (and (loaded ?r ?b)
                       (not (free ?r))
                       (not (empty ?b))
                       (at-robot ?r ?l)
                       (at-box ?b ?l)
                       (at-carrier ?c ?l)
                       (not (= (carrier-capacity ?c) 0))
    )
    :effect (and (not (loaded ?r ?b))
                 (free ?r)
                 (decrease (carrier-capacity ?c) 1)

    )
)

(:action empty-box-food
    :parameters (?r - robot ?b - box ?l - location ?f - food ?p - person)
    :precondition (and (at-robot ?r ?l)
                       (at-box ?b ?l)
                       (at-person ?p ?l)
                       (at-item ?f ?l)
                       (full ?b ?f)
                       (not (loaded ?r ?b))
                       (free ?r)
                       (need-food ?p)
                       (inbox ?f)

    )
    :effect (and (not (need-food ?p))
                 (not (inbox ?f))
                 (not (full ?b ?f))
    )
)

(:action empty-box-medicine
    :parameters (?r - robot ?b - box ?l - location ?m - medicine ?p - person)
    :precondition (and (at-robot ?r ?l)
                       (at-box ?b ?l)
                       (at-person ?p ?l)
                       (at-item ?m ?l)
                       (full ?b ?m)
                       (not (loaded ?r ?b))
                       (free ?r)
                       (need-medicine ?p)
                       (inbox ?m)

    )
    :effect (and (not (need-medicine ?p))
                 (not (inbox ?m))
                 (not (full ?b ?m))
    )
)

(:action empty-box-tool
    :parameters (?r - robot ?b - box ?l - location ?t - tool ?p - person)
    :precondition (and (at-robot ?r ?l)
                       (at-box ?b ?l)
                       (at-person ?p ?l)
                       (at-item ?t ?l)
                       (full ?b ?t)
                       (not (loaded ?r ?b))
                       (free ?r)
                       (need-tool ?p)
                       (inbox ?t)

    )
    :effect (and (not (need-tool ?p))
                 (not (inbox ?t))
                 (not (full ?b ?t))
    )
)

(:action move
    :parameters (?r - robot ?from ?to - location ?c - carrier)
    :precondition (and (at-robot ?r ?from)
                       (at-carrier ?c ?from)
                       (not (at-robot ?r ?to))
                       (not (at-carrier ?c ?to))
                       (not (= ?from ?to))
    )
    :effect (and (not (at-robot ?r ?from))
                 (not (at-carrier ?c ?from))
                 (at-robot ?r ?to)
                 (at-carrier ?c ?to)
                 (decrease (battery-amount ?r) 5)
    )
)


)