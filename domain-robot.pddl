;Header and description

(define (domain robot)

;remove requirements that are not needed
(:requirements :strips :typing :disjunctive-preconditions :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle

    person
    location
    box
    robot
    food medicine tool
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
    (attool ?t - tool ?l - location)

    (infood ?f - food ?b - box)
    (inmedicine ?m - medicine ?b - box)
    (intool ?f - food ?b - box)

    (empty ?b - box)

    ; Useful when emptying the box in order to specify the correct atfood, atmedicine
    ; attool
    (fullfood ?b - box ?f - food)
    (fullmedicine ?b - box ?m - medicine)
    (fulltool ?b - box ?m - tool)

    (loaded ?r - robot ?b - box)
    (free ?r - robot)


    (needfood ?p - person ?f - food)
    (needmedicine ?p - person ?m - medicine)
    (needtool ?p - person ?t - tool)

    (deliveredfood ?f - food ?p - person)
    (deliveredmedicine ?m - medicine ?p - person)
    (deliveredtool ?t - tool ?p - person)

    ; otherwise two boxes can be filled with the same item at the same time
    (inboxfood ?f - food)
    (inboxmedicine ?m - medicine)
    (inboxtool ?t - tool)
    ;(fullfilled ?p - person)
)


(:functions ;todo: define numeric functions here
)


;define actions here

; Robot moves withou picking it up
(:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (atrobot ?r ?from)
                       (not (= ?from ?to))
    )
    :effect (and (atrobot ?r ?to)
                 (not (atrobot ?r ?from))
    )
)

; The robot moves with a full box after picking it up
(:action movewithboxfood
    :parameters (?r - robot ?from ?to - location ?b - box ?f - food)
    :precondition (and (atrobot ?r ?from)
                       (atbox ?b ?from)
                       (atfood ?f ?from)
                       (not (atrobot ?r ?to))
                       (not (atbox ?b ?to))
                       (not (atfood ?f ?to))
                       ;(not (= ?from ?to))
                       (fullfood ?b ?f)
                       (not (empty ?b))
                       (loaded ?r ?b)
    )
    :effect (and (atrobot ?r ?to)
                 (atbox ?b ?to)
                 (atfood ?f ?to)
                 (not (atrobot ?r ?from))
                 (not (atbox ?b ?from))
    )
)

(:action movewithboxmedicine
    :parameters (?r - robot ?from ?to - location ?b - box ?m - medicine)
    :precondition (and (atrobot ?r ?from)
                       (atbox ?b ?from)
                       (atmedicine ?m ?from)
                       (not (atrobot ?r ?to))
                       (not (atbox ?b ?to))
                       (not (atmedicine ?m ?to))
                       ;(not (= ?from ?to))
                       (fullmedicine ?b ?m)
                       (not (empty ?b))
                       (loaded ?r ?b)
    )
    :effect (and (atrobot ?r ?to)
                 (atbox ?b ?to)
                 (atmedicine ?m ?to)
                 (not (atrobot ?r ?from))
                 (not (atbox ?b ?from))
    )
)

(:action movewithboxtool
    :parameters (?r - robot ?from ?to - location ?b - box ?t - tool)
    :precondition (and (atrobot ?r ?from)
                       (atbox ?b ?from)
                       (attool ?t ?from)
                       (not (atrobot ?r ?to))
                       (not (atbox ?b ?to))
                       (not (attool ?t ?to))
                       ;(not (= ?from ?to))
                       (fulltool ?b ?t)
                       (not (empty ?b))
                       (loaded ?r ?b)
    )
    :effect (and (atrobot ?r ?to)
                 (atbox ?b ?to)
                 (attool ?t ?to)
                 (not (atrobot ?r ?from))
                 (not (atbox ?b ?from))
    )
)

; The robot takes a full box
(:action loadrobotfood
    :parameters (?r - robot ?b - box ?l - location ?f - food)
    :precondition (and (fullfood ?b ?f)
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

(:action loadrobotmedicine
    :parameters (?r - robot ?b - box ?l - location ?m - medicine)
    :precondition (and (fullmedicine ?b ?m)
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

(:action loadrobottool
    :parameters (?r - robot ?b - box ?l - location ?t - tool)
    :precondition (and (fulltool ?b ?t)
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

(:action unloadrobot
    :parameters (?r - robot ?b - box ?l - location)
    :precondition (and (loaded ?r ?b)
                       (not (free ?r))
                       (not (empty ?b))
                       (atrobot ?r ?l)
                       (atbox ?b ?l)
    )
    :effect (and (not (loaded ?r ?b))
                 (free ?r)
    )
)

(:action emptybox
    :parameters (?r - robot ?b - box ?l - location)
    :precondition (and )
    :effect (and )
)



; Fill box with stuff
(:action fillfood
    :parameters (?b - box ?r - robot ?l - location ?f - food)
    :precondition (and ;(= ?l depot)
                       (atbox ?b ?l)
                       (atrobot ?r ?l)
                       (atfood ?f ?l)
                       (empty ?b)
                       (not (fullfood ?b ?f))
                       (not (infood ?f ?b))
                       (not (inboxfood ?f))
    )
    :effect (and (fullfood ?b ?f)
                 (not (empty ?b))
                 (infood ?f ?b)
                 (inboxfood ?f)
    
    )
)

(:action fillmedicine
    :parameters (?b - box ?r - robot ?l - location ?m - medicine)
    :precondition (and ;(= ?l depot)
                       (atbox ?b ?l)
                       (atrobot ?r ?l)
                       (atmedicine ?m ?l)
                       (empty ?b)
                       (not (fullmedicine ?b ?m))
                       (not (inmedicine ?m ?b))
                       (not (inboxmedicine ?m))
    )
    :effect (and (fullmedicine ?b ?m)
                 (not (empty ?b))
                 (inmedicine ?m ?b)
                 (inboxmedicine ?m)
    
    )
)

(:action filltool
    :parameters (?b - box ?r - robot ?l - location ?t - tool)
    :precondition (and ;(= ?l depot)
                       (atbox ?b ?l)
                       (atrobot ?r ?l)
                       (attool ?t ?l)
                       (empty ?b)
                       (not (fulltool ?b ?t))
                       (not (intool ?t ?b))
                       (not (inboxtool ?t))
    )
    :effect (and (fulltool ?b ?t)
                 (not (empty ?b))
                 (intool ?t ?b)
                 (inboxtool ?t)
    
    )
)






)