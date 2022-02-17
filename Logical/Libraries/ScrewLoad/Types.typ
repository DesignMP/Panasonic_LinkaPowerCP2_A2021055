(*--- Vibracny hrniec ---*)

TYPE
	VibracnyHrniecStruc : 	STRUCT 
		IN : VibracnyHrniecIN;
		OUT : VibracnyHrniecOUT;
		Premenne : VibracnyHrniecVAR;
	END_STRUCT;
	VibracnyHrniecIN : 	STRUCT 
		PritomnostSkrutiekVHrnci : BOOL;
		VibracnaListaZaplnena : BOOL;
		PreletovySnimac : BOOL;
	END_STRUCT;
	VibracnyHrniecOUT : 	STRUCT 
		PrerusenieZasobovaniaSkrutiek : BOOL;
		TiedenieSkrutiek : BOOL;
		VzduchNastreleniaSkrutky : BOOL;
		OddelovacVysunut : BOOL;
		ZapniVibromotor : BOOL;
	END_STRUCT;
	VibracnyHrniecVAR : 	STRUCT 
		T_ZapnutieTriediacehoVzduchu : TON;
		T_Zaplnenie : TON;
		T_PreletSkrutky : TON;
	END_STRUCT;
END_TYPE

(*--- Brzda ---*)

TYPE
	BrzdaStruc : 	STRUCT 
		IN : BrzdaIN;
		OUT : BrzdaOUT;
		Premenne : BrzdaVAR;
	END_STRUCT;
	BrzdaIN : 	STRUCT 
		ZakladnaPoloha : BOOL;
		PodajSkrutku : BOOL;
		PreletSkrutky : BOOL;
		SkrutkaPritomnaVBrzde : BOOL;
		VyziadanieSkrutky : BOOL;
	END_STRUCT;
	BrzdaOUT : 	STRUCT 
		ZakladnaPoloha : BOOL;
		PodajSkrutku : BOOL;
		OdsavanieNecistot : BOOL;
		SktutkaPodana : BOOL;
		NastrelenieSkrutky : BOOL;
	END_STRUCT;
	BrzdaVAR : 	STRUCT 
		T_PreletSkrutky : TON;
		T_CasCisteniaSkrutky : TON;
		T_PresunBrzdy : TON;
	END_STRUCT;
END_TYPE

(*--- Brzda ---*)

TYPE
	StepStruc_typ : 	STRUCT 
		VibracnyHrniec : USINT;
		Brzda : USINT;
	END_STRUCT;
	StatusStruc_typ : 	STRUCT 
		VibracnyHrniec : WSTRING[80];
		Brzda : WSTRING[80];
	END_STRUCT;
END_TYPE

(*--- Struktura ---*)

TYPE
	InternalStruc : 	STRUCT 
		Brzda : BrzdaVAR;
		VibracnyHrniec : VibracnyHrniecVAR;
		Step : StepStruc_typ;
		Status : StatusStruc_typ;
	END_STRUCT;
	ErrorStruc_typ : 	STRUCT 
		ErrorBit : BOOL;
		ErrorNumber : UINT;
		ErrorMessage : WSTRING[80];
	END_STRUCT;
	StatusFBStruc : 	STRUCT 
		AutomatBezi : BOOL;
		ManualBeziHrniec : BOOL;
		SkrutkaPripravena : BOOL;
	END_STRUCT;
	CmdStruc : 	STRUCT 
		AutomatStart : BOOL;
		ManualStartHrniec : BOOL;
		PodajSkrutku : BOOL;
	END_STRUCT;
	OutStruc : 	STRUCT 
		Brzda : BrzdaOUT;
		VibracnyHrniec : VibracnyHrniecOUT;
	END_STRUCT;
	InStruc : 	STRUCT 
		Brzda : BrzdaIN;
		VibracnyHrniec : VibracnyHrniecIN;
	END_STRUCT;
END_TYPE
