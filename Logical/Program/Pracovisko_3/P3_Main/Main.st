
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie podprogramov//
	ProfinetKomunikaciaKAM13;
	
	
	//Odomknutie pneumatického zámku zdvižiek//
	IF Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P3_Pracovisko.OUT.ZdvizkyPneuZamok_ODOMKNI:= TRUE;
	ELSE
		P3_Pracovisko.OUT.ZdvizkyPneuZamok_ODOMKNI:= FALSE;
	END_IF	
	
	
	 //**************************************Ukonèenie cyklu pracoviska****************************************************//
	IF P3_Pracovisko.KoniecCyklu THEN
		IF P3_Dopravniky.Automat THEN
			P3_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P3_SpodnyStoper.Automat THEN
			P3_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P3_StoperSrobovania.Automat THEN
			P3_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P3_Srobovanie.Automat THEN
			P3_Srobovanie.KoniecCyklu:= TRUE;
		END_IF
		IF P3_HV_Test.Automat THEN
			P3_HV_Test.KoniecCyklu:= TRUE;
		END_IF
		IF P3_ZdvizkaPredLeakTestA.Automat THEN
			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P3_ZdvizkaPredLeakTestB.Automat THEN
			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P3_LeakageTestA.Automat THEN
			P3_LeakageTestA.KoniecCyklu:= TRUE; 
		END_IF 
		IF P3_LeakageTestB.Automat THEN
			P3_LeakageTestB.KoniecCyklu:= TRUE; 
		END_IF 
		IF P3_ZdvizkaZaLeakTestA.Automat THEN
			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P3_ZdvizkaZaLeakTestB.Automat THEN
			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
		END_IF
		P3_Pracovisko.KoniecCyklu:= FALSE;
	END_IF    
    
    
	//************************************Ukonèenie cyklu pri poruche*****************************************//
	//ST1 - Šrobovanie//
//	IF P3_Pracovisko.STAV.Porucha_ST1 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.Reset:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.Reset:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF
     
	//ST2 - HV test//
//	IF P3_Pracovisko.STAV.Porucha_ST2 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.Reset:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF	
    
	
	//ST3 - Zdvižka pred Leakage testom A//
//	IF P3_Pracovisko.STAV.Porucha_ST3 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.Reset:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF 
	
	
	//ST4 - Zdvižka pred Leakage testom B//
//	IF P3_Pracovisko.STAV.Porucha_ST4 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.Reset:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF 
    
	
	//ST5 - Leakage test A//
//	IF P3_Pracovisko.STAV.Porucha_ST5 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.Reset:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF 
	
	//ST6 - Leakage test B//
//	IF P3_Pracovisko.STAV.Porucha_ST6 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.Reset:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF 
	
	//ST7 - Zdvižka za Leakage testom A//
//	IF P3_Pracovisko.STAV.Porucha_ST7 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.Reset:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//	END_IF 
	
	//ST8 - Zdvižka za Leakage testom B//
