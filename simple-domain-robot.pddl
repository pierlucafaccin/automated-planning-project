;Header and description

(define (domain robot-simple)

;remove requirements that are not needed
(:requirements :strips :typing :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    person
    robot
    location
    item
    food medicine tool - item
    box
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

    (empty ?b - box)
    (full ?b - box ?i - item)

    (loaded ?r - robot ?b - box)
    (free ?r - robot)

    (need-food ?p - person)
    (need-medicine ?p - person)
    (need-tool ?p - person)

    ;(delivered ?i - item ?p - person)

    ; otherwise two boxes can be filled with the same item at the same time
    (inbox ?i - item)


)


(:functions ;todo: define numeric functions here
)

;define actions here

(:action fill-item
    :parameters (?b - box ?r - robot ?l - location ?i - item)
    :precondition (and ;(= ?l depot)
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

(:action load-robot
    :parameters (?r - robot ?b - box ?l - location ?i - item)
    :precondition (and (full ?b ?i)
                       (not (empty ?b))
                       (inbox ?i)
                       (not (loaded ?r ?b))
                       (free ?r)
                       (at-robot ?r ?l)
                       (at-box ?b ?l)

    )
    :effect (and (loaded ?r ?b)
                 (not (free ?r))
                       
    )
)

; can be improved by adding the person who needs the item
(:action move-with-box
    :parameters (?r - robot ?from ?to - location ?b - box ?i - item)
    :precondition (and (at-robot ?r ?from)
                       (at-box ?b ?from)
                       (at-item ?i ?from)
                       (not (at-robot ?r ?to))
                       (not (at-box ?b ?to))
                       (not (at-item ?i ?to))
                       ;(not (= ?from ?to))
                       (full ?b ?i)
                       (inbox ?i)
                       (not (empty ?b))
                       (loaded ?r ?b)
                       (not (free ?r))
    )
    :effect (and (at-robot ?r ?to)
                 (at-box ?b ?to)
                 (at-item ?i ?to)
                 (not (at-robot ?r ?from))
                 (not (at-box ?b ?from))
                 (not (at-item ?i ?from))
    )
)

; can be improved by adding the person who needs the item
; Control of full box is unecessary because if the robot has a box,
; it must be full
(:action unloadrobot
    :parameters (?r - robot ?b - box ?l - location)
    :precondition (and (loaded ?r ?b)
                       (not (free ?r))
                       (not (empty ?b))
                       (at-robot ?r ?l)
                       (at-box ?b ?l)
    )
    :effect (and (not (loaded ?r ?b))
                 (free ?r)
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
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (at-robot ?r ?from)
                       (not (= ?from ?to))
    )
    :effect (and (at-robot ?r ?to)
                 (not (at-robot ?r ?from))
    )
)


)