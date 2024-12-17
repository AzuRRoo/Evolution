(deftemplate response-to-query
        (slot query (type STRING))
        (slot response (type STRING))
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
(assert (response-to-query (query "Favorite")(reponse "undefined")))

(assert (response-to-query (query "How")(reponse "undefined")))

(assert (response-to-query (query "With")(reponse "undefined")))
(assert (response-to-query (query "Posture")(reponse "undefined")))
(assert (response-to-query (query "Literally")(reponse "undefined")))
(assert (response-to-query (query "How so")(reponse "undefined")))
(assert (response-to-query (query "Mostly")(reponse "undefined")))
(assert (response-to-query (query "IPOD")(reponse "undefined")))
(assert (response-to-query (query "Own or rent")(reponse "undefined")))

(assert (response-to-query (query "Hit Quit")(reponse "undefined")))
(assert (response-to-query (query "Home dad")(reponse "undefined")))

(assert (response-to-query (query "Where")(reponse "undefined")))
(assert (response-to-query (query "French Fries")(reponse "undefined")))
(assert (response-to-query (query "Shallows")(reponse "undefined")));;;;;;;;;;;;;;;;;;
(assert (response-to-query (query "DeepSea")(reponse "undefined")));;;;;;;;;;;;;;;;;;
(assert (response-to-query (query "Buoyancy")(reponse "undefined")))
(assert (response-to-query (query "Recreationally")(reponse "undefined")))
(assert (response-to-query (query "AloneQuestion")(reponse "undefined")));;;;;;;;;;;;;;;;;;
(assert (response-to-query (query "Stupid")(reponse "undefined")));;;;;;;;;;;;;;;;;;
(assert (response-to-query (query "Alone")(reponse "undefined")))
(assert (response-to-query (query "Bummer")(reponse "undefined")))
(assert (response-to-query (query "With who")(reponse "undefined")))
(assert (response-to-query (query "Scary")(reponse "undefined")))
(assert (response-to-query (query "More of")(reponse "undefined")))

(assert (response-to-query (query "Graveyard")(reponse "undefined")))
(assert (response-to-query (query "Cuddly")(reponse "undefined")))

(assert (response-to-query (query "What")(reponse "undefined")))
(assert (response-to-query (query "Hippie")(reponse "undefined")))
(assert (response-to-query (query "Beard")(reponse "undefined")))
(assert (response-to-query (query "Vote")(reponse "undefined")))
(assert (response-to-query (query "Tree")(reponse "undefined")))
(assert (response-to-query (query "Lazy")(reponse "undefined")))
(assert (response-to-query (query "Quickly")(reponse "undefined")))
(assert (response-to-query (query "Kill")(reponse "undefined")))
(assert (response-to-query (query "Why not")(reponse "undefined")))
(assert (response-to-query (query "Take")(reponse "undefined")))

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
        (modify ?u (answer "undefined"))
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
        (response-to-query (query "Favorite")(reponse "undefined"))
        =>
        (assert (request (query "Favorite")))
)
;;;
(defrule run
        (response-to-query (query "Favorite") (response "run"))
        =>
        (assert (request (query "How")))
)
(defrule Kidding-i-walk
        (response-to-query (query "How") (response "Kidding… I walk"))
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
        (response-to-query (query "Posture") (response "Bloody good, mate")
        =>
        (assert (result-animal Antilopine-kangaroo))
)
(defrule Quasimodo
        (response-to-query (query "Posture") (response "Quasimodo")
        =>
        (assert (result-animal Quasimodo))
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
        (response-to-query (query "Mostly") (response "Yes")
        =>
        (assert (request (query "Own or rent)))
)
(defrule Outdoors
        (response-to-query (query "Mostly") (response "No")
        =>
        (assert (request (query "IPOD")))
)
(defrule Cock
        (response-to-query (query "Own or rent") (response "I'm in betweeen floors at the moment"))
        =>
        (assert (result-animal Cockroach))
)
(defrule Pee
        (response-to-query (query "Own or rent") (response "If i pee on it i own it, right?"))
        =>
        (assert (result-animal Miniature-schnauzer))
)





============TIMOTI

(defrule Eat
        (response-to-query (query "Favorite") (response "Eat"))
        =>
        (assert (request (query "What")))
)
(defrule NoMeat
        (response-to-query (query "What") (response "No Meat"))
        =>
        (assert (request("Hippie"))
)
(defrule Picky
        (response-to-query (query "What") (response "Picky"))
        =>
        (assert (request("Tree"))
)
(defrule Blood
        (response-to-query (query "What") (response "Blood"))
        =>
        (assert (request("Kill"))
)
(defrule Beard
        (response-to-query (query "Hippie") (response "Yes"))
        =>
        (assert (request("Beard"))
)
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
)
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
)
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
)
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
)
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
)
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
======================
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
	(response-to-query (query "Where") (response "ShallowsResponse"))
	=>
	(assert (request (query "Shallows")))
)
(defrule Puddles
	(response-to-query (query "Shallows") (response "Puddles"))
	=>
	(assert (request (query "French Fries")))
)
(defrule PondsAndLakes
	(response-to-query (query "Shallows") (response "PondsAndLakes"))
	=>
	(assert (request (query "Buoyancy")))
)
(defrule RiversAndStreams
	(response-to-query (query "Shallows") (response "RiversAndStreams"))
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
==================================
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule Mate
	(response-to-query (query "Favorite") (response "Mate"))
	=>
	(assert (request (query "Hit Quit")))
)
(defrule Dolphin
	(response-to-query (query "Hit Quit") (response "Yes"))
	=>
	(assert (result-animal BottlenoseDolphin))
)
(defrule HomeDad
	(response-to-query (query "Hit Quit") (response "No"))
	=>
	(assert (request (query "Home dad")))
)
(defrule SeaHorse
	(response-to-query (query "Home dad") (response "Yes"))
	=>
	(assert (result-animal PygmySeahorse))
)
(defrule TurtleDove
	(response-to-query (query "Home dad") (response "No"))
	=>
	(assert (result-animal TurtleDove))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






