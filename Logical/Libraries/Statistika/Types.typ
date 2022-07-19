
TYPE
	Statistika_IN_typ : 	STRUCT 
		START_MeraniaCasu : BOOL;
		START_MeraniaStratovehoCasu : BOOL;
		ZAPIS_MeraniaCasu : BOOL;
		ZAPIS_StratovyCas : BOOL;
		TaskovaTrieda_ms : UINT;
		RESET_CelkovehoCasu : BOOL;
		RESET_HistorieMeraniCasu : BOOL;
		RESET_PoctuKusov : BOOL;
		RESET_CelkovehoPoctuKusov : BOOL;
		RESET_StratovehoCasu : BOOL;
		PriratajKus_OK : BOOL;
		PriratajKus_NG : BOOL;
	END_STRUCT;
	Statistika_OUT_typ : 	STRUCT 
		NameranyCas_v_Sekundach : REAL;
		NameranyCas_v_Minutach : REAL;
		NameranyCas_v_Hodinach : REAL;
		PriemernyCas_v_Sekundach : REAL;
		PriemernyCas_v_Minutach : REAL;
		StratoveSekundy : REAL;
		StratoveMinuty : REAL;
		StratoveHodiny : REAL;
		HistoriaMerani_v_Sekundach : ARRAY[0..14]OF REAL;
		HistoriaMerani_v_Minutach : ARRAY[0..14]OF REAL;
		HistoriaMerani_v_Hodinach : ARRAY[0..14]OF REAL;
		CelkovyPocetNameranychSekund : REAL;
		CelkovyPocetNameranychMinut : REAL;
		CelkovyPocetNameranychHodin : REAL;
		PocetKusov_OK : UDINT;
		PocetKusov_NG : UDINT;
		CelkovyPocetKusov : UDINT;
	END_STRUCT;
	Statistika_VAR_typ : 	STRUCT 
		NameraneMilisekundy_REAL : REAL;
		NameraneSekundy_REAL : REAL;
		NameraneMinuty_REAL : REAL;
		NameraneHodiny_REAL : REAL;
		Milisekundy : UINT;
		Sekundy : UINT;
		Minuty : UINT;
		Hodiny : UINT;
		CelkoveSekundy : UINT;
		CelkoveMinuty : UINT;
		CelkoveHodiny : UINT;
		i : USINT;
		a : USINT;
		b : USINT;
		c : USINT;
		d : USINT;
		Priemer_SucetSekund_REAL : REAL;
		Priemer_SucetMinut_REAL : REAL;
		Priemer_SucetHodin_REAL : REAL;
		StratoveMilisekundy : UINT;
		StratoveSekundy : UINT;
		StratoveMinuty : UINT;
		StratoveHodiny : UINT;
		CelkoveStratoveMilisekundy_REAL : REAL;
		CelkoveStratoveSekundy_REAL : REAL;
	END_STRUCT;
END_TYPE
