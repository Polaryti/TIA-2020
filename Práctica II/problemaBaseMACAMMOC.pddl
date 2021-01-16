(define (problem Transporte) (:domain TrasporteMultiModal)

(:objects
	bus metro tren - transporte
	juan maria eva ana pedro - nombre
	a b c d e - ciudad
)

(:init
	(user juan e)
	(user maria e)
	(user eva d)
	(user ana a)
	(user pedro b)

	(at juan a)
	(at maria c)
	(at eva c)
	(at ana d)
	(at pedro e)

	(= (dinero juan) 50)
	(= (dinero maria) 15)
	(= (dinero eva) 13)
	(= (dinero ana) 18)
	(= (dinero pedro) 14)

	(= (bono juan) 5)
	(= (bono maria) 1)
	(= (bono eva) 0)
	(= (bono ana) 0)
	(= (bono pedro) 4)

	(= (ticket juan) 0)
	(= (ticket maria) 0)
	(= (ticket eva) 0)
	(= (ticket ana) 0)
	(= (ticket pedro) 0)

	(resident juan)
	(resident maria)
	(resident ana)

	(ruta a b bus)
	(ruta a b metro)
	(ruta a b tren)
	(ruta a c bus)
	(ruta a c metro)
	(ruta a c tren)
	(ruta a d bus)
	(ruta a d metro)
	(ruta a e tren)

	(ruta b a bus)
	(ruta b a metro)
	(ruta b a tren)
	(ruta b c bus)
	(ruta b c metro)
	(ruta b c tren)
	(ruta b d bus)
	(ruta b d metro)
	(ruta b e tren)

	(ruta c a bus)
	(ruta c a metro)
	(ruta c a tren)
	(ruta c b bus)
	(ruta c b metro)
	(ruta c b tren)
	(ruta c d bus)

	(ruta d a bus)
	(ruta d a metro)
	(ruta d b bus)
	(ruta d b metro)
	(ruta d c bus)

	(ruta e a tren)
	(ruta e b tren)

	(= (distancia a b) 40)
	(= (distancia a c) 80)
	(= (distancia a d) 120)
	(= (distancia a e) 200)

	(= (distancia b a) 40)
	(= (distancia b c) 40)
	(= (distancia b d) 80)
	(= (distancia b e) 80)

	(= (distancia c a) 80)
	(= (distancia c b) 40)
	(= (distancia c d) 80)
	(= (distancia c e) 200)

	(= (distancia d a) 120)
	(= (distancia d b) 80)
	(= (distancia d c) 40)
	(= (distancia d e) 120)

	(= (distancia e a) 200)
	(= (distancia e b) 120)
	(= (distancia e c) 240)
	(= (distancia e d) 160)

	(= (speed bus) 1)
	(= (speed metro) 2)
	(= (speed tren) 4)

	(= (bono-precio) 12)
	(= (ticket-precio) 6)
	(= (charge-bono-tickets) 10)
	(= (charge-bono-duration) 1)
	(= (buy-ticket-duration) 2)
	(= (gasto-total) 0)
)

(:goal (and
	(at juan e)
	(at maria e)
	(at eva d)
	(at ana a)
	(at pedro b)
))

(:metric minimize (+ (* 0.8 (total-time)) (* 0.2 (gasto-total)))))