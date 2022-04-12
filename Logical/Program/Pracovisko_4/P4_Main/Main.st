
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
		
	//Volanie podprogramu//
	ProfinetKomunikaciaKAM14;
	ProfinetKomunikaciaKAM15;
	ProfinetKomunikaciaKAM16;
	 
	
	//Odomknutie pneumatickÈho z·mku zdviûiek//
	IF Safety.STAV.P4_ZonaBunky_AKTIVNA THEN
		P4_Pracovisko.OUT.ZdvizkyPneuZamok_ODOMKNI:= TRUE;
	ELSE
		P4_Pracovisko.OUT.ZdvizkyPneuZamok_ODOMKNI:= FALSE;
	END_IF	
	
	
	
	
	
	
	//**************************************UkonËenie cyklu pracoviska****************************************************//
	IF P4_Pracovisko.KoniecCyklu THEN
		IF P4_Dopravniky.Automat THEN
			P4_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P4_SpodnyStoper.Automat THEN
			P4_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestA.Automat THEN
			P4_FunkcnyTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestB.Automat THEN
			P4_FunkcnyTestB.KoniecCyklu:= TRUE;
		END_IF	
		IF P4_ZdvizkaZaFunkcTestA.Automat THEN
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestB.Automat THEN
			P4_ZdvizkaZaFunkcTestB.KoniecCyklu:= TRUE;
		END_IF	
		IF P4_Etiketovacka.Automat THEN
			P4_Etiketovacka.KoniecCyklu:= TRUE;
		END_IF
		IF P4_Vytah.Automat THEN
			P4_Vytah.KoniecCyklu:= TRUE;
		END_IF
		P4_Pracovisko.KoniecCyklu:= FALSE;
	END_IF    
    
	
	
	//************************************UkonËenie cyklu pri poruche*****************************************//
	//ST1 - Final test A//
	IF P4_Pracovisko.STAV.Porucha_ST1 THEN
		IF P4_FunkcnyTestA.Automat THEN
			P4_FunkcnyTestA.Reset:= TRUE;
		END_IF
		IF P4_Dopravniky.Automat THEN
			P4_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P4_SpodnyStoper.Automat THEN
			P4_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestB.Automat THEN
			P4_FunkcnyTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestA.Automat THEN
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestB.Automat THEN
			P4_ZdvizkaZaFunkcTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_Etiketovacka.Automat THEN
			P4_Etiketovacka.KoniecCyklu:= TRUE;
		END_IF
	END_IF
     
	//ST2 - Final test B//
	IF P4_Pracovisko.STAV.Porucha_ST2 THEN
		IF P4_FunkcnyTestB.Automat THEN
			P4_FunkcnyTestB.Reset:= TRUE;
		END_IF
		IF P4_Dopravniky.Automat THEN
			P4_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P4_SpodnyStoper.Automat THEN
			P4_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestA.Automat THEN
			P4_FunkcnyTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestA.Automat THEN
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestB.Automat THEN
			P4_ZdvizkaZaFunkcTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_Etiketovacka.Automat THEN
			P4_Etiketovacka.KoniecCyklu:= TRUE;
		END_IF
	END_IF	
    
	
	//ST3 - Zdviûka za final testom A//
	IF P4_Pracovisko.STAV.Porucha_ST3 THEN
		IF P4_ZdvizkaZaFunkcTestA.Automat THEN
			P4_ZdvizkaZaFunkcTestA.Reset:= TRUE;
		END_IF
		IF P4_Dopravniky.Automat THEN
			P4_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P4_SpodnyStoper.Automat THEN
			P4_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestA.Automat THEN
			P4_FunkcnyTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestB.Automat THEN
			P4_FunkcnyTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestB.Automat THEN
			P4_ZdvizkaZaFunkcTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_Etiketovacka.Automat THEN
			P4_Etiketovacka.KoniecCyklu:= TRUE;
		END_IF
	END_IF 
	
	
	//ST4 - Zdviûka za final testom B//
	IF P4_Pracovisko.STAV.Porucha_ST4 THEN
		IF P4_ZdvizkaZaFunkcTestB.Automat THEN
			P4_ZdvizkaZaFunkcTestB.Reset:= TRUE;
		END_IF
		IF P4_Dopravniky.Automat THEN
			P4_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P4_SpodnyStoper.Automat THEN
			P4_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestA.Automat THEN
			P4_FunkcnyTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestB.Automat THEN
			P4_FunkcnyTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestA.Automat THEN
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_Etiketovacka.Automat THEN
			P4_Etiketovacka.KoniecCyklu:= TRUE;
		END_IF
	END_IF 
    
	
	//ST5 - Etiketovanie//
	IF P4_Pracovisko.STAV.Porucha_ST5 THEN
		IF P4_Etiketovacka.Automat THEN
			P4_Etiketovacka.Reset:= TRUE;
		END_IF
		IF P4_Dopravniky.Automat THEN
			P4_Dopravniky.KoniecCyklu:= TRUE;
		END_IF
		IF P4_SpodnyStoper.Automat THEN
			P4_SpodnyStoper.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestA.Automat THEN
			P4_FunkcnyTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_FunkcnyTestB.Automat THEN
			P4_FunkcnyTestB.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestA.Automat THEN
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= TRUE;
		END_IF
		IF P4_ZdvizkaZaFunkcTestB.Automat THEN
			P4_ZdvizkaZaFunkcTestB.KoniecCyklu:= TRUE;
		END_IF
	END_IF 
	
	
	//ST6 - V˝ùah//
	IF P4_Pracovisko.STAV.Porucha_ST6 THEN
		IF P4_Vytah.Automat THEN
			P4_Vytah.Reset:= TRUE;
		END_IF
	END_IF
	
	
	//*********************************Status prebieha ukonËenie cyklu********************************************//
	IF P4_Dopravniky.KoniecCyklu OR
		P4_SpodnyStoper.KoniecCyklu OR
		P4_FunkcnyTestA.KoniecCyklu OR
		P4_FunkcnyTestB.KoniecCyklu OR
		P4_ZdvizkaZaFunkcTestA.KoniecCyklu OR
		P4_ZdvizkaZaFunkcTestB.KoniecCyklu OR
		P4_Etiketovacka.KoniecCyklu OR
		P4_Vytah.KoniecCyklu THEN
		P4_Pracovisko.STAV.UkoncenieCyklu_BUSY:= TRUE;
	ELSE
		P4_Pracovisko.STAV.UkoncenieCyklu_BUSY:= FALSE;
	END_IF   
	
	
	//*******************************Resetovanie pracoviska po stlaËenÌ tlaËÌtka Automat******************************************//
	IF P34_Vizu.TL_RezimAutomat THEN
		IF P3_Pracovisko.STAV.Manual THEN
			P3_Pracovisko.Reset:= TRUE;
		END_IF
		IF P4_Pracovisko.STAV.Manual THEN
			P4_Pracovisko.Reset:= TRUE;
		END_IF
		P34_Vizu.TL_RezimAutomat:= FALSE;
	END_IF    
	
	//******************************************Resetovanie pracoviska************************************************************//
	IF P4_Pracovisko.Reset THEN
		P4_Dopravniky.Reset:= TRUE;
		P4_SpodnyStoper.Reset:= TRUE;
		P4_FunkcnyTestA.Reset:= TRUE;
		P4_FunkcnyTestB.Reset:= TRUE;
		P4_ZdvizkaZaFunkcTestA.Reset:= TRUE;
		P4_ZdvizkaZaFunkcTestB.Reset:= TRUE;
		P4_Etiketovacka.Reset:= TRUE;
		P4_Vytah.Reset:= TRUE;
		P4_Pracovisko.STAV.Porucha_ST1:= FALSE;
		P4_Pracovisko.STAV.Porucha_ST2:= FALSE;
		P4_Pracovisko.STAV.Porucha_ST3:= FALSE;
		P4_Pracovisko.STAV.Porucha_ST4:= FALSE;
		P4_Pracovisko.STAV.Porucha_ST5:= FALSE;
		P4_Pracovisko.STAV.Porucha_ST6:= FALSE;
		P4_Pracovisko.Reset:= FALSE;
	END_IF	
	
	
	//Prepnutie pracoviska do manualneho reûimu//
	IF P4_Pracovisko.Manual THEN
		P4_Dopravniky.Manual:= TRUE;
		P4_SpodnyStoper.Manual:= TRUE;
		P4_FunkcnyTestA.Manual:= TRUE;
		P4_FunkcnyTestB.Manual:= TRUE;
		P4_ZdvizkaZaFunkcTestA.Manual:= TRUE;
		P4_ZdvizkaZaFunkcTestB.Manual:= TRUE;
		P4_Etiketovacka.Manual:= TRUE;
		P4_Vytah.Manual:= TRUE;
		P4_Pracovisko.Manual:= FALSE;
	END_IF	
	
	
	//Spustenie pracoviska v automatickom reûime//
	IF P4_Pracovisko.Automat THEN
		IF Safety.STAV.P4_ZonaVytahu_AKTIVNA AND P4_Pracovisko.STAV.HardwareVytahu_OK THEN	
			P4_Vytah.Automat:= TRUE;
		END_IF
		IF Safety.STAV.P4_ZonaBunky_AKTIVNA AND P4_Pracovisko.STAV.HardwareBunky_OK THEN
			P4_Dopravniky.Automat:= TRUE;
			P4_SpodnyStoper.Automat:= TRUE;
			P4_FunkcnyTestA.Automat:= TRUE;
			P4_FunkcnyTestB.Automat:= TRUE;
			P4_ZdvizkaZaFunkcTestA.Automat:= TRUE;
			P4_ZdvizkaZaFunkcTestB.Automat:= TRUE;
			P4_Etiketovacka.Automat:= TRUE;
		END_IF
		P4_Pracovisko.Automat:= FALSE;
	END_IF
	
	
	
	
	//***************************************************PrÌznaky pracoviska******************************************************//
	//PrÌznak pracovisko stav AUTOMAT//
	IF P4_Dopravniky.Automat OR
		P4_SpodnyStoper.Automat OR
		P4_FunkcnyTestA.Automat OR
		P4_FunkcnyTestB.Automat OR
		P4_ZdvizkaZaFunkcTestA.Automat OR
		P4_ZdvizkaZaFunkcTestB.Automat OR
		P4_Etiketovacka.Automat OR
		P4_Vytah.Automat THEN
		P4_Pracovisko.STAV.Automat:= TRUE;
	ELSE
		P4_Pracovisko.STAV.Automat:= FALSE;
	END_IF	
	
	
	//Priznak pracovisko stav MANUAL//
	IF P4_Dopravniky.Manual OR
		P4_SpodnyStoper.Manual OR
		P4_FunkcnyTestA.Manual OR
		P4_FunkcnyTestB.Manual OR
		P4_ZdvizkaZaFunkcTestA.Manual OR
		P4_ZdvizkaZaFunkcTestB.Manual OR
		P4_Etiketovacka.Manual OR
		P4_Vytah.Manual THEN
		P4_Pracovisko.STAV.Manual:= TRUE;
	ELSE
		P4_Pracovisko.STAV.Manual:= FALSE;
	END_IF
	
	
	//PrÌznak pracovisko stav PoINIT//
	IF P4_Dopravniky.STAV.PoINIT AND
		P4_SpodnyStoper.STAV.PoINIT AND
		P4_FunkcnyTestA.STAV.PoINIT AND
		P4_FunkcnyTestB.STAV.PoINIT AND
		P4_ZdvizkaZaFunkcTestA.STAV.PoINIT AND
		P4_ZdvizkaZaFunkcTestB.STAV.PoINIT AND
		P4_Etiketovacka.STAV.PoINIT AND
		P4_Vytah.STAV.PoINIT THEN
		P4_Pracovisko.STAV.PoINIT:= TRUE;
	ELSE
		P4_Pracovisko.STAV.PoINIT:= FALSE;
	END_IF	
	
	//PrÌznak pracovisko stav READY//
	IF SC_P4_Dopravniky.Step = 1 AND
		SC_P4_SpodnyStoper.Step = 1 AND
		SC_P4_FunkcnyTestA.Step = 1 AND
		SC_P4_FunkcnyTestB.Step = 1 AND
		SC_P4_ZdvizkaZaFunkcTestA.Step = 1 AND
		SC_P4_ZdvizkaZaFunkcTestB.Step = 1 AND
		SC_P4_Etiketovacka.Step = 1 AND
		SC_P4_Vytah.Step = 1 THEN 
		P4_Pracovisko.STAV.READY:= TRUE;
	ELSE
		P4_Pracovisko.STAV.READY:= FALSE;
	END_IF
	
	//PrÌznak pracovisko stav PORUCHA//
	IF P4_Pracovisko.STAV.Porucha_ST1 OR
		P4_Pracovisko.STAV.Porucha_ST2 OR
		P4_Pracovisko.STAV.Porucha_ST3 OR
		P4_Pracovisko.STAV.Porucha_ST4 OR
		P4_Pracovisko.STAV.Porucha_ST5 OR
		P4_Pracovisko.STAV.Porucha_ST6 THEN
		P4_Pracovisko.STAV.PORUCHA:= TRUE;
	ELSE
		P4_Pracovisko.STAV.PORUCHA:= FALSE;
	END_IF	
	
	
	
	//Priznak HW Vytahu OK//
	IF P4_Pracovisko.IN.TlakVzduchu_OK AND
		P4_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P4_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		P4_Pracovisko.IN.ServoZdvihuVytahu_KomOK AND
		(*P3_Pracovisko.IN.Kamery_ControlUnit_KomOK AND*)
		P4_Pracovisko.IN.VentilovyTerminal_KomOK THEN
		P4_Pracovisko.STAV.HardwareVytahu_OK:= TRUE;
	ELSE	
		P4_Pracovisko.STAV.HardwareVytahu_OK:= FALSE;
	END_IF	
	
	//PrÌznak HW Bunky OK//
	IF P4_Pracovisko.IN.TlakVzduchu_OK AND
		P4_Pracovisko.IN.ModulFesto_IO_KomOK AND
		P4_Pracovisko.IN.ModulWeidmuller_IO_KomOK AND
		P4_Pracovisko.IN.ServoZdvihuAplikEtikiet_KomOK AND
		P4_Pracovisko.IN.SmartKamera14_KomOK AND
		(*P3_Pracovisko.IN.Kamery_ControlUnit_KomOK AND*)
		P4_Pracovisko.IN.VentilovyTerminal_KomOK THEN
		P4_Pracovisko.STAV.HardwareBunky_OK:= TRUE;
	ELSE	
		P4_Pracovisko.STAV.HardwareBunky_OK:= FALSE;
	END_IF	
	
	
	//Priznak FunkËn˝ Test A zasunuty//
	IF P4_FunkcnyTestA.IN.Centrovanie_ZASUNUTE AND P4_FunkcnyTestA.IN.HorneKontakty_ZASUNUTE AND P4_FunkcnyTestA.IN.SpodneKontakty_ZASUNUTE THEN
		P4_Pracovisko.STAV.FunkcnyTestA_Zasunuty:= TRUE;
	ELSE
		P4_Pracovisko.STAV.FunkcnyTestA_Zasunuty:= FALSE;
	END_IF	
	
	
	//Priznak FunkËn˝ Test B zasunuty//
	IF P4_FunkcnyTestB.IN.Centrovanie_ZASUNUTE AND P4_FunkcnyTestB.IN.HorneKontakty_ZASUNUTE AND P4_FunkcnyTestB.IN.SpodneKontakty_ZASUNUTE THEN
		P4_Pracovisko.STAV.FunkcnyTestB_Zasunuty:= TRUE;
	ELSE
		P4_Pracovisko.STAV.FunkcnyTestB_Zasunuty:= FALSE;
	END_IF	
	
	
	//*****************************Zapnutie osvetlenia pracoviska*********************************************************//
	P4_Pracovisko.OUT.OsvetlenieBunky_ON:= TRUE;
			
		
	//****************************************Ovl·danie maj·ka***********************************************//
	//ZelenÈ svetlo//
    
	IF P4_Pracovisko.STAV.Automat THEN
		P4_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Manual THEN
		P4_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= Blikac500ms;
	ELSE
		P4_Pracovisko.OUT.Majak_ZeleneSvetlo_ON:= FALSE;
	END_IF
		
	//OranûovÈ svetlo//
	IF P4_Pracovisko.STAV.Automat AND NOT P4_Pracovisko.STAV.PoINIT THEN
		P4_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= TRUE;
	ELSE
		P4_Pracovisko.OUT.Majak_OranzoveSvetlo_ON:= FALSE;
	END_IF      
        
            
        
	
	//»ervenÈ svetlo//
	IF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Porucha_ST1 THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Porucha_ST2 THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Porucha_ST3 THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Porucha_ST4 THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Porucha_ST5 THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSIF P4_Pracovisko.STAV.Porucha_ST6 THEN
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= TRUE;
	ELSE
		P4_Pracovisko.OUT.Majak_CerveneSvetlo_ON:= FALSE;
	END_IF
	
	//Zvukov· signaliz·cia//
//	IF EDGEPOS(P4_Pracovisko.STAV.Porucha_ST1) THEN
//		P4_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P4_Pracovisko.STAV.Porucha_ST2) THEN
//		P4_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P4_Pracovisko.STAV.Porucha_ST3) THEN
//		P4_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P4_Pracovisko.STAV.Porucha_ST4) THEN
//		P4_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;	
//	ELSIF EDGEPOS(P4_Pracovisko.STAV.Porucha_ST5) THEN
//		P4_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	ELSIF EDGEPOS(P4_Pracovisko.STAV.Porucha_ST6) THEN
//		P4_Pracovisko.OUT.Majak_Hukacka_ON:= Blikac500ms;
//	END_IF
    
	
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

