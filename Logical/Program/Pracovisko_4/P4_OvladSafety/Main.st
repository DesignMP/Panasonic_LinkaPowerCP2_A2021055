
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//******************************************Ovl�danie z�mkov dver� bunky****************************************//
	//Predn� dvere //
	IF P34_Vizu.TL_ZamkniPrednyZamok_P4 THEN
		IF NOT P4_Pracovisko.OUT.PredneDvere_ZAMKNI AND P4_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
			P4_Pracovisko.OUT.PredneDvere_ZAMKNI:= TRUE;
		ELSIF P4_Pracovisko.OUT.PredneDvere_ZAMKNI THEN	
			P4_Pracovisko.OUT.PredneDvere_ZAMKNI:= FALSE;
		END_IF	
		P34_Vizu.TL_ZamkniPrednyZamok_P4:= FALSE;
	END_IF	
	
	//Zadn� dvere//
	IF P34_Vizu.TL_ZamkniZadnyZamok_P4 THEN
		IF NOT P4_Pracovisko.OUT.ZadneDvere_ZAMKNI AND P4_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
			P4_Pracovisko.OUT.ZadneDvere_ZAMKNI:= TRUE;
		ELSIF P4_Pracovisko.OUT.ZadneDvere_ZAMKNI THEN	
			P4_Pracovisko.OUT.ZadneDvere_ZAMKNI:= FALSE;
		END_IF	
		P34_Vizu.TL_ZamkniZadnyZamok_P4:= FALSE;
	END_IF
	 
	
	//******************************************Reset z�ny v�tahu*********************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P4_Vytah_Bariera_AKTIVNA OR Safety.STAV.P4_Vytah_Muting_AKTIVNY) AND
		NOT Safety.STAV.P4_ZonaVytahu_AKTIVNA THEN
		Safety.OUT.P4_ResetZonyVytahu:= TRUE;
	ELSE
		Safety.OUT.P4_ResetZonyVytahu:= FALSE;
	END_IF	
	
	//*****************************************Reset z�ny bunky************************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P4_Bunka_Zamky_AKTIVNE OR Safety.STAV.P4_VyblokovanieZamkov_AKTIVNE) AND
		NOT Safety.STAV.P4_ZonaBunky_AKTIVNA AND
		(Safety.STAV.P4_Bunka_VstupBariera_AKTIVNA OR Safety.STAV.P3_Bunka_Zamky_AKTIVNE)AND
		(Safety.STAV.P4_VystupBunky_VstupBar_AKTIVNA OR Safety.STAV.P4_VystupBunky_VystupBar_AKTIVNA) THEN
		Safety.OUT.P4_ResetZonyBunky:= TRUE;
	ELSE
		Safety.OUT.P4_ResetZonyBunky:= FALSE;
	END_IF	
	
	
	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

