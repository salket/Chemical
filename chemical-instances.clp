; Sun Jan 16 17:48:32 EET 2022
; 
;+ (version "3.5")
;+ (build "Build 663")
(definstances facts
	([acetic_acid] of  weak_acid

		(smell vinegar))

	([aluminium_hydroxide] of  weak_base

		(colour white)
		(specific_gravity above_1)
		(spectrometry metal))

	([carbonic_acid] of  weak_acid

		(spectrometry carbon))

	([chromogen_23] of  weak_base

		(colour red)
		(specific_gravity below_1))

	([hydrochloric_acid] of  strong_acid

		(hazards asphyxiation burns_skin)
		(smell choking))

	([manhole_1] of  manhole

		(downstream [manhole_9]))

	([manhole_10] of  manhole

		(downstream [manhole_12]))

	([manhole_11] of  manhole

		(downstream [manhole_13]))

	([manhole_12] of  manhole

		(downstream [monitoring_station]))

	([manhole_13] of  manhole

		(downstream [monitoring_station]))

	([manhole_2] of  manhole

		(downstream [manhole_9]))

	([manhole_3] of  manhole

		(downstream [manhole_9]))

	([manhole_4] of  manhole

		(downstream [manhole_10]))

	([manhole_5] of  manhole

		(downstream [manhole_10]))

	([manhole_6] of  manhole

		(downstream [manhole_11]))

	([manhole_7] of  manhole

		(downstream [manhole_11]))

	([manhole_8] of  manhole

		(downstream [manhole_13]))

	([manhole_9] of  manhole

		(downstream [manhole_12]))

	([monitoring_station] of  node
	)

	([petrol] of  oil

		(hazards explosive)
		(specific_gravity below_1))

	([rubidium_hydroxide] of  weak_base

		(radioactivity yes)
		(specific_gravity above_1)
		(spectrometry metal))

	([sodium_hydroxide] of  strong_base

		(spectrometry sodium))

	([store_1] of  store

		(contents
			[sulphuric_acid]
			[petrol])
		(downstream [manhole_1]))

	([store_2] of  store

		(contents
			[hydrochloric_acid]
			[acetic_acid])
		(downstream [manhole_2]))

	([store_3] of  store

		(contents
			[rubidium_hydroxide]
			[transformer_oil])
		(downstream [manhole_3]))

	([store_4] of  store

		(contents
			[carbonic_acid]
			[acetic_acid]
			[petrol])
		(downstream [manhole_4]))

	([store_5] of  store

		(contents
			[chromogen_23]
			[sulphuric_acid]
			[petrol])
		(downstream [manhole_5]))

	([store_6] of  store

		(contents
			[aluminium_hydroxide]
			[transformer_oil]
			[carbonic_acid])
		(downstream [manhole_6]))

	([store_7] of  store

		(contents
			[hydrochloric_acid]
			[sulphuric_acid])
		(downstream [manhole_7]))

	([store_8] of  store

		(contents
			[acetic_acid]
			[carbonic_acid]
			[sodium_hydroxide])
		(downstream [manhole_8]))

	([sulphuric_acid] of  strong_acid

		(spectrometry sulphur))

	([transformer_oil] of  oil

		(hazards highly_toxic_PCBs))
)