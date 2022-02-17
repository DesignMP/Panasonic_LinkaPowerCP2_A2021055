
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//*************************************PrÌznak tlaËÌtka CS odblokovanÈ**********************************************//
	IF Safety.STAV.P1_Panel_TlacitkoCS_ODBLOK AND
		Safety.STAV.P1_Robot_TlacitkoCS_ODBLOK AND
		Safety.STAV.P1_Rozvadzac_TlacitkoCS_ODBLOK AND
		Safety.STAV.P2_Panel_TlacitkoCS_ODBLOK AND
		Safety.STAV.P2_DvojrucOvl_TlacitkoCS_ODBLOK AND
		Safety.STAV.P2_Robot_TlacitkoCS_ODBLOK AND
		Safety.STAV.P2_Rozvadzac_TlacitkoCS_ODBLOK AND
		Safety.STAV.P3_Rozvadzac_TlacitkoCS_ODBLOK AND
		Safety.STAV.P4_Panel_TlacitkoCS_ODBLOK AND
		Safety.STAV.P4_Rozvadzac_TlacitkoCS_ODBLOK THEN
		Safety.STAV.Linka_TlacitkaCS_ODBLOKOVANE:= TRUE;
	ELSE
		Safety.STAV.Linka_TlacitkaCS_ODBLOKOVANE:= FALSE;
	END_IF	
	
	
		
	//******************************************Reset zÛny CS*******************************************************//
	IF P1_Vizu.TL_ResetCS THEN
		Safety.OUT.Linka_ResetCS:= TRUE;
		P1_Vizu.TL_ResetCS:= FALSE;
	ELSIF P2_Vizu.TL_ResetCS THEN
		Safety.OUT.Linka_ResetCS:= TRUE;
		P2_Vizu.TL_ResetCS:= FALSE;	
	ELSIF P34_Vizu.TL_ResetCS THEN
		Safety.OUT.Linka_ResetCS:= TRUE;
		P34_Vizu.TL_ResetCS:= FALSE;		
	END_IF
	
	
	IF Safety.OUT.Linka_ResetCS THEN
		IF Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
			Safety.OUT.Linka_ResetCS:= FALSE;
		ELSIF NOT Safety.STAV.Linka_TlacitkaCS_ODBLOKOVANE THEN
			Safety.OUT.Linka_ResetCS:= FALSE;
		END_IF
	END_IF	
		
	
//    //Reset bariÈry vstupnÈho v˝ùahu//
//    IF NOT Safety.STAV.P1_Vytah_Bariera_AKTIVNA THEN
//        Safety.OUT.P1_ResetBarieryVytahu:= Blikac500ms;
//    ELSE
//        Safety.OUT.P1_ResetBarieryVytahu:= FALSE;
//    END_IF    
//  
//    
//    //Reset bariÈry v˝stupnÈho v˝ùahu//
//    IF NOT Safety.STAV.P4_Vytah_Bariera_AKTIVNA THEN
//        Safety.OUT.P4_ResetBarieryVytahu:= Blikac500ms;
//    ELSE
//        Safety.OUT.P4_ResetBarieryVytahu:= FALSE;
//    END_IF    
    
        
        
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

