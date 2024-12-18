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
(deftemplate result-animal
  (slot animal (type STRING))
)
(defrule queries
=>
(assert (response-to-query (query "Favorite")(response "undefined") (options "Run" "Mate" "Eat" "Swim" "Sleep" "I don't understand this chart") ))


(assert (response-to-query (query "How")(response "undefined") (options "Kidding... I walk" "So fast i fly" "I'm pretty quick")   ))

(assert (response-to-query (query "With")(response "undefined") (options "Yes" "No")	))
(assert (response-to-query (query "Posture")(response "undefined") 	(options "Bloody good, mate" "Quasimodo") 	))
(assert (response-to-query (query "Literally")(response "undefined")	(options "Yes" "No")	))
(assert (response-to-query (query "How so")(response "undefined")	(options "In my dreams" "Metaphorically")	))
(assert (response-to-query (query "Mostly")(response "undefined")	(options "Yes" "No")	))




(assert (response-to-query (query "IPOD")(response "undefined")		(options "Hakuna matata" "My old kentucky home")	))
(assert (response-to-query (query "Own or rent")(response "undefined") 		(options "If i pee on it, i own it, right?" "I'm in between floors at the moment")	))

(assert (response-to-query (query "Hit Quit")(response "undefined")	(options "Yes" "No")	))
(assert (response-to-query (query "HomeDad")(response "undefined")	(options "Yes" "No")	))

(assert (response-to-query (query "Where")(response "undefined")	(options "The sand" "In the shallows" "The deep blue sea")	))
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

(assert (response-to-query (query "What")(response "undefined")(options "No Meat" "Eh, i'm not that picky" "Things with blood")))
(assert (response-to-query (query "Hippie")(response "undefined") (options "Yes" "No")	))
(assert (response-to-query (query "Beard")(response "undefined") (options "Full-Body" "I'm more into tats")	))
(assert (response-to-query (query "Vote")(response "undefined")(options "For guns" "For the underground movement" )))
(assert (response-to-query (query "Tree")(response "undefined")	(options "Yes" "No"	)))
(assert (response-to-query (query "Lazy")(response "undefined")	(options "I need 9 months of beauty sleep" "Trash cans are easier")))
(assert (response-to-query (query "Quickly")(response "undefined")(options "Faster than you'd think" "Slower than you'd think")	))
(assert (response-to-query (query "Kill")(response "undefined")(options "Yes" "No")))
(assert (response-to-query (query "Why not")(response "undefined") (options "Cuz someone else does" "I like my steak extra rare")	))

(assert (response-to-query (query "Shallows")(response "undefined")(options "Sidewalk puddles" "Ponds and lakes" "Rivers and streams")   ))
(assert (response-to-query (query "DeepSea")(response "undefined")(options "Alone?" "No, THE deep blue sea")))
(assert (response-to-query (query "AloneQuestion")(response "undefined")(options "Yes" "No")))
(assert (response-to-query (query "Stupid")(response "undefined")(options "It's ok; No one expects you to")))

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
	(assert (result-animal (animal "Galapagos-tortoise")))
)
(defrule Bloody-good
	(response-to-query (query "Posture") (response "Bloody good, mate"))
	=>
	(assert (result-animal (animal "Antilopine-kangaroo")))
)
(defrule Quasimodo
	(response-to-query (query "Posture") (response "Quasimodo"))
	=>
	(assert (result-animal (animal "Silverback-gorilla")))
)

(defrule So-fast-i-fly
	(response-to-query (query "How")(response "So fast i fly"))
	=>
	(assert (request (query "Literally")))	
)
(defrule Falcon
	(response-to-query (query "Literally")(response "Yes"))
	=>
	(assert (result-animal (animal "Peregrine-falcon")))
)
(defrule Not-literally
	(response-to-query (query "Literally")(response "No"))
	=>
	(assert (request (query "How so")))
)
(defrule Dreams
	(response-to-query (query "How so")(response "In my dreams"))
	=>
	(assert (result-animal (animal "Tanzania-ostrich")))
)
(defrule Metaphorically
	(response-to-query (query "How so")(response "Metaphorically"))
	=>
	(assert (result-animal (animal "Cheetah")))
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
	(assert (result-animal (animal "Cockroach")))
)
(defrule Pee
	(response-to-query (query "Own or rent") (response "If i pee on it, i own it, right?"))
	=>
	(assert (result-animal (animal "Miniature-schnauzer")))
)

