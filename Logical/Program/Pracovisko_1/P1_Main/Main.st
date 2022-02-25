
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie podprogramov//
	ProfinetKomunikaciaKAM2;
	ProfinetKomunikaciaKAM3;
	ProfinetKomunikaciaKAM4;
	ProfinetKomunikaciaKAM5;
	ProfinetKomunikaciaKAM6;
	
	
	
	
	 
		//**************************************UkonËenie cyklu pracoviska****************************************************//
	IF P1_Pracovisko.KoniecCyklu THEN
		IF P1_Dopravniky.Automat THEN
			P1_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P1_SpodnyStoper.Automat THEN
			P1_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P1_Vytah.Automat THEN
			P1_Vytah.KoniecCyklu:= TRUE;
		END_IF	
		IF P1_StoperSrobovania.Automat THEN
			P1_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P1_Srobovanie.Automat THEN
			P1_Srobovanie.KoniecCyklu:= TRUE;
		END_IF	
		IF P1_Robot.Automat THEN
			P1_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P1_AkumulacnyStoper.Automat THEN
			P1_AkumulacnyStoper.KoniecCyklu:= TRUE;
		END_IF
		P1_Pracovisko.KoniecCyklu:= FALSE;
	END_IF    
    
    
	//************************************UkonËenie cyklu pri poruche*****************************************//
	//ST1 - Vstupny v˝ùah//
	IF P1_Pracovisko.STAV.Porucha_ST1 THEN
		IF P1_Vytah.Automat THEN
			P1_Vytah.Reset:= TRUE;
		END_IF
	END_IF
     
	//ST2 - ärobovanie//
	IF P1_Pracovisko.STAV.Porucha_ST2 THEN
		IF P1_Dopravniky.Automat THEN
			P1_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P1_SpodnyStoper.Automat THEN
			P1_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P1_StoperSrobovania.Automat THEN
			P1_StoperSrobovania.Reset:= TRUE;
		END_IF
		IF P1_Srobovanie.Automat THEN
			P1_Srobovanie.Reset:= TRUE;
		END_IF	
		IF P1_Robot.Automat THEN
			P1_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P1_AkumulacnyStoper.Automat THEN
			P1_AkumulacnyStoper.KoniecCyklu:= TRUE;
		END_IF
	END_IF	
    
	//ST3 - AkumulaËn˝ stoper//
	IF P1_Pracovisko.STAV.Porucha_ST3 THEN
		IF P1_Dopravniky.Automat THEN
			P1_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P1_SpodnyStoper.Automat THEN
			P1_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P1_StoperSrobovania.Automat THEN
			P1_StoperSrobovania.KoniecCyklu:= TRUE;
		END_IF
		IF P1_Srobovanie.Automat THEN
			P1_Srobovanie.KoniecCyklu:= TRUE;
		END_IF	
		IF P1_Robot.Automat THEN
			P1_Robot.KoniecCyklu:= TRUE;
		END_IF
		IF P1_AkumulacnyStoper.Automat THEN
			P1_AkumulacnyStoper.Reset:= TRUE;
		END_IF
	END_IF	
		
	
	
	//*********************************Status prebieha ukonËenie cyklu********************************************//
	IF P1_Vytah.KoniecCyklu OR
		P1_SpodnyStoper.KoniecCyklu OR
		P1_Dopravniky.KoniecCyklu OR
		P1_StoperSrobovania.KoniecCyklu OR
		P1_Srobovanie.KoniecCyklu OR
		P1_Robot.KoniecCyklu OR
		P1_AkumulacnyStoper.KoniecCyklu THEN
		P1_Pracovisko.STAV.UkoncenieCyklu_BUSY:= TRUE;
	ELSE
		P1_Pracovisko.STAV.UkoncenieCyklu_BUSY:= FALSE;
	END_IF   
    
    
    
    
    
	//*******************************Resetovanie pracoviska po stlaËenÌ tlaËÌtka Automat******************************************//
	IF P1_Vizu.TL_RezimAutomat THEN
		IF P1_Pracovisko.STAV.Manual THEN
			P1_Pracovisko.Reset:= TRUE;
		END_IF    
		P1_Vizu.TL_RezimAutomat:= FALSE;
	END_IF    

	//******************************************Resetovanie pracoviska************************************************************//
	IF P1_Pracovisko.Reset THEN
		P1_Vytah.Reset:= TRUE;
		P1_SpodnyStoper.Reset:= TRUE;
		P1_Dopravniky.Reset:= TRUE;
		P1_StoperSrobovania.Reset:= TRUE;
		P1_Srobovanie.Reset:= TRUE;
		P1_Robot.Reset:= TRUE;
		P1_AkumulacnyStoper.Reset:= TRUE;
		P1_Pracovisko.Reset:= FALSE;
	END_IF	
	
	//Prepnutie pracoviska do manualneho reûimu//
	IF P1_Pracovisko.Manual THEN
		P1_Vytah.Manual:= TRUE;
		P1_SpodnyStoper.Manual:= TRUE;
		P1_Dopravniky.Manual:= TRUE;
		P1_StoperSrobovania.Manual:= TRUE;
		P1_Srobovanie.Manual:= TRUE;
		P1_Robot.Manual:= TRUE;
		P1_AkumulacnyStoper.Manual:= TRUE;
		P1_Pracovisko.Manual:= FALSE;
	END_IF	
	
	
	//Spustenie pracoviska v automatickom reûime//
	IF P1_Pracovisko.Automat THEN
		P1_SpodnyStoper.Automat:= TRUE;
		IF Safety.STAV.P1_ZonaVytahu_AKTIVNA AND P1_Pracovisko.STAV.HardwareVytahu_OK THEN	
			P1_Vytah.Automat:= TRUE;
		END_IF
		IF Safety.STAV.P1_ZonaBunky_AKTIVNA AND P1_Pracovisko.STAV.HardwareBunky_OK THEN
			P1_Dopravniky.Automat:= TRUE;
			P1_StoperSrobovania.Automat:= TRUE;
			P1_Srobovanie.Automat:= TRUE;
			P1_Robot.Automat:= TRUE;
			P1_AkumulacnyStoper.Automat:= TRUE;
		END_IF
		P1_Pracovisko.Automat:= FALSE;
	END_IF
	
	
	//***************************************************PrÌznaky pracoviska******************************************************//
	//PrÌznak pracovisko stav AUTOMAT//
	IF P1_Vytah.Automat OR
		P1_SpodnyStoper.Automat OR
		P1_Dopravniky.Automat OR
		P1_StoperSrobovania.Automat OR
		P1_Srobovanie.Automat OR
		P1_Robot.Automat OR
		P1_AkumulacnyStoper.Automat THEN
		P1_Pracovisko.STAV.Automat:= TRUE;
	ELSE
		P1_Pracovisko.STAV.Automat:= FALSE;
	END_IF	
	
	//Priznak pracovisko stav MANUAL//
	IF P1_Vytah.Manual OR
		P1_SpodnyStoper.Manual OR
		P1_Dopravniky.Manual OR
		P1_StoperSrobovania.Manual OR
		P1_Srobovanie.Manual OR
		P1_Robot.Manual OR
		P1_AkumulacnyStoper.Manual THEN
		P1_Pracovisko.STAV.Manual:= TRUE;
	ELSE
		P1_Pracovisko.STAV.Manual:= FALSE;
	END_IF
	
	
	//PrÌznak pracovisko stav PoINIT//
	IF P1_Vytah.STAV.PoINIT AND
		P1_SpodnyStoper.STAV.PoINIT AND
		P1_Dopravniky.STAV.PoINIT AND
		P1_StoperSrobovania.STAV.PoINIT AND
		P1_Srobovanie.STAV.PoINIT AND
		P1_Robot.STAV.PoINIT AND
		P1_AkumulacnyStoper.STAV.PoINIT THEN
		P1_Pracovisko.STAV.PoINIT:= TRUE;
	ELSE
		P1_Pracovisko.STAV.PoINIT:= FALSE;
	END_IF	
		
	
	//PrÌznak pracovisko stav READY//
	IF SC_P1_Vytah.Step = 1 AND
		SC_P1_SpodnyStoper.Step = 1 AND
		SC_P1_Dopravniky.Step = 1 AND
		SC_P1_StoperSrobovania.Step = 1 AND
		SC_P1_Srobovanie.Step = 1 AND
		SC_P1_Robot.Step = 1 AND
		SC_P1_AkumulacnyStoper.Step = 1 THEN 
		P1_Pracovisko.STAV.READY:= TRUE;
	ELSE
		P1_Pracovisko.STAV.READY:= FALSE;
	END_IF
	

	//Priznak HW Vytahu OK//
	IF P1_Pracovisko.IN.TlakVzduchu_OK AND
		P1_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P1_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		P1_Pracovisko.IN.ServoZdvihuVytahu_KomOK AND
		P1_Pracovisko.IN.SmartKamera3_KomOK AND
		P1_Pracovisko.IN.SmartKamera5_KomOK AND
		P3_Pracovisko.IN.Kamery_ControlUnit_KomOK AND
		P1_Pracovisko.IN.VentilovyTerminal_KomOK THEN
		P1_Pracovisko.STAV.HardwareVytahu_OK:= TRUE;
	ELSE	
		P1_Pracovisko.STAV.HardwareVytahu_OK:= FALSE;
	END_IF	
	
	
	//PrÌznak HW Bunky OK//
	IF P1_Pracovisko.IN.TlakVzduchu_OK AND
		P1_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P1_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		P1_Pracovisko.IN.Robot_KomOK AND
		P1_Pracovisko.IN.ServoManipulatorOsX_KomOK AND
		P1_Pracovisko.IN.ServoManipulatorOsY_KomOK AND
		P1_Pracovisko.IN.ServoManipulatorOsZ_M4_KomOK AND
		P1_Pracovisko.IN.ServoManipulatorOsZ_M5_KomOK AND
		P1_Pracovisko.IN.Skrutkovacka_K30_KomOK AND
		P1_Pracovisko.IN.Skrutkovacka_M4_KomOK AND
		P1_Pracovisko.IN.Skrutkovacka_M5_KomOK AND
		P3_Pracovisko.IN.Kamery_ControlUnit_KomOK AND
		P1_Pracovisko.IN.VentilovyTerminal_KomOK THEN
		P1_Pracovisko.STAV.HardwareBunky_OK:= TRUE;
	ELSE	
		P1_Pracovisko.STAV.HardwareBunky_OK:= FALSE;
	END_IF	
		
		
		
	
	//PrÌznak skrutkovaËky zasunutÈ//
	IF P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA AND P1_Srobovanie.PAR.ManipulOsZ_M4_AktualnaPozicia < 5 AND P1_Srobovanie.PAR.ManipulOsZ_M5_AktualnaPozicia < 5 THEN
		P1_Pracovisko.STAV.SkrutkovackyZasunute:= TRUE;
	ELSE
		P1_Pracovisko.STAV.SkrutkovackyZasunute:= FALSE;
	END_IF	
	
		
	//*****************************Zapnutie osvetlenia pracoviska*********************************************************//
	P1_Pracovisko.OUT.OsvetlenieBunky_ON:= TRUE;
		
	//	P2_Pracovisko.OUT.Osvetlenie_CAM1:= TRUE;
	//	P2_Pracovisko.OUT.Osvetlenie_CAM7_CAM17:= TRUE;
	//	P2_Pracovisko.OUT.Osvetlenie_CAM10:= TRUE;
	//	P2_Pracovisko.OUT.Osvetlenie_CAM11:= TRUE;
	
	
	
	
	//****************************************Ovl·danie maj·ka***********************************************//
	//ZelenÈ svetlo//
	IF P1_Pracovisko.STAV.Automat THEN
		P1_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= TRUE;
	ELSIF P1_Pracovisko.STAV.Manual THEN
		P1_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= Blikac500ms;
	ELSE
		P1_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= FALSE;
	END_IF
		
	//OranûovÈ svetlo//
	IF P1_Pracovisko.STAV.Automat AND NOT P1_Pracovisko.STAV.PoINIT THEN
		P1_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= TRUE;
	ELSE
		P1_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= FALSE;
	END_IF      
        
           
	
	//»ervenÈ svetlo//
	IF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P1_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P1_Pracovisko.STAV.Porucha_ST1 THEN
		P1_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P1_Pracovisko.STAV.Porucha_ST2 THEN
		P1_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P1_Pracovisko.STAV.Porucha_ST3 THEN
		P1_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSE
		P1_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= FALSE;
	END_IF
	
	//Zvukov· signaliz·cia//
	IF EDGEPOS(P1_Pracovisko.STAV.Porucha_ST1) THEN
		P1_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
	ELSIF EDGEPOS(P1_Pracovisko.STAV.Porucha_ST2) THEN
		P1_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
	ELSIF EDGEPOS(P1_Pracovisko.STAV.Porucha_ST3) THEN
		P1_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
	END_IF
    
		
	
	 
END_PROGRAM

PROGRAM _EXIT
		(* Insert code here *)
	 
END_PROGRAM



