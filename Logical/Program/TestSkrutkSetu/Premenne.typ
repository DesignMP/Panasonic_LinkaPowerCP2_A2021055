
TYPE
	AirSkrutkovaciSet_typ : 	STRUCT 
		CMD : AirSkrutkovaciSet_CMD_typ;
		STAV : AirSkrutkovaciSet_STAV_typ;
		IN : AirSkrutkovaciSet_IN_typ;
		OUT : AirSkrutkovaciSet_OUT_typ;
		Internal : AirSkrutkovaciSet_Internal_typ;
		Step : USINT;
	END_STRUCT;
	AirSkrutkovaciSet_CMD_typ : 	STRUCT 
		ENABLE : BOOL;
		Rezim_MANUAL : BOOL;
		PodajSkrutku : BOOL;
		VysunBrzdu : BOOL;
		ResetPoruchy : BOOL;
		RR_ZapniZasobnik : BOOL;
		RR_VysunOddelovacSkrutiek : BOOL;
		RR_VysunBrzdu : BOOL;
	END_STRUCT;
	AirSkrutkovaciSet_Internal_typ : 	STRUCT 
		PocetPodaniSkrutky : USINT;
		CasZaplneniaZasobnika : TON;
		CasVypnTriediacehoVzduchu : TON;
		CasVypnZasobnika : TON;
		CasPredSpustenimZasobnika : TON;
		IdleTime_200ms : TON;
		IdleTime_1500ms : TON;
		IdleTime_1s : TON;
		IdleTime_500ms : TON;
		IdleTime_100ms : TON;
		IdleTime_2s : TON;
		IdleTime_5s : TON;
		AlarmTime_5s : TON;
		AlarmTime_10s : TON;
	END_STRUCT;
	AirSkrutkovaciSet_IN_typ : 	STRUCT 
		ZasobnikSkrutiekPrazdny : BOOL;
		ZaplnenieListyZasobnika : BOOL;
		PreletSnimacZaOddelovacom : BOOL;
		PreletSnimacPredBrzdou : BOOL;
		PreletSnimacPredSkrutkovackou : BOOL;
		BrzdaVYSUNUTA : BOOL; (*Pozícia podania skrutky do skrutkovaèky*)
		BrzdaZASUNUTA : BOOL; (*Pozícia èakania na skrutku zo zásobníka*)
		SkrutkovackaZASUNUTA : BOOL; (*Kontrola zasunutia skrutkovaèky*)
	END_STRUCT;
	AirSkrutkovaciSet_OUT_typ : 	STRUCT 
		VibropohonZasobnika_RUN : BOOL;
		TriediaciVzduch_RUN : BOOL; (*Tryska nad lištou zásobníka*)
		ZhadzovaciVzduch_RUN : BOOL; (*Tryska pred lištou zásobníka*)
		NastrelSkrutkuDoBrzdy : BOOL;
		NastrelSkrutkuDoSkrutkovacky : BOOL;
		OdsavanieBrzdy_RUN : BOOL; (*Odsávanie neèistôt z brzdy*)
		OddelovacSkrutiek_VYSUN : BOOL; (*Podanie skrutky do hadice*)
		Brzdu_VYSUN : BOOL; (*Podanie skrutky do skrutkovaèky*)
		Brzdu_ZASUN : BOOL; (*Presun brzdy na pozíciu èakania skrutky zo zásobníka*)
	END_STRUCT;
	AirSkrutkovaciSet_STAV_typ : 	STRUCT 
		SkrutkaPripravena : BOOL;
		ERROR : BOOL;
		PopisPoruchy : STRING[100];
		PodanieSkrutky_BUSY : BOOL;
		SkrutkovaciSet_READY : BOOL;
	END_STRUCT;
END_TYPE
