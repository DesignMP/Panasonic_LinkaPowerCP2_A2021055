
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	
	//Vstupy zo Safety PLC//
	Safety.Mapping_BYTE_IN[0];
	
	
	
	IF P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.6 AND P2_Pracovisko.COM_Weidmuller.AB2_8_8DI.7 THEN
		Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE:= TRUE;
	ELSE	
		Safety.STAV.P2_DvojrucneOvladanie_AKTIVNE:= FALSE;
	END_IF	
	
	
	
	//Výstupy pre Safety PLC//
	Safety.Mapping_BYTE_OUT[0];
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

