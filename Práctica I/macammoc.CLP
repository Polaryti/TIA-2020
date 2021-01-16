(deftemplate vivienda
	(slot Categoria (type INTEGER))
	(slot Edad_Aparente (type INTEGER))
	(slot Ventanas (type INTEGER))
	(slot Vue (type INTEGER))
)

(deftemplate Categoria 0 150
	(
		(Economica (40 1) (70 0))
		(Estandar (40 0) (70 1) (100 0))
		(Intermedio (70 0) (100 1) (130 0))
		(Alta (100 0) (130 1))
	)
)

(deftemplate Edad_Aparente 0 100
	(
		(Reciente (0 1) (12 0))
		(Nuevo (0 0) (12 1) (24 0))
		(Medio (24 0) (36 1) (48 0))
		(Viejo (48 0) (60 1))
	)
)

(deftemplate Vue 0 10000
	(
		(Bajisimo (500 1) (1500 0))
		(Bajo (500 0) (1500 1) (2500 0))
		(Medio (2500 0) (3500 1) (4500 0))
		(Alto (4500 0) (5500 1) (6500 0))
		(Altisimo (5500 0) (6500 1))
	)
)


(defrule regla1
	(Categoria Alta)
	(Edad_Aparente Reciente)
	=>
	(assert (Vue Altisimo))
)

(defrule regla2
	(Categoria Alta)
	(Edad_Aparente not [ Medio or Viejo ])
	=>
	(assert (Vue Alto))
)

(defrule regla3
	(Categoria Alta)
	(Edad_Aparente not [ Reciente or Nuevo ])
	=>
	(assert (Vue Medio))
)

(defrule regla4
	(Categoria Intermedio)
	(Edad_Aparente Nuevo)
	=>
	(assert (Vue not [ Medio or Alto ]))
)

(defrule regla5
	(Categoria Intermedio)
	(Edad_Aparente not [ Medio or Viejo ])
	=>
	(assert (Vue Bajo))
)

(defrule regla6
	(Categoria Estandar)
	(Edad_Aparente Nuevo)
	=>
	(assert (Vue Medio))
)

(defrule regla7
	(Categoria Estandar)
	(Edad_Aparente Viejo)
	=>
	(assert (Vue Bajisimo))
)

(defrule regla8
	(Categoria Economica)
	(Edad_Aparente Nuevo)
	=>
	(assert (Vue not [ Bajo or Medio ]))
)

(defrule regla9
	(Categoria Economica)
	(Edad_Aparente not [ Reciente or Nuevo ])
	=>
	(assert (Vue Bajisimo)).
)

(defrule reglaExt1
	(Ventanas ?v)
	(test (< ?v 3))
	=>
	(assert (Vue more-or-less Bajo))
)

(defrule reglaExt2
	(Ventanas ?v)
	(test (> ?v 5))
	=>
	(assert (Vue very Alto))
)

(defrule defuzzificar
	(declare (salience -1))
	(Vue ?val)
	=>
	(printout T "Valor catastral por por Momentum: " (moment-defuzzify ?val) crlf)
	(printout T "Valor catastral por por Maximum: " (maximum-defuzzify ?val) crlf)
	(halt)
)

(deffunction fuzzify (?fztemplate ?value ?delta)
 (bind ?low (get-u-from ?fztemplate))
 (bind ?hi (get-u-to ?fztemplate))
 (if (<= ?value ?low)
 then
 (assert-string
 (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
 else
 (if (>= ?value ?hi)
 then
 (assert-string
 (format nil "(%s (%g 0.0) (%g 1.0))"
 ?fztemplate (- ?hi ?delta) ?hi))
 else
 (assert-string
 (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
 ?fztemplate (max ?low (- ?value ?delta))
 ?value (min ?hi (+ ?value ?delta)) ))
 ))) 

(defrule leerconsola
	(initial-fact)
	=>
	(printout t "Introduzca la categoria (en puntuacion): " crlf)
	(bind ?Rcat (read))
	(fuzzify Categoria ?Rcat 0)
	
	(printout t "Introduzca la edad (en anyos o valoracion): " crlf)
	(bind ?Red (read))
	(if (integerp ?Red)
		then
	(fuzzify Edad_Aparente ?Red 0)
		else
	(assert-string (format nil "(Edad_Aparente %s)" ?Red))
	)
	
	(printout t "Introduzca el numero de ventanas: " crlf)
	(bind ?Rven (read))
	(assert (Ventanas ?Rven))
)