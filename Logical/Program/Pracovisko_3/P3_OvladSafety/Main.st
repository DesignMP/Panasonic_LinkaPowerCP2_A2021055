
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	//******************************************Ovl�danie z�mkov dver� bunky****************************************//
	//Zadn� dvere //
	IF P34_Vizu.TL_ZamkniZadneZamky_P3 THEN
		IF NOT P3_Pracovisko.STAV.ZadneDvereZamknute AND P3_Pracovisko.IN.ZadneDvereLave_PritomnAdaptera AND P3_Pracovisko.IN.ZadneDverePrave_PritomnAdaptera THEN
			P3_Pracovisko.OUT.ZadneDvereLave_ZAMKNI:= TRUE;
			P3_Pracovisko.OUT.ZadneDverePrave_ZAMKNI:= TRUE;
		ELSIF P3_Pracovisko.STAV.ZadneDvereZamknute THEN	
			P3_Pracovisko.OUT.ZadneDvereLave_ZAMKNI:= FALSE;
			P3_Pracovisko.OUT.ZadneDverePrave_ZAMKNI:= FALSE;
		END_IF	
		P34_Vizu.TL_ZamkniZadneZamky_P3:= FALSE;
	END_IF	
	
		
	//Predn� dvere //
	IF P34_Vizu.TL_ZamkniPredneZamky_P3 THEN
		IF NOT P3_Pracovisko.STAV.PredneDvereZamknute AND P3_Pracovisko.IN.PredneDvereLave_PritomnAdaptera AND P3_Pracovisko.IN.PredneDverePrave_PritomnAdaptera THEN
			P3_Pracovisko.OUT.PredneDvereLave_ZAMKNI:= TRUE;
			P3_Pracovisko.OUT.PredneDverePrave_ZAMKNI:= TRUE;
		ELSIF P3_Pracovisko.STAV.PredneDvereZamknute THEN	
			P3_Pracovisko.OUT.PredneDvereLave_ZAMKNI:= FALSE;
			P3_Pracovisko.OUT.PredneDverePrave_ZAMKNI:= FALSE;
		END_IF	
		P34_Vizu.TL_ZamkniPredneZamky_P3:= FALSE;
	END_IF
	
	//Stav zadn� dvere zamknut�//
	IF P3_Pracovisko.OUT.ZadneDvereLave_ZAMKNI AND P3_Pracovisko.OUT.ZadneDverePrave_ZAMKNI THEN
		P3_Pracovisko.STAV.ZadneDvereZamknute:= TRUE;
	ELSE	
		P3_Pracovisko.STAV.ZadneDvereZamknute:= FALSE;
	END_IF	
	
	
	
	
	//Stav predn� dvere zamknut�//
	IF P3_Pracovisko.OUT.PredneDvereLave_ZAMKNI AND P3_Pracovisko.OUT.PredneDverePrave_ZAMKNI THEN
		P3_Pracovisko.STAV.PredneDvereZamknute:= TRUE;
	ELSE	
		P3_Pracovisko.STAV.PredneDvereZamknute:= FALSE;
	END_IF	
	
	
	
	//*****************************Reset z�ny HV test*****************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P3_Bunka_Zamky_AKTIVNE OR Safety.STAV.P3_VyblokovanieZamkov_AKTIVNE) AND
		NOT Safety.STAV.P3_ZonaHVtest_AKTIVNA AND
		(Safety.STAV.P3_Bunka_VstupBariera_AKTIVNA OR Safety.STAV.P2_Bunka_Zamky_AKTIVNE)AND
		(Safety.STAV.P4_Bunka_VstupBariera_AKTIVNA OR Safety.STAV.P4_Bunka_Zamky_AKTIVNE)THEN
		Safety.OUT.P3_ResetZonyHVtest:= TRUE;
	ELSE
		Safety.OUT.P3_ResetZonyHVtest:= FALSE;
	END_IF	
	
	
	//*****************************************Reset z�ny bunky************************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P3_Bunka_Zamky_AKTIVNE OR Safety.STAV.P3_VyblokovanieZamkov_AKTIVNE) AND
		NOT Safety.STAV.P3_ZonaBunky_AKTIVNA AND
		(Safety.STAV.P3_Bunka_VstupBariera_AKTIVNA OR Safety.STAV.P2_Bunka_Zamky_AKTIVNE)AND
		(Safety.STAV.P4_Bunka_VstupBariera_AKTIVNA OR Safety.STAV.P4_Bunka_Zamky_AKTIVNE)THEN
		Safety.OUT.P3_ResetZonyBunky:= TRUE;
	ELSE
		Safety.OUT.P3_ResetZonyBunky:= FALSE;
	END_IF	
	
	
	
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

