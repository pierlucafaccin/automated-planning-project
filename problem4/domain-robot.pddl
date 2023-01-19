;Header and description

(define (domain robot)

;remove requirements that are not needed
(:requirements :strips :typing :negative-preconditions :equality :durative-actions)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    person
    robot
    location
    item
    food medicine tool - item
    box
    carrier
    cap_number
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


    (capacity ?c - carrier ?cap - cap_number)
    (capacity-predecessor ?cap1 ?cap2 - cap_number)

    ; otherwise two boxes can be filled with the same item at the same time
    (inbox ?i - item)


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
    )
    :effect (and (at end(full ?b ?i))
                 (at start(not (empty ?b)))
                 (at start(inbox ?i))
    
    )
)

(:durative-action load-carrier
    :parameters (?r - robot ?b - box ?l - location ?i - item ?c - carrier ?cap1 ?cap2 - cap_number)
    :duration (= ?duration 4)
    :condition (and (full ?b ?i)
                       (over all(not (empty ?b)))
                       (over all(inbox ?i))
                       (at start(not (loaded ?r ?b)))
                       (at start(free ?r))
                       (over all(at-robot ?r ?l))
                       (over all(at-box ?b ?l))
                       (over all(at-carrier ?c ?l))
                       (over all(capacity-predecessor ?cap1 ?cap2))
                       (at start(capacity ?c ?cap2))


    )
    :effect (and (at end(loaded ?r ?b)) ;seguendo la logica del prof commentare questo e togliere i due commenti sotto 
                 ;(at start((loaded ?r ?b)))
                 ;(at end(not(loaded ?r ?b)))
                 (at start(not(free ?r)))
                 (at end(free ?r))
                 (at start(capacity ?c ?cap1))
                 (at start(not (capacity ?c ?cap2)))
    )
)

; can be improved by adding the person who needs the item
(:durative-action move-with-box
    :parameters (?r - robot ?from ?to - location ?b - box ?i - item ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at-robot ?r ?from))
                       (at start(at-box ?b ?from))
                       (at start(at-item ?i ?from))
                       (at start(at-carrier ?c ?from))
                       (at start(not (at-robot ?r ?to)))
                       (at start(not (at-box ?b ?to)))
                       (at start(not (at-item ?i ?to)))
                       (at start(not (at-carrier ?c ?to)))
                       ;(not (= ?from ?to))
                       (over all(full ?b ?i))
                       (over all(inbox ?i))
                       (over all(not (empty ?b)))
                       (over all(loaded ?r ?b))
                       (over all(not (free ?r)))
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

; can be improved by adding the person who needs the item
; Control of full box is unecessary because if the robot has a box,
; it must be full
(:durative-action unloadrobot
    :parameters (?r - robot ?b - box ?l - location ?c - carrier ?cap1 ?cap2 - cap_number)
    :duration (= ?duration 2)
    :condition (and (at start(loaded ?r ?b))
                       (at start(not (free ?r)))
                       (over all(not (empty ?b)))
                       (over all(at-robot ?r ?l))
                       (over all(at-box ?b ?l))
                       ; redundant but for kept for clarity
                       (over all(at-carrier ?c ?l))
                       (over all(capacity-predecessor ?cap1 ?cap2))
                       (at start(capacity ?c ?cap1))
    )
    :effect (and (at end(not (loaded ?r ?b)))
                 (at start(free ?r))
                 (at end(not (free ?r)))
                 (at start(capacity ?c ?cap2))
                 (at start(not (capacity ?c ?cap1)))

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
                       (at start(free ?r))
                       (at start(need-food ?p))
                       (at start(inbox ?f))

    )
    :effect (and (at end(not (need-food ?p)))
                 (at start(not (free ?r)))
                 (at end (free ?r))
                 (at end(not (inbox ?f)))
                 (at end(not (full ?b ?f)))
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
                       (at start(free ?r))
                       (at start(need-medicine ?p))
                       (at start(inbox ?m))

    )
    :effect (and (at end(not (need-medicine ?p)))
                 (at start(not (free ?r)))
                 (at end (free ?r))
                 (at end(not (inbox ?m)))
                 (at end(not (full ?b ?m)))
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
                       (at start(free ?r))
                       (at start(need-tool ?p))
                       (at start(inbox ?t))

    )
    :effect (and (at end(not (need-tool ?p)))
                 (at start(not (free ?r)))
                 (at end (free ?r))
                 (at end(not (inbox ?t)))
                 (at end(not (full ?b ?t)))
    )
)

(:durative-action move
    :parameters (?r - robot ?from ?to - location ?c - carrier)
    :duration (= ?duration 10)
    :condition (and (at start(at-robot ?r ?from))
                       (at start(at-carrier ?c ?from))
                       (at start(not (at-robot ?r ?to)))
                       (at start(not (at-carrier ?c ?to)))
                       (over all(not (= ?from ?to)))
    )
    :effect (and (at start(not (at-robot ?r ?from)))
                 (at start(not (at-carrier ?c ?from)))
                 (at end(at-robot ?r ?to))
                 (at end(at-carrier ?c ?to))
    )
)

)

