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

(assert (response-to-query (query "Shallows")(response "undefined")(options "Sidewalk puddles" "Ponds and lakes" "Rivers and streams")   ))
(assert (response-to-query (query "DeepSea")(response "undefined")(options "Alone?" "No, the deep blue sea")))
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
(defrule Swim
	(response-to-query (query "Favorite") (response "Swim"))
	=>
	(assert (request (query "Where")))
)
(defrule DesertMonitor
        (response-to-query (query "Where") (response "TheSand"))
        =>
        (assert result-animal DesertMonitor)
)
(defrule Shallows
	(response-to-query (query "Where") (response "In the shallows"))
	=>
	(assert (request (query "Shallows")))
)
(defrule Puddles
	(response-to-query (query "Shallows") (response "Puddles and lakes"))
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
        (assert result-animal Algae)
)
(defrule FeralPigeon
        (response-to-query (query "French Fries") (response "Yes"))
        =>
        (assert result-animal FeralPigeon)
)
(defrule ThickShelledRiverMussel
        (response-to-query (query "Buoyancy") (response "Rock"))
        =>
        (assert result-animal ThickShelledRiverMussel)
)
(defrule LesserSnowGoose
        (response-to-query (query "Buoyancy") (response "NoSink"))
        =>
        (assert result-animal LesserSnowGoose)
)
(defrule EurasianRiverOtter
        (response-to-query (query "Recreationally") (response "Goof"))
        =>
        (assert result-animal EurasianRiverOtter)
)
(defrule RedPiranha
        (response-to-query (query "Recreationally") (response "Intense"))
        =>
        (assert result-animal RedPiranha)
)
(defrule TheDeepBlueSea
	(response-to-query (query "Where") (response "TheDeepBlueSeaResponse"))
	=>
	(assert (request (query "DeepSea")))
)
(defrule AloneQuestionRule
	(response-to-query (query "DeepSea") (response "AloneQuestion"))
	=>
	(assert (request (query "Alone")))
)
(defrule TheGigaDeepBlueSea
	(response-to-query (query "DeepSea") (response "GigaDeepBlueSea"))
	=>
	(assert (request (query "Scary")))
)
(defrule WithWhoSwim
	(response-to-query (query "Alone") (response "No"))
	=>
	(assert (request (query "With who")))
)
(defrule FrenchAngelfish
        (response-to-query (query "With who") (response "MyLifeMate"))
        =>
        (assert result-animal FrenchAngelfish)
)
(defrule YellowTailBarracuda
        (response-to-query (query "With who") (response "FacebookFriends"))
        =>
        (assert result-animal YellowTailBarracuda)
)
(defrule WhyAlone
	(response-to-query (query "Alone") (response "Yes"))
	=>
	(assert (request (query "Bummer")))
)
(defrule BullShark
        (response-to-query (query "Bummer") (response "Mean"))
        =>
        (assert result-animal BullShark)
)
(defrule TransparentJellyfish
        (response-to-query (query "Bummer") (response "Invisible"))
        =>
        (assert result-animal TransparentJellyfish)
)
(defrule IsScary
	(response-to-query (query "Scary") (response "Yes"))
	=>
	(assert (request (query "More of")))
)
(defrule IsScary
	(response-to-query (query "Scary") (response "No"))
	=>
	(assert (request (query "More of")))
)
(defrule Viperfish
        (response-to-query (query "More of") (response "Teeth"))
        =>
        (assert result-animal Viperfish)
)
(defrule GiantSquid
        (response-to-query (query "More of") (response "Appendagaes"))
        =>
        (assert result-animal GiantSquid)
)
(defrule Sleep
	(response-to-query (query "Favorite") (response "Sleep"))
	=>
	(assert (request (query "Graveyard")))
)
(defrule IsCuddly
	(response-to-query (query "Graveyard") (response "No"))
	=>
	(assert (request (query "Cuddly")))
)
(defrule BrownBat
        (response-to-query (query "Graveyard") (response "Yes"))
        =>
        (assert result-animal BrownBat)
)
(defrule GiantArmadillo
        (response-to-query (query "Cuddly") (response "Mother"))
        =>
        (assert result-animal GiantArmadillo)
)
(defrule KoalaBear
        (response-to-query (query "Cuddly") (response "OtherThanMother"))
        =>
        (assert result-animal KoalaBear)
)
(defrule Stupido
        (response-to-query (query "Favourite") (response "DontUnderstand"))
        =>
        (assert (request (query "Stupid")))
)
(defrule BelgiumMilkSheep
        (response-to-query (query "Stupid") (response "NoExpect"))
        =>
        (assert result-animal BelgiumMilkSheep)
)
(defrule Eat
        (response-to-query (query "Favorite") (response "Eat"))
        =>
        (assert (request (query "What")))
)
(defrule NoMeat
        (response-to-query (query "What") (response "No Meat"))
        =>
        (assert (request("Hippie"))
))
(defrule Picky
        (response-to-query (query "What") (response "Picky"))
        =>
        (assert (request("Tree"))
))
(defrule Blood
        (response-to-query (query "What") (response "Blood"))
        =>
        (assert (request("Kill"))
))
(defrule Beard
        (response-to-query (query "Hippie") (response "Yes"))
        =>
        (assert (request("Beard"))
))
(defrule WoollyYak
        (response-to-query (query "Beard") (response "FullBody"))
        =>
        (assert result-animal WoollyYak)
)
(defrule GrantsZebra
        (response-to-query (query "Beard") (response "Tats"))
        =>
        (assert result-animal GrantsZebra)
)
(defrule Vote
        (response-to-query (query "Hippie") (response "No"))
        =>
        (assert (request("Vote"))
))
(defrule AfricanElephant
        (response-to-query (query "Vote") (response "Guns"))
        =>
        (assert result-animal AfricanElephant)
)
(defrule GardenWorm
        (response-to-query (query "Vote") (response "UndergroundMovement"))
        =>
        (assert result-animal GardenWorm)
)
(defrule HowLazy
        (response-to-query (query "Tree") (response "No"))
        =>
        (assert (request("Lazy"))
))
(defrule AlpineMarmot
        (response-to-query (query "Lazy") (response "NineMonths"))
        =>
        (assert result-animal AlpineMarmot)
)
(defrule NorthernRaccoon
        (response-to-query (query "Lazy") (response "TrashCan"))
        =>
        (assert result-animal NorthernRaccoon)
)
(defrule HowQuick
        (response-to-query (query "Tree") (response "Yes"))
        =>
        (assert (request("Quickly"))
))
(defrule HimalayanBlackBear
        (response-to-query (query "Quickly") (response "FasterThanYouThink"))
        =>
        (assert result-animal HimalayanBlackBear)
)
(defrule TwoToedSloth
        (response-to-query (query "Quickly") (response "SlowerThanYouThink"))
        =>
        (assert result-animal TwoToedSloth)
)
(defrule WhyNotKill
        (response-to-query (query "Kill") (response "No"))
        =>
        (assert (request("Why not"))
))
(defrule RuppellsGriffinVulture
        (response-to-query (query "Why not") (response "SomeoneElse"))
        =>
        (assert result-animal RuppellsGriffinVulture)
)
(defrule HorseLeech
        (response-to-query (query "Why not") (response "ExtraRare"))
        =>
        (assert result-animal HorseLeech)
)
(defrule HowLongKill
        (response-to-query (query "Kill") (response "Yes"))
        =>
        (assert (request("Take"))
))
(defrule SaltwaterCrocodile
        (response-to-query (query "Take") (response "FewSeconds"))
        =>
        (assert result-animal SaltwaterCrocodile)
)
(defrule BurmesePython
        (response-to-query (query "Take") (response "Hours"))
        =>
        (assert result-animal BurmesePython)
)