
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie podprogramov//
	ProfinetKomunikaciaKAM1;
	ProfinetKomunikaciaKAM7;
	ProfinetKomunikaciaKAM8;
	ProfinetKomunikaciaKAM9;
	ProfinetKomunikaciaKAM10;
	ProfinetKomunikaciaKAM11;
	ProfinetKomunikaciaKAM12;
	ProfinetKomunikaciaKAM17;
	
	 
    //**************************************Ukonèenie cyklu pracoviska****************************************************//
	IF P2_Pracovisko.KoniecCyklu THEN
		IF P2_Dopravniky.Automat THEN
			P2_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_SpodnyStoper.Automat THEN
			P2_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperZaklTesnenia.Automat THEN
			P2_StoperZaklTesnenia.KoniecCyklu:= TRUE;
		END_IF
		IF P2_ZakladacTesnenia.Automat THEN
			P2_ZakladacTesnenia.KoniecCyklu:= TRUE;
		END_IF	
		IF P2_StoperMaticovacky.Automat THEN
			P2_StoperMaticovacky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_AkumulacnyStoper.Automat THEN
			P2_AkumulacnyStoper.KoniecCyklu:= TRUE;
		END_IF	
		IF P2_StoperSrobovania.Automat THEN
			P2_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Srobovanie.Automat THEN
			P2_Srobovanie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Robot.Automat THEN
			P2_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperZvarania.Automat THEN
			P2_StoperZvarania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Zvaranie.Automat THEN
			P2_Zvaranie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Cistenie.Automat THEN
			P2_Cistenie.KoniecCyklu:= TRUE; 
		END_IF 
		P2_Pracovisko.KoniecCyklu:= FALSE;
	END_IF    
    
    
	//************************************Ukonèenie cyklu pri poruche*****************************************//
	//ST1 - Zakladanie tesnenia//
	IF P2_Pracovisko.STAV.Porucha_ST1 THEN
		IF P2_StoperZaklTesnenia.Automat THEN
			P2_StoperZaklTesnenia.Reset:= TRUE;
		END_IF
		IF P2_ZakladacTesnenia.Automat THEN
			P2_ZakladacTesnenia.Reset:= TRUE;
		END_IF
	END_IF
     
	//ST2 - Skrutkovanie matice//
	IF P2_Pracovisko.STAV.Porucha_ST2 THEN
		IF P2_Dopravniky.Automat THEN
			P2_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_SpodnyStoper.Automat THEN
			P2_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperMaticovacky.Automat THEN
			P2_StoperMaticovacky.Reset:= TRUE;
		END_IF
		IF P2_AkumulacnyStoper.Automat THEN
			P2_AkumulacnyStoper.KoniecCyklu:= TRUE;
		END_IF	
		IF P2_StoperSrobovania.Automat THEN
			P2_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Srobovanie.Automat THEN
			P2_Srobovanie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Robot.Automat THEN
			P2_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperZvarania.Automat THEN
			P2_StoperZvarania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Zvaranie.Automat THEN
			P2_Zvaranie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Cistenie.Automat THEN
			P2_Cistenie.KoniecCyklu:= TRUE; 
		END_IF 
	END_IF	
    
	
	//ST3 - Akumulaèný stoper//
	IF P2_Pracovisko.STAV.Porucha_ST3 THEN
		IF P2_Dopravniky.Automat THEN
			P2_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_SpodnyStoper.Automat THEN
			P2_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperMaticovacky.Automat THEN
			P2_StoperMaticovacky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_AkumulacnyStoper.Automat THEN
			P2_AkumulacnyStoper.Reset:= TRUE;
		END_IF	
		IF P2_StoperSrobovania.Automat THEN
			P2_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Srobovanie.Automat THEN
			P2_Srobovanie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Robot.Automat THEN
			P2_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperZvarania.Automat THEN
			P2_StoperZvarania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Zvaranie.Automat THEN
			P2_Zvaranie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Cistenie.Automat THEN
			P2_Cistenie.KoniecCyklu:= TRUE; 
		END_IF 
	END_IF 
	
	
	//ST4 - Šrobovanie//
	IF P2_Pracovisko.STAV.Porucha_ST4 THEN
		IF P2_Dopravniky.Automat THEN
			P2_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_SpodnyStoper.Automat THEN
			P2_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperMaticovacky.Automat THEN
			P2_StoperMaticovacky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_AkumulacnyStoper.Automat THEN
			P2_AkumulacnyStoper.KoniecCyklu:= TRUE;
		END_IF	
		IF P2_StoperSrobovania.Automat THEN
			P2_StoperSrobovania.Reset:= TRUE;
		END_IF
		IF P2_Srobovanie.Automat THEN
			P2_Srobovanie.Reset:= TRUE;
		END_IF
		IF P2_Robot.Automat THEN
			P2_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperZvarania.Automat THEN
			P2_StoperZvarania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Zvaranie.Automat THEN
			P2_Zvaranie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Cistenie.Automat THEN
			P2_Cistenie.KoniecCyklu:= TRUE; 
		END_IF 
	END_IF 
    
	
	//ST5 - Zváranie a èistenie//
	IF P2_Pracovisko.STAV.Porucha_ST5 THEN
		IF P2_Dopravniky.Automat THEN
			P2_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_SpodnyStoper.Automat THEN
			P2_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperMaticovacky.Automat THEN
			P2_StoperMaticovacky.KoniecCyklu:= TRUE;
		END_IF
		IF P2_AkumulacnyStoper.Automat THEN
			P2_AkumulacnyStoper.KoniecCyklu:= TRUE;
		END_IF	
		IF P2_StoperSrobovania.Automat THEN
			P2_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Srobovanie.Automat THEN
			P2_Srobovanie.KoniecCyklu:= TRUE;
		END_IF
		IF P2_Robot.Automat THEN
			P2_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P2_StoperZvarania.Automat THEN
			P2_StoperZvarania.Reset:= TRUE;
		END_IF
		IF P2_Zvaranie.Automat THEN
			P2_Zvaranie.Reset:= TRUE;
		END_IF
		IF P2_Cistenie.Automat THEN
			P2_Cistenie.Reset:= TRUE; 
		END_IF 
	END_IF 
	
	
	//*********************************Status prebieha ukonèenie cyklu********************************************//
	IF P2_Dopravniky.KoniecCyklu OR
		P2_SpodnyStoper.KoniecCyklu OR
		P2_StoperZaklTesnenia.KoniecCyklu OR
		P2_ZakladacTesnenia.KoniecCyklu OR
		P2_StoperMaticovacky.KoniecCyklu OR
		P2_AkumulacnyStoper.KoniecCyklu OR
		P2_StoperSrobovania.KoniecCyklu OR
		P2_Srobovanie.KoniecCyklu OR
		P2_Robot.KoniecCyklu OR
		P2_StoperZvarania.KoniecCyklu OR
		P2_Zvaranie.KoniecCyklu OR
		P2_Cistenie.KoniecCyklu THEN
		P2_Pracovisko.STAV.UkoncenieCyklu_BUSY:= TRUE;
	ELSE
		P2_Pracovisko.STAV.UkoncenieCyklu_BUSY:= FALSE;
	END_IF   
    
    
    
    
    
    
    
    
    
	//*******************************Resetovanie pracoviska po stlaèení tlaèítka Automat******************************************//
	IF P2_Vizu.TL_RezimAutomat THEN
		IF P2_Pracovisko.STAV.Manual THEN
			P2_Pracovisko.Reset:= TRUE;
		END_IF    
		P2_Vizu.TL_RezimAutomat:= FALSE;
	END_IF    

	//******************************************Resetovanie pracoviska************************************************************//
	IF P2_Pracovisko.Reset THEN
		P2_Dopravniky.Reset:= TRUE;
		P2_SpodnyStoper.Reset:= TRUE;
		P2_StoperZaklTesnenia.Reset:= TRUE;
		P2_ZakladacTesnenia.Reset:= TRUE;
		P2_StoperMaticovacky.Reset:= TRUE;
		P2_AkumulacnyStoper.Reset:= TRUE;
		P2_StoperSrobovania.Reset:= TRUE;
		P2_Srobovanie.Reset:= TRUE;
		P2_Robot.Reset:= TRUE;
		P2_StoperZvarania.Reset:= TRUE;
		P2_Zvaranie.Reset:= TRUE;
		P2_Cistenie.Reset:= TRUE;
		P2_Pracovisko.Reset:= FALSE;
	END_IF	
	
	//Prepnutie pracoviska do manualneho režimu//
	IF P2_Pracovisko.Manual THEN
		P2_Dopravniky.Manual:= TRUE;
		P2_SpodnyStoper.Manual:= TRUE;
		P2_StoperZaklTesnenia.Manual:= TRUE;
		P2_ZakladacTesnenia.Manual:= TRUE;
		P2_StoperMaticovacky.Manual:= TRUE;
		P2_AkumulacnyStoper.Manual:= TRUE;
		P2_StoperSrobovania.Manual:= TRUE;
		P2_Srobovanie.Manual:= TRUE;
		P2_Robot.Manual:= TRUE;
		P2_StoperZvarania.Manual:= TRUE;
		P2_Zvaranie.Manual:= TRUE;
		P2_Cistenie.Manual:= TRUE;
		P2_Pracovisko.Manual:= FALSE;
	END_IF	
	
	
	//Spustenie pracoviska v automatickom režime//
	IF P2_Pracovisko.Automat THEN
		IF P2_Pracovisko.STAV.HardwareZaklTesnenia_OK THEN
			P2_StoperZaklTesnenia.Automat:= TRUE;
			P2_ZakladacTesnenia.Automat:= TRUE;
		END_IF	
		IF Safety.STAV.P2_ZonaBunky_AKTIVNA AND P2_Pracovisko.STAV.HardwareBunky_OK THEN
			P2_Dopravniky.Automat:= TRUE;
			P2_SpodnyStoper.Automat:= TRUE;
			P2_StoperMaticovacky.Automat:= TRUE;
			P2_AkumulacnyStoper.Automat:= TRUE;
			P2_StoperSrobovania.Automat:= TRUE;
			P2_Srobovanie.Automat:= TRUE;
			P2_Robot.Automat:= TRUE;
			P2_StoperZvarania.Automat:= TRUE;
			P2_Zvaranie.Automat:= TRUE;
			P2_Cistenie.Automat:= TRUE;
		END_IF	
		P2_Pracovisko.Automat:= FALSE;
	END_IF
	
	
	//***************************************************Príznaky pracoviska******************************************************//
	//Príznak pracovisko stav AUTOMAT//
	IF P2_Dopravniky.Automat OR
		P2_SpodnyStoper.Automat OR
		P2_StoperZaklTesnenia.Automat OR
		P2_ZakladacTesnenia.Automat OR
		P2_StoperMaticovacky.Automat OR
		P2_AkumulacnyStoper.Automat OR
		P2_StoperSrobovania.Automat OR
		P2_Srobovanie.Automat OR
		P2_Robot.Automat OR
		P2_StoperZvarania.Automat OR
		P2_Zvaranie.Automat OR
		P2_Cistenie.Automat THEN
		P2_Pracovisko.STAV.Automat:= TRUE;
	ELSE
		P2_Pracovisko.STAV.Automat:= FALSE;
	END_IF	
	
	//Priznak pracovisko stav MANUAL//
	IF P2_Dopravniky.Manual OR
		P2_SpodnyStoper.Manual OR
		P2_StoperZaklTesnenia.Manual OR
		P2_ZakladacTesnenia.Manual OR
		P2_StoperMaticovacky.Manual OR
		P2_AkumulacnyStoper.Manual OR
		P2_StoperSrobovania.Manual OR
		P2_Srobovanie.Manual OR
		P2_Robot.Manual OR
		P2_StoperZvarania.Manual OR
		P2_Zvaranie.Manual OR
		P2_Cistenie.Manual THEN
		P2_Pracovisko.STAV.Manual:= TRUE;
	ELSE
		P2_Pracovisko.STAV.Manual:= FALSE;
	END_IF
	
	
	//Príznak pracovisko stav PoINIT//
	IF P2_Dopravniky.STAV.PoINIT AND
		P2_SpodnyStoper.STAV.PoINIT AND
		(P2_StoperZaklTesnenia.STAV.PoINIT OR NOT P2_StoperZaklTesnenia.Automat) AND
		(P2_ZakladacTesnenia.STAV.PoINIT OR NOT P2_ZakladacTesnenia.Automat) AND
		P2_Robot.STAV.PoINIT AND
		P2_StoperMaticovacky.STAV.PoINIT AND
		P2_AkumulacnyStoper.STAV.PoINIT AND
		P2_StoperSrobovania.STAV.PoINIT AND
		P2_Srobovanie.STAV.PoINIT AND
		P2_StoperZvarania.STAV.PoINIT AND
		P2_Zvaranie.STAV.PoINIT AND
		P2_Cistenie.STAV.PoINIT THEN
		P2_Pracovisko.STAV.PoINIT:= TRUE;
	ELSE
		P2_Pracovisko.STAV.PoINIT:= FALSE;
	END_IF	
		
	
	//Príznak pracovisko stav READY//
	IF SC_P2_Dopravniky.Step = 1 AND
		SC_P2_SpodnyStoper.Step = 1 AND
		SC_P2_StoperZaklTesnenia.Step = 1 AND
		SC_P2_ZakladacTesnenia.Step = 1 AND
		SC_P2_StoperMaticovacky.Step = 1 AND
		SC_P2_AkumulacnyStoper.Step = 1 AND
		SC_P2_StoperSrobovania.Step = 1 AND
		SC_P2_Srobovanie.Step = 1 AND
		SC_P2_Robot.Step = 1 AND
		SC_P2_StoperZvarania.Step = 1 AND
		SC_P2_Zvaranie.Step = 1 AND
		SC_P2_Cistenie.Step = 1	THEN 
		P2_Pracovisko.STAV.READY:= TRUE;
	ELSE
		P2_Pracovisko.STAV.READY:= FALSE;
	END_IF
	
	//Príznak HW zakladaèa tesnenia OK//
	IF P2_Pracovisko.IN.TlakVzduchu_OK AND
		P2_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P2_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		P2_Pracovisko.IN.ServoZaklTesneniaPojazd_KomOK AND
		P2_Pracovisko.IN.ServoZaklTesneniaZdvih_KomOK AND
		P2_Pracovisko.IN.VentilovyTerminal_KomOK THEN
		P2_Pracovisko.STAV.HardwareZaklTesnenia_OK:= TRUE;
	ELSE	
		P2_Pracovisko.STAV.HardwareZaklTesnenia_OK:= FALSE;
	END_IF	
	
	
	//Príznak HW Bunky OK//
	IF P2_Pracovisko.IN.TlakVzduchu_OK AND
		P2_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P2_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		P2_Pracovisko.IN.Robot_KomOK AND
		P2_Pracovisko.IN.Maticovacka_M4_KomOK AND
		P2_Pracovisko.IN.ServoManipulatorOsX_KomOK AND
		P2_Pracovisko.IN.ServoManipulatorOsY_KomOK AND
		P2_Pracovisko.IN.ServoManipulatorOsZ_M4_KomOK AND
		P2_Pracovisko.IN.ServoZvaraniaOsZ_KomOK AND
		P2_Pracovisko.IN.Skrutkovacka_M4_KomOK AND
		P2_Pracovisko.IN.Skrutkovacka_M5_KomOK AND
		P2_Pracovisko.IN.Skrutkovacka_M6_KomOK AND
		P2_Pracovisko.IN.VentilovyTerminal_KomOK AND
		P2_Srobovanie.IN.NapajanieSkrutkovackyM4_OK AND
		P2_Srobovanie.IN.NapajanieSkrutkovackyM5_OK AND
		P2_Srobovanie.IN.NapajanieSkrutkovackyM6_OK AND
		P2_Srobovanie.IN.NapajanieVibrolistyM4_OK AND
		P2_Srobovanie.IN.NapajanieZasobnikaM6_OK AND
		P2_Srobovanie.IN.NapajanieZasobnikaM4_OK AND
		P2_Srobovanie.IN.NapajanieZasobnikaM5_OK AND
		P2_Pracovisko.IN.SmartKamera8_KomOK AND
		P3_Pracovisko.IN.Kamery_ControlUnit_KomOK AND
		P2_Pracovisko.IN.SmartKamera9_KomOK THEN
		P2_Pracovisko.STAV.HardwareBunky_OK:= TRUE;
	ELSE	
		P2_Pracovisko.STAV.HardwareBunky_OK:= FALSE;
	END_IF	
	
	//Príznak skrutkovaèky zasunuté//
	IF P2_Srobovanie.IN.Skrutkovacka_M5_ZASUNUTA AND P2_Srobovanie.IN.Skrutkovacka_M6_ZASUNUTA AND P2_Srobovanie.PAR.ManipulOsZ_M4_AktualnaPozicia < 5 THEN
		P2_Pracovisko.STAV.SkrutkovackyZasunute:= TRUE;
	ELSE
		P2_Pracovisko.STAV.SkrutkovackyZasunute:= FALSE;
	END_IF
	
	
		
	//*****************************Zapnutie osvetlenia pracoviska*********************************************************//
	P2_Pracovisko.OUT.OsvetlenieBunky_ON:= TRUE;
			
	//		
	//	P2_Pracovisko.OUT.Osvetlenie_CAM1:= TRUE;
	//	P2_Pracovisko.OUT.Osvetlenie_CAM7_CAM17:= TRUE;
	//	P2_Pracovisko.OUT.Osvetlenie_CAM10:= TRUE;
	//	P2_Pracovisko.OUT.Osvetlenie_CAM11:= TRUE;
	
	
	
	
	//****************************************Ovládanie majáka***********************************************//
	//Zelené svetlo//
    
	IF P2_Pracovisko.STAV.Automat THEN
		P2_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= TRUE;
	ELSIF P2_Pracovisko.STAV.Manual THEN
		P2_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= Blikac500ms;
	ELSE
		P2_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= FALSE;
	END_IF
		
	//Oranžové svetlo//
	IF P2_Pracovisko.STAV.Automat AND NOT P2_Pracovisko.STAV.PoINIT THEN
		P2_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= TRUE;
	ELSE
		P2_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= FALSE;
	END_IF      
        
            
        
	
	//Èervené svetlo//
	IF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P2_Pracovisko.STAV.Porucha_ST1 THEN
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P2_Pracovisko.STAV.Porucha_ST2 THEN
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P2_Pracovisko.STAV.Porucha_ST3 THEN
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P2_Pracovisko.STAV.Porucha_ST4 THEN
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P2_Pracovisko.STAV.Porucha_ST5 THEN
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;	
	ELSE
		P2_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= FALSE;
	END_IF
	
	//Zvuková signalizácia//
	IF EDGEPOS(P2_Pracovisko.STAV.Porucha_ST1) THEN
		P2_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
	ELSIF EDGEPOS(P2_Pracovisko.STAV.Porucha_ST2) THEN
		P2_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
	ELSIF EDGEPOS(P2_Pracovisko.STAV.Porucha_ST3) THEN
		P2_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
	ELSIF EDGEPOS(P2_Pracovisko.STAV.Porucha_ST4) THEN
		P2_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;	
	ELSIF EDGEPOS(P2_Pracovisko.STAV.Porucha_ST5) THEN
		P2_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;		
	END_IF
    
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

