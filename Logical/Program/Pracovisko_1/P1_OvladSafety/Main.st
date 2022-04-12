
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
	

	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

