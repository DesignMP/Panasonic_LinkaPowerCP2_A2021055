
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
    //Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_StoperMaticovacky);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	IOLinkKomunikacia;
	AtlasCopcoKomunikacia;
	
	
	//Reset sekcie //
	IF P2_StoperMaticovacky.Reset THEN
		SC_P2_StoperMaticovacky.Step:= 0;
		P2_StoperMaticovacky.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN	
		SC_P2_StoperMaticovacky.Step:= 0;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		SC_P2_StoperMaticovacky.Step:= 0;
	END_IF	
	
	
	//Zrušenie podania matice//
	IF P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu AND P2_StoperMaticovacky.SkrutSet_MaticaM4.STAV.MaticaPripravena THEN
		P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu:= FALSE;
	ELSIF P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu AND P2_StoperMaticovacky.SkrutSet_MaticaM4.STAV.ERROR THEN
		P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu:= FALSE;
		P2_Alarmy[298]:= TRUE;
		P2_Pracovisko.STAV.Porucha_ST2:= TRUE;	
	END_IF
			

	
	
	
	CASE SC_P2_StoperMaticovacky.Step OF 
	
		0:
			SC_P2_StoperMaticovacky.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			P2_StoperMaticovacky.Automat:= FALSE;
			P2_StoperMaticovacky.KoniecCyklu:= FALSE;
			P2_StoperMaticovacky.Manual:= FALSE;
			P2_StoperMaticovacky.STAV.PoINIT:= FALSE;
			P2_StoperMaticovacky.OUT.ZasunStoper:= FALSE;
			P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN:= FALSE;
			P2_StoperMaticovacky.OUT.Maticovacka_M4_Odvzdusn_ON:= FALSE;
			P2_StoperMaticovacky.OUT.Maticovacka_M4_Prisavanie_ON:= FALSE;
			P2_StoperMaticovacky.RFID_hlava.PrecitajChipRFID:= FALSE;
			P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.RR_ZapniZasobnik:= FALSE;
			P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu:= FALSE;
			P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.ENABLE:= FALSE;
			P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.RucnyRezim:= FALSE;
			P2_StoperMaticovacky.Maticovacka_M4.RESET_Poruchy:= FALSE;
			P2_StoperMaticovacky.Maticovacka_M4.RESET_Vysledkov:= FALSE;
			P2_StoperMaticovacky.Maticovacka_M4.START_Skrutkovania:= FALSE;
			P2_StoperMaticovacky.Maticovacka_M4.START_Utahovania:= FALSE;
			CAM9.CMD.Triger:= FALSE;
			CAM9.STAV.Results_READY:= FALSE;
			FTP_CAM9.CMD.OdosliFotku:= FALSE;
			FTP_CAM9.CMD.VymazFotku:= FALSE;
			TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P2_Maticovacka_ST4.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P2_Maticovacka_ST4.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			P2_StoperMaticovacky.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_StoperZaklTesnenia.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_Maticov_KAM_Result_Ignoruj:= FALSE;
			TestovaciKus:= FALSE;
			CisloFotky:= 0;
			P2_Maticov_KAM_Result_OK:= FALSE;
			P2_Maticov_KAM_Result_NG:= FALSE;
			P2_Vizu.ZobrazHL1_ST4:= FALSE;
			P2_Vizu.ZobrazHL2_ST4:= FALSE;
			P2_Vizu.ZobrazHL3_ST4:= FALSE;
			TRCB_P2_Maticov_OpatovnyDopyt:= FALSE;
			TRCB_P2_Maticov_PaletkaNG:= FALSE;
			VysunutieSkrutkovacky_OK:= FALSE;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CasSrobovania:= 0;
            
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND 
				Safety.STAV.P2_ZonaBunky_AKTIVNA AND
				P2_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND
				NOT P2_Pracovisko.STAV.Porucha_ST5 THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 1;
			END_IF
	
		1:
			SC_P2_StoperMaticovacky.StepName:='1 - Cakam na spustenie vyroby';
			P2_StoperMaticovacky.KoniecCyklu:= FALSE;
			IF P2_StoperMaticovacky.Automat THEN
				SC_P2_StoperMaticovacky.Step:= 2;
			ELSIF P2_StoperMaticovacky.Manual THEN
				SC_P2_StoperMaticovacky.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
	
		2:
			SC_P2_StoperMaticovacky.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#4s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			
			P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN:= FALSE;
			
            
									
			IF P2_StoperMaticovacky.IN.Maticovacka_M4_ZASUNUTA AND P2_Dopravniky.STAV.PoINIT THEN
				P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.ENABLE:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 3;
			END_IF
		
		3:	
			SC_P2_StoperMaticovacky.StepName:='3 - Inicializacia - vymazanie adresara kamery';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#4s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;	
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 10;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				FTP_CAM9.CMD.VymazFotku:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
			
					
			IF FTP_CAM9.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM9.CMD.VymazFotku:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 10;
			ELSIF FTP_CAM9.STATUS.KomunikaciaError THEN
				P2_Alarmy[229]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
					
		
				
				
		10:
			SC_P2_StoperMaticovacky.StepName:='10 - Inicializacia - zasunutie centrovacky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#4s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperMaticovacky.IN.Centrovanie_ZASUNUTE AND P2_Dopravniky.STAV.PoINIT THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 12;
			END_IF	
			
		12:
			SC_P2_StoperMaticovacky.StepName:='12 - Inicializacia - kontrola matice v maticovacke';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 AND NOT P2_StoperMaticovacky.SkrutSet_MaticaM4.STAV.MaticaPripravena THEN
				P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
			
			IF P2_StoperMaticovacky.SkrutSet_MaticaM4.STAV.MaticaPripravena THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 13;
			END_IF
			
			
			
		13:
			SC_P2_StoperMaticovacky.StepName:='13 - Inicializacia - hladanie paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
	
			IF P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 20;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 100;
			END_IF
		
			
			
		20:
			SC_P2_StoperMaticovacky.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			SC_P2_StoperMaticovacky.IdleTime.IN:= P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky;
		
          							
			IF SC_P2_StoperMaticovacky.IdleTime.Q AND NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF P2_StoperMaticovacky.RFID_hlava.Stav_CitanieZapis_OK AND P2_StoperMaticovacky.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P2_StoperMaticovacky.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperMaticovacky.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 23;
			END_IF	
			
			
			
			
			
			
		23:
			SC_P2_StoperMaticovacky.StepName:='23 - Inicializacia - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#1s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P2_StoperMaticovacky.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 30;
			ELSE
				P2_Alarmy[211]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
		
			
		30:
			SC_P2_StoperMaticovacky.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560; 
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_4' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_4' THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_4' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 33; 
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_4' THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;     
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			END_IF	
		
		           
            
            
		33:
			SC_P2_StoperMaticovacky.StepName:='33 - Inicializacia - rozhodnutie podla typu modelu';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;		
				
			
			IF Linka.PAR.ZvolenyModel = '5H' THEN 
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 35;
			ELSE 
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;   
				SC_P2_StoperMaticovacky.Step:= 560;         
			END_IF		 
			
		35:
			SC_P2_StoperMaticovacky.StepName:='35 - Inicializacia - kontrola uzavretia komunikacie';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			ELSE
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 38;
			END_IF	
		
		
            
			
		38:
			SC_P2_StoperMaticovacky.StepName:='38 - Inicializacia - kontrola odoslania fotiek';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.OdoslanieFotiek_DONE THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 550;
			ELSE
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 40;
			END_IF 
			
		40:
			SC_P2_StoperMaticovacky.StepName:='43 - Inicializacia - zacentrovanie paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperMaticovacky.IN.Centrovanie_VYSUNUTE THEN
				CAM9.STAV.Results_READY:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 45;
			END_IF	
            
		45:
			SC_P2_StoperMaticovacky.StepName:='45 - Inicializacia - vstupna kamerova kontrola paletky CAM9';//CAM 9//
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF Linka.P2_Kamery_OFF THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 135;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				CAM9.CMD.Triger:= TRUE;
				SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
		
			IF CAM9.STAV.Results_READY THEN
				PocetTrigrovKamery:= 0;
				CAM9.STAV.Results_READY:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 50;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM9.STAV.Results_READY:= FALSE;
				CAM9.CMD.Triger:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 48;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[294]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
		
            
            
            
                  
            
            
            
		48:
			SC_P2_StoperMaticovacky.StepName:='48 - Inicializacia - cakam na opatovny triger kamery CAM9';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#1s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperMaticovacky.IdleTime.Q THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 45;
			END_IF
            
            
		
		50:
			SC_P2_StoperMaticovacky.StepName:='50 - Inicializacia - vysledok kamerovej kontroly paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
		
			IF NOT CAM9.STAV.BUSY AND SC_P2_StoperMaticovacky.IdleTime.Q THEN
				CAM9.CMD.Triger:= FALSE;
				IF CAM9.RESULT.PowerCP.NepritomMatice AND
					CAM9.RESULT.PowerCP.PritomnBusbaru_5H THEN
					CAM9.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 53;
				ELSE	
					CAM9.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 53;	
				END_IF
			END_IF
	
		53:
			SC_P2_StoperMaticovacky.StepName:='53 - Inicializacia - vymazanie fotky CAM9';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 55;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				FTP_CAM9.CMD.VymazFotku:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM9.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM9.CMD.VymazFotku:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 55;
			ELSIF FTP_CAM9.STATUS.KomunikaciaError THEN
				P2_Alarmy[229]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
            
            
		55:
			SC_P2_StoperMaticovacky.StepName:='55 - Inicializacia - rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
            
				
			IF CAM9.PAR.ResultFotky = 'PASS' THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 135;
			ELSIF CAM9.PAR.ResultFotky = 'FAIL' THEN
				P2_StoperMaticovacky.STAV.PoINIT:= TRUE;
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 540;
			END_IF    
            
          
        
			
			
		
		//********************************************************Automatický režim****************************************************************************//
	
		100:  
			SC_P2_StoperMaticovacky.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		         
            
			SC_P2_StoperMaticovacky.IdleTime.IN:= P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky;
			
			IF P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky THEN
				P2_StoperZaklTesnenia.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			           
            
			IF P2_StoperMaticovacky.KoniecCyklu THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 0;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 101;
			END_IF
		
		101:
			SC_P2_StoperMaticovacky.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#500ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
		
			          							
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF P2_StoperMaticovacky.RFID_hlava.Stav_CitanieZapis_OK AND P2_StoperMaticovacky.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P2_StoperMaticovacky.RFID_hlava.PrecitaneCisloPaletky;
				P2_StoperMaticovacky.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 102;
			END_IF	
			
			          
				
		102:
			SC_P2_StoperMaticovacky.StepName:='102 - Automaticky Rezim - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#1s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P2_StoperMaticovacky.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 103;
			ELSE
				P2_Alarmy[211]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
		
			
		103:
			SC_P2_StoperMaticovacky.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
					
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560; 
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_4' THEN
				TestovaciKus:= TRUE;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_4' THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_4' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 108; 
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_4' THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;     
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 108;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			END_IF	
			
	
			
			
		108:
			SC_P2_StoperMaticovacky.StepName:='108 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;		
			
			
			IF Linka.PAR.ZvolenyModel = '5H' THEN 
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 110;
			ELSE 
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;   //Paletka iba prechádza 
				SC_P2_StoperMaticovacky.Step:= 560;         
			END_IF		
			
		
		110:
			SC_P2_StoperMaticovacky.StepName:='110 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 118;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 111;
			ELSIF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaError THEN	
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 115;
			END_IF
		
			
		111:
			SC_P2_StoperMaticovacky.StepName:='111 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 111;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 111;	
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 111;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 111;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 111;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 111;
				END_IF   
			END_IF
		
		
		113:
			SC_P2_StoperMaticovacky.StepName:='113 - Automaticky Rezim - vyziadanie stavu paletky zo servera'; 
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;	
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;	
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 114;
			ELSIF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaError THEN	
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 115;
			END_IF	
			
			
			
		114:
			SC_P2_StoperMaticovacky.StepName:='114 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Maticovacka_ST4.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST4' THEN
						SC_P2_StoperMaticovacky.ResetStep:= TRUE;
						SC_P2_StoperMaticovacky.Step:= 118;
					END_IF 
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 115;
				END_IF	
			END_IF
				
	
		115:
			SC_P2_StoperMaticovacky.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;		
            
            
			P2_Vizu.ZobrazHL3_ST4:= TRUE;
            
			IF TRCB_P2_Maticov_OpatovnyDopyt THEN
				TRCB_P2_Maticov_OpatovnyDopyt:= FALSE; 
				P2_Vizu.ZobrazHL3_ST4:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 110;
			ELSIF TRCB_P2_Maticov_PaletkaNG THEN
				TRCB_P2_Maticov_PaletkaNG:= FALSE;
				P2_Vizu.ZobrazHL3_ST4:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			END_IF    
		
	
		118:
			SC_P2_StoperMaticovacky.StepName:='118 - Automaticky Rezim - zacentrovanie paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperMaticovacky.IN.Centrovanie_VYSUNUTE THEN
				CAM9.STAV.Results_READY:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 120;
			END_IF		
			
		
			
		120:		
			SC_P2_StoperMaticovacky.StepName:='120 - Automaticky Rezim - vstupna kamerova kontrola paletky CAM9';//CAM 9//
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 130;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				CAM9.CMD.Triger:= TRUE;
				SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
		
			IF CAM9.STAV.Results_READY THEN
				PocetTrigrovKamery:= 0;
				CAM9.STAV.Results_READY:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 125;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM9.STAV.Results_READY:= FALSE;
				CAM9.CMD.Triger:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 123;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[294]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;    
			END_IF	
	
            
                       
            
		123:
			SC_P2_StoperMaticovacky.StepName:='123 - Automaticky Rezim - cakam na opatovny triger kamery CAM9';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#1s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperMaticovacky.IdleTime.Q THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 120;
			END_IF
            
                  
		
		125:
			SC_P2_StoperMaticovacky.StepName:='125 - Automaticky Rezim - vysledok kamerovej kontroly paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
		
			IF NOT CAM9.STAV.BUSY AND SC_P2_StoperMaticovacky.IdleTime.Q THEN
				CAM9.CMD.Triger:= FALSE;
				IF CAM9.RESULT.PowerCP.NepritomMatice AND
					CAM9.RESULT.PowerCP.PritomnBusbaru_5H THEN
					CAM9.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 128;
				ELSE	
					CAM9.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 128;	
				END_IF
			END_IF
	
            
		128:
			SC_P2_StoperMaticovacky.StepName:='128 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
							
			IF CAM9.PAR.ResultFotky = 'PASS' THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 130;
			ELSIF CAM9.PAR.ResultFotky = 'FAIL' THEN
				P2_Vizu.ZobrazHL1_ST4:= TRUE;
				IF P2_Maticov_KAM_Result_OK THEN 
					P2_Maticov_KAM_Result_OK:= FALSE;
					P2_Vizu.ZobrazHL1_ST4:= FALSE;
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 130;
				ELSIF P2_Maticov_KAM_Result_NG THEN
					P2_Maticov_KAM_Result_NG:= FALSE;
					P2_Vizu.ZobrazHL1_ST4:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 540;
				END_IF
			END_IF    
          
                    
		
		130:
			SC_P2_StoperMaticovacky.StepName:='130 - Automaticky Rezim - vymazanie fotky CAM9';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 132;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				FTP_CAM9.CMD.VymazFotku:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
			
			IF FTP_CAM9.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM9.CMD.VymazFotku:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 132;
			ELSIF FTP_CAM9.STATUS.KomunikaciaError THEN
				P2_Alarmy[229]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
		132:
			SC_P2_StoperMaticovacky.StepName:='132 - Automaticky Rezim - vymazanie vysledkov skrutkovania matice M4';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#2s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.Maticovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_StoperMaticovacky.Maticovacka_M4.Stav_VysledokUtahovania_NG AND NOT P2_StoperMaticovacky.Maticovacka_M4.Stav_VysledokUtahovania_OK THEN
				P2_StoperMaticovacky.Maticovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 133;
			END_IF	
	
		133:
			SC_P2_StoperMaticovacky.StepName:='133 - Automaticky Rezim - kontrola matice M4 v skrutkovacke';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#2s;
                       
					
			IF P2_StoperMaticovacky.SkrutSet_MaticaM4.STAV.MaticaPripravena THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 136;
			ELSIF SC_P2_StoperMaticovacky.AlarmTime.Q THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 135;
			END_IF	
			
		135:
			SC_P2_StoperMaticovacky.StepName:='135 - Automaticky Rezim - nabitie matice do maticovacky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
			
			IF P2_StoperMaticovacky.SkrutSet_MaticaM4.STAV.MaticaPripravena THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 133;
			END_IF
			
		136:
			SC_P2_StoperMaticovacky.StepName:='136 - Automaticky Rezim - kontrola stavu skrutkovacky matic M4';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#2s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF P2_StoperMaticovacky.Maticovacka_M4.Stav_READY_to_START AND Safety.STAV.P2_ZonaMaticovacky_AKTIVNA THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 138;
			END_IF	
			
			
			
		138:
			SC_P2_StoperMaticovacky.StepName:='138 - Automaticky Rezim - start skrutkovania matic M4';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#2s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			SC_P2_StoperMaticovacky.AlarmTime.IN:= (P2_StoperMaticovacky.PAR.Maticov_M4_AktualHodnVysunutia < 5);
            
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.OUT.Maticovacka_M4_Prisavanie_ON:= TRUE;
				P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN:= TRUE;
				P2_StoperMaticovacky.Maticovacka_M4.START_Utahovania:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P2_StoperMaticovacky.Maticovacka_M4.Stav_UtahovanieUkoncene AND P2_StoperMaticovacky.PAR.Maticov_M4_AktualHodnVysunutia > 5 THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 139;
			ELSIF SC_P2_StoperMaticovacky.AlarmTime.Q THEN
				P2_Alarmy[267]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
		139:
			SC_P2_StoperMaticovacky.StepName:='139 - Automaticky Rezim - cakam na ukoncenie skrutkovania matic M4';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#30s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
			SC_P2_StoperMaticovacky.AlarmTime.IN:= TRUE;
            
						
			IF P2_StoperMaticovacky.Maticovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_StoperMaticovacky.Maticovacka_M4.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_StoperMaticovacky.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_MaticaM4:= UINT_TO_STRING(P2_StoperMaticovacky.PAR.Maticov_M4_AktualHodnVysunutia); 
				Reports.Skrutkovacky.CasSkrutkovania.P2_MaticaM4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 140;
			ELSIF SC_P2_StoperMaticovacky.AlarmTime.Q THEN
				P2_Alarmy[267]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
				
		140:
			SC_P2_StoperMaticovacky.StepName:='140 - Automaticky Rezim - zasunutie skrutkovacky matic M4 a vypnutie prisavania matice';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN:= FALSE;
				P2_StoperMaticovacky.OUT.Maticovacka_M4_Prisavanie_ON:= FALSE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF P2_StoperMaticovacky.IN.Maticovacka_M4_ZASUNUTA THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 143;
			END_IF
		
		
		143:
			SC_P2_StoperMaticovacky.StepName:='143 - Automaticky Rezim - nabitie matice do maticovacky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#500ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_StoperMaticovacky.SkrutSet_MaticaM4.CMD.PodajMaticu:= TRUE;
				SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF SC_P2_StoperMaticovacky.IdleTime.Q THEN
				IF Linka.P2_SkrutkovanieResult_OFF THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 148;
				ELSE	
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 145;
				END_IF	
			END_IF
	
				
			
	
		145:
			SC_P2_StoperMaticovacky.StepName:='145 - Automaticky Rezim - kontrola vysledkov skrutkovania matice M4';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
                       
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_MaticaM4:= REAL_TO_STRING(P2_StoperMaticovacky.STAV.Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_MaticaM4:= REAL_TO_STRING(P2_StoperMaticovacky.STAV.Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P2_MaticaM4:= REAL_TO_STRING(P2_StoperMaticovacky.STAV.DosiahnutyMoment_REAL); 
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_MaticaM4:= UDINT_TO_STRING(P2_StoperMaticovacky.STAV.Uhol_ToleranciaMIN);
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_MaticaM4:= UDINT_TO_STRING(P2_StoperMaticovacky.STAV.Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_MaticaM4:= UDINT_TO_STRING(P2_StoperMaticovacky.STAV.DosiahnutyUhol);
            
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				P2_Maticovacka_5H_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P2_MaticaM4);
				IF (P2_Maticovacka_5H_Vysunutie <= P2_RemPremenne.P2_Maticovacka_Vysunutie_HI) AND (P2_Maticovacka_5H_Vysunutie >= P2_RemPremenne.P2_Maticovacka_Vysunutie_LO)THEN
					VysunutieSkrutkovacky_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovacky_OK:= FALSE;
				END_IF 
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF  
            
            
            
			IF P2_StoperMaticovacky.Maticovacka_M4.Stav_VysledokUtahovania_OK THEN
				IF VysunutieSkrutkovacky_OK THEN
					Reports.Skrutkovacky.VyslednyReport.P2_MaticaM4:= 'PASS';
					CAM9.STAV.Results_READY:= FALSE;
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 148;
				ELSE
					Paletka[i].STAV.StavPaletky:= 'NG';
					Reports.Skrutkovacky.VyslednyReport.P2_MaticaM4:= 'FAIL'; 
					IF P2_Maticov_MaticaM4_Result_OFF THEN
						CAM9.STAV.Results_READY:= FALSE;
						SC_P2_StoperMaticovacky.ResetStep:= TRUE;
						SC_P2_StoperMaticovacky.Step:= 148;
					ELSE
						CAM9.STAV.Results_READY:= FALSE;
						Paletka[i].PAR.StavPowerCP:= 'FAIL';
						Paletka[i].STAV.StavPaletky:= 'NG';
						SC_P2_StoperMaticovacky.ResetStep:= TRUE;
						SC_P2_StoperMaticovacky.Step:= 545;         
					END_IF		
				END_IF
			ELSIF P2_StoperMaticovacky.Maticovacka_M4.Stav_VysledokUtahovania_NG THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				Reports.Skrutkovacky.VyslednyReport.P2_MaticaM4:= 'FAIL';
				IF P2_Maticov_MaticaM4_Result_OFF THEN
					CAM9.STAV.Results_READY:= FALSE;
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 148;
				ELSE
					CAM9.STAV.Results_READY:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 545;         
				END_IF		
			END_IF		
			
		148:
			SC_P2_StoperMaticovacky.StepName:='148 - Automaticky Rezim - kamerova kontrola paletky CAM9'; //CAM 9//
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF Linka.P2_Kamery_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 540;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				CAM9.CMD.Triger:= TRUE;
				SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF	
		
			IF CAM9.STAV.Results_READY THEN
				PocetTrigrovKamery:= 0;
				CAM9.STAV.Results_READY:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 153;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q AND PocetTrigrovKamery < 5 THEN
				PocetTrigrovKamery:= PocetTrigrovKamery + 1;
				CAM9.STAV.Results_READY:= FALSE;
				CAM9.CMD.Triger:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 150;
			ELSIF SC_P2_StoperMaticovacky.IdleTime.Q AND PocetTrigrovKamery >= 5 THEN
				P2_Alarmy[294]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;    
			END_IF
		
                      
            
            
		150:
			SC_P2_StoperMaticovacky.StepName:='150 - Automaticky Rezim - cakam na opatovny triger kamery CAM9';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#1s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
            
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
            
			IF SC_P2_StoperMaticovacky.IdleTime.Q THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 148;
			END_IF
            
            
            
			
		153:
			SC_P2_StoperMaticovacky.StepName:='153 - Automaticky Rezim - vysledok kamerovej kontroly paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			SC_P2_StoperMaticovacky.IdleTime.IN:= TRUE;
		
			IF NOT CAM9.STAV.BUSY AND SC_P2_StoperMaticovacky.IdleTime.Q THEN		
				CAM9.CMD.Triger:= FALSE;
				IF NOT CAM9.RESULT.PowerCP.NepritomMatice AND 
					CAM9.RESULT.PowerCP.PritomnBusbaru_5H THEN
					CAM9.PAR.ResultFotky:= 'PASS';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 155;
				ELSE	
					CAM9.PAR.ResultFotky:= 'FAIL';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 155;		
				END_IF
			END_IF
			
	
			
		155:
			SC_P2_StoperMaticovacky.StepName:='155 - Automaticky Rezim - rozhodnutie podla kamerovej kontroly paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
								
			IF CAM9.PAR.ResultFotky = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 540;
			ELSIF CAM9.PAR.ResultFotky = 'FAIL' THEN   
				P2_Vizu.ZobrazHL2_ST4:= TRUE;
				IF P2_Maticov_KAM_Result_OK THEN
					P2_Maticov_KAM_Result_OK:= FALSE;
					P2_Vizu.ZobrazHL2_ST4:= FALSE;
					CAM9.PAR.ResultFotky:= 'PASS';
					Paletka[i].PAR.StavPowerCP:= 'PASS';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 540;
				ELSIF P2_Maticov_KAM_Result_NG THEN
					P2_Maticov_KAM_Result_NG:= FALSE;
					P2_Vizu.ZobrazHL2_ST4:= FALSE;
					Paletka[i].PAR.StavPowerCP:= 'FAIL';
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 540;
				END_IF	
			END_IF
			
		
		
			//*********************************Odoslanie fotiek na server******************************//			
			
		540:
			SC_P2_StoperMaticovacky.StepName:='540 - Automaticky Rezim - odoslanie fotiek na server';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_FTP_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 545; 
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				FTP_CAM9.INPUTS.QRkodPowerCP:= Paletka[i].PAR.QRkodPowerCP;
				CisloFotky:= CisloFotky + 1;
				FTP_CAM9.INPUTS.IndexFotky:= USINT_TO_STRING(CisloFotky);
				FTP_CAM9.INPUTS.Result:= CAM9.PAR.ResultFotky;
				Reports.Kamery.P2_CAM9_KontrolaPaletky:= CAM9.PAR.ResultFotky;	
			    FTP_CAM9.CMD.OdosliFotku:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
          
			
			IF FTP_CAM9.STATUS.KomunikaciaUkoncena THEN
				FTP_CAM9.CMD.OdosliFotku:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 545; 
			ELSIF FTP_CAM9.STATUS.KomunikaciaError THEN
				P2_Alarmy[229]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
				
		
			
			//*********************************Odcentrovanie paletky*****************************************//			
				
		545:
			SC_P2_StoperMaticovacky.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
		
			IF P2_StoperMaticovacky.IN.Centrovanie_ZASUNUTE THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 550;
			END_IF	
		
		
	
		//*************************************Odoslanie dát na server*******************************************//
		
		550:
			SC_P2_StoperMaticovacky.StepName:='550 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 560;
			ELSIF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Maticovacka_ST4.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 552;
			ELSIF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaError THEN	
				P2_Alarmy[231]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
			
		552:
			SC_P2_StoperMaticovacky.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 552;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '1;Scanning' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 552;	
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 552;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 552;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '4;OFF' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 552;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.DruhCinnostiNaPaletke = '5;Bussy' THEN
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 552;
				END_IF   
			END_IF
		
		
		
		555:
			SC_P2_StoperMaticovacky.StepName:='555 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P2_StoperMaticovacky.Switch1 THEN
				TRCB_P2_Maticovacka_ST4.CMD.OdosliStavPaletky_TYP2:= TRUE;
				SC_P2_StoperMaticovacky.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				TRCB_P2_Maticovacka_ST4.CMD.OdosliStavPaletky_TYP2:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 556;
			ELSIF TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaError THEN
				P2_Alarmy[231]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
			
		
		556:
			SC_P2_StoperMaticovacky.StepName:='553 - Automaticky Rezim - kontrola odpovede servera';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;
			
			IF NOT TRCB_P2_Maticovacka_ST4.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P2_Maticovacka_ST4.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 560;
				ELSIF TRCB_P2_Maticovacka_ST4.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					SC_P2_StoperMaticovacky.ResetStep:= TRUE;
					SC_P2_StoperMaticovacky.Step:= 560;
				END_IF	
			END_IF
			
	           
            
            

		//************************************************Vyvezenie paletky******************************************************//	
		
		560:
			SC_P2_StoperMaticovacky.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na akumulacny stoper';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
            
                     
            
			IF P2_StoperMaticovacky.KoniecCyklu THEN
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 0;
			ELSIF ((NOT P2_AkumulacnyStoper.IN.PritomnostPaletky AND SC_P2_AkumulacnyStoper.Step = 100) OR (P2_AkumulacnyStoper.OUT.ZasunStoper AND SC_P2_AkumulacnyStoper.Step = 105)) AND NOT P2_StoperMaticovacky.STAV.PrebiehaVyvezeniePaletky THEN
				P2_StoperMaticovacky.OUT.ZasunStoper:= TRUE;
				P2_StoperMaticovacky.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 561;
			END_IF	
		
		561:
			SC_P2_StoperMaticovacky.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na akumulacny stoper';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#200ms;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#10s;
		
			SC_P2_StoperMaticovacky.AlarmTime.IN:= P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky;
			SC_P2_StoperMaticovacky.IdleTime.IN:= NOT P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky;
			
			IF NOT P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P2_MaticaM4:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P2_MaticaM4:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P2_MaticaM4:= '';
				Reports.Skrutkovacky.VyslednyReport.P2_MaticaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P2_MaticaM4:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P2_MaticaM4:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P2_MaticaM4:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P2_MaticaM4:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_MaticaM4:= '';
				Reports.Kamery.P2_CAM9_KontrolaPaletky:= '';
				P2_StoperMaticovacky.OUT.ZasunStoper:= FALSE;
				SC_P2_StoperMaticovacky.ResetStep:= TRUE;
				SC_P2_StoperMaticovacky.Step:= 100;
			ELSIF SC_P2_StoperMaticovacky.AlarmTime.Q THEN
				P2_Alarmy[287]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF   
                
       
		
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P2_StoperMaticovacky.StepName:='700 - Manualny Rezim';
			SC_P2_StoperMaticovacky.IdleTime.PT:= T#8s;
			SC_P2_StoperMaticovacky.AlarmTime.PT:= T#5s;
		
		
			//Vysunutie maticovaèky//
			IF P2_StoperMaticovacky.CMD.RR_Maticovacku_VYSUN THEN
				P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN:= TRUE;
				P2_StoperMaticovacky.CMD.RR_Maticovacku_VYSUN:= FALSE;
			ELSIF P2_StoperMaticovacky.CMD.RR_Maticovacku_ZASUN THEN
				P2_StoperMaticovacky.OUT.Maticovacku_M4_VYSUN:= FALSE;
				P2_StoperMaticovacky.CMD.RR_Maticovacku_ZASUN:= FALSE;
			END_IF	
		
		
	
	END_CASE
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

