;Header and description

(define (domain robot)

;remove requirements that are not needed
(:requirements :strips :typing :disjunctive-preconditions :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle

    person
    location
    box
    robot
    food medicine tools
)

(:constants
    depot - location
    agent - robot
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here

    (atperson ?p - person ?l - location)
    (atbox ?b - box ?l - location)
    (atrobot ?r - robot ?l - location)

    (atfood ?f - food ?l - location)
    (atmedicine ?m - medicine ?l - location)
    (attool ?t - tools ?l - location)

    (infood ?f - food ?b - box)
    (inmedicine ?m - medicine ?b - box)
    (intool ?f - food ?b - box)

    (empty ?b - box)
    (full ?b - box)

    (loaded ?r - robot ?b - box)
    (free ?r - robot)


    (needfood ?p - person ?f - food)
    (needmedicine ?p - person ?m - medicine)
    (needtools ?p - person ?t - tools)

    (deliveredfood ?f - food ?p - person)
    (deliveredmedicine ?m - medicine ?p - person)
    (deliveredtools ?t - tools ?p - person)


    ;(fullfilled ?p - person)
)


(:functions ;todo: define numeric functions here
)


;define actions here
(:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (atrobot ?r ?from)
                       (not (= ?from ?to))
    )
    :effect (and (atrobot ?r ?to)
                 (not (atrobot ?r ?from))
    )
)

(:action movewithbox
    :parameters (?r - robot ?from ?to - location ?b - box)
    :precondition (and (atrobot ?r ?from)
                       (atbox ?b ?from)
                       (not (atrobot ?r ?to))
                       (not (atbox ?b ?to))
                       ;(not (= ?from ?to))
                       (full ?b)
                       (not (empty ?b))
                       (loaded ?r ?b)
                       (not (free ?r))
    )
    :effect (and (atrobot ?r ?to)
                 (atbox ?b ?to)
                 (not (atrobot ?r ?from))
                 (not (atbox ?b ?from))
    )
)


(:action loadrobot
    :parameters (?r - robot ?b - box ?l - location)
    :precondition (and (full ?b)
                       (not (empty ?b))
                       (not (loaded ?r ?b))
                       (free ?r)
                       (atrobot ?r ?l)
                       (atbox ?b ?l)

    )
    :effect (and (loaded ?r ?b)
                 (not (free ?r))
                       
    )
)


(:action fillfood
    :parameters (?b - box ?r - robot ?l - location ?f - food)
    :precondition (and ;(= ?l depot)
                       (atbox ?b ?l)
                       (atrobot ?r ?l)
                       (atfood ?f ?l)
                       (empty ?b)
                       (not (full ?b))
                       (not (infood ?f ?b))
    )
    :effect (and (full ?b)
                 (not (empty ?b))
                 (infood ?f ?b)
    
    )
)

(:action fillmedicine
    :parameters (?b - box ?r - robot ?l - location ?m - medicine)
    :precondition (and ;(= ?l depot)
                       (atbox ?b ?l)
                       (atrobot ?r ?l)
                       (atmedicine ?m ?l)
                       (empty ?b)
                       (not (full ?b))
                       (not (inmedicine ?m ?b))
    )
    :effect (and (full ?b)
                 (not (empty ?b))
                 (inmedicine ?m ?b)
    
    )
)

(:action filltool
    :parameters (?b - box ?r - robot ?l - location ?t - tool)
    :precondition (and ;(= ?l depot)
                       (atbox ?b ?l)
                       (atrobot ?r ?l)
                       (attool ?t ?l)
                       (empty ?b)
                       (not (full ?b))
                       (not (intool ?t ?b))
    )
    :effect (and (full ?b)
                 (not (empty ?b))
                 (intool ?t ?b)
    
    )
)


)