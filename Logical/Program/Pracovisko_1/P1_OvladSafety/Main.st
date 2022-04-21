
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//******************************************Ovládanie zámkov dverí bunky****************************************//
	//Predné dvere //
	IF P1_Vizu.TL_ZamkniPrednyZamok THEN
		IF NOT P1_Pracovisko.OUT.PredneDvere_ZAMKNI AND P1_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
			P1_Pracovisko.OUT.PredneDvere_ZAMKNI:= TRUE;
		ELSIF P1_Pracovisko.OUT.PredneDvere_ZAMKNI THEN	
			P1_Pracovisko.OUT.PredneDvere_ZAMKNI:= FALSE;
		END_IF	
		P1_Vizu.TL_ZamkniPrednyZamok:= FALSE;
	END_IF	
	
	//Zadné dvere//
	IF P1_Vizu.TL_ZamkniZadnyZamok THEN
		IF NOT P1_Pracovisko.OUT.ZadneDvere_ZAMKNI AND P1_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
			P1_Pracovisko.OUT.ZadneDvere_ZAMKNI:= TRUE;
		ELSIF P1_Pracovisko.OUT.ZadneDvere_ZAMKNI THEN	
			P1_Pracovisko.OUT.ZadneDvere_ZAMKNI:= FALSE;
		END_IF	
		P1_Vizu.TL_ZamkniZadnyZamok:= FALSE;
	END_IF
	

	//******************************************Reset zóny výtahu*********************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P1_Vytah_Bariera_AKTIVNA OR Safety.STAV.P1_Vytah_Muting_AKTIVNY) AND
		NOT Safety.STAV.P1_ZonaVytahu_AKTIVNA THEN
		Safety.OUT.P1_ResetZonyVytahu:= TRUE;
	ELSE
		Safety.OUT.P1_ResetZonyVytahu:= FALSE;
	END_IF	
	
	
	
	//*****************************************Reset zóny bunky************************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P1_Bunka_Zamky_AKTIVNE OR Safety.STAV.P1_VyblokovanieZamkov_AKTIVNE) AND
		NOT Safety.STAV.P1_ZonaBunky_AKTIVNA AND
		Safety.STAV.P1_VstupBunky_VstupBar_AKTIVNA AND
		Safety.STAV.P1_VstupBunky_VystupBar_AKTIVNA AND
		Safety.STAV.P1_VystupBunky_VstupBar_AKTIVNA AND
		Safety.STAV.P1_VystupBunky_VystupBar_AKTIVNA THEN
		Safety.OUT.P1_ResetZonyBunky:= TRUE;
	ELSE
		Safety.OUT.P1_ResetZonyBunky:= FALSE;
	END_IF	

	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

