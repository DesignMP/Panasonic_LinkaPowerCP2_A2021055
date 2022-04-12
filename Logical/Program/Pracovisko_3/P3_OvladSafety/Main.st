
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	//******************************************Ovládanie zámkov dverí bunky****************************************//
	//Zadné dvere //
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
	
		
	//Predné dvere //
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
	
	//Stav zadné dvere zamknuté//
	IF P3_Pracovisko.OUT.ZadneDvereLave_ZAMKNI AND P3_Pracovisko.OUT.ZadneDverePrave_ZAMKNI THEN
		P3_Pracovisko.STAV.ZadneDvereZamknute:= TRUE;
	ELSE	
		P3_Pracovisko.STAV.ZadneDvereZamknute:= FALSE;
	END_IF	
	
	
	
	
	//Stav predné dvere zamknuté//
	IF P3_Pracovisko.OUT.PredneDvereLave_ZAMKNI AND P3_Pracovisko.OUT.PredneDverePrave_ZAMKNI THEN
		P3_Pracovisko.STAV.PredneDvereZamknute:= TRUE;
	ELSE	
		P3_Pracovisko.STAV.PredneDvereZamknute:= FALSE;
	END_IF	
	
	
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

