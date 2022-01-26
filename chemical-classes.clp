; Sun Jan 16 17:48:32 EET 2022
; 
;+ (version "3.5")
;+ (build "Build 663")


(defclass chemical
	(is-a USER)
	(role concrete)
	(multislot colour
		(type SYMBOL)
		(allowed-values clear red white)
		(default clear)
		(create-accessor read-write))
	(multislot specific_gravity
		(type SYMBOL)
		(allowed-values equal_to_1 above_1 below_1)
		(default equal_to_1)
		(create-accessor read-write))
	(multislot radioactivity
		(type SYMBOL)
		(allowed-values no yes)
		(default no)
		(create-accessor read-write))
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(create-accessor read-write))
	(multislot solubility
		(type SYMBOL)
		(allowed-values soluble insoluble)
		(default soluble)
		(create-accessor read-write))
	(multislot smell
		(type SYMBOL)
		(allowed-values none vinegar choking)
		(default none)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values asphyxiation burns_skin explosive highly_toxic_PCBs)
		(create-accessor read-write))
	(multislot spectrometry
		(type SYMBOL)
		(allowed-values none sulphur carbon sodium metal)
		(default none)
		(create-accessor read-write)))

(defclass acid
	(is-a chemical)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 6)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 0)
		(create-accessor read-write)))

(defclass strong_acid
	(is-a acid)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 3)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values asphyxiation burns_skin explosive highly_toxic_PCBs)
		(default burns_skin)
		(create-accessor read-write)))

(defclass weak_acid
	(is-a acid)
	(role concrete)
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 3)
		(create-accessor read-write)))

(defclass base
	(is-a chemical)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 14)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 8)
		(create-accessor read-write)))

(defclass strong_base
	(is-a base)
	(role concrete)
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 11)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values asphyxiation burns_skin explosive highly_toxic_PCBs)
		(default burns_skin)
		(create-accessor read-write)))

(defclass weak_base
	(is-a base)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 11)
		(create-accessor read-write)))

(defclass oil
	(is-a chemical)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 8)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 6)
		(create-accessor read-write))
	(multislot solubility
		(type SYMBOL)
		(allowed-values soluble insoluble)
		(default insoluble)
		(create-accessor read-write))
	(multislot spectrometry
		(type SYMBOL)
		(allowed-values none sulphur carbon sodium metal)
		(default carbon)
		(create-accessor read-write)))

(defclass node
	(is-a USER)
	(role concrete)
	(multislot downstream
		(type INSTANCE)
		(create-accessor read-write)))

(defclass store
	(is-a node)
	(role concrete)
	(multislot contents
		(type INSTANCE)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write)))

(defclass manhole
	(is-a node)
	(role concrete))

;+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;+--------------------------------------------------------------------------------FUNCTIONS---------------------------------------------------------------------------------
;+ Asking question for specific_gravity_reading && solubility_reading && colour_reading && radioactivity_reading && smell_reading && spectrometry_reading && hazards_reading

(deffunction ask_question (?question $?allowed_values)
   (printout t ?question)
   (bind ?answer (read))
   (while (not (member ?answer ?allowed_values)) do
      (printout t "Given wrong input  : " ?answer crlf)
	  (printout t ?question)
      (bind ?temp (read))
      (if (lexemep ?answer) 
          then (bind ?answer ?temp )))
   return ?answer)

(deffunction ask_question_number (?question )
   (printout t ?question)
   (bind ?answer (read))
   (while ( not(and ( > ?answer 0) ( <= ?answer 14))) do
      (printout t "Given wrong input  : " ?answer crlf)
	  (printout t ?question)
      (bind ?answer (read)))
    ?answer)


;+--------------------------------------------------------------------------------RULES---------------------------------------------------------------------------------

;+------------Input------------
(defrule inputOfmetrics "Input"
	(initial-fact)
	=>
	(printout t "Gia poies metriseis tha dothoyn times? (pH solubility spectrometry colour smell specific_gravity radioactivity) ")
	(bind $?answer(readline))
	(bind $?typeOfmetric (explode$ $?answer))
	 
	(if (member pH ?typeOfmetric)	
	then
		(bind ?ph_value  (ask_question_number "Poso einai to pH: " ))
    	(assert (ph_value ?ph_value)))

	(if (member solubility ?typeOfmetric)	
	then
		(bind ?solubility_value  (ask_question "Poio einai to solubility( soluble insoluble ) : " soluble insoluble ))
   		(assert (solubility_value ?solubility_value)))
   		
	(if (member spectrometry ?typeOfmetric)	
	then
		(bind ?spectrometry_value  (ask_question "Ti timh exei to spectrometry ( none sulphur carbon sodium metal ): " none sulphur carbon sodium metal ))
  		(assert (spectrometry_value ?spectrometry_value)))

	(if (member colour ?typeOfmetric)	
	then
		(bind ?colour_value  (ask_question "Poso einai to colour( clear red white ): " clear red white ))
   		(assert (colour_value ?colour_value)))

	(if (member smell ?typeOfmetric)	
	then
		(bind ?smell_value  (ask_question "Poio einai to smell ( none vinegar choking ): " none vinegar choking ))
   		(assert (smell_value ?smell_value)))

	(if (member specific_gravity ?typeOfmetric)	
	then
		(bind ?specific_gravity_value  (ask_question "Poso einai to specific_gravity( equal_to_1 above_1 below_1 ): " equal_to_1 above_1 below_1 ))
   		(assert (specific_gravity_value ?specific_gravity_value)))

	
	(if (member radioactivity ?typeOfmetric)	
	then
		(bind ?radioactivity_value  (ask_question "Einai radioactive ( yes no ): " yes no ))
   		(assert (radioactivity_value ?radioactivity_value)))

)
;+-----------network-----------
(defrule storeXsuspects   
	(declare (salience -1))
	(suspect ?y)  
	(object (is-a store)        
		(name ?x) 
		(contents $?contents))                             
=>     	
	(if  (member ?y $?contents ) 
	then 
	    (printout t "Suspect : " ?y   "in list " $?contents  crlf)
		(assert (sus_store ?x))  
	)                              
)

(defrule sus_manhole  
	(declare (salience 1))
	(sus_store ?y)  
	(object (is-a store)        
		(name ?x) 
		(downstream ?downstream))                             
=>    
	(printout t "store : " ?y "downstream : " ?downstream crlf)
	(assert (sus_manhole ?downstream))                      
) 



;+(defrule manholeXsuspects   
;+	(declare (salience -3))
;+	(sus_store ?y)  
;+	(object (is-a manhole)        
;+		(name ?x) 
;+		(downstream ?downstream))                             
;+=>    
;+	(printout t "store : " ?y  crlf)
;+	(assert (connected ?x ?downstream))                      
;+) 







;+-----------Assert all chemicals suspect-------------

(defrule assert_all_chems "All chemical suspects"
   	(object (is-a chemical)
    	(name ?x))
=>
   (assert (suspect ?x))
)
;+-----------Retract mismatch-------------           
(defrule retract_pH
	(ph_value ?pH)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(pH-high ?phH)
    	(pH-low ?phL)
	)
=>
   (if (and (eq ?x ?sus) (or(< ?pH ?phL) (> ?pH ?phH)))
   then
		(retract ?y)
   		(printout t "retract_pH : " ?x  crlf)
    )
)
(defrule retract_colour
	(colour_value ?colour_value)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(colour ?colour)
	)
=>
   (if (and (eq ?x ?sus) (neq ?colour ?colour_value))
   then
		(retract ?y)
   		(printout t "retract_colour : " ?x  crlf)
    )
)

(defrule retract_radioactivity
	(radioactivity_value ?radioactivity_value)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(radioactivity ?radioactivity)
	)
=>
   (if (and (eq ?x ?sus) (neq ?radioactivity ?radioactivity_value))
   then
		(retract ?y)
   		(printout t "retract_radioactivity : " ?x  crlf)
    )
)

(defrule retract_smell
	(smell_value ?smell_value)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(smell ?smell)
	)
=>
   (if (and (eq ?x ?sus) (neq ?smell ?smell_value))
   then
		(retract ?y)
   		(printout t "retract_smell : " ?x  crlf)
    )
)

(defrule retract_solubility
	(solubility_value ?solubility_value)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(solubility ?solubility)
	)