//	IF P3_Pracovisko.STAV.Porucha_ST8 THEN
//		IF P3_Dopravniky.Automat THEN
//			P3_Dopravniky.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_SpodnyStoper.Automat THEN
//			P3_SpodnyStoper.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_StoperSrobovania.Automat THEN
//			P3_StoperSrobovania.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_Srobovanie.Automat THEN
//			P3_Srobovanie.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_HV_Test.Automat THEN
//			P3_HV_Test.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestA.Automat THEN
//			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaPredLeakTestB.Automat THEN
//			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_LeakageTestA.Automat THEN
//			P3_LeakageTestA.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_LeakageTestB.Automat THEN
//			P3_LeakageTestB.KoniecCyklu:= TRUE; 
//		END_IF 
//		IF P3_ZdvizkaZaLeakTestA.Automat THEN
//			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= TRUE;
//		END_IF
//		IF P3_ZdvizkaZaLeakTestB.Automat THEN
//			P3_ZdvizkaZaLeakTestB.Reset:= TRUE;
//		END_IF
//	END_IF 
	
	//*********************************Status prebieha ukonèenie cyklu********************************************//
	IF P3_Dopravniky.KoniecCyklu OR
		P3_SpodnyStoper.KoniecCyklu OR
		P3_StoperSrobovania.KoniecCyklu OR
		P3_Srobovanie.KoniecCyklu OR
		P3_HV_Test.KoniecCyklu OR
		P3_ZdvizkaPredLeakTestA.KoniecCyklu OR
		P3_ZdvizkaPredLeakTestB.KoniecCyklu OR
		P3_LeakageTestA.KoniecCyklu OR
		P3_LeakageTestB.KoniecCyklu OR
		P3_ZdvizkaZaLeakTestA.KoniecCyklu OR
		P3_ZdvizkaZaLeakTestB.KoniecCyklu THEN
		P3_Pracovisko.STAV.UkoncenieCyklu_BUSY:= TRUE;
	ELSE
		P3_Pracovisko.STAV.UkoncenieCyklu_BUSY:= FALSE;
	END_IF   
    
        
    
    
    
    
	

	//******************************************Resetovanie pracoviska************************************************************//
	IF P3_Pracovisko.Reset THEN
		P3_Dopravniky.Reset:= TRUE;
		P3_SpodnyStoper.Reset:= TRUE;
		P3_StoperSrobovania.Reset:= TRUE;
		P3_Srobovanie.Reset:= TRUE;
		P3_HV_Test.Reset:= TRUE;
		P3_ZdvizkaPredLeakTestA.Reset:= TRUE;
		P3_ZdvizkaPredLeakTestB.Reset:= TRUE;
		P3_LeakageTestA.Reset:= TRUE;
		P3_LeakageTestB.Reset:= TRUE;
		P3_ZdvizkaZaLeakTestA.Reset:= TRUE;
		P3_ZdvizkaZaLeakTestB.Reset:= TRUE;
		P3_Pracovisko.Reset:= FALSE;
	END_IF	
	
	//Prepnutie pracoviska do manualneho režimu//
	IF P3_Pracovisko.Manual THEN
		P3_Dopravniky.Manual:= TRUE;
		P3_SpodnyStoper.Manual:= TRUE;
		P3_StoperSrobovania.Manual:= TRUE;
		P3_Srobovanie.Manual:= TRUE;
		P3_HV_Test.Manual:= TRUE;
		P3_ZdvizkaPredLeakTestA.Manual:= TRUE;
		P3_ZdvizkaPredLeakTestB.Manual:= TRUE;
		P3_LeakageTestA.Manual:= TRUE;
		P3_LeakageTestB.Manual:= TRUE;
		P3_ZdvizkaZaLeakTestA.Manual:= TRUE;
		P3_ZdvizkaZaLeakTestB.Manual:= TRUE;
		P3_Pracovisko.Manual:= FALSE;
	END_IF	
	
	
	//Spustenie pracoviska v automatickom režime//
	IF P3_Pracovisko.Automat THEN
		IF Safety.STAV.P3_ZonaBunky_AKTIVNA AND P3_Pracovisko.STAV.HardwareBunky_OK THEN
			P3_Dopravniky.Automat:= TRUE;
			(*P3_SpodnyStoper.Automat:= TRUE;*)
			P3_StoperSrobovania.Automat:= TRUE;
			P3_Srobovanie.Automat:= TRUE;
			P3_HV_Test.Automat:= TRUE;
			P3_ZdvizkaPredLeakTestA.Automat:= TRUE;
			P3_ZdvizkaPredLeakTestB.Automat:= TRUE;
			P3_LeakageTestA.Automat:= TRUE;
			P3_LeakageTestB.Automat:= TRUE;
			P3_ZdvizkaZaLeakTestA.Automat:= TRUE;
			P3_ZdvizkaZaLeakTestB.Automat:= TRUE;
		END_IF	
		P3_Pracovisko.Automat:= FALSE;
	END_IF
	
	
	//***************************************************Príznaky pracoviska******************************************************//
	//Príznak pracovisko stav AUTOMAT//
	IF P3_Dopravniky.Automat OR
		P3_SpodnyStoper.Automat OR
		P3_StoperSrobovania.Automat OR
		P3_Srobovanie.Automat OR
		P3_HV_Test.Automat OR
		P3_ZdvizkaPredLeakTestA.Automat OR
		P3_ZdvizkaPredLeakTestB.Automat OR
		P3_LeakageTestA.Automat OR
		P3_LeakageTestB.Automat OR
		P3_ZdvizkaZaLeakTestA.Automat OR
		P3_ZdvizkaZaLeakTestB.Automat THEN
		P3_Pracovisko.STAV.Automat:= TRUE;
	ELSE
		P3_Pracovisko.STAV.Automat:= FALSE;
	END_IF	
	
	//Priznak pracovisko stav MANUAL//
	IF P3_Dopravniky.Manual OR
		P3_SpodnyStoper.Manual OR
		P3_StoperSrobovania.Manual OR
		P3_Srobovanie.Manual OR
		P3_HV_Test.Manual OR
		P3_ZdvizkaPredLeakTestA.Manual OR
		P3_ZdvizkaPredLeakTestB.Manual OR
		P3_LeakageTestA.Manual OR
		P3_LeakageTestB.Manual OR
		P3_ZdvizkaZaLeakTestA.Manual OR
		P3_ZdvizkaZaLeakTestB.Manual THEN
		P3_Pracovisko.STAV.Manual:= TRUE;
	ELSE
		P3_Pracovisko.STAV.Manual:= FALSE;
	END_IF
	
	
	//Príznak pracovisko stav PoINIT//
	IF P3_Dopravniky.STAV.PoINIT AND
		P3_SpodnyStoper.STAV.PoINIT AND
		P3_StoperSrobovania.STAV.PoINIT AND
		P3_Srobovanie.STAV.PoINIT AND
		P3_HV_Test.STAV.PoINIT AND
		P3_ZdvizkaPredLeakTestA.STAV.PoINIT AND
		P3_ZdvizkaPredLeakTestB.STAV.PoINIT AND
		P3_LeakageTestA.STAV.PoINIT AND
		P3_LeakageTestB.STAV.PoINIT AND
		P3_ZdvizkaZaLeakTestA.STAV.PoINIT AND
		P3_ZdvizkaZaLeakTestB.STAV.PoINIT THEN
		P3_Pracovisko.STAV.PoINIT:= TRUE;
	ELSE
		P3_Pracovisko.STAV.PoINIT:= FALSE;
	END_IF	
		
	
	//Príznak pracovisko stav READY//
	IF SC_P3_Dopravniky.Step = 1 AND
		SC_P3_SpodnyStoper.Step = 1 AND
		SC_P3_StoperSrobovania.Step = 1 AND
		SC_P3_Srobovanie.Step = 1 AND
		SC_P3_HV_Test.Step = 1 AND
		SC_P3_ZdvizkaPredLeakTestA.Step = 1 AND
		SC_P3_ZdvizkaPredLeakTestB.Step = 1 AND
		SC_P3_LeakageTestA.Step = 1 AND
		SC_P3_LeakageTestB.Step = 1 AND
		SC_P3_ZdvizkaZaLeakTestA.Step = 1 AND
		SC_P3_ZdvizkaZaLeakTestB.Step = 1 THEN 
		P3_Pracovisko.STAV.READY:= TRUE;
	ELSE
		P3_Pracovisko.STAV.READY:= FALSE;
	END_IF
	
		
	//Príznak HW Bunky OK//
	IF P3_Pracovisko.IN.TlakVzduchu_OK AND
		P3_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P3_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		(*P3_Pracovisko.IN.Kamery_ControlUnit_KomOK AND*)
		P3_Pracovisko.IN.LeakageTesterA_KomOK AND
		P3_Pracovisko.IN.LeakageTesterB_KomOK AND
		P3_Pracovisko.IN.ServoManipulatorOsY_KomOK AND
		P3_Pracovisko.IN.ServoManipulatorOsZ_M5_KomOK AND
		P3_Pracovisko.IN.Skrutkovacka_K40_KomOK AND
		P3_Pracovisko.IN.Skrutkovacka_M5_KomOK AND
		P3_Srobovanie.IN.NapajanieSkrutkovackyK40_OK AND
		P3_Srobovanie.IN.NapajanieSkrutkovackyM5_OK AND
		P3_Srobovanie.IN.NapajanieVibrolistyM5_OK AND
		P3_Srobovanie.IN.NapajanieZasobnikaK40_OK AND
		P3_Srobovanie.IN.NapajanieZasobnikaM5_OK AND
		P3_Pracovisko.IN.VentilovyTerminal_KomOK THEN
		P3_Pracovisko.STAV.HardwareBunky_OK:= TRUE;
	ELSE	
		P3_Pracovisko.STAV.HardwareBunky_OK:= FALSE;
	END_IF	
	
	//Príznak skrutkovaèky zasunuté//
	IF P3_Srobovanie.IN.Skrutkovacka_K40_ZASUNUTA AND P3_Srobovanie.PAR.ManipulOsZ_M5_AktualnaPozicia < 5 THEN
		P3_Pracovisko.STAV.SkrutkovackyZasunute:= TRUE;
	ELSE
		P3_Pracovisko.STAV.SkrutkovackyZasunute:= FALSE;
	END_IF
	
	
	
	//Priznak HV test zasunuty//
	IF P3_HV_Test.IN.Centrovanie_ZASUNUTE AND P3_HV_Test.IN.HorneKontakty_ZASUNUTE AND P3_HV_Test.IN.SpodneKontakty_ZASUNUTE THEN
		P3_Pracovisko.STAV.HVtest_Zasunuty:= TRUE;
	ELSE	
		P3_Pracovisko.STAV.HVtest_Zasunuty:= FALSE;
	END_IF
	
	//Priznak LeakageTest A zasunuty//
	IF P3_LeakageTestA.IN.Centrovanie_ZASUNUTE AND P3_LeakageTestA.IN.HornyPritlak_ZASUNUTY (*AND P3_LeakageTestA.IN.Kopito_ZASUNUTE*) THEN
		P3_Pracovisko.STAV.LeakageTestA_Zasunuty:= TRUE;
	ELSE
		P3_Pracovisko.STAV.LeakageTestA_Zasunuty:= FALSE;
	END_IF	
	
	//Priznak LeakageTest B zasunuty//
	IF P3_LeakageTestB.IN.Centrovanie_ZASUNUTE AND P3_LeakageTestB.IN.HornyPritlak_ZASUNUTY (*AND P3_LeakageTestB.IN.Kopito_ZASUNUTE*) THEN
		P3_Pracovisko.STAV.LeakageTestB_Zasunuty:= TRUE;
	ELSE
		P3_Pracovisko.STAV.LeakageTestB_Zasunuty:= FALSE;
	END_IF	
	
	
		
	//*****************************Zapnutie osvetlenia pracoviska*********************************************************//
	P3_Pracovisko.OUT.OsvetlenieBunky_ON:= TRUE;
			
		
	
	
	
	//****************************************Ovládanie majáka***********************************************//
	//Zelené svetlo//
    
	IF P3_Pracovisko.STAV.Automat THEN
		P3_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Manual THEN
		P3_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= Blikac500ms;
	ELSE
		P3_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= FALSE;
	END_IF
		
	//Oranžové svetlo//
	IF P3_Pracovisko.STAV.Automat AND NOT P3_Pracovisko.STAV.PoINIT THEN
		P3_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= TRUE;
	ELSE
		P3_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= FALSE;
	END_IF      
        
            
        
	
	//Èervené svetlo//
	IF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST1 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST2 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST3 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST4 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST5 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST6 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST7 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P3_Pracovisko.STAV.Porucha_ST8 THEN
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;	
	ELSE
		P3_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= FALSE;
	END_IF
	
	//Zvuková signalizácia//
//	IF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST1) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST2) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST3) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST4) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;	
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST5) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST6) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST7) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P3_Pracovisko.STAV.Porucha_ST8) THEN
//		P3_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	END_IF
    
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

