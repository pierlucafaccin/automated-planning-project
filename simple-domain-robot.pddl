;Header and description

(define (domain robot-simple)

;remove requirements that are not needed
(:requirements :strips :typing :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    person
    robot
    location
    item
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

    (need ?p - person ?i - item)
    (delivered ?i - item ?p - person)

    ; otherwise two boxes can be filled with the same item at the same time
    (inbox ?i - item)


)


(:functions ;todo: define numeric functions here
)

;define actions here

(:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (at-robot ?r ?from)
                       (not (= ?from ?to))
    )
    :effect (and (at-robot ?r ?to)
                 (not (at-robot ?r ?from))
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
                       (not (empty ?b))
                       (loaded ?r ?b)
    )
    :effect (and (at-robot ?r ?to)
                 (at-box ?b ?to)
                 (at-item ?i ?to)
                 (not (at-robot ?r ?from))
                 (not (at-box ?b ?from))
    )
)


(:action load-robot
    :parameters (?r - robot ?b - box ?l - location ?i - item)
    :precondition (and (full ?b ?i)
                       (not (empty ?b))
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

(:action empty-box
    :parameters (?r - robot ?b - box ?l - location ?i - item ?p - person)
    :precondition (and (at-robot ?r ?l)
                       (at-box ?b ?l)
                       (at-person ?p ?l)
                       (full ?b ?i)
                       (not (loaded ?r ?b))
                       (free ?r)
                       (need ?p ?i)
                       (inbox ?i)

    )
    :effect (and (delivered ?i ?p)
                 (not (need ?p ?i))
                 (not (inbox ?i))
                 (not (full ?b ?i))
    )
)

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

)