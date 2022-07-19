
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_StoperSrobovania);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	IOLinkKomunikacia;
	
	
	//Reset sekcie //
	IF P3_StoperSrobovania.Reset THEN
		SC_P3_StoperSrobovania.Step:= 0;
		P3_StoperSrobovania.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA AND NOT P3_StoperSrobovania.Automat THEN
		SC_P3_StoperSrobovania.Step:= 0;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA AND P3_StoperSrobovania.Automat THEN	
		P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
	END_IF	
	
	//Ukonèenie komunikácie pri poruche//
	IF P3_Pracovisko.STAV.Porucha_ST1 AND NOT Triger_0 THEN
		Triger_0:= TRUE;
		IF P3_StoperSrobovania.STAV.VyrobaZacala THEN
			Paletka[i].PAR.StavPowerCP:= 'FAIL';
			Paletka[i].STAV.StavPaletky:= 'NG';
			P3_StoperSrobovania.KoniecCyklu:= TRUE;
			SC_P3_StoperSrobovania.ResetStep:= TRUE;
			SC_P3_StoperSrobovania.Step:= 550;
		ELSE
			SC_P3_StoperSrobovania.ResetStep:= TRUE;
			SC_P3_StoperSrobovania.Step:= 0;
		END_IF
	END_IF	
	
	IF NOT P3_Pracovisko.STAV.Porucha_ST1 THEN
		Triger_0:= FALSE;
	END_IF	
	
	
	CASE SC_P3_StoperSrobovania.Step OF 
	
		0:
			SC_P3_StoperSrobovania.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			P3_StoperSrobovania.Automat:= FALSE;
			P3_StoperSrobovania.KoniecCyklu:= FALSE;
			P3_StoperSrobovania.Manual:= FALSE;
			P3_StoperSrobovania.STAV.PoINIT:= FALSE;
			P3_StoperSrobovania.STAV.VyrobaZacala:= FALSE;
			P3_StoperSrobovania.OUT.ZasunStoper:= FALSE;
			P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
		
			P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky:= FALSE;
			P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky:= FALSE;
			P3_Srobovanie.COM_IN.PresunManipulatora_VPRED:= FALSE;
			P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
			P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			
			CAM13.CMD.Triger:= FALSE;
			CAM13.STAV.Results_READY:= FALSE;
			
		
			TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P3_Srobovanie_ST7.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
		
			P3_Srobov_KAM_Result_OK:= FALSE;
			P3_Srobov_KAM_Result_NG:= FALSE;
			P3_Srobov_KAM_Result_Ignoruj:= FALSE;
			P3_Srobov_K40_Result_OFF:= FALSE;
			P3_Srobov_M5_Result_OFF:= FALSE;
			P34_Vizu.ZobrazHL1_ST7:= FALSE;
			P34_Vizu.ZobrazHL2_ST7:= FALSE;
			TRCB_P3_Srobov_OpatovnyDopyt:= FALSE;
			TRCB_P3_Srobov_PaletkaNG:= FALSE;
			VysunutieSkrutkovackyK40_OK:= FALSE;
			VysunutieSkrutkovackyM5_OK:= FALSE;
			P3_StoperSrobovania.PAR.IndexFotky:= 0;
			PocetTrigrovKamery:= 0;
			PocetDopytovNaServer:= 0;
			CisloFotky:= 0;
			TestovaciKus:= FALSE;
			P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			SkrutkaM5_Zahodena:= FALSE;
			P3_Skrutkovanie_Taktime.IN.START_MeraniaCasu:= FALSE;
			P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
			
		
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P3_ZonaBunky_AKTIVNA AND
				P3_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P3_Pracovisko.STAV.Porucha_ST1 AND
				NOT P3_Pracovisko.STAV.Porucha_ST2 AND
				NOT P3_Pracovisko.STAV.Porucha_ST3 AND
				NOT P3_Pracovisko.STAV.Porucha_ST4 AND
				NOT P3_Pracovisko.STAV.Porucha_ST5 AND
				NOT P3_Pracovisko.STAV.Porucha_ST6 AND
				NOT P3_Pracovisko.STAV.Porucha_ST7 AND
				NOT P3_Pracovisko.STAV.Porucha_ST8 THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 1;
			END_IF
	
		1:
			SC_P3_StoperSrobovania.StepName:='1 - Cakam na spustenie vyroby';
			P3_StoperSrobovania.KoniecCyklu:= FALSE;
			IF P3_StoperSrobovania.Automat THEN
				SC_P3_StoperSrobovania.Step:= 2;
			ELSIF P3_StoperSrobovania.Manual THEN
				SC_P3_StoperSrobovania.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P3_StoperSrobovania.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			
									
			IF P3_Srobovanie.STAV.PoINIT AND P3_Dopravniky.STAV.PoINIT AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 5;
			END_IF	
		
			
		
		5:
			SC_P3_StoperSrobovania.StepName:='5 - Inicializacia - zasunutie centrovacky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#4s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 13;
			END_IF		
		
		
		13:
			SC_P3_StoperSrobovania.StepName:='13 - Inicializacia - hladanie paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
	
			IF P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 20;		
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 100;
			END_IF
		
		
		20:
			SC_P3_StoperSrobovania.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
		
			SC_P3_StoperSrobovania.IdleTime.IN:= P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
									
			IF SC_P3_StoperSrobovania.IdleTime.Q AND NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P3_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK AND P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P3_StoperSrobovania.PAR.CisloPaletky:= P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 23;
			END_IF	
			
		23:
			SC_P3_StoperSrobovania.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P3_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 30;
			ELSE
				P34_Alarmy[321]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
		30:
			SC_P3_StoperSrobovania.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = '' THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' THEN  
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_7' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_7' THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;    
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF	
            
                      
            
            
		33:
			SC_P3_StoperSrobovania.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie s Panatrace'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSE
				P3_StoperSrobovania.STAV.PoINIT:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 100;
			END_IF	
					
			
		
			
		
		
			//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P3_StoperSrobovania.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			              
			SC_P3_StoperSrobovania.IdleTime.IN:= P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			
			IF P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				P2_StoperZvarania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			         
			IF NOT SC_P3_StoperSrobovania.Switch1 AND P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				P3_Skrutkovanie_Taktime.IN.START_MeraniaCasu:= TRUE;
				P3_Skrutkovanie_Taktime.IN.ZAPIS_MeraniaCasu:= TRUE;
				P3_Skrutkovanie_Taktime.IN.ZAPIS_StratovyCas:= TRUE;
				Buffer_7.Hodnota:= P3_Skrutkovanie_Taktime.OUT.StratoveSekundy;
				Buffer_7.ZapisHodnotu:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
			
			IF P3_StoperSrobovania.KoniecCyklu THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 0;
			ELSIF SC_P3_StoperSrobovania.IdleTime.Q THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 102;
			END_IF
		
			
			
			
		102:
			SC_P3_StoperSrobovania.StepName:='102 - Automaticky Rezim - precitanie cisla paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#500ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				i:= 0;
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF	
			
					
			IF P3_StoperSrobovania.RFID_hlava.Stav_CitanieZapis_OK AND P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P3_StoperSrobovania.PAR.CisloPaletky:= P3_StoperSrobovania.RFID_hlava.PrecitaneCisloPaletky;
				P3_StoperSrobovania.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 103;
			END_IF	
           
			
		
		
		
		
		103:
			SC_P3_StoperSrobovania.StepName:='103 - Automaticky Rezim - kontrola a priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
			IF i<> 0 THEN
				P3_StoperSrobovania.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 104;
			ELSE
				P34_Alarmy[321]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
			
		
		104:
			SC_P3_StoperSrobovania.StepName:='104 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			IF Paletka[i].STAV.StavPaletky = '' THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_7' THEN
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_7' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;  
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF		
		
		
		
		105:
			SC_P3_StoperSrobovania.StepName:='105 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 120;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 AND TRCB_P3_Srobovanie_ST7.STATUS.KOM_READY THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				Centrovacku_VYSUN:= TRUE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 106;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN	
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 107;
			END_IF	
			
		106:
			SC_P3_StoperSrobovania.StepName:='106 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 107;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '1;Request' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 108;	
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 120;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 107;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '4;Status' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 107;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '5;' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 107;
				ELSE
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 107;
				END_IF   
			END_IF
				
		
		107:
			SC_P3_StoperSrobovania.StepName:='107 - Automaticky Rezim - rozhodnutie obsluhy po chybe komunikacie s Panatrace';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
             
            
			P34_Vizu.ZobrazHL2_ST7:= TRUE;
            
			IF TRCB_P3_Srobov_OpatovnyDopyt THEN
				TRCB_P3_Srobov_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL2_ST7:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF TRCB_P3_Srobov_PaletkaNG THEN
				TRCB_P3_Srobov_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL2_ST7:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 116;
			END_IF   	
			
			
			
			
			
			
		108:
			SC_P3_StoperSrobovania.StepName:='108 - Automaticky Rezim - vyziadanie stavu paletky zo servera, zacentrovanie paletky'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;	
			SC_P3_StoperSrobovania.IdleTime.IN:= TRUE;
            
            
			IF NOT SC_P3_StoperSrobovania.Switch1 AND TRCB_P3_Srobovanie_ST7.STATUS.KOM_READY THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 110;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN	
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 107;
			END_IF	
		
		110:
			SC_P3_StoperSrobovania.StepName:='110 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;		
				
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena AND P3_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = 'PRD;ST7' THEN
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 120;
					END_IF    
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 115;
				END_IF	
			END_IF
		
		
		
		115:
			SC_P3_StoperSrobovania.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
             
            
			P34_Vizu.ZobrazHL1_ST7:= TRUE;
            
			IF TRCB_P3_Srobov_OpatovnyDopyt THEN
				TRCB_P3_Srobov_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL1_ST7:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 105;
			ELSIF TRCB_P3_Srobov_PaletkaNG THEN
				TRCB_P3_Srobov_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL1_ST7:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 116;
			END_IF   
            
            
            
            
            
	
		116:
			SC_P3_StoperSrobovania.StepName:='116 - Automaticky Rezim - odcentrovanie paletky po odpovedi servera NG';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#10s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
				
			IF P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF    
		
		
		120:
			SC_P3_StoperSrobovania.StepName:='120 - Automaticky Rezim - zacentrovanie paletky ';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#10s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
				
			IF P3_StoperSrobovania.IN.Centrovanie_VYSUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 125;
			END_IF    
		         
            
            
			
			
		125:
			SC_P3_StoperSrobovania.StepName:='125 - Automaticky Rezim - rozhodnutie podla typu modelu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#5s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			             
			
			IF Linka.PAR.ZvolenyModel = '4F' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 130;
			ELSIF Linka.PAR.ZvolenyModel = '5F' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 130;
			ELSIF Linka.PAR.ZvolenyModel = '5H' THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 350; 
			END_IF
		
           
		
		
			//********************************************Model 45F**************************************************************//
		
		130:
			SC_P3_StoperSrobovania.StepName:='130 - Automaticky Rezim - model 45F vystavenie signalu zaskrutkuj skrutky K40 A M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
						
			
			
			IF NOT SC_P3_StoperSrobovania.Switch1  THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaK40:= '';
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= '';
				P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 135;
			END_IF	
	
			
		135:
			SC_P3_StoperSrobovania.StepName:='135 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P3_SkrutkovanieResult_OFF THEN
					IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 500; 
					ELSE	
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 545;
					END_IF	
				ELSE	
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 140;
				END_IF	
			END_IF	
			
			
			
		140:
			SC_P3_StoperSrobovania.StepName:='140 - Automaticky Rezim - model 45F kontrola stavu zaskrutkovania skrutiek K40 a M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
                      
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.STAV.K40_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.STAV.K40_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.STAV.K40_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaK40:= UDINT_TO_STRING(P3_Srobovanie.STAV.K40_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaK40:= UDINT_TO_STRING(P3_Srobovanie.STAV.K40_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaK40:= UDINT_TO_STRING(P3_Srobovanie.STAV.K40_DosiahnutyUhol);
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Skrutk_45F_StredK40_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40);
				P3_Skrutk_45F_StredM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5);
				IF (P3_Skrutk_45F_StredK40_Vysunutie <= P34_RemPremenne.P3_Srob45F_K40_Vysunutie_HI) AND
					(P3_Skrutk_45F_StredK40_Vysunutie >= P34_RemPremenne.P3_Srob45F_K40_Vysunutie_LO) THEN
					VysunutieSkrutkovackyK40_OK:= TRUE;
				ELSE
					VysunutieSkrutkovackyK40_OK:= FALSE;
				END_IF	
				IF (P3_Skrutk_45F_StredM5_Vysunutie <= P34_RemPremenne.P3_Srob45F_M5_Vysunutie_HI) AND
					(P3_Skrutk_45F_StredM5_Vysunutie >= P34_RemPremenne.P3_Srob45F_M5_Vysunutie_LO) THEN
					VysunutieSkrutkovackyM5_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovackyM5_OK:= FALSE;
				END_IF  
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF 
              
         
            
			IF P3_Srobovanie.STAV.Vysledok_SrobovaniaK40 = 'OK' AND VysunutieSkrutkovackyK40_OK THEN
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= 'PASS';
			ELSE	
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= 'FAIL';
			END_IF	
			
			IF P3_Srobovanie.STAV.Vysledok_SrobovaniaM5 = 'OK' AND VysunutieSkrutkovackyM5_OK THEN
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'PASS';
			ELSE
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'FAIL';
			END_IF	
			
			IF Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40 = 'PASS' AND Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5 = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 545;
			ELSE
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 500;
			END_IF	
			
				
		
			
		
			
		
			//********************************************Model 5H**************************************************************//
				
        		
		350:	
			SC_P3_StoperSrobovania.StepName:='350 - Automaticky Rezim - model 5H vystavenie signalu zaskrutkuj skrutku M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
						
						
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= '';
				P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 355;
			END_IF	
		
			
		355:
			SC_P3_StoperSrobovania.StepName:='355 - Automaticky Rezim - cakam na zrusenie signalu skrutkovanie ukoncene';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene THEN
				IF Linka.P3_SkrutkovanieResult_OFF THEN
					IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 500; 
					ELSE	
						SC_P3_StoperSrobovania.ResetStep:= TRUE;
						SC_P3_StoperSrobovania.Step:= 545;
					END_IF	
				ELSE
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 360;
				END_IF	
			END_IF	
			
	           
            
		360:
			SC_P3_StoperSrobovania.StepName:='360 - Automaticky Rezim - model 5H kontrola stavu zaskrutkovania skrutky M5';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
            
                      
            
			Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMIN_REAL);
			Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_Moment_ToleranciaMAX_REAL);
			Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyMoment_REAL);
			Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMIN); 
			Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_Uhol_ToleranciaMAX);
			Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaM5:= UDINT_TO_STRING(P3_Srobovanie.STAV.M5_DosiahnutyUhol);
            
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Skrutk_5H_StredM5_Vysunutie:= STRING_TO_REAL(Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5);
				IF (P3_Skrutk_5H_StredM5_Vysunutie <= P34_RemPremenne.P3_Srob5H_M5_Vysunutie_HI) AND
					(P3_Skrutk_5H_StredM5_Vysunutie >= P34_RemPremenne.P3_Srob5H_M5_Vysunutie_LO) THEN
					VysunutieSkrutkovackyM5_OK:= TRUE;
				ELSE    
					VysunutieSkrutkovackyM5_OK:= FALSE;
				END_IF  
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF  
            
            
			IF P3_Srobovanie.STAV.Vysledok_SrobovaniaM5 = 'OK' AND VysunutieSkrutkovackyM5_OK THEN
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'PASS';
			ELSE
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= 'FAIL';
			END_IF
			
			
			
			IF Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5 = 'PASS' THEN
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				Paletka[i].STAV.StavPaletky:= 'OK';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 545;
			ELSE
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 500;
			END_IF	
			
			
		
			
			
			
		
			//********************************Presun manipulatora po zlom skrutkovaní**********************************//			
			
			
			
		500:
			SC_P3_StoperSrobovania.StepName:='500 - Automaticky Rezim - presun manipulatora vzad';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			
			
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny) THEN
				P3_Srobovanie.COM_IN.PresunManipulatora_VZAD:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 501;
			END_IF
		
			
		501:
			SC_P3_StoperSrobovania.StepName:='501 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora ukonceny';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
			
			IF NOT P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny THEN
				CAM13.STAV.Results_READY:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 545;
			END_IF	
			
			
        			
			
			
			//**********************************Odcentrovanie paletky***************************************//	
		545:
			SC_P3_StoperSrobovania.StepName:='545 - Automaticky Rezim - odcentrovanie paletky';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_StoperSrobovania.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF
		
			IF P3_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 550;
			END_IF	
		
				
			//**********************Odoslanie dát na server************************************//	
		
		550:
			SC_P3_StoperSrobovania.StepName:='550 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			ELSIF NOT SC_P3_StoperSrobovania.Switch1 AND TRCB_P3_Srobovanie_ST7.STATUS.KOM_READY THEN
				TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= TRUE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF   
						
			
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= FALSE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 552;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN
				TRCB_P3_Srobovanie_ST7.CMD.OdosliStavPaletky_TYP2:= FALSE;
				P3_Skrutkovanie_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 557;
			END_IF
			
		
		552:
			SC_P3_StoperSrobovania.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
			
			
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					P3_StoperSrobovania.STAV.VyrobaZacala:= FALSE;
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 560;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
					P3_StoperSrobovania.STAV.VyrobaZacala:= FALSE;
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 560;
				END_IF	
			END_IF
		
			
			
			
			
			
		555:
			SC_P3_StoperSrobovania.StepName:='555 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;	
			

			IF NOT SC_P3_StoperSrobovania.Switch1 AND TRCB_P3_Srobovanie_ST7.STATUS.KOM_READY THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P3_StoperSrobovania.Switch1:= TRUE;
			END_IF 
			            
			IF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 556;
			ELSIF TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaError THEN	
				TRCB_P3_Srobovanie_ST7.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 557;
			END_IF
		
			
		556:
			SC_P3_StoperSrobovania.StepName:='556 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_Srobovanie_ST7.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 557;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '1;Request' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 557;	
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 550;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 557;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '4;Status' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 557;
				ELSIF TRCB_P3_Srobovanie_ST7.OUTPUTS.DruhCinnostiNaPaletke = '5;' THEN
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 557;
				ELSE
					SC_P3_StoperSrobovania.ResetStep:= TRUE;
					SC_P3_StoperSrobovania.Step:= 557;
				END_IF   
			END_IF
		
		
	
            
		557:
			SC_P3_StoperSrobovania.StepName:='557 - Automaticky Rezim - rozhodnutie obsluhy po chybe komunikacie s Panatrace';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;	
             
            
			P34_Vizu.ZobrazHL2_ST7:= TRUE;
            
			IF TRCB_P3_Srobov_OpatovnyDopyt THEN
				TRCB_P3_Srobov_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL2_ST7:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 555;
			ELSIF TRCB_P3_Srobov_PaletkaNG THEN
				TRCB_P3_Srobov_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL2_ST7:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				P3_StoperSrobovania.STAV.VyrobaZacala:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 560;
			END_IF   
			
			

			//********************************Vyvezenie paletky**************************************//	
		560:
			SC_P3_StoperSrobovania.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na stoper HV testu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
            
			IF P3_StoperSrobovania.KoniecCyklu THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 0;
			ELSIF P3_Pracovisko.STAV.Porucha_ST1 THEN
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 0;	
			ELSIF ((NOT P3_HV_Test.RFID_hlava.PritomnostPaletky AND SC_P3_HV_Test.Step = 100) OR (P3_HV_Test.OUT.ZasunStoper AND SC_P3_HV_Test.Step = 561)) AND NOT P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky THEN
				P3_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 561;
			END_IF	
		
		
		561:
			SC_P3_StoperSrobovania.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na stoper HV testu';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#200ms;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#10s;
		
			SC_P3_StoperSrobovania.IdleTime.IN:= NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
			SC_P3_StoperSrobovania.AlarmTime.IN:= P3_StoperSrobovania.RFID_hlava.PritomnostPaletky;
            
			IF NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				CisloFotky:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMIN.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_ToleranciaMAX.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Moment_NameranaHodnota.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.VyslednyReport.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMIN.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_ToleranciaMAX.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.Uhol_NameranaHodnota.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaM5:= '';
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5:= '';
				Reports.Kamery.P3_CAM13_KontrolaPaletky:= '';
				SkrutkaM5_Zahodena:= FALSE;
				P3_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= FALSE;
				SC_P3_StoperSrobovania.ResetStep:= TRUE;
				SC_P3_StoperSrobovania.Step:= 100;
			ELSIF SC_P3_StoperSrobovania.AlarmTime.Q THEN
				P34_Alarmy[355]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF
            
		            
		        
            
					
		
				
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P3_StoperSrobovania.StepName:='700 - Manualny Rezim';
			SC_P3_StoperSrobovania.IdleTime.PT:= T#8s;
			SC_P3_StoperSrobovania.AlarmTime.PT:= T#5s;
		
		
			//Ovládanie zdvižky//
			IF P3_StoperSrobovania.CMD.RR_VysunCentrovanie THEN
				P3_StoperSrobovania.OUT.Centrovanie_ZASUN:= FALSE;
				P3_StoperSrobovania.OUT.Centrovanie_VYSUN:= TRUE;
			ELSE 
				P3_StoperSrobovania.OUT.Centrovanie_ZASUN:= TRUE;
				P3_StoperSrobovania.OUT.Centrovanie_VYSUN:= FALSE;
			END_IF	
		
		
		
		
		
		
	
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

