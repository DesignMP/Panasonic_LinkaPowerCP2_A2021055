
PROGRAM _INIT
	Safety.STAV.Linka_SafetyPLC_Nabehlo:= TRUE;
	Safety.STAV.Linka_ZonaCS_AKTIVNA:= TRUE;
	Safety.STAV.P1_Vytah_Bariera_AKTIVNA:= TRUE;
	Safety.STAV.P1_ZonaBunky_AKTIVNA:= TRUE;
	Safety.STAV.P1_ZonaVytahu_AKTIVNA:= TRUE;
	Linka.PAR.ZvolenyModel:= '5F';
END_PROGRAM

PROGRAM _CYCLIC
	
 //Volanie podprogramov//
ProfinetKomunikaciaCU;	
	

	Linka.KOM_FTP_OFF:= TRUE;
	Linka.KOM_Panatrace_OFF:= TRUE;
	Linka.P1_Kamery_OFF:= TRUE;
	Linka.P2_Kamery_OFF:= TRUE;
	Linka.P3_Kamery_OFF:= TRUE;
	Linka.P4_Kamery_OFF:= TRUE;
	Linka.P1_SkrutkovanieResult_OFF:= TRUE;
	Linka.P2_SkrutkovanieResult_OFF:= TRUE;
	Linka.P3_SkrutkovanieResult_OFF:= TRUE;
	P1_UzivatelPrihlaseny:= TRUE;
	
	
	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

