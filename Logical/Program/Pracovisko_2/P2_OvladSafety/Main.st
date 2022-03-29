
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Ovládanie pneuzámku skrutkovaèky matice//
	IF Safety.STAV.P2_ZonaMaticovacky_AKTIVNA THEN
		P2_StoperMaticovacky.OUT.Maticovacka_M4_Pneuzamok_ODOMKNI:= TRUE;
	ELSE	
		P2_StoperMaticovacky.OUT.Maticovacka_M4_Pneuzamok_ODOMKNI:= FALSE;
	END_IF	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

