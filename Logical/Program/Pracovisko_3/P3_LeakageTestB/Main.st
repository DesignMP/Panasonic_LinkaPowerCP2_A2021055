
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
		//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_LeakageTestB);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	OvlHornehoPritlaku;
	IOLinkKomunikacia;
	COM_Tester;
	 
	
	//Reset sekcie //
	IF P3_LeakageTestB.Reset THEN
		SC_P3_LeakageTestB.Step:= 0;
		P3_LeakageTestB.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_LeakageTestB.Step:= 0;
	END_IF	
	
	
	
	CASE SC_P3_LeakageTestB.Step OF 
	
		0:
			SC_P3_LeakageTestB.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			SC_OvlHornehoPritlaku.Step:= 0;
			P3_LeakageTestB.Automat:= FALSE;
			P3_LeakageTestB.KoniecCyklu:= FALSE;
			P3_LeakageTestB.Manual:= FALSE;
			P3_LeakageTestB.STAV.PoINIT:= FALSE;
			P3_LeakageTestB.OUT.ZasunStoper:= FALSE;
			P3_LeakageTestB.OUT.Kopito_VYSUN:= FALSE;
			P3_LeakageTestB.OUT.Kopito_ZASUN:= TRUE;
			P3_LeakageTestB.RFID_hlava.PrecitajChipRFID:= FALSE;
			P3_LeakageTestB.CMD.RR_TestovaciaSekvencia_START:= FALSE;
			P3_LeakageTestB.CMD.RR_VysunSpodneKopito:= FALSE;
			P3_LeakageTestB.CMD.RR_HornyPritlak_VYSUN:= FALSE;
			P3_LeakageTestB.CMD.RR_HornyPritlak_ZASUN:= FALSE;
			P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY:= FALSE;
			TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPaletky_TYP1:= FALSE;
			TRCB_P3_LeakageTestB_ST8B.CMD.PriradQRkodFiltra_TYP3:= FALSE;
			TRCB_P3_LeakageTestB_ST8B.CMD.OdosliStavPaletky_TYP2:= FALSE;
			TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
			AteqLeakageTester_B.CitajParametreTestera:= FALSE;	
			AteqLeakageTester_B.START_Testovania:= FALSE;
			P34_Vizu.ZobrazHL2_ST8:= FALSE;
			P34_Vizu.ZobrazHL4_ST8:= FALSE;
			TRCB_P3_LeakTestB_OpatovnyDopyt:= FALSE;
			TRCB_P3_LeakTestB_PaletkaNG:= FALSE;
			PocetDopytovNaServer:= 0;
			PocetOpakovaniTestu:= 0;
			OpakovanyTest:= FALSE;
			TestovaciKus:= FALSE;
			P3_LeakageTestB_Taktime.IN.START_MeraniaCasu:= FALSE;
			P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
		
			P3_ZdvizkaPredLeakTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P3_LeakageTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
		
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
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 1;
			END_IF
		
		
		1:
			SC_P3_LeakageTestB.StepName:='1 - Cakam na spustenie vyroby';
			P3_LeakageTestB.KoniecCyklu:= FALSE;
			IF P3_LeakageTestB.Automat THEN
				SC_P3_LeakageTestB.Step:= 2;
			ELSIF P3_LeakageTestB.Manual THEN
				SC_P3_LeakageTestB.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P3_LeakageTestB.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_LeakageTestB.IdleTime.PT:= T#500ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			SC_P3_LeakageTestB.IdleTime.IN:= TRUE;
												
			IF SC_P3_LeakageTestB.IdleTime.Q THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 5;
			END_IF	
		
		
		5:
			SC_P3_LeakageTestB.StepName:='5 - Inicializacia - zasunutie horneho pritlaku';
			SC_P3_LeakageTestB.IdleTime.PT:= T#2s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				HornyPritlak_ZASUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_LeakageTestB.IN.HornyPritlak_ZASUNUTY THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 8;
			END_IF	
		
		
		8:
			SC_P3_LeakageTestB.StepName:='8 - Inicializacia - zasunutie centrovacky';
			SC_P3_LeakageTestB.IdleTime.PT:= T#4s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_LeakageTestB.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 10;
			END_IF	
		
		
		10:
			SC_P3_LeakageTestB.StepName:='10 - Inicializacia - kontrola typu zalozeneho kopita';
			SC_P3_LeakageTestB.IdleTime.PT:= T#4s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			IF Linka.PAR.ZvolenyModel = '4F' AND P3_LeakageTestB.IN.PritomnostKopita AND P3_LeakageTestB.IN.Tester_TypKonektoru_4F THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 13;
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND P3_LeakageTestB.IN.PritomnostKopita AND P3_LeakageTestB.IN.Tester_TypKonektoru_5F_5H THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 13;
			ELSIF Linka.PAR.ZvolenyModel = '5H' AND P3_LeakageTestB.IN.PritomnostKopita AND P3_LeakageTestB.IN.Tester_TypKonektoru_5F_5H THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 13;	
			ELSE
				P34_Alarmy[315]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF	
		
		
		13:
			SC_P3_LeakageTestB.StepName:='13 - Inicializacia - hladanie paletky';
			SC_P3_LeakageTestB.IdleTime.PT:= T#5s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			SC_P3_LeakageTestB.IdleTime.IN:= P3_Dopravniky.STAV.PoINIT;
	
			IF P3_LeakageTestB.CMD.RR_TestovaciaSekvencia_START THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 120;
			ELSIF P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 20;		 
			ELSIF SC_P3_LeakageTestB.IdleTime.Q THEN
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 100;
			END_IF	
		
		
		20:
			SC_P3_LeakageTestB.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
		
			SC_P3_LeakageTestB.IdleTime.IN:= P3_LeakageTestB.RFID_hlava.PritomnostPaletky;
									
			IF SC_P3_LeakageTestB.IdleTime.Q AND NOT SC_P3_LeakageTestB.Switch1 THEN
				P3_LeakageTestB.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
			
			IF P3_LeakageTestB.RFID_hlava.Stav_CitanieZapis_OK AND P3_LeakageTestB.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P3_LeakageTestB.RFID_hlava.PrecitaneCisloPaletky;
				P3_LeakageTestB.PAR.CisloPaletky:= P3_LeakageTestB.RFID_hlava.PrecitaneCisloPaletky;
				P3_LeakageTestB.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 23;
			END_IF	
			
		23:
			SC_P3_LeakageTestB.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P3_LeakageTestB.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 30;
			ELSE
				P34_Alarmy[312]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF
		
		30:
			SC_P3_LeakageTestB.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF Paletka[i].STAV.StavPaletky = '' THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_8A,8B' THEN
				IF P3_LeakageTestB.STAV.Tester_ON THEN
					TestovaciKus:= TRUE;
					P3_LeakageTestB.STAV.PoINIT:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 110;
				ELSE
					P3_LeakageTestB.STAV.PoINIT:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_8A,8B' THEN 
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_8A,8B' THEN
				IF P3_LeakageTestB.STAV.Tester_ON THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
					P3_LeakageTestB.STAV.PoINIT:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 110;
				ELSE
					P3_LeakageTestB.STAV.PoINIT:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_8A,8B' THEN
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				IF P3_LeakageTestB.STAV.Tester_ON THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 33;
				ELSE
					P3_LeakageTestB.STAV.PoINIT:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;	
			END_IF	
		
		33:
			SC_P3_LeakageTestB.StepName:='33 - Inicializacia - kontrola uzavretia komunikacie'; 
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
            
			IF Paletka[i].STAV.Komunikacia_DONE THEN
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSE
				P3_LeakageTestB.STAV.PoINIT:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 100;
			END_IF		
		
			
	
		
			//********************************************************Automatický režim****************************************************************************//
		
	
		100:  
			SC_P3_LeakageTestB.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			SC_P3_LeakageTestB.IdleTime.IN:= P3_LeakageTestB.RFID_hlava.PritomnostPaletky;
			
			IF P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN
				P3_ZdvizkaPredLeakTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF
             
			IF NOT SC_P3_LeakageTestB.Switch1 AND P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN
				P3_LeakageTestB_Taktime.IN.START_MeraniaCasu:= TRUE;
				P3_LeakageTestB_Taktime.IN.ZAPIS_MeraniaCasu:= TRUE;
				P3_LeakageTestB_Taktime.IN.ZAPIS_StratovyCas:= TRUE;
				Buffer_10.Hodnota:= P3_LeakageTestB_Taktime.OUT.StratoveSekundy;
				Buffer_10.ZapisHodnotu:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
			
			
			           
			IF P3_LeakageTestB.KoniecCyklu THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 0;
			ELSIF SC_P3_LeakageTestB.IdleTime.Q THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 101;
			END_IF
		
		101:
			SC_P3_LeakageTestB.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			SC_P3_LeakageTestB.IdleTime.IN:= TRUE;
		
												
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				P3_LeakageTestB.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
			
			IF P3_LeakageTestB.RFID_hlava.Stav_CitanieZapis_OK AND P3_LeakageTestB.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P3_LeakageTestB.RFID_hlava.PrecitaneCisloPaletky;
				P3_LeakageTestB.PAR.CisloPaletky:= P3_LeakageTestB.RFID_hlava.PrecitaneCisloPaletky;
				P3_LeakageTestB.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 102;
			END_IF	
			
		102:
			SC_P3_LeakageTestB.StepName:='102 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P3_LeakageTestB.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 103;
			ELSE
				P34_Alarmy[312]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF
		
		103:
			SC_P3_LeakageTestB.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
		
			IF Paletka[i].STAV.StavPaletky = '' THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_8A,8B' THEN
				IF P3_LeakageTestB.STAV.Tester_ON THEN
					TestovaciKus:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 110; 
				ELSE
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_8A,8B' THEN 
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_8A,8B' THEN
				IF P3_LeakageTestB.STAV.Tester_ON THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 110;
				ELSE
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_8A,8B' THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				IF P3_LeakageTestB.STAV.Tester_ON THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 110;
				ELSE
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;	
			END_IF	
		
		
		
		110:
			SC_P3_LeakageTestB.StepName:='110 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#10s;	
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 120;
			ELSIF NOT SC_P3_LeakageTestB.Switch1 THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				Centrovacku_VYSUN:= TRUE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 111;
			ELSIF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaError THEN	
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 112;
			END_IF	
			
		111:
			SC_P3_LeakageTestB.StepName:='111 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 112;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '1;Request' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 115;	
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 120;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 112;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '4;Status' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 112;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '5;' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 112;
				ELSE
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 112;
				END_IF   
			END_IF	
		
			
		112:
			SC_P3_LeakageTestB.StepName:='112 - Automaticky Rezim - rozhodnutie obsluhy po chybe komunikacie s Panatrace';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
            
            
			P34_Vizu.ZobrazHL4_ST8:= TRUE;
            
			IF TRCB_P3_LeakTestB_OpatovnyDopyt THEN
				TRCB_P3_LeakTestB_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL4_ST8:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 110;
			ELSIF TRCB_P3_LeakTestB_PaletkaNG THEN
				TRCB_P3_LeakTestB_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL4_ST8:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 118;
			END_IF   	
			
			
			
			
			
		115:
			SC_P3_LeakageTestB.StepName:='115 - Automaticky Rezim - vyziadanie stavu paletky zo servera, zacentrovanie paletky'; 
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;	
			SC_P3_LeakageTestB.IdleTime.IN:= TRUE;
			
                        
			IF NOT SC_P3_LeakageTestB.Switch1 AND TRCB_P3_LeakageTestB_ST8B.STATUS.KOM_READY THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPaletky_TYP1:= TRUE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
			
			IF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 116;
			ELSIF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaError THEN	
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPaletky_TYP1:= FALSE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 112;
			END_IF	
			
				
		
			
		116:
			SC_P3_LeakageTestB.StepName:='116 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena AND P3_LeakageTestB.IN.Centrovanie_VYSUNUTE THEN
				IF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					IF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke  = 'PRD;ST8B' THEN
						SC_P3_LeakageTestB.ResetStep:= TRUE;
						SC_P3_LeakageTestB.Step:= 120;
					ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke  = 'SMP;ST8A,ST8B' THEN
						SC_P3_LeakageTestB.ResetStep:= TRUE;
						SC_P3_LeakageTestB.Step:= 120; 
					ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke  = 'PRD;ST8A,ST8B' THEN
						SC_P3_LeakageTestB.ResetStep:= TRUE;
						SC_P3_LeakageTestB.Step:= 120; 
					END_IF    
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 117;
				END_IF	
			END_IF
		
      
		117:
			SC_P3_LeakageTestB.StepName:='115 - Automaticky Rezim - rozhodnutie obsluhy po odpovedi panatrace NG';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
            
            
			P34_Vizu.ZobrazHL2_ST8:= TRUE;
            
			IF TRCB_P3_LeakTestB_OpatovnyDopyt THEN
				TRCB_P3_LeakTestB_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL2_ST8:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 110;
			ELSIF TRCB_P3_LeakTestB_PaletkaNG THEN
				TRCB_P3_LeakTestB_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL2_ST8:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 118;
			END_IF   
            
            
		
		118:
			SC_P3_LeakageTestB.StepName:='118 - Automaticky Rezim - odcentrovanie paletky po odpovedi servera NG';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_LeakageTestB.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			END_IF	
		
			
			//Zatvorenie Leakage testera//		
			
		
		120:
			SC_P3_LeakageTestB.StepName:='120 - Automaticky Rezim - zacentrovanie paletky ';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_LeakageTestB.IN.Centrovanie_VYSUNUTE THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 123;
			END_IF	   
            
		
		123:
			SC_P3_LeakageTestB.StepName:='123 - Automaticky Rezim - vysunutie horneho pritlaku ';
			SC_P3_LeakageTestB.IdleTime.PT:= T#3s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
                        
            
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				HornyPritlak_VYSUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
					
			IF P3_LeakageTestB.IN.HornyPritlak_VYSUNUTY THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 125;
			END_IF	
		
		
		125:
			SC_P3_LeakageTestB.StepName:='125 - Automaticky Rezim - vysunutie spodneho kopita';
			SC_P3_LeakageTestB.IdleTime.PT:= T#1s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			SC_P3_LeakageTestB.IdleTime.IN:= TRUE;
	
			IF P3_LeakageTestB.IN.PritomnostKopita AND P3_LeakageTestB.IN.Kopito_ZASUNUTE THEN
				P3_LeakageTestB.OUT.Kopito_ZASUN:= FALSE;
				P3_LeakageTestB.OUT.Kopito_VYSUN:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 128;
			END_IF
		
		
		128:
			SC_P3_LeakageTestB.StepName:='128 - Automaticky Rezim - cakam na vysunutie kopita';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#300ms;
	
			
			SC_P3_LeakageTestB.IdleTime.IN:= NOT P3_LeakageTestB.IN.Kopito_ZASUNUTE;
			
			IF SC_P3_LeakageTestB.IdleTime.Q THEN
				P3_LeakageTestB.OUT.PneuZamokCentrovania_ODOMKNI:= FALSE;
				P3_LeakageTestB.OUT.PneuZamokZvonu_ODOMKNI:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 130;
			END_IF	
	
		
		130:
			SC_P3_LeakageTestB.StepName:='130 - Automaticky Rezim - spustenie testera';
			SC_P3_LeakageTestB.IdleTime.PT:= T#4s800ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		    
		
			IF NOT SC_P3_LeakageTestB.Switch1 AND AteqLeakageTester_B.Stav_READY THEN
				AteqLeakageTester_B.START_Testovania:= TRUE;
				SC_P3_LeakageTestB.IdleTime.IN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF	
		
                
			IF NOT AteqLeakageTester_B.Stav_READY AND AteqLeakageTester_B.Stav_START_DONE AND NOT AteqLeakageTester_B.VysledokTestovania_OK AND NOT AteqLeakageTester_B.VysledokTestovania_NG AND SC_P3_LeakageTestB.IdleTime.Q THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 133;
			END_IF	
		
		133:
			SC_P3_LeakageTestB.StepName:='133 - Automaticky Rezim - nacitanie parametrov testera';
			SC_P3_LeakageTestB.IdleTime.PT:= T#500ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			IF AteqLeakageTester_B.Stav_READY THEN
				AteqLeakageTester_B.START_Testovania:= FALSE;
				AteqLeakageTester_B.CitajParametreTestera:= TRUE;
			END_IF    
                
			SC_P3_LeakageTestB.IdleTime.IN:= AteqLeakageTester_B.Stav_CitanieParametrov_OK;
            
			IF AteqLeakageTester_B.Stav_CitanieParametrov_OK AND SC_P3_LeakageTestB.IdleTime.Q THEN    
				Reports.LeakageTest.CasPlnenia.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.CasPnenia);
				Reports.LeakageTest.CasStabilizacie.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.CasStabilizacie);
				Reports.LeakageTest.TlakPlnenia.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.TlakPlnenia);
				Reports.LeakageTest.ToleranciaPritlaku_MIN.StanicaB:= '';
				Reports.LeakageTest.ToleranciaPritlaku_MAX.StanicaB:= '';
				Reports.LeakageTest.TlakPritlaku.StanicaB:= REAL_TO_STRING(P3_LeakageTestB.PAR.PreratanyVyrovnavaciTlak_Bar);
				Reports.LeakageTest.TlakUniku.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.TlakUniku);
				Reports.LeakageTest.ToleranciaTlakUniku_MIN.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.Tolerancia * -1);
				Reports.LeakageTest.ToleranciaTlakUniku_MAX.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.Tolerancia);
				Reports.LeakageTest.Tolerancia.StanicaB:= REAL_TO_STRING(AteqLeakageTester_B.Tolerancia);
				AteqLeakageTester_B.CitajParametreTestera:= FALSE;
				IF P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 150;
				ELSE	
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 135;
				END_IF	
			END_IF	
		
            
		135:
			SC_P3_LeakageTestB.StepName:='135 - Automaticky Rezim - kontrola výsledku testu';
			SC_P3_LeakageTestB.IdleTime.PT:= T#1s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
            
			IF AteqLeakageTester_B.VysledokTestovania_OK THEN
				Paletka[i].STAV.LeakageTest_Ukonceny:= TRUE;
				Reports.LeakageTest.VyslednyReport.StanicaB:= 'PASS';
				Paletka[i].PAR.StavPowerCP:= 'PASS';
				IF Paletka[i].STAV.StavPaletky <> 'TEST'THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
				END_IF	
				PocetOpakovaniTestu:= 0;
				OpakovanyTest:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 150;
			ELSE 
				IF NOT TestovaciKus THEN
					PocetOpakovaniTestu:= PocetOpakovaniTestu + 1;
					OpakovanyTest:= TRUE;
				END_IF    
				Reports.LeakageTest.VyslednyReport.StanicaB:= 'FAIL';
				Paletka[i].PAR.StavPowerCP:= 'FAIL';
				IF Paletka[i].STAV.StavPaletky <> 'TEST'THEN
					Paletka[i].STAV.StavPaletky:= 'NG';
				END_IF	
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 150;
			END_IF
		
			//Otvorenie Leakage testera//	
		
		
		150:
			SC_P3_LeakageTestB.StepName:='150 - Automaticky Rezim - zasunutie spodneho kopita ';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
	
            
			P3_LeakageTestB.OUT.Kopito_VYSUN:= FALSE;
			P3_LeakageTestB.OUT.Kopito_ZASUN:= TRUE;
            
			IF P3_LeakageTestB.IN.Kopito_ZASUNUTE THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 153;
			END_IF    
		
		
		153:
			SC_P3_LeakageTestB.StepName:='153 - Automaticky Rezim - zasunutie horneho pritlaku';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				HornyPritlak_ZASUN:= TRUE;
				Centrovacku_ZASUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
				
			
			IF P3_LeakageTestB.IN.HornyPritlak_ZASUNUTY THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 155;
			END_IF	
		
		
		
		155:
			SC_P3_LeakageTestB.StepName:='155 - Automaticky Rezim - odcentrovanie paletky ';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_LeakageTestB.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_LeakageTestB.IN.Centrovanie_ZASUNUTE THEN
				IF P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY THEN
					P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY:= FALSE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 700;
				ELSE	
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 160;
				END_IF	
			END_IF	 
		
		160:
			SC_P3_LeakageTestB.StepName:='160 - Automaticky Rezim - rozhodnutie o opakovani testu ';
			SC_P3_LeakageTestB.IdleTime.PT:= T#1s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			SC_P3_LeakageTestB.IdleTime.IN:= TRUE;
			
			IF OpakovanyTest AND PocetOpakovaniTestu < 2 AND SC_P3_LeakageTestB.IdleTime.Q THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 120;
			ELSIF OpakovanyTest AND PocetOpakovaniTestu >= 2 THEN
				PocetOpakovaniTestu:= 0;
				OpakovanyTest:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 550;
			ELSIF NOT OpakovanyTest THEN
				PocetOpakovaniTestu:= 0;
				OpakovanyTest:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 550;
			END_IF	
			
			
			//**************************Odoslanie dát na server************************************//	
		550:
			SC_P3_LeakageTestB.StepName:='550 - Automaticky Rezim - odoslanie stavu paletky na server';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			IF Linka.KOM_Panatrace_OFF THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			ELSIF NOT SC_P3_LeakageTestB.Switch1 AND TRCB_P3_LeakageTestB_ST8B.STATUS.KOM_READY THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.OdosliStavPaletky_TYP2:= TRUE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF
			
			
			IF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.OdosliStavPaletky_TYP2:= FALSE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 552;
			ELSIF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaError THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.OdosliStavPaletky_TYP2:= FALSE;
				P3_LeakageTestB_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 557;
			END_IF
			
		
		552:
			SC_P3_LeakageTestB.StepName:='552 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
			
			IF NOT TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.PovolenieCinnostiNaPaletke = 'OK' THEN
					Paletka[i].STAV.Komunikacia_DONE:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.PovolenieCinnostiNaPaletke = 'NG' THEN
					IF Paletka[i].STAV.StavPaletky <> 'TEST'THEN
						Paletka[i].STAV.StavPaletky:= 'NG';
					END_IF	
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 560;
				END_IF	
			END_IF
			
			
		555:
			SC_P3_LeakageTestB.StepName:='555 - Automaticky Rezim - vyziadanie stavu komunikacie zo serverom'; 
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#10s;	
			
			IF NOT SC_P3_LeakageTestB.Switch1 AND TRCB_P3_LeakageTestB_ST8B.STATUS.KOM_READY THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= TRUE;
				SC_P3_LeakageTestB.Switch1:= TRUE;
			END_IF 
            
			IF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 556;
			ELSIF TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaError THEN	
				TRCB_P3_LeakageTestB_ST8B.CMD.VyziadajStavPanatrace_TYP4:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 557;
			END_IF	
			
		556:
			SC_P3_LeakageTestB.StepName:='556 - Automaticky Rezim - kontrola odpovede servera';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;		
			
			IF NOT TRCB_P3_LeakageTestB_ST8B.STATUS.KomunikaciaUkoncena THEN
				IF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '0;Generating' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 557;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '1;Request' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 557;	
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '2;Report' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 550;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '3;Wedding' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 557;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '4;Status' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 557;
				ELSIF TRCB_P3_LeakageTestB_ST8B.OUTPUTS.DruhCinnostiNaPaletke = '5;' THEN
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 557;
				ELSE
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 557;
				END_IF   
			END_IF	
		
		557:
			SC_P3_LeakageTestB.StepName:='557 - Automaticky Rezim - rozhodnutie obsluhy po chybe komunikacie s Panatrace';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
            
            
			P34_Vizu.ZobrazHL4_ST8:= TRUE;
            
			IF TRCB_P3_LeakTestB_OpatovnyDopyt THEN
				TRCB_P3_LeakTestB_OpatovnyDopyt:= FALSE; 
				P34_Vizu.ZobrazHL4_ST8:= FALSE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 555;
			ELSIF TRCB_P3_LeakTestB_PaletkaNG THEN
				TRCB_P3_LeakTestB_PaletkaNG:= FALSE;
				P34_Vizu.ZobrazHL4_ST8:= FALSE;
				Paletka[i].STAV.StavPaletky := 'NG';
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 560;
			END_IF   	
	
		
			//***************************Vyvezenie paletky**********************************************//	
		
		
		560:
			SC_P3_LeakageTestB.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na zdvizku za leakage testom B';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
		
			IF P3_LeakageTestB.KoniecCyklu THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 0;
			ELSIF P3_Pracovisko.STAV.Porucha_ST6 THEN
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 0;
			ELSIF NOT P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky AND
				SC_P3_ZdvizkaZaLeakTestB.Step = 100 AND
				NOT P3_LeakageTestB.STAV.PrebiehaVyvezeniePaletky AND
				NOT P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB AND
				P3_ZdvizkaZaLeakTestB.IN.Zdvizka_StrednaPoloha AND
				P3_ZdvizkaZaLeakTestA.STAV.PoINIT AND
				P3_ZdvizkaZaLeakTestB.STAV.PoINIT THEN
				P3_LeakageTestB.OUT.ZasunStoper:= TRUE;
				P3_LeakageTestB.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 561;
			END_IF	
		
		
		561:
			SC_P3_LeakageTestB.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na zdvizku za leakage testom B';
			SC_P3_LeakageTestB.IdleTime.PT:= T#200ms;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#10s;
		
			SC_P3_LeakageTestB.IdleTime.IN:= NOT P3_LeakageTestB.RFID_hlava.PritomnostPaletky;
			SC_P3_LeakageTestB.AlarmTime.IN:= P3_LeakageTestB.RFID_hlava.PritomnostPaletky;
           
			IF NOT P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN
				P3_LeakageTestB.OUT.ZasunStoper:= FALSE;
				TestovaciKus:= FALSE;
				OpakovanyTest:= FALSE;
				PocetOpakovaniTestu:= 0;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Reports.LeakageTest.CasPlnenia.StanicaB:= '';
				Reports.LeakageTest.VyslednyReport.StanicaB:= '';
				Reports.LeakageTest.CasStabilizacie.StanicaB:= '';
				Reports.LeakageTest.TlakPlnenia.StanicaB:= '';
				Reports.LeakageTest.ToleranciaPritlaku_MIN.StanicaB:= '';
				Reports.LeakageTest.ToleranciaPritlaku_MAX.StanicaB:= '';
				Reports.LeakageTest.TlakPritlaku.StanicaB:= '';
				Reports.LeakageTest.TlakUniku.StanicaB:= '';
				Reports.LeakageTest.Tolerancia.StanicaB:= '';
				SC_P3_LeakageTestB.ResetStep:= TRUE;
				SC_P3_LeakageTestB.Step:= 100;
			ELSIF SC_P3_LeakageTestB.AlarmTime.Q THEN
				P34_Alarmy[358]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF    
            
             
					
		
			
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P3_LeakageTestB.StepName:='700 - Manualny Rezim';
			SC_P3_LeakageTestB.IdleTime.PT:= T#8s;
			SC_P3_LeakageTestB.AlarmTime.PT:= T#5s;
		
			
		
			//Vysunutie spodneho kopita//
			IF P3_LeakageTestB.CMD.RR_VysunSpodneKopito THEN
				P3_LeakageTestB.OUT.Kopito_ZASUN:= FALSE;
				P3_LeakageTestB.OUT.Kopito_VYSUN:= TRUE;
			ELSE    
				P3_LeakageTestB.OUT.Kopito_VYSUN:= FALSE;
				P3_LeakageTestB.OUT.Kopito_ZASUN:= TRUE;
			END_IF
		
		
			//Testovacia sekvencia//
			IF P3_LeakageTestB.CMD.RR_TestovaciaSekvencia_START THEN
				IF P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN 
					P3_LeakageTestB.STAV.RR_TestovaciaSekvencia_BUSY:= TRUE;
					SC_P3_LeakageTestB.ResetStep:= TRUE;
					SC_P3_LeakageTestB.Step:= 120;
				END_IF	
				P3_LeakageTestB.CMD.RR_TestovaciaSekvencia_START:= FALSE;
			END_IF
		
		
			//Ovládanie centrovania paletky//
			IF P3_LeakageTestB.CMD.RR_VysunCentrovanie THEN
				P3_LeakageTestB.OUT.PneuZamokCentrovania_ODOMKNI:= TRUE;
				P3_LeakageTestB.OUT.Centrovanie_VYSUN:= TRUE;
			ELSE
				P3_LeakageTestB.OUT.PneuZamokCentrovania_ODOMKNI:= TRUE;
				P3_LeakageTestB.OUT.Centrovanie_VYSUN:= FALSE;
			END_IF	
		
			
			//Ovládanie horného prítlaku//
			IF P3_LeakageTestB.CMD.RR_HornyPritlak_VYSUN THEN
				P3_LeakageTestB.OUT.PneuZamokZvonu_ODOMKNI:= TRUE;
				P3_LeakageTestB.OUT.HornyPritlak_ZASUN:= FALSE;
				P3_LeakageTestB.OUT.HornyPritlak_VYSUN:= TRUE;
				P3_LeakageTestB.CMD.RR_HornyPritlak_VYSUN:= FALSE;
			ELSIF P3_LeakageTestB.CMD.RR_HornyPritlak_ZASUN THEN
				P3_LeakageTestB.OUT.PneuZamokZvonu_ODOMKNI:= TRUE;
				P3_LeakageTestB.OUT.HornyPritlak_ZASUN:= TRUE;
				P3_LeakageTestB.OUT.HornyPritlak_VYSUN:= FALSE;
				P3_LeakageTestB.CMD.RR_HornyPritlak_ZASUN:= FALSE;
			END_IF	
		
	
	END_CASE
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

