
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
			
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_HV_Test);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	OvlHornychKontaktov;
	OvlSpodnychKontaktov;
	IOLinkKomunikacia;
	COM_Tester;
	
	//Reset sekcie //
	IF P3_HV_Test.Reset THEN
		SC_P3_HV_Test.Step:= 0;
		P3_HV_Test.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_HV_Test.Step:= 0;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		SC_P3_HV_Test.Step:= 0;	
	END_IF	
	
	
	CASE SC_P3_HV_Test.Step OF 
	
		0:
			SC_P3_HV_Test.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			SC_OvlHornychKontaktov.Step:= 0;
			SC_OvlSpodnychKontaktov.Step:= 0;
			SC_OvlTesteraHV.Step:= 0;
			P3_HV_Test.Automat:= FALSE;
			P3_HV_Test.KoniecCyklu:= FALSE;
			P3_HV_Test.Manual:= FALSE;
			P3_HV_Test.STAV.PoINIT:= FALSE;
			P3_HV_Test.OUT.ZasunStoper:= FALSE;
			P3_HV_Test.OUT.PritlacenieKontaktovTestera_ON:= FALSE;
			P3_HV_Test.OUT.PruzenieHornychKontaktov_VYSUN:= FALSE;
			P3_HV_Test.OUT.PruzenieHornychKontaktov_ZASUN:= TRUE;
			P3_HV_Test.OUT.HorneKontakty_VYSUN:= FALSE;
			P3_HV_Test.OUT.HorneKontakty_ZASUN:= TRUE;
			P3_HV_Test.OUT.SpodneKontakty_VYSUN:= FALSE;
			P3_HV_Test.OUT.SpodneKontakty_ZASUN:= TRUE;
			P3_HV_Test.RFID_hlava.PrecitajChipRFID:= FALSE;
			P3_HV_Test.CMD.RR_OtvorTester:= FALSE;
			P3_HV_Test.CMD.RR_ZatvorTester:= FALSE;
			P3_HV_Test.CMD.StartTestovania:= FALSE;
			
			
			P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P3_HV_Test.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			TestovaciKus:= FALSE;
			
			
			PocetDopytovNaTester:= 0;
		
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
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 1;
			END_IF
		
		
		1:
			SC_P3_HV_Test.StepName:='1 - Cakam na spustenie vyroby';
			P3_HV_Test.KoniecCyklu:= FALSE;
			IF P3_HV_Test.Automat THEN
				SC_P3_HV_Test.Step:= 2;
			ELSIF P3_HV_Test.Manual THEN
				SC_P3_HV_Test.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P3_HV_Test.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_HV_Test.IdleTime.PT:= T#500ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			
			SC_P3_HV_Test.IdleTime.IN:= TRUE;
												
			IF SC_P3_HV_Test.IdleTime.Q THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 5;
			END_IF	
		
			
		5:
			SC_P3_HV_Test.StepName:='5 - Inicializacia - zasunutie spodnych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#4s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_HV_Test.Switch1 THEN
				SpodneKontakty_ZASUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
			
			IF P3_HV_Test.IN.SpodneKontakty_ZASUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 8;
			END_IF	
		
				
				
		8:
			SC_P3_HV_Test.StepName:='8 - Inicializacia - zasunutie hornych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#4s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;	
				
				
			IF NOT SC_P3_HV_Test.Switch1 THEN
				HorneKontakty_ZASUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
			
			IF P3_HV_Test.IN.HorneKontakty_ZASUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 10;
			END_IF	
			
					
				
			
		10:
			SC_P3_HV_Test.StepName:='10 - Inicializacia - zasunutie cenrovacky';
			SC_P3_HV_Test.IdleTime.PT:= T#4s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_HV_Test.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
			
			IF P3_HV_Test.IN.Centrovanie_ZASUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 13;
			END_IF	
			
				
		
		13:
			SC_P3_HV_Test.StepName:='13 - Inicializacia - kontrola kontaktov HV testu';
			SC_P3_HV_Test.IdleTime.PT:= T#4s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			
			IF Linka.PAR.ZvolenyModel = '4F' AND P3_HV_Test.IN.TypKonektoru_4F THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 15;
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND P3_HV_Test.IN.TypKonektoru_5F_5H THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 15; 	
			ELSIF Linka.PAR.ZvolenyModel = '5H' AND P3_HV_Test.IN.TypKonektoru_5F_5H THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 15;  
			ELSE
				P34_Alarmy[326]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		
		15:
			SC_P3_HV_Test.StepName:='15 - Inicializacia - hladanie paletky';
			SC_P3_HV_Test.IdleTime.PT:= T#5s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			
			SC_P3_HV_Test.IdleTime.IN:= P3_Dopravniky.STAV.PoINIT;
	
			IF P3_HV_Test.RFID_hlava.PritomnostPaletky THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 20;		 
			ELSIF SC_P3_HV_Test.IdleTime.Q THEN
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 100;
			END_IF
		
		
		20:
			SC_P3_HV_Test.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			SC_P3_HV_Test.IdleTime.IN:= TRUE;
		
			SC_P3_HV_Test.IdleTime.IN:= P3_HV_Test.RFID_hlava.PritomnostPaletky;
									
			IF SC_P3_HV_Test.IdleTime.Q THEN
				P3_HV_Test.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P3_HV_Test.RFID_hlava.Stav_CitanieZapis_OK AND P3_HV_Test.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P3_HV_Test.RFID_hlava.PrecitaneCisloPaletky;
				P3_HV_Test.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 23;
			END_IF	
			
		23:
			SC_P3_HV_Test.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P3_HV_Test.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 30;
			ELSE
				P34_Alarmy[366]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		30:
			SC_P3_HV_Test.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
		
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_7' THEN
				TestovaciKus:= TRUE;
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_7' THEN 
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' THEN
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;	
			END_IF	
			
		33:
			SC_P3_HV_Test.StepName:='33 - Inicializacia - kontrola ukonceneho HV testu'; 
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF Paletka[i].STAV.HV_Test_Ukonceny THEN
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSE
				P3_HV_Test.STAV.PoINIT:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 110;
			END_IF
		
		
			//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P3_HV_Test.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			SC_P3_HV_Test.IdleTime.IN:= P3_HV_Test.RFID_hlava.PritomnostPaletky;
			
			IF P3_HV_Test.RFID_hlava.PritomnostPaletky THEN
				P3_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF
                
			           
			IF P3_HV_Test.KoniecCyklu THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 0;
			ELSIF SC_P3_HV_Test.IdleTime.Q THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 101;
			END_IF
		
		101:
			SC_P3_HV_Test.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
			SC_P3_HV_Test.IdleTime.IN:= TRUE;
		
												
			IF NOT SC_P3_HV_Test.Switch1 THEN
				P3_HV_Test.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
			
			IF P3_HV_Test.RFID_hlava.Stav_CitanieZapis_OK AND P3_HV_Test.RFID_hlava.PrecitaneCisloPaletky <> 0 THEN
				i:= P3_HV_Test.RFID_hlava.PrecitaneCisloPaletky;
				P3_HV_Test.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 102;
			END_IF	
			
		102:
			SC_P3_HV_Test.StepName:='102 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P3_HV_Test.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 103;
			ELSE
				P34_Alarmy[366]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		103:	
			SC_P3_HV_Test.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
		
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_7' THEN
				TestovaciKus:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_7' THEN 
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 560;	
			END_IF	
		
	
			//Zatvorenie HV testera//
			
			
			
		110:
			SC_P3_HV_Test.StepName:='110 - Automaticky Rezim - zacentrovanie paletky';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
		
				
			IF P3_HV_Test.IN.Centrovanie_VYSUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 113;
			END_IF
		
		
		113:
			SC_P3_HV_Test.StepName:='113 - Automaticky Rezim - vysunutie pruzenia hornych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#500ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				P3_HV_Test.OUT.PruzenieHornychKontaktov_ZASUN:= FALSE;
				P3_HV_Test.OUT.PruzenieHornychKontaktov_VYSUN:= TRUE;
				SC_P3_HV_Test.IdleTime.IN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_HV_Test.IdleTime.Q THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 115;
			END_IF	
		
		
		
		115:
			SC_P3_HV_Test.StepName:='115 - Automaticky Rezim - vysunutie hornych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				HorneKontakty_VYSUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
		
			IF P3_HV_Test.IN.HorneKontakty_VYSUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 118;
			END_IF
		
		
		118:
			SC_P3_HV_Test.StepName:='118 - Automaticky Rezim - vysunutie spodnych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				SpodneKontakty_VYSUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
		
			IF P3_HV_Test.IN.SpodneKontakty_VYSUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 120;
			END_IF
		
		120:
			SC_P3_HV_Test.StepName:='120 - Automaticky Rezim - pritlacenie kontaktov testera';
			SC_P3_HV_Test.IdleTime.PT:= T#1s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			P3_HV_Test.OUT.PritlacenieKontaktovTestera_ON:= TRUE;
			SC_P3_HV_Test.IdleTime.IN:= TRUE;
		
			IF SC_P3_HV_Test.IdleTime.Q THEN
				IF P3_HV_Test.CMD.RR_ZatvorTester THEN
					P3_HV_Test.CMD.RR_ZatvorTester:= FALSE;
					P3_HV_Test.CMD.RR_OtvorTester:= FALSE;
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 700;
				ELSE	
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 130;
				END_IF	
			END_IF
		
	
		
		130:
			SC_P3_HV_Test.StepName:='130 - Automaticky Rezim - spustenie testera';
			SC_P3_HV_Test.IdleTime.PT:= T#2s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			SC_P3_HV_Test.IdleTime.IN:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF AND SC_P3_HV_Test.IdleTime.Q THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 140;
			ELSIF NOT Linka.KOM_Panatrace_OFF THEN	
				P3_HV_Test.STAV.Vysledok_HV_Testu:= '';
				P3_HV_Test.CMD.StartTestovania:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 133;
			END_IF	
		
		133:
			SC_P3_HV_Test.StepName:='133 - Automaticky Rezim - cakam na ukoncenie HV testu';
			SC_P3_HV_Test.IdleTime.PT:= T#1s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF P3_HV_Test.STAV.TestovanieUkoncene THEN
				Paletka[i].STAV.HV_Test_Ukonceny:= TRUE;
				P3_HV_Test.CMD.StartTestovania:= FALSE;
				IF Paletka[i].STAV.StavPaletky = 'TEST' THEN
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 135;
				ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN	
					IF P3_HV_Test.STAV.Vysledok_HV_Testu = 'OK' THEN
						Paletka[i].STAV.StavPaletky:= 'OK';
					ELSIF P3_HV_Test.STAV.Vysledok_HV_Testu = 'NG' THEN
						Paletka[i].STAV.StavPaletky:= 'NG';
					END_IF
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 135;
				END_IF
			END_IF	
						
		
		
		135:
			SC_P3_HV_Test.StepName:='135 - Automaticky Rezim - cakam na zrusenie signalu HV test ukonceny';
			SC_P3_HV_Test.IdleTime.PT:= T#1s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
							
			IF NOT P3_HV_Test.STAV.TestovanieUkoncene THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 140;
			END_IF
	
			//Otvorenie HV testera//	
			
							
		140:
			SC_P3_HV_Test.StepName:='140 - Automaticky Rezim - zasunutie pritlacenia kontaktov testera';
			SC_P3_HV_Test.IdleTime.PT:= T#1s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			P3_HV_Test.OUT.PritlacenieKontaktovTestera_ON:= FALSE;
			SC_P3_HV_Test.IdleTime.IN:= TRUE;
		
			IF SC_P3_HV_Test.IdleTime.Q THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 143;
			END_IF	
		
		
		143:
			SC_P3_HV_Test.StepName:='143 - Automaticky Rezim - zasunutie spodnych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				SpodneKontakty_ZASUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
		
			IF P3_HV_Test.IN.SpodneKontakty_ZASUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 145;
			END_IF
		
		
		145:
			SC_P3_HV_Test.StepName:='145 - Automaticky Rezim - zasunutie hornych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				HorneKontakty_ZASUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
		
			IF P3_HV_Test.IN.HorneKontakty_ZASUNUTE THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 148;
			END_IF
		
		148:
			SC_P3_HV_Test.StepName:='148 - Automaticky Rezim - zasunutie pruzenia hornych kontaktov';
			SC_P3_HV_Test.IdleTime.PT:= T#500ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				P3_HV_Test.OUT.PruzenieHornychKontaktov_VYSUN:= FALSE;
				P3_HV_Test.OUT.PruzenieHornychKontaktov_ZASUN:= TRUE;
				SC_P3_HV_Test.IdleTime.IN:= TRUE;
			END_IF
			
			IF SC_P3_HV_Test.IdleTime.Q THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 150;
			END_IF	
		
		
		150:
			SC_P3_HV_Test.StepName:='150 - Automaticky Rezim - odcentrovanie paletky';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_HV_Test.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P3_HV_Test.Switch1:= TRUE;
			END_IF
		
				
			IF P3_HV_Test.IN.Centrovanie_ZASUNUTE THEN
				IF P3_HV_Test.CMD.RR_OtvorTester THEN
					P3_HV_Test.CMD.RR_OtvorTester:= FALSE;
					P3_HV_Test.CMD.RR_ZatvorTester:= FALSE;
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 700;
				ELSE	
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 560;
				END_IF	
			END_IF
		
		
			//***************************Vyvezenie paletky**********************************************//	
		560:					
			SC_P3_HV_Test.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na zdvižku pred Leakage Testom A';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
            					
			IF P3_HV_Test.KoniecCyklu THEN
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 0;
			ELSIF NOT P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky AND
				SC_P3_ZdvizkaPredLeakTestA.Step = 100 AND
				NOT P3_HV_Test.STAV.PrebiehaVyvezeniePaletky AND
				P3_ZdvizkaPredLeakTestA.STAV.PoINIT THEN
				P3_HV_Test.OUT.ZasunStoper:= TRUE;
				P3_HV_Test.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 561;
			END_IF	
		
		
		561:
			SC_P3_HV_Test.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na zdvižku pred Leakage Testom A';
			SC_P3_HV_Test.IdleTime.PT:= T#200ms;
			SC_P3_HV_Test.AlarmTime.PT:= T#10s;
		
			SC_P3_HV_Test.AlarmTime.IN:= P3_HV_Test.RFID_hlava.PritomnostPaletky;
			SC_P3_HV_Test.IdleTime.IN:= NOT P3_HV_Test.RFID_hlava.PritomnostPaletky;
			            
            
			IF NOT P3_HV_Test.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				P3_HV_Test.OUT.ZasunStoper:= FALSE;
				SC_P3_HV_Test.ResetStep:= TRUE;
				SC_P3_HV_Test.Step:= 100;
			ELSIF SC_P3_HV_Test.AlarmTime.Q THEN
				P34_Alarmy[367]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF    
           
          
			
			
	
			
			
			
			
		
		
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P3_HV_Test.StepName:='700 - Manualny Rezim';
			SC_P3_HV_Test.IdleTime.PT:= T#8s;
			SC_P3_HV_Test.AlarmTime.PT:= T#5s;
		
		
			//Otváranie a zatváranie testera//
			IF P3_HV_Test.CMD.RR_ZatvorTester THEN
				IF P3_HV_Test.RFID_hlava.PritomnostPaletky THEN 
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 110;
				ELSE
					P3_HV_Test.CMD.RR_ZatvorTester:= FALSE;
				END_IF	
			ELSIF P3_HV_Test.CMD.RR_OtvorTester THEN
				IF P3_HV_Test.RFID_hlava.PritomnostPaletky THEN 
					SC_P3_HV_Test.ResetStep:= TRUE;
					SC_P3_HV_Test.Step:= 140;
				ELSE
					P3_HV_Test.CMD.RR_OtvorTester:= FALSE;
				END_IF	
			END_IF	
		
		
		
	END_CASE
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