(defrule Mate
	(response-to-query (query "Favorite") (response "Mate"))
	=>
	(assert (request (query "Hit Quit")))
)
(defrule Dolphin
	(response-to-query (query "Hit Quit") (response "Yes"))
	=>
	(assert (result-animal (animal "BottlenoseDolphin")))
)
(defrule NotHitQuit
        (response-to-query (query "Hit Quit") (response "No"))
	=>
	(assert (request (query "HomeDad")))
)
(defrule HomeDad
        (response-to-query (query "HomeDad") (response "Yes"))
	=>
	(assert (result-animal (animal "PygmySeahorse")))
)
(defrule NotHomeDad
        (response-to-query (query "HomeDad") (response "No"))
	=>
	(assert (result-animal (animal "TurtleDove")))
)
(defrule Swim
	(response-to-query (query "Favorite") (response "Swim"))
	=>
	(assert (request (query "Where")))
)
(defrule DesertMonitor
        (response-to-query (query "Where") (response "The sand"))
        =>
        (assert (result-animal (animal "DesertMonitor")))
)
(defrule QuarterHorse
        (response-to-query (query "IPOD") (response "My old kentucky home"))
        =>
        (assert (result-animal (animal "Quarterhorse")))
)
(defrule AfricanLion
        (response-to-query (query "IPOD") (response "Hakuna matata"))
        =>
        (assert (result-animal (animal "AfricanLion")))
)
(defrule Shallows
	(response-to-query (query "Where") (response "In the shallows"))
	=>
	(assert (request (query "Shallows")))
)
(defrule Puddles
	(response-to-query (query "Shallows") (response "Sidewalk puddles"))
	=>
	(assert (request (query "French Fries")))
)
(defrule PondsAndLakes
	(response-to-query (query "Shallows") (response "Ponds and lakes"))
	=>
	(assert (request (query "Buoyancy")))
)
(defrule RiversAndStreams
	(response-to-query (query "Shallows") (response "Rivers and streams"))
	=>
	(assert (request (query "Recreationally")))
)
(defrule Algae
        (response-to-query (query "French Fries") (response "No"))
        =>
        (assert (result-animal (animal "Algae")))
)
(defrule FeralPigeon
        (response-to-query (query "French Fries") (response "Yes, and pretzels"))
        =>
        (assert (result-animal (animal "FeralPigeon")))
)
(defrule ThickShelledRiverMussel
        (response-to-query (query "Buoyancy") (response "I sink like a rock"))
        =>
        (assert (result-animal (animal "ThickShelledRiverMussel")))
)
(defrule LesserSnowGoose
        (response-to-query (query "Buoyancy") (response "I couldn't sink if i tried"))
        =>
        (assert (result-animal (animal "LesserSnowGoose")))
)
(defrule EurasianRiverOtter
        (response-to-query (query "Recreationally") (response "I like to goof around"))
        =>
        (assert (result-animal (animal "EurasianRiverOtter")))
)
(defrule RedPiranha
        (response-to-query (query "Recreationally") (response "I can be pretty intense"))
        =>
        (assert (result-animal (animal "RedPiranha")))
)
(defrule TheDeepBlueSea
	(response-to-query (query "Where") (response "The deep blue sea"))
	=>
	(assert (request (query "DeepSea")))
)
(defrule AloneQuestionRule
	(response-to-query (query "DeepSea") (response "Alone?"))
	=>
	(assert (request (query "Alone")))
)
(defrule TheGigaDeepBlueSea
	(response-to-query (query "DeepSea") (response "No, THE deep blue sea"))
	=>
	(assert (request (query "Scary")))
)
(defrule WithWhoSwim
	(response-to-query (query "Alone") (response "No"))
	=>
	(assert (request (query "With who")))
)
(defrule FrenchAngelfish
        (response-to-query (query "With who") (response "My life mate"))
        =>
        (assert (result-animal (animal "FrenchAngelfish")))
)
(defrule YellowTailBarracuda
        (response-to-query (query "With who") (response "All 15000 of my facebook friends"))
        =>
        (assert (result-animal (animal "YellowTailBarracuda")))
)
(defrule WhyAlone
	(response-to-query (query "Alone") (response "Yes"))
	=>
	(assert (request (query "Bummer")))
)
(defrule BullShark
        (response-to-query (query "Bummer") (response "Because i'm mean"))
        =>
        (assert (result-animal (animal "BullShark")))
)
(defrule TransparentJellyfish
        (response-to-query (query "Bummer") (response "Because i feel...invisible"))
        =>
        (assert (result-animal (animal "TransparentJellyfish")))
)
;(defrule IsScary
;	(response-to-query (query "Scary") (response "Yes"))
;	=>
;	(assert (request (query "More of")))
;)
(defrule NotScary
	(or
	(response-to-query (query "Scary") (response "No"))
	(response-to-query (query "Scary") (response "Yes"))
	)
	=>
	(assert (request (query "More of")))
)
(defrule Viperfish
        (response-to-query (query "More of") (response "Teeth"))
        =>
        (assert (result-animal (animal "Viperfish")))
)
(defrule GiantSquid
        (response-to-query (query "More of") (response "Appendages"))
        =>
        (assert (result-animal (animal "GiantSquid")))
)
(defrule Sleep
	(response-to-query (query "Favorite") (response "Sleep"))
	=>
	(assert (request (query "Graveyard")))
)
(defrule NotCuddly
	(response-to-query (query "Graveyard") (response "No"))
	=>
	(assert (request (query "Cuddly")))
)
(defrule CuddlyYes
	(response-to-query (query "Cuddly") (response "People other than my mother say i am"))
	=>
	(assert (result-animal (animal "KoalaBear")))
)
(defrule CuddlyMom
	(response-to-query (query "Cuddly") (response "My mother says i am"))
	=>
	(assert (result-animal (animal "GiantArmadillo")))
)
(defrule BrownBat
        (response-to-query (query "Graveyard") (response "Yes"))
        =>
        (assert (result-animal (animal "BrownBat")))
)
(defrule GiantArmadillo
        (response-to-query (query "Cuddly") (response "Mother"))
        =>
        (assert (result-animal (animal "GiantArmadillo")))
)
(defrule KoalaBear
        (response-to-query (query "Cuddly") (response "People other than my mother say i am"))
        =>
        (assert (result-animal (animal "KoalaBear")))
)
(defrule Stupido
        (response-to-query (query "Favorite") (response "I don't understand this chart"))
        =>
        (assert (request (query "Stupid")))
)
(defrule BelgiumMilkSheep
        (response-to-query (query "Stupid") (response "It's ok; No one expects you to"))
        =>
        (assert (result-animal (animal "BelgiumMilkSheep")))
)
(defrule Eat
        (response-to-query (query "Favorite") (response "Eat"))
        =>
        (assert (request (query "What")))
)
(defrule NoMeat
        (response-to-query (query "What") (response "No Meat"))
        =>
        (assert (request(query "Hippie")))
)
(defrule Beard
        (response-to-query (query "Hippie") (response "Yes"))
        =>
        (assert (request(query "Beard"))
))
(defrule Picky
        (response-to-query (query "What") (response "Eh, i'm not that picky"))
        =>
        (assert (request(query "Tree"))
))
(defrule Blood
        (response-to-query (query "What") (response "Things with blood"))
        =>
        (assert (request(query "Kill"))
))
(defrule WoollyYak
        (response-to-query (query "Beard") (response "Full-Body"))
        =>
        (assert (result-animal (animal "WoollyYak")))
)
(defrule GrantsZebra
        (response-to-query (query "Beard") (response "I'm more into tats"))
        =>
        (assert (result-animal (animal "GrantsZebra")))
)
(defrule Vote
        (response-to-query (query "Hippie") (response "No"))
        =>
        (assert (request(query "Vote"))
))
(defrule AfricanElephant
        (response-to-query (query "Vote") (response "For guns"))
        =>
        (assert (result-animal (animal "AfricanElephant")))
)
(defrule GardenWorm
        (response-to-query (query "Vote") (response "For the underground movement"))
        =>
        (assert (result-animal (animal "GardenWorm")))
)
(defrule HowLazy
        (response-to-query (query "Tree") (response "No"))
        =>
        (assert (request(query "Lazy"))
))
(defrule AlpineMarmot
        (response-to-query (query "Lazy") (response "I need 9 months of beauty sleep"))
        =>
        (assert (result-animal (animal "AlpineMarmot")))
)
(defrule NorthernRaccoon
        (response-to-query (query "Lazy") (response "Trash cans are easier"))
        =>
        (assert (result-animal (animal "NorthernRaccoon")))
)
(defrule HowQuick
        (response-to-query (query "Tree") (response "Yes"))
        =>
        (assert (request(query "Quickly")))
)
(defrule HimalayanBlackBear
        (response-to-query (query "Quickly") (response "Faster than you'd think"))
        =>
        (assert (result-animal (animal "HimalayanBlackBear")))
)
(defrule TwoToedSloth
        (response-to-query (query "Quickly") (response "Slower than you'd think"))
        =>
        (assert (result-animal (animal "TwoToedSloth")))
)
(defrule WhyNotKill
        (response-to-query (query "Kill") (response "No"))
        =>
        (assert (request(query "Why not"))
))
(defrule RuppellsGriffinVulture
        (response-to-query (query "Why not") (response "Cuz someone else does"))
        =>
        (assert (result-animal (animal "RuppellsGriffinVulture")))
)
(defrule HorseLeech
        (response-to-query (query "Why not") (response "I like my steak extra rare"))
        =>
        (assert (result-animal (animal "HorseLeech")))
)
(defrule HowLongKill
        (response-to-query (query "Kill") (response "Yes"))
        =>
        (assert (request(query "Take"))
))
(defrule SaltwaterCrocodile
        (response-to-query (query "Take") (response "A few seconds"))
        =>
        (assert (result-animal (animal "SaltwaterCrocodile")))
)
(defrule BurmesePython
        (response-to-query (query "Take") (response "Hours"))
        =>
        (assert (result-animal (animal "BurmesePython")))
)
;(defrule show-animal
;   (result-animal ?animal)
;   =>
;   (printout t "The selected animal is: " ?animal crlf)
;)