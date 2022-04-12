
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	
	//**************************************Zmena farby tla��tok Reset CS *********************************************//
	IF Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		Vizu.TL_ResetCS_Farba:= "Button_Green";
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA AND Safety.STAV.Linka_TlacitkaCS_ODBLOKOVANE THEN	
		IF Blikac1s THEN
			Vizu.TL_ResetCS_Farba:= "Button_Blue";
		ELSE
			Vizu.TL_ResetCS_Farba:= "Operate";
		END_IF	
	ELSE
		Vizu.TL_ResetCS_Farba:= "Operate";
	END_IF	
	
	
	
    
	//************************************Blokovanie tla��tok prihl�senia oper�tora*************************************//
	IF P1_Vizu.TL_PrihlasovOperatora_AKTIVNE THEN
		P2_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
		P34_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
		P2_Vizu.TL_PrihlasenieOperatora_ENABLE:= FALSE;
		P34_Vizu.TL_PrihlasenieOperatora_ENABLE:= FALSE;
	ELSIF P2_Vizu.TL_PrihlasovOperatora_AKTIVNE THEN
		P1_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
		P34_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
		P1_Vizu.TL_PrihlasenieOperatora_ENABLE:= FALSE;
		P34_Vizu.TL_PrihlasenieOperatora_ENABLE:= FALSE;
	ELSIF P34_Vizu.TL_PrihlasovOperatora_AKTIVNE THEN
		P1_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
		P2_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
		P1_Vizu.TL_PrihlasenieOperatora_ENABLE:= FALSE;
		P2_Vizu.TL_PrihlasenieOperatora_ENABLE:= FALSE;
	ELSE
		P1_Vizu.TL_PrihlasenieOperatora_ENABLE:= TRUE;
		P2_Vizu.TL_PrihlasenieOperatora_ENABLE:= TRUE;
		P34_Vizu.TL_PrihlasenieOperatora_ENABLE:= TRUE;
	END_IF
    
	//************************************Vypnutie tla��tok prihl�senie oper�tora*********************************************//
	//Panel 1//
	IF P1_UzivatelPrihlaseny AND P1_Vizu.TL_PrihlasovOperatora_AKTIVNE AND P1_Vizu.ActualPage <> 'PageUsers' THEN
		P1_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
	END_IF    
    
	//Panel 2//
	IF P2_UzivatelPrihlaseny AND P2_Vizu.TL_PrihlasovOperatora_AKTIVNE THEN
		P2_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
	END_IF    
    
	//Panel 3//
	IF P34_UzivatelPrihlaseny AND P34_Vizu.TL_PrihlasovOperatora_AKTIVNE THEN
		P34_Vizu.TL_PrihlasovOperatora_AKTIVNE:= FALSE;
	END_IF    
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM
