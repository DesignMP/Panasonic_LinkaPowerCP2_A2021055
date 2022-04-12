
PROGRAM _INIT
	Safety.STAV.Linka_SafetyPLC_Nabehlo:= TRUE;
	Safety.STAV.Linka_ZonaCS_AKTIVNA:= TRUE;
	Safety.STAV.P1_Vytah_Bariera_AKTIVNA:= TRUE;
	Safety.STAV.P1_ZonaBunky_AKTIVNA:= TRUE;
	Safety.STAV.P1_ZonaVytahu_AKTIVNA:= TRUE;
	Safety.STAV.P3_ZonaBunky_AKTIVNA:= TRUE;
	Safety.STAV.P4_ZonaBunky_AKTIVNA:= TRUE;
	Safety.STAV.P4_ZonaVytahu_AKTIVNA:= TRUE;
	Safety.STAV.P4_Vytah_Bariera_AKTIVNA:= TRUE;
	P3_LeakageTestA.STAV.Tester_ON:= TRUE;
	P3_LeakageTestB.STAV.Tester_ON:= TRUE;
	P4_FunkcnyTestA.STAV.Tester_ON:= TRUE;
	P4_FunkcnyTestB.STAV.Tester_ON:= TRUE;
	Safety.STAV.P2_ZonaZakladacaPojazd_AKTIVNA:= TRUE;
	Safety.STAV.P2_ZonaZakladacaZdvih_AKTIVNA:= TRUE;
	Safety.STAV.P2_ZonaBunky_AKTIVNA:= TRUE;
	Safety.STAV.P2_ZaklTesn_Bariera_AKTIVNA:= TRUE;
	Safety.STAV.P2_ZaklTesn_Bumper_AKTIVNY:= TRUE;
	Safety.STAV.P2_ZonaMaticovacky_AKTIVNA:= TRUE;
	
	
	Linka.PAR.IndexModelu:= 1;
	
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
	P2_UzivatelPrihlaseny:= TRUE;
	P34_UzivatelPrihlaseny:= TRUE;
	
	
	
	
	//**************************Zmena èasu a dátumu***************************************//
	IF Vizu.NastavCasPLC THEN
		DTSetTime_0.enable:= TRUE;
		DTSetTime_0.DT1:= Vizu.ZadanyCasPLC;
		DTSetTime_0();
	END_IF	
	
	IF DTSetTime_0.status = 0 THEN
		Vizu.NastavCasPLC:= FALSE;
		DTSetTime_0.enable:= FALSE;
		DTSetTime_0();
	END_IF	
		
	
	//**********************Naèítanie èasu a dátumu do vizualizácie**************************//
	DTGetTime_0.enable:= TRUE;
	Vizu.AktualnyCasPLC:= DTGetTime_0.DT1;
	DTGetTime_0();
		
	
	//Volba modelu//
	IF Linka.STAV.OFF THEN
		IF Linka.PAR.IndexModelu = 0 THEN
			Linka.PAR.ZvolenyModel:= '4F';
		ELSIF Linka.PAR.IndexModelu = 1 THEN
			Linka.PAR.ZvolenyModel:= '5F';
		ELSIF Linka.PAR.IndexModelu = 2 THEN
			Linka.PAR.ZvolenyModel:= '5H';
		END_IF  
	END_IF
    
	//**************************Stav linka vypnuta********************************************//
	IF P1_Pracovisko.STAV.Automat THEN
		Linka.STAV.OFF:= FALSE;
	ELSIF P2_Pracovisko.STAV.Automat THEN
		Linka.STAV.OFF:= FALSE; 
	ELSIF P3_Pracovisko.STAV.Automat THEN
		Linka.STAV.OFF:= FALSE; 
	ELSIF P4_Pracovisko.STAV.Automat THEN
		Linka.STAV.OFF:= FALSE; 
	ELSE
		Linka.STAV.OFF:= TRUE;
	END_IF    
	
	
	//**************************Stav linka prazdna********************************************//
	IF NOT P1_StoperSrobovania.RFID_hlava.PritomnostPaletky AND
		NOT P1_AkumulacnyStoper.IN.PritomnostPaletky AND
		NOT P2_StoperZaklTesnenia.RFID_hlava.PritomnostPaletky AND
		NOT P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky AND
		NOT P2_AkumulacnyStoper.IN.PritomnostPaletky AND
		NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky AND
		NOT P2_StoperZvarania.RFID_hlava.PritomnostPaletky AND
		NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky AND
		NOT P3_HV_Test.RFID_hlava.PritomnostPaletky AND
		NOT P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky AND
		NOT P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky AND
		NOT P3_LeakageTestA.RFID_hlava.PritomnostPaletky AND
		NOT P3_LeakageTestB.RFID_hlava.PritomnostPaletky AND
		NOT P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky AND
		NOT P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky AND
		NOT P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky AND
		NOT P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky AND
		NOT P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky AND
		NOT P4_ZdvizkaZaFunkcTestB.IN.PritomnostPaletky AND
		NOT P4_Etiketovacka.RFID_hlava.PritomnostPaletky AND
		NOT P4_Vytah.RFID_hlava.PritomnostPaletky THEN
		Linka.STAV.PRAZDNA:= TRUE;
	ELSE
		Linka.STAV.PRAZDNA:= FALSE;
	END_IF	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