=>
   (if (and (eq ?x ?sus) (neq ?solubility ?solubility_value))
   then
		(retract ?y)
   		(printout t "retract_solubility : " ?x  crlf)
    )
)

(defrule retract_specific_gravity
	(specific_gravity_value ?specific_gravity_value)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(specific_gravity ?specific_gravity)
	)
=>
   (if (and (eq ?x ?sus) (neq ?specific_gravity ?specific_gravity_value))
   then
		(retract ?y)
   		(printout t "retract_specific_gravity : " ?x  crlf)
    )
)

(defrule retract_spectrometry
	(spectrometry_value ?spectrometry_value)
  	?y<-(suspect ?sus)
   	(object (is-a chemical)
    	(name ?x)
    	(spectrometry ?spectrometry)
	)
=>
   (if (and (eq ?x ?sus) (neq ?spectrometry ?spectrometry_value))
   then
		(retract ?y)
   		(printout t "retract_spectrometry : " ?x  crlf)
    )
)



;+--------------------------------------------------------------------------------NOTES---------------------------------------------------------------------------------
;+colour          
;+hazards         
;+pH       
;+radioactivity   
;+smell           
;+solubility      
;+specific_gravity
;+spectrometry    
;+stored in       


;+	strong_acid
;+ #1
;+		 sulphuric_acid  
;+		  colour           clear	
;+		  hazards          burns_skin
;+		  pH-high          3
;+		  pH-low           0
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       soluble
;+		  specific_gravity equal_to_1
;+		  spectrometry     sulphur 
;+        stored in        1 5 7

;+ #2
;+		 hydrochloric_acid  
;+		  colour           clear	
;+		  hazards          asphyxiation burns_skin
;+		  pH-high          3
;+		  pH-low           0
;+		  radioactivity    no
;+		  smell            choking
;+		  solubility       soluble
;+		  specific_gravity equal_to_1
;+		  spectrometry     sulphur 
;+		  stored in        2 7

;+	weak_acid
;+ #1
;+		 acetic_acid  
;+		  colour           clear	
;+		  pH-high          6
;+		  pH-low           3
;+		  radioactivity    no
;+		  smell            vinegar
;+		  solubility       soluble
;+		  specific_gravity equal_to_1
;+		  spectrometry     none 
;+        stored in        2 4 8 

;+ #2
;+		 carbonic_acid  
;+		  colour           clear
;+		  pH-high          6
;+		  pH-low           3
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       soluble
;+		  specific_gravity equal_to_1
;+		  spectrometry     carbon 
;+		  stored in        4 6 8



;+	strong_base
;+ #1
;+		 sodium_hydroxide  
;+		  colour           clear	
;+		  hazards          burns_skin
;+		  pH-high          14
;+		  pH-low           11
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       soluble
;+		  specific_gravity equal_to_1
;+		  spectrometry     none 
;+        stored in        8

;+	strong_weak
;+ #1
;+		 aluminium_hydroxide  
;+		  colour           white
;+		  pH-high          11
;+		  pH-low           8
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       soluble
;+		  specific_gravity above_1
;+		  spectrometry     metal 
;+        stored in        6

;+ #2
;+		 chromogen_23  
;+		  colour           red
;+		  pH-high          11
;+		  pH-low           8
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       soluble
;+		  specific_gravity below_1
;+		  spectrometry     none 
;+        stored in        5

;+ #3
;+		 rubidium_hydroxide  
;+		  colour           clear
;+		  pH-high          11
;+		  pH-low           8
;+		  radioactivity    yes
;+		  smell            none
;+		  solubility       soluble
;+		  specific_gravity above_1
;+		  spectrometry     metal 
;+        stored in        3


;+	oil
;+ #1
;+		 petrol  
;+		  colour           clear	
;+		  hazards          explosive
;+		  pH-high          8
;+		  pH-low           6
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       insoluble
;+		  specific_gravity below_1
;+		  spectrometry     carbon 
;+        stored in        1 4 5

;+ #2
;+		 transformer_oil  
;+		  colour           clear	
;+		  hazards          highly_toxic_PCBs
;+		  pH-high          8
;+		  pH-low           6
;+		  radioactivity    no
;+		  smell            none
;+		  solubility       insoluble
;+		  specific_gravity equal_1
;+		  spectrometry     carbon 
;+        stored in        3 6 