
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//******************************************Ovládanie zámkov dverí bunky****************************************//
	//Predné dvere //
	IF P34_Vizu.TL_ZamkniPrednyZamok_P4 THEN
		IF NOT P4_Pracovisko.OUT.PredneDvere_ZAMKNI AND P4_Pracovisko.IN.PredneDvere_PritomnostAdaptera THEN
			P4_Pracovisko.OUT.PredneDvere_ZAMKNI:= TRUE;
		ELSIF P4_Pracovisko.OUT.PredneDvere_ZAMKNI THEN	
			P4_Pracovisko.OUT.PredneDvere_ZAMKNI:= FALSE;
		END_IF	
		P34_Vizu.TL_ZamkniPrednyZamok_P4:= FALSE;
	END_IF	
	
	//Zadné dvere//
	IF P34_Vizu.TL_ZamkniZadnyZamok_P4 THEN
		IF NOT P4_Pracovisko.OUT.ZadneDvere_ZAMKNI AND P4_Pracovisko.IN.ZadneDvere_PritomnostAdaptera THEN
			P4_Pracovisko.OUT.ZadneDvere_ZAMKNI:= TRUE;
		ELSIF P4_Pracovisko.OUT.ZadneDvere_ZAMKNI THEN	
			P4_Pracovisko.OUT.ZadneDvere_ZAMKNI:= FALSE;
		END_IF	
		P34_Vizu.TL_ZamkniZadnyZamok_P4:= FALSE;
	END_IF
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

