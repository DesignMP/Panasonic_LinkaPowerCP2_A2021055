
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//*************************************Príznak tlaèítka CS odblokované**********************************************//
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
	
	
		
	//******************************************Reset zóny CS*******************************************************//
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
		
	
	
	//***************************************Príznak safety PLC nabehlo*********************************************//
    CasNabehnutiaSafetyPLC.PT:= T#10s;    
	CasNabehnutiaSafetyPLC();
	
	CasNabehnutiaSafetyPLC.IN:= Linka.IN.SafetyMaster_OK;
    
	IF CasNabehnutiaSafetyPLC.Q THEN
		Safety.STAV.Linka_SafetyPLC_Nabehlo:= TRUE;
	ELSE	
		Safety.STAV.Linka_SafetyPLC_Nabehlo:= FALSE;
	END_IF	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

