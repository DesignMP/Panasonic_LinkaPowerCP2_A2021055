
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Ovl�danie pneuz�mku skrutkova�ky matice//
	IF Safety.STAV.P2_ZonaMaticovacky_AKTIVNA THEN
		P2_StoperMaticovacky.OUT.Maticovacka_M4_Pneuzamok_ODOMKNI:= TRUE;
	ELSE	
		P2_StoperMaticovacky.OUT.Maticovacka_M4_Pneuzamok_ODOMKNI:= FALSE;
	END_IF	
	
	
	//******************************************Ovl�danie z�mkov dver� bunky****************************************//
	//Zadn� dvere //
	IF P2_Vizu.TL_ZamkniZadneZamky THEN
		IF NOT P2_Pracovisko.STAV.ZadneDvereZamknute AND P2_Pracovisko.IN.ZadneDvereLS_PritomnostAdaptera AND P2_Pracovisko.IN.ZadneDverePS_PritomnostAdaptera THEN
			P2_Pracovisko.OUT.ZadneDvereLS_ZAMKNI:= TRUE;
			P2_Pracovisko.OUT.ZadneDverePS_ZAMKNI:= TRUE;
		ELSIF P2_Pracovisko.STAV.ZadneDvereZamknute THEN	
			P2_Pracovisko.OUT.ZadneDvereLS_ZAMKNI:= FALSE;
			P2_Pracovisko.OUT.ZadneDverePS_ZAMKNI:= FALSE;
		END_IF	
		P2_Vizu.TL_ZamkniZadneZamky:= FALSE;
	END_IF	
	
		
	//Predn� dvere //
	IF P2_Vizu.TL_ZamkniPredneZamky THEN
		IF NOT P2_Pracovisko.STAV.PredneDvereZamknute AND P2_Pracovisko.IN.PredneDvereLS_PritomnostAdaptera AND P2_Pracovisko.IN.PredneDverePS_PritomnostAdaptera THEN
			P2_Pracovisko.OUT.PredneDvereLS_ZAMKNI:= TRUE;
			P2_Pracovisko.OUT.PredneDverePS_ZAMKNI:= TRUE;
		ELSIF P2_Pracovisko.STAV.PredneDvereZamknute THEN	
			P2_Pracovisko.OUT.PredneDvereLS_ZAMKNI:= FALSE;
			P2_Pracovisko.OUT.PredneDverePS_ZAMKNI:= FALSE;
		END_IF	
		P2_Vizu.TL_ZamkniPredneZamky:= FALSE;
	END_IF
	
	//Stav zadn� dvere zamknut�//
	IF P2_Pracovisko.OUT.ZadneDvereLS_ZAMKNI AND P2_Pracovisko.OUT.ZadneDverePS_ZAMKNI THEN
		P2_Pracovisko.STAV.ZadneDvereZamknute:= TRUE;
	ELSE	
		P2_Pracovisko.STAV.ZadneDvereZamknute:= FALSE;
	END_IF	
	
	
	
	
	//Stav predn� dvere zamknut�//
	IF P2_Pracovisko.OUT.PredneDvereLS_ZAMKNI AND P2_Pracovisko.OUT.PredneDverePS_ZAMKNI THEN
		P2_Pracovisko.STAV.PredneDvereZamknute:= TRUE;
	ELSE	
		P2_Pracovisko.STAV.PredneDvereZamknute:= FALSE;
	END_IF	
	
	
	//*****************************************Reset z�ny bunky************************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
		(Safety.STAV.P2_Bunka_Zamky_AKTIVNE OR Safety.STAV.P2_VyblokovanieZamkov_AKTIVNE) AND
		NOT Safety.STAV.P2_ZonaBunky_AKTIVNA AND
		Safety.STAV.P2_Bunka_VstupBariera_AKTIVNA AND
		(Safety.STAV.P3_Bunka_VstupBariera_AKTIVNA OR Safety.STAV.P3_Bunka_Zamky_AKTIVNE)THEN
		Safety.OUT.P2_ResetZonyBunky:= TRUE;
	ELSE
		Safety.OUT.P2_ResetZonyBunky:= FALSE;
	END_IF	
	
	
	
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

