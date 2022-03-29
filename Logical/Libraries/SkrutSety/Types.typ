
TYPE
	PickAndPlace_CMD_typ : 	STRUCT 
		ENABLE : BOOL;
		PodajSkrutku : BOOL;
		RucnyRezim : BOOL;
		RR_ZapniZasobnik : BOOL;
		RR_ZapniVibrolistu : BOOL;
		RR_OtocPodavac_Vstup : BOOL;
		RR_OtocPodavac_Vystup : BOOL;
		ResetPoruchy : BOOL;
	END_STRUCT;
	PickAndPlace_IN_typ : 	STRUCT 
		ZasobnikSkrutiekPrazdny : BOOL;
		ZaplnenieListyZasobnika : BOOL;
		ZaplnenieVibrolisty_MIN : BOOL;
		ZaplnenieVibrolisty_MAX : BOOL;
		PodavacOtoceny_VSTUP : BOOL; (*Smerom k zásobníku*)
		PodavacOtoceny_VYSTUP : BOOL; (*Smerom k skrutkovaèke*)
		Podavac_SkrutkaNaVstupe : BOOL;
		Podavac_SkrutkaNaVystupe : BOOL;
		NapajanieZasobnika_OK : BOOL;
		NapajanieVibrolisty_OK : BOOL;
	END_STRUCT;
	PickAndPlace_OUT_typ : 	STRUCT 
		VibropohonZasobnika_RUN : BOOL;
		VibropohonListy_RUN : BOOL;
		TriediaciVzduch_RUN : BOOL; (*Tryska nad lištou zásobníka*)
		ZhadzovaciVzduch_RUN : BOOL; (*Tryska pred lištou zásobníka*)
		OtocPodavac_NaVstup : BOOL; (*Smerom k zásobníku*)
		OtocPodavac_NaVystup : BOOL; (*Smerom k skrutkovaèke*)
	END_STRUCT;
	PickAndPlace_STAV_typ : 	STRUCT 
		SkrutkaPripravena : BOOL;
		ERROR : BOOL;
		CisloPoruchy : USINT;
		PopisPoruchy : STRING[100];
	END_STRUCT;
	PickAndPlace_Internal_typ : 	STRUCT 
		CasZaplneniaVibrolisty : TON;
		CasZaplneniaZasobnika : TON;
		CasVypnTriediacehoVzduchu : TON;
		IdleTime_200ms : TON;
		IdleTime_1s : TON;
		IdleTime_500ms : TON;
		IdleTime_100ms : TON;
		AlarmTime_10s : TON;
	END_STRUCT;
	MaticaSet_CMD_typ : 	STRUCT 
		ENABLE : BOOL;
		PodajMaticu : BOOL;
		RucnyRezim : BOOL;
		RR_ZapniZasobnik : BOOL;
		ResetPoruchy : BOOL;
	END_STRUCT;
	MaticaSet_IN_typ : 	STRUCT 
		ZasobnikMaticPrazdny : BOOL;
		ZaplnenieListyZasobnika : BOOL;
		Oddelovac_SnimPrechoduMatice : BOOL;
		OddelovacOtoceny_VSTUP : BOOL; (*Smerom k zásobníku*)
		OddelovacOtoceny_VYSTUP : BOOL; (*Smerom k maticovaèke*)
		PodavacMatice_VYSUNUTY : BOOL;
		PodavacMatice_ZASUNUTY : BOOL;
		Podavac_SnimPrechoduMatice : BOOL;
		PritomnostMaticeNaVystupe : BOOL;
		NapajanieZasobnika_OK : BOOL;
	END_STRUCT;
	MaticaSet_OUT_typ : 	STRUCT 
		VibropohonZasobnika_RUN : BOOL;
		TriediaciVzduch_RUN : BOOL; (*Tryska nad lištou zásobníka*)
		ZhadzovaciVzduch_RUN : BOOL; (*Tryska pred lištou zásobníka*)
		OtocOddelovacMatice_NaVystup : BOOL; (*Smerom k maticovaèke*)
		NastrelenieMatice_RUN : BOOL;
		PodavacMatice_Vysun : BOOL;
	END_STRUCT;
	MaticaSet_STAV_typ : 	STRUCT 
		MaticaPripravena : BOOL;
		ERROR : BOOL;
		CisloPoruchy : USINT;
		PopisPoruchy : STRING[100];
	END_STRUCT;
	MaticaSet_Internal_typ : 	STRUCT 
		PoInit : BOOL;
		CasZaplneniaZasobnika : TON;
		CasVypnTriediacehoVzduchu : TON;
		CasVypnZasobnika : TON;
		IdleTime_200ms : TON;
		IdleTime_1s : TON;
		IdleTime_500ms : TON;
		IdleTime_100ms : TON;
		AlarmTime_3s : TON;
		IdleTime_1500ms : TON;
	END_STRUCT;
END_TYPE
