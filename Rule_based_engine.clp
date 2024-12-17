(deftemplate response-to-query
	(slot query (type STRING))
	(slot response (type STRING))
	(multislot options) ;The list of possible answers
)
(deftemplate return
	(slot query (type STRING))
)
(deftemplate set-to-undefined
	(slot query (type STRING))
)
(deftemplate to-change
	(slot query (type STRING))
	(slot response (type STRING))
)
(deftemplate request
	(slot query (type STRING))
)
(defrule queries
=>
(assert (response-to-query (query "Favorite")(response "undefined") (options "Run" "Mate" "Eat" "Swim" "Sleep") ))


(assert (response-to-query (query "How")(response "undefined") (options "Kidding... I walk" "So fast i fly" "I'm pretty quick")   ))

(assert (response-to-query (query "With")(response "undefined") (options "Yes" "No")	))
(assert (response-to-query (query "Posture")(response "undefined") 	(options "Bloody good, mate" "Quasimodo") 	))
(assert (response-to-query (query "Literally")(response "undefined")	(options "Yes" "No")	))
(assert (response-to-query (query "How so")(response "undefined")	(options "In my dreams" "Metaphorically")	))
(assert (response-to-query (query "Mostly")(response "undefined")	(options "Yes" "No")	))




(assert (response-to-query (query "IPOD")(response "undefined")		(options "Hakuna matata" "My old kentucky home")	))
(assert (response-to-query (query "Own or rent")(response "undefined") 		(options "If i pee on it, i own it, right?" "I'm in between floors at the moment")	))

(assert (response-to-query (query "Hit Quit")(response "undefined")	(options "Yes" "No")	))
(assert (response-to-query (query "Home dad")(response "undefined")	(options "Yes" "No")	))

(assert (response-to-query (query "Where")(response "undefined")	(options "The sand" "In the shallows" "The deep blue sea" "No, the deep blue see")	))
(assert (response-to-query (query "French Fries")(response "undefined")	(options "Yes, and pretzels"	"No")	))
(assert (response-to-query (query "Buoyancy")(response "undefined")	(options "I sink like a rock" "I couldn't sink if i tried")	))
(assert (response-to-query (query "Recreationally")(response "undefined")	(options "I like to goof around" "I can be pretty intense")	))
(assert (response-to-query (query "Alone")(response "undefined")	(options "Yes"	"No")	))
(assert (response-to-query (query "Bummer")(response "undefined") (options "Because i'm mean" "Because i feel...invisible") 	))
(assert (response-to-query (query "With who")(response "undefined") (options "All 15000 of my facebook friends" "My life mate")))
(assert (response-to-query (query "Scary")(response "undefined") (options "Yes" "No")	))
(assert (response-to-query (query "More of")(response "undefined") (options "Teeth" "Appendages")))

(assert (response-to-query (query "Graveyard")(response "undefined")(options "Yes" "No")))
(assert (response-to-query (query "Cuddly")(response "undefined")(options "People other than my mother say i am" "My mother says i am")))

(assert (response-to-query (query "What")(response "undefined")(options "No meat" "Eh, i'm not that picky" "Things with blood")))
(assert (response-to-query (query "Hippie")(response "undefined") (options "Yes" "No")	))
(assert (response-to-query (query "Beard")(response "undefined") (options "Full-body" "I'm more into tats")	))
(assert (response-to-query (query "Vote")(response "undefined")(options "For guns" "For the underground movement" )))
(assert (response-to-query (query "Tree")(response "undefined")	(options "Yes" "No"	)))
(assert (response-to-query (query "Lazy")(response "undefined")	(options "I need 9 months of beauty sleep" "Trash cans are easier")))
(assert (response-to-query (query "Quickly")(response "undefined")(options "Faster than you'd think" "Slower than you'd think")	))
(assert (response-to-query (query "Kill")(response "undefined")(options "Yes" "No")))
(assert (response-to-query (query "Why not")(response "undefined") (options "Cuz someone else does" "I like my steak extra rare")	))
(assert (response-to-query (query "Take")(response "undefined") (options "I tie it up out back and kill it later" "A few seconds" "Hours")	))
)
(defrule return-rule
	?t <- (request (query ?x))
	?r <- (return (query ?x))
	?s <- (set-to-undefined (query ?y))
	?u <- (response-to-query (query ?y))
	=> 
	(retract ?s)
	(retract ?r)
	(retract ?t)
	(modify ?u (response "undefined"))
)
(defrule change-fact
	?e <- (to-change (query ?x) (response ?y))
	?f <- (response-to-query (query ?x))
	?g <- (request (query ?x))
	=>
	(modify ?f (response ?y))
	(retract ?e)
	(retract ?g)
)




(defrule favorite
	(response-to-query (query "Favorite")(response "undefined"))
	=>
	(assert (request (query "Favorite")))
)
;;;

(defrule Run
	(response-to-query (query "Favorite") (response "Run"))
	=>
	(assert (request (query "How")))
)

(defrule Kidding-i-walk
	(response-to-query (query "How") (response "Kidding... I walk"))
	=>
	(assert (request (query "With")))
)
(defrule Hasty
	(response-to-query (query "With") (response "Yes"))
	=>
	(assert (request (query "Posture")))	
)
(defrule Slow
	(response-to-query (query "With") (response "No"))
	=>
	(assert (result-animal Galapagos-tortoise)) 	
)
(defrule Bloody-good
	(response-to-query (query "Posture") (response "Bloody good, mate"))
	=>
	(assert (result-animal Antilopine-kangaroo))
)
(defrule Quasimodo
	(response-to-query (query "Posture") (response "Quasimodo"))
	=>
	(assert (result-animal Silverback-gorilla))
)

(defrule So-fast-i-fly
	(response-to-query (query "How")(response "So fast i fly"))
	=>
	(assert (request (query "Literally")))	
)
(defrule Falcon
	(response-to-query (query "Literally")(response "Yes"))
	=>
	(assert (result-animal Peregrine-falcon))
)
(defrule Not-literally
	(response-to-query (query "Literally")(response "No"))
	=>
	(assert (request (query "How so")))
)
(defrule Dreams
	(response-to-query (query "How so")(response "In my dreams"))
	=>
	(assert (result-animal Tanzania-ostrich))
)
(defrule Metaphorically
	(response-to-query (query "How so")(response "Metaphorically"))
	=>
	(assert (result-animal Cheetah))
)

(defrule Pretty-quick
	(response-to-query (query "How")(response "I'm pretty quick"))
	=>
	(assert (request (query "Mostly")))
)
(defrule Indoors
	(response-to-query (query "Mostly") (response "Yes"))
	=>
	(assert (request (query "Own or rent")))
)
(defrule Outdoors
	(response-to-query (query "Mostly") (response "No"))
	=>
	(assert (request (query "IPOD")))
)
(defrule Cock
	(response-to-query (query "Own or rent") (response "I'm in between floors at the moment"))
	=>
	(assert (result-animal Cockroach))
)
(defrule Pee
	(response-to-query (query "Own or rent") (response "If i pee on it, i own it, right?"))
	=>
	(assert (result-animal Miniature-schnauzer))
)
(defrule Mate
	(response-to-query (query "Favorite") (response "Mate"))
	=>
	(assert (request (query "Hit Quit")))
)
