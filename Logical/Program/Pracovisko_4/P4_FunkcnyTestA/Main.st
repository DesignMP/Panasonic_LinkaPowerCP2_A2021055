
PROGRAM _INIT
	
	P4_FunkcnyTestA.PAR.CisloPortuKlienta:= 1040;
	 
END_PROGRAM

PROGRAM _CYCLIC

	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P4_FunkcnyTestA);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	OvlHornychKontaktov;
	OvlSpodnychKontaktov;
	IOLinkKomunikacia;
	COM_Tester;
	
	//Reset sekcie //
	IF P4_FunkcnyTestA.Reset THEN
		SC_P4_FunkcnyTestA.Step:= 0;
		P4_FunkcnyTestA.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P4_FunkcnyTestA.Step:= 0;
	END_IF	
	
	CASE SC_P4_FunkcnyTestA.Step OF 
	
		0:
			SC_P4_FunkcnyTestA.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			SC_OvlHornychKontaktov.Step:= 0;
			SC_OvlSpodnychKontaktov.Step:= 0;
			SC_OvlTesteraFT.Step:= 0;
			P4_FunkcnyTestA.Automat:= FALSE;
			P4_FunkcnyTestA.KoniecCyklu:= FALSE;
			P4_FunkcnyTestA.Manual:= FALSE;
			P4_FunkcnyTestA.STAV.PoINIT:= FALSE;
			P4_FunkcnyTestA.OUT.ZasunStoper:= FALSE;
			P4_FunkcnyTestA.OUT.KontaktyTestera_VYSUN:= FALSE;
			P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_VYSUN:= FALSE;
			P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_ZASUN:= TRUE;
			P4_FunkcnyTestA.OUT.PritlakPowerCP_VYSUN:= FALSE;
			P4_FunkcnyTestA.OUT.SpodneKontakty_VYSUN:= FALSE;
			P4_FunkcnyTestA.OUT.SpodneKontakty_ZASUN:= TRUE;
			P4_FunkcnyTestA.OUT.HorneKontakty_VYSUN:= FALSE;
			P4_FunkcnyTestA.OUT.HorneKontakty_ZASUN:= TRUE;
			P4_FunkcnyTestA.RFID_hlava.PrecitajChipRFID:= FALSE;
			P4_FunkcnyTestA.CMD.RR_ZatvorTester:= FALSE;
			P4_FunkcnyTestA.CMD.StartTestovania:= FALSE;
			P4_FunkcnyTestA.CMD.RR_VysunPruzenieKontaktov:= FALSE;
			P4_FunkcnyTestA.CMD.OpatovnyTest:= FALSE;
			P4_FunkcnyTestA.STAV.RR_SekvenciaTestera_BUSY:= FALSE;
			P4_FunkcnyTestA.STAV.PaletkaOznacena_NG:= FALSE;
			P34_Vizu.ZobrazHL1_FinalTestA:= FALSE;
			P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA:= FALSE;
			P4_FunkcnyTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			TestovaciKus:= FALSE;
			P4_FinalTestA_Taktime.IN.START_MeraniaCasu:= FALSE;
			P4_FinalTestA_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
			
			PocetDopytovNaTester:= 0;
		
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P4_ZonaBunky_AKTIVNA AND
				P4_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P4_Pracovisko.STAV.Porucha_ST1 AND
				NOT P4_Pracovisko.STAV.Porucha_ST2 AND
				NOT P4_Pracovisko.STAV.Porucha_ST3 AND
				NOT P4_Pracovisko.STAV.Porucha_ST4 AND
				NOT P4_Pracovisko.STAV.Porucha_ST5 AND
				NOT P4_Pracovisko.STAV.Porucha_ST6 THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 1;
			END_IF
		
		
		1:
			SC_P4_FunkcnyTestA.StepName:='1 - Cakam na spustenie vyroby';
			P4_FunkcnyTestA.KoniecCyklu:= FALSE;
			IF P4_FunkcnyTestA.Automat THEN
				SC_P4_FunkcnyTestA.Step:= 2;
			ELSIF P4_FunkcnyTestA.Manual THEN
				SC_P4_FunkcnyTestA.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
	
		2:
			SC_P4_FunkcnyTestA.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#500ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
			SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
												
			IF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 5;
			END_IF	
		
		
		
		5:
			SC_P4_FunkcnyTestA.StepName:='5 - Inicializacia - zasunutie spodnych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				SpodneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestA.IN.SpodneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 8;
			END_IF	
		
		8:
			SC_P4_FunkcnyTestA.StepName:='8 - Inicializacia - zasunutie hornych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;	
				
				
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				HorneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestA.IN.HorneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 10;
			END_IF	
			
		
		10:
			SC_P4_FunkcnyTestA.StepName:='10 - Inicializacia - zasunutie cenrovacky';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestA.IN.Centrovanie_ZASUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 13;
			END_IF	
			
		
		13:
			SC_P4_FunkcnyTestA.StepName:='13 - Inicializacia - kontrola kontaktov Funkcneho testu';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
			IF Linka.PAR.ZvolenyModel = '4F' AND P4_FunkcnyTestA.IN.TypSpodnychKontaktov_4F THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 15;
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND P4_FunkcnyTestA.IN.TypSpodnychKontaktov_5F_5H THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 15; 	
			ELSIF Linka.PAR.ZvolenyModel = '5H' AND P4_FunkcnyTestA.IN.TypSpodnychKontaktov_5F_5H THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 15;  
			ELSE
				P34_Alarmy[437]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
	
		15:
			SC_P4_FunkcnyTestA.StepName:='15 - Inicializacia - hladanie paletky';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#5s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
			SC_P4_FunkcnyTestA.IdleTime.IN:= P4_Dopravniky.STAV.PoINIT;
	
			IF P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 20;		 
			ELSIF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 100;
			END_IF
		
		
		20:
			SC_P4_FunkcnyTestA.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
		
			SC_P4_FunkcnyTestA.IdleTime.IN:= P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky;
									
			IF SC_P4_FunkcnyTestA.IdleTime.Q AND NOT SC_P4_FunkcnyTestA.Switch1 THEN
				P4_FunkcnyTestA.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestA.RFID_hlava.Stav_CitanieZapis_OK AND P4_FunkcnyTestA.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P4_FunkcnyTestA.RFID_hlava.PrecitaneCisloPaletky;
				P4_FunkcnyTestA.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 23;
			END_IF	
			
		23:
			SC_P4_FunkcnyTestA.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_FunkcnyTestA.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 30;
			ELSE
				P34_Alarmy[427]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
		30:
			SC_P4_FunkcnyTestA.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
		
			IF Paletka[i].STAV.StavPaletky = '' THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_FT1,FT2' THEN
				TestovaciKus:= TRUE;
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_FT1,FT2' THEN 
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_FT1,FT2' THEN
				IF P4_FunkcnyTestA.STAV.Tester_ON THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
					P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 110;
				ELSE
					P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_FT1,FT2' THEN
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;	
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;	
			END_IF	
			
		33:
			SC_P4_FunkcnyTestA.StepName:='33 - Inicializacia - kontrola ukonceneho HV testu'; 
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF Paletka[i].STAV.FunkcnyTest_Ukonceny THEN
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSE
				P4_FunkcnyTestA.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 110;
			END_IF
		
		
		//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P4_FunkcnyTestA.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			SC_P4_FunkcnyTestA.IdleTime.IN:= P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky;
			
			IF P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky THEN
				P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA:= FALSE;
			END_IF
            
			IF NOT SC_P4_FunkcnyTestA.Switch1 AND P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky THEN
				P4_FinalTestA_Taktime.IN.START_MeraniaCasu:= TRUE;
				P4_FinalTestA_Taktime.IN.ZAPIS_MeraniaCasu:= TRUE;
				P4_FinalTestA_Taktime.IN.ZAPIS_StratovyCas:= TRUE;
				Buffer_11.Hodnota:= P4_FinalTestA_Taktime.OUT.StratoveSekundy;
				Buffer_11.ZapisHodnotu:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF	
			
			           
			IF P4_FunkcnyTestA.KoniecCyklu THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 0;
			ELSIF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 101;
			END_IF
		
		
		101:
			SC_P4_FunkcnyTestA.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
		
												
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				P4_FunkcnyTestA.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestA.RFID_hlava.Stav_CitanieZapis_OK AND P4_FunkcnyTestA.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P4_FunkcnyTestA.RFID_hlava.PrecitaneCisloPaletky;
				P4_FunkcnyTestA.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 102;
			END_IF	
		
		102:
			SC_P4_FunkcnyTestA.StepName:='102 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_FunkcnyTestA.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 103;
			ELSE
				P34_Alarmy[427]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF
		
		103:	
			SC_P4_FunkcnyTestA.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF Paletka[i].STAV.StavPaletky = '' THEN
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_FT1,FT2' THEN
				TestovaciKus:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_FT1,FT2' THEN 
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_FT1,FT2' THEN
				IF P4_FunkcnyTestA.STAV.Tester_ON THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 110;
				ELSE
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_FT1,FT2' THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;	
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 560;	
			END_IF	
		
		
		//Zatvorenie Funkèného testera//
		
		110:
			SC_P4_FunkcnyTestA.StepName:='110 - Automaticky Rezim - zacentrovanie paletky';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
		
				
			IF P4_FunkcnyTestA.IN.Centrovanie_VYSUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 113;
			END_IF
		
		
		113:
			SC_P4_FunkcnyTestA.StepName:='113 - Automaticky Rezim - vysunutie pruzenia hornych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#500ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_ZASUN:= FALSE;
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_VYSUN:= TRUE;
				SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 115;	
			END_IF	
		
		
		115:
			SC_P4_FunkcnyTestA.StepName:='115 - Automaticky Rezim - vysunutie hornych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				HorneKontakty_VYSUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestA.IN.HorneKontakty_VYSUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 118;
			END_IF
		
		118:
			SC_P4_FunkcnyTestA.StepName:='118 - Automaticky Rezim - vysunutie spodnych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				SpodneKontakty_VYSUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestA.IN.SpodneKontakty_VYSUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 120;
			END_IF
		
		120:
			SC_P4_FunkcnyTestA.StepName:='120 - Automaticky Rezim - pritlacenie kontaktov testera';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			P4_FunkcnyTestA.OUT.KontaktyTestera_VYSUN:= TRUE;
			SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
		
			IF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				IF P4_FunkcnyTestA.Manual THEN
					IF NOT P4_FunkcnyTestA.CMD.RR_ZatvorTester THEN
						SC_P4_FunkcnyTestA.ResetStep:= TRUE;
						SC_P4_FunkcnyTestA.Step:= 140;
					END_IF	
				ELSE	
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 130;
				END_IF	
			END_IF
		
		130:
			SC_P4_FunkcnyTestA.StepName:='130 - Automaticky Rezim - spustenie testera';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#2s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF THEN
				IF SC_P4_FunkcnyTestA.IdleTime.Q THEN
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 140;
				END_IF
			ELSE	
				P4_FunkcnyTestA.STAV.Vysledok_FV_Testu:= '';
				P4_FunkcnyTestA.CMD.StartTestovania:= TRUE;
				P4_FinalTestA_Taktime.IN.START_MeraniaStratovehoCasu:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 133;
			END_IF	
		
		
		
		133:
			SC_P4_FunkcnyTestA.StepName:='133 - Automaticky Rezim - cakam na ukoncenie HV testu';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF P4_FunkcnyTestA.STAV.TestovanieUkoncene THEN
				P4_FinalTestA_Taktime.IN.START_MeraniaStratovehoCasu:= FALSE;
				Paletka[i].STAV.FunkcnyTest_Ukonceny:= TRUE;
				P4_FunkcnyTestA.CMD.StartTestovania:= FALSE;
				IF Paletka[i].STAV.StavPaletky = 'TEST' THEN
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 135;
				ELSE 	
					IF P4_FunkcnyTestA.STAV.Vysledok_FV_Testu = 'OK' THEN
						Paletka[i].STAV.StavPaletky:= 'OK';
					ELSIF P4_FunkcnyTestA.STAV.Vysledok_FV_Testu = 'NG' THEN
						Paletka[i].STAV.StavPaletky:= 'NG';
					END_IF
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 135;
				END_IF
			ELSIF P4_FunkcnyTestA.STAV.TesterNeodpoveda THEN
				P4_FunkcnyTestA.CMD.StartTestovania:= FALSE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 134;
			END_IF	
	
			
			
		134:
			SC_P4_FunkcnyTestA.StepName:='134 - Automaticky Rezim - zobrazenie hlasenia tester neodpoveda';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
			
			P34_Vizu.ZobrazHL1_FinalTestA:= TRUE;
			
			IF P4_FunkcnyTestA.CMD.OpatovnyTest THEN
				P4_FunkcnyTestA.CMD.OpatovnyTest:= FALSE;
				P34_Vizu.ZobrazHL1_FinalTestA:= FALSE;
				IF P4_FunkcnyTestA.PAR.CisloPortuKlienta < 1049 THEN
					P4_FunkcnyTestA.PAR.CisloPortuKlienta:= P4_FunkcnyTestA.PAR.CisloPortuKlienta + 1;
				ELSE
					P4_FunkcnyTestA.PAR.CisloPortuKlienta:= 1040;
				END_IF	
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 130;
			ELSIF P4_FunkcnyTestA.STAV.PaletkaOznacena_NG THEN
				P4_FunkcnyTestA.STAV.PaletkaOznacena_NG:= FALSE;
				P34_Vizu.ZobrazHL1_FinalTestA:= FALSE;
				Paletka[i].STAV.StavPaletky:= 'NG';
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 135;
			END_IF	
			
			
			
			
		
		135:
			SC_P4_FunkcnyTestA.StepName:='135 - Automaticky Rezim - cakam na zrusenie signalu Funkcny test ukonceny';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
							
			IF NOT P4_FunkcnyTestA.STAV.TestovanieUkoncene THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 140;
			END_IF
	
		
			//Otvorenie Funkcneho testera//	
			
							
		140:
			SC_P4_FunkcnyTestA.StepName:='140 - Automaticky Rezim - zasunutie pritlacenia kontaktov testera';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			P4_FunkcnyTestA.OUT.KontaktyTestera_VYSUN:= FALSE;
			SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
		
			IF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 143;
			END_IF	
		
		
		143:
			SC_P4_FunkcnyTestA.StepName:='143 - Automaticky Rezim - zasunutie spodnych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				P4_FunkcnyTestA.OUT.PritlakPowerCP_VYSUN:= TRUE;
				SpodneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestA.IN.SpodneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 145;
			END_IF
		
		
		145:
			SC_P4_FunkcnyTestA.StepName:='145 - Automaticky Rezim - zasunutie hornych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				HorneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestA.IN.HorneKontakty_ZASUNUTE THEN
				P4_FunkcnyTestA.OUT.PritlakPowerCP_VYSUN:= FALSE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 148;
			END_IF
		
		
		148:
			SC_P4_FunkcnyTestA.StepName:='148 - Automaticky Rezim - zasunutie pruzenia hornych kontaktov';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#500ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_VYSUN:= FALSE;
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.IdleTime.IN:= TRUE;
			END_IF
			
			IF SC_P4_FunkcnyTestA.IdleTime.Q THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 150;
			END_IF	
		
		150:
			SC_P4_FunkcnyTestA.StepName:='150 - Automaticky Rezim - odcentrovanie paletky';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestA.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_FunkcnyTestA.Switch1:= TRUE;
			END_IF
		
				
			IF P4_FunkcnyTestA.IN.Centrovanie_ZASUNUTE THEN
				IF P4_FunkcnyTestA.Manual THEN
					P4_FunkcnyTestA.STAV.RR_SekvenciaTestera_BUSY:= FALSE;
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 700;
				ELSE	
					SC_P4_FunkcnyTestA.ResetStep:= TRUE;
					SC_P4_FunkcnyTestA.Step:= 560;
				END_IF	
			END_IF
		
		
		//***************************Vyvezenie paletky**********************************************//	
		
		560:					
			SC_P4_FunkcnyTestA.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na zdvižku za Funkcnym Testom A';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
            					
			IF P4_FunkcnyTestA.KoniecCyklu THEN
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 0;
			ELSIF NOT P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky AND
				SC_P4_ZdvizkaZaFunkcTestA.Step = 100 AND
				NOT P4_FunkcnyTestA.STAV.PrebiehaVyvezeniePaletky AND
				NOT P4_ZdvizkaZaFunkcTestB.STAV.PrebiehaVyvezeniePaletky AND
				P4_ZdvizkaZaFunkcTestA.STAV.PoINIT AND
				P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_StrednaPoloha AND
				P4_ZdvizkaZaFunkcTestB.STAV.PoINIT THEN
				P4_FunkcnyTestA.OUT.ZasunStoper:= TRUE;
				P4_FunkcnyTestA.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 561;
			END_IF	
		
		
		561:
			SC_P4_FunkcnyTestA.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na zdvižku za Funkcnym Testom A';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#10s;
		
			SC_P4_FunkcnyTestA.AlarmTime.IN:= P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky;
			SC_P4_FunkcnyTestA.IdleTime.IN:= NOT P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky;
			            
            
			IF NOT P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				P4_FunkcnyTestA.OUT.ZasunStoper:= FALSE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 100;
			ELSIF SC_P4_FunkcnyTestA.AlarmTime.Q THEN
				P34_Alarmy[450]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF    
           
          
			
			
	
			
			
			
			
		
		
		//*******************************************************Manuálny režim*******************************************************************************//	
		700:
			SC_P4_FunkcnyTestA.StepName:='700 - Manualny Rezim';
			SC_P4_FunkcnyTestA.IdleTime.PT:= T#8s;
			SC_P4_FunkcnyTestA.AlarmTime.PT:= T#5s;
		
		
			//Sekvencia zatvárania testera//
			IF P4_FunkcnyTestA.CMD.RR_ZatvorTester THEN
				P4_FunkcnyTestA.STAV.RR_SekvenciaTestera_BUSY:= TRUE;
				SC_P4_FunkcnyTestA.ResetStep:= TRUE;
				SC_P4_FunkcnyTestA.Step:= 110;
			END_IF	
		
		
			//Ovládanie zdvižky//
			IF P4_FunkcnyTestA.CMD.RR_VysunCentrovanie THEN
				P4_FunkcnyTestA.OUT.Centrovanie_VYSUN:= TRUE;
				P4_FunkcnyTestA.OUT.Centrovanie_ZASUN:= FALSE;
			ELSE
				P4_FunkcnyTestA.OUT.Centrovanie_VYSUN:= FALSE;
				P4_FunkcnyTestA.OUT.Centrovanie_ZASUN:= TRUE;
			END_IF	
		
			//Ovládanie pruženia horných kontaktov//
			IF P4_FunkcnyTestA.CMD.RR_VysunPruzenieKontaktov THEN
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_ZASUN:= FALSE;
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_VYSUN:= TRUE;
			ELSE
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_ZASUN:= TRUE;
				P4_FunkcnyTestA.OUT.OdpruzHornychKontaktov_VYSUN:= FALSE;
			END_IF	
		
		
		
		
		
	END_CASE
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

