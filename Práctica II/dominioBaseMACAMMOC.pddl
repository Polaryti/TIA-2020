(define (domain TrasporteMultiModal)
(:requirements 
    :typing 
    :durative-actions 
    :fluents
)

(:types 
    ciudad 
    nombre 
    transporte
)

(:predicates 
	(at ?user - nombre ?ciudad - ciudad)
	(ruta ?ciudadOrigen - ciudad ?ciudadDestino - ciudad ?transporte - transporte)
	(user ?nombre - nombre ?destination - ciudad)
	(resident ?nombre - nombre)
)

(:functions 
	(dinero ?nombre - nombre)
	(bono ?nombre - nombre)
	(ticket ?nombre - nombre)
	(distancia ?ciudadOrigen - ciudad ?ciudadDestino - ciudad)
	(speed ?transporte - transporte)
	(bono-precio)
	(ticket-precio)
	(charge-bono-tickets)
	(charge-bono-duration)
	(buy-ticket-duration)
	(gasto-total)
)
	
(:durative-action move-bus
	:parameters (?source - ciudad ?destination - ciudad ?nombre - nombre ?user-destination - ciudad) 
	:duration (= ?duration (/ (distancia ?source ?destination) (speed bus)))
	:condition (and
		(at start (user ?nombre ?user-destination)) 			
		(at start (not (at ?nombre ?user-destination)))
		(at start (ruta ?source ?destination bus)) 			
		(at start (at ?nombre ?source)) 						
		(at start (resident ?nombre))							
	)
	:effect (and
		(at end (not (at ?nombre ?source)))					
		(at end (at ?nombre ?destination))					
	)
)

(:durative-action move-metro
	:parameters (?source - ciudad ?destination - ciudad ?nombre - nombre ?user-destination - ciudad) 
	:duration (= ?duration (/ (distancia ?source ?destination) (speed metro)))
	:condition (and
		(at start (user ?nombre ?user-destination)) 			
		(at start (not (at ?nombre ?user-destination)))
		(at start (ruta ?source ?destination metro)) 	 
		(at start (>= (bono ?nombre) 1))						
	)
	:effect (and
		(at end (decrease (bono ?nombre) 1))					
		(at end (not (at ?nombre ?source)))					
		(at end (at ?nombre ?destination))					
	)
)

(:durative-action move-tren
	:parameters (?source - ciudad ?destination - ciudad ?nombre - nombre ?user-destination - ciudad) 
	:duration (= ?duration (/ (distancia ?source ?destination) (speed tren)))
	:condition (and
		(at start (user ?nombre ?user-destination)) 			
		(at start (not (at ?nombre ?user-destination)))
		(at start (ruta ?source ?destination tren)) 		
		(at start (at ?nombre ?source)) 						
		(at start (>= (ticket ?nombre) 1))					
	)
	:effect (and
		(at end (decrease (ticket ?nombre) 1))				
		(at end (not (at ?nombre ?source)))					
		(at end (at ?nombre ?destination))					
	)
)

(:durative-action charge-bono
	:parameters (?nombre - nombre ?destination - ciudad)
	:duration (= ?duration (charge-bono-duration))
	:condition (and
		(at start (user ?nombre ?destination))
		(at start (>= (dinero ?nombre) (bono-precio)))
	)
	:effect (and
		(at end (increase (bono ?nombre) (charge-bono-tickets)))
		(at end (decrease (dinero ?nombre) (bono-precio)))
		(at end (increase (gasto-total) (bono-precio)))
	)
)

(:durative-action buy-ticket
	:parameters (?nombre - nombre ?destination - ciudad)
	:duration (= ?duration (buy-ticket-duration))
	:condition (and
		(at start (user ?nombre ?destination))
		(at start (>= (dinero ?nombre) (ticket-precio)))
		(at start (<= (ticket ?nombre) 0))
	)
	:effect (and
		(at end (increase (ticket ?nombre) 1))
		(at end (decrease (dinero ?nombre) (ticket-precio)))
		(at end (increase (gasto-total) (ticket-precio)))
	)
)
)
