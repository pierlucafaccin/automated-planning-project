;Header and description

(define (domain prova)

;remove requirements that are not needed
(:requirements :strips :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    location
    robot
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (at ?r - robot ?l - location)
)


(:functions ;todo: define numeric functions here
)

;define actions here
(:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (at ?r ?from)
                       (not (= ?from ?to))
    )
    :effect (and (at ?r ?to)
                 (not (at ?r ?from))
    )
)

)