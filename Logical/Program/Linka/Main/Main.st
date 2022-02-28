
PROGRAM _INIT

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
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

