
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P4_FunkcnyTestB);
	
	
	//Volanie podprogramov//
	OvlCentrovacky;
	OvlHornychKontaktov;
	OvlSpodnychKontaktov;
	IOLinkKomunikacia;
	COM_Tester;
	
	//Reset sekcie //
	IF P4_FunkcnyTestB.Reset THEN
		SC_P4_FunkcnyTestB.Step:= 0;
		P4_FunkcnyTestB.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P4_FunkcnyTestB.Step:= 0;
	ELSIF NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN
		SC_P4_FunkcnyTestB.Step:= 0;	
	END_IF	
	
	CASE SC_P4_FunkcnyTestB.Step OF 
	
		0:
			SC_P4_FunkcnyTestB.StepName:='0 - Nulovanie';
			SC_OvlCentrovacky.Step:= 0;
			SC_OvlHornychKontaktov.Step:= 0;
			SC_OvlSpodnychKontaktov.Step:= 0;
			SC_OvlTesteraFT.Step:= 0;
			P4_FunkcnyTestB.Automat:= FALSE;
			P4_FunkcnyTestB.KoniecCyklu:= FALSE;
			P4_FunkcnyTestB.Manual:= FALSE;
			P4_FunkcnyTestB.STAV.PoINIT:= FALSE;
			P4_FunkcnyTestB.OUT.ZasunStoper:= FALSE;
			P4_FunkcnyTestB.OUT.KontaktyTestera_VYSUN:= FALSE;
			P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_VYSUN:= FALSE;
			P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_ZASUN:= TRUE;
			P4_FunkcnyTestB.OUT.PritlakPowerCP_VYSUN:= FALSE;
			P4_FunkcnyTestB.OUT.SpodneKontakty_VYSUN:= FALSE;
			P4_FunkcnyTestB.OUT.SpodneKontakty_ZASUN:= TRUE;
			P4_FunkcnyTestB.RFID_hlava.PrecitajChipRFID:= FALSE;
			P4_FunkcnyTestB.CMD.RR_OtvorTester:= FALSE;
			P4_FunkcnyTestB.CMD.RR_ZatvorTester:= FALSE;
			P4_FunkcnyTestB.CMD.StartTestovania:= FALSE;
			
			
			P3_ZdvizkaZaLeakTestB.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
			P4_FunkcnyTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			TestovaciKus:= FALSE;
			
			
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
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 1;
			END_IF
		
		
		1:
			SC_P4_FunkcnyTestB.StepName:='1 - Cakam na spustenie vyroby';
			P4_FunkcnyTestB.KoniecCyklu:= FALSE;
			IF P4_FunkcnyTestB.Automat THEN
				SC_P4_FunkcnyTestB.Step:= 2;
			ELSIF P4_FunkcnyTestB.Manual THEN
				SC_P4_FunkcnyTestB.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P4_FunkcnyTestB.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#500ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			
			SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
												
			IF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 5;
			END_IF	
		
		
		
		5:
			SC_P4_FunkcnyTestB.StepName:='5 - Inicializacia - zasunutie spodnych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				SpodneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestB.IN.SpodneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 8;
			END_IF	
		
		8:
			SC_P4_FunkcnyTestB.StepName:='8 - Inicializacia - zasunutie hornych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;	
				
				
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				HorneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestB.IN.HorneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 10;
			END_IF	
			
		
		10:
			SC_P4_FunkcnyTestB.StepName:='10 - Inicializacia - zasunutie cenrovacky';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestB.IN.Centrovanie_ZASUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 13;
			END_IF	
			
		
		13:
			SC_P4_FunkcnyTestB.StepName:='13 - Inicializacia - kontrola kontaktov Funkcneho testu';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#4s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			
			IF Linka.PAR.ZvolenyModel = '4F' AND P4_FunkcnyTestB.IN.TypSpodnychKontaktov_4F THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 15;
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND P4_FunkcnyTestB.IN.TypSpodnychKontaktov_5F_5H THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 15; 	
			ELSIF Linka.PAR.ZvolenyModel = '5H' AND P4_FunkcnyTestB.IN.TypSpodnychKontaktov_5F_5H THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 15;  
			ELSE
				P34_Alarmy[438]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
	
		15:
			SC_P4_FunkcnyTestB.StepName:='15 - Inicializacia - hladanie paletky';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#5s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			
			SC_P4_FunkcnyTestB.IdleTime.IN:= P4_Dopravniky.STAV.PoINIT;
	
			IF P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 20;		 
			ELSIF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 100;
			END_IF
		
		
		20:
			SC_P4_FunkcnyTestB.StepName:='20 - Inicializacia - precitanie cisla paletky';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
		
			SC_P4_FunkcnyTestB.IdleTime.IN:= P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky;
									
			IF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				P4_FunkcnyTestB.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
			END_IF
			
			IF P4_FunkcnyTestB.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P4_FunkcnyTestB.RFID_hlava.PrecitaneCisloPaletky;
				P4_FunkcnyTestB.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 23;
			END_IF	
			
		23:
			SC_P4_FunkcnyTestB.StepName:='23 - Inicializacia - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_FunkcnyTestB.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 30;
			ELSE
				P34_Alarmy[429]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		30:
			SC_P4_FunkcnyTestB.StepName:='30 - Inicializacia - kontrola stavu paletky'; 
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
		
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_FT1,FT2' THEN
				TestovaciKus:= TRUE;
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_FT1,FT2' THEN 
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_FT1,FT2' THEN
				IF P4_FunkcnyTestB.STAV.Tester_ON THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
					P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 110;
				ELSE
					P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_FT1,FT2' THEN
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;	
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 33;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;	
			END_IF	
			
		33:
			SC_P4_FunkcnyTestB.StepName:='33 - Inicializacia - kontrola ukonceneho HV testu'; 
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF Paletka[i].STAV.FunkcnyTest_Ukonceny THEN
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;
			ELSE
				P4_FunkcnyTestB.STAV.PoINIT:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 110;
			END_IF
		
		
		//********************************************************Automatický režim****************************************************************************//
		
		100:  
			SC_P4_FunkcnyTestB.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			SC_P4_FunkcnyTestB.IdleTime.IN:= P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky;
			
			IF P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN
				P3_ZdvizkaZaLeakTestB.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
			END_IF
                
			           
			IF P4_FunkcnyTestB.KoniecCyklu THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 0;
			ELSIF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 101;
			END_IF
		
		
		101:
			SC_P4_FunkcnyTestB.StepName:='101 - Automaticky Rezim - precitanie cisla paletky';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
			SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
		
												
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				P4_FunkcnyTestB.RFID_hlava.PrecitajChipRFID:= TRUE;
				i:= 0;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
			
			IF P4_FunkcnyTestB.RFID_hlava.Stav_CitanieZapis_OK THEN
				i:= P4_FunkcnyTestB.RFID_hlava.PrecitaneCisloPaletky;
				P4_FunkcnyTestB.RFID_hlava.PrecitajChipRFID:= FALSE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 102;
			END_IF	
		
		102:
			SC_P4_FunkcnyTestB.StepName:='102 - Automaticky Rezim - priradenie indexu paletky na zaklade precitanej hodnoty';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF i<> 0 THEN
				P4_FunkcnyTestB.PAR.CisloPaletky_STRING:= USINT_TO_STRING(i);
				Paletka[i].PAR.CisloPaletky:= USINT_TO_STRING(i);
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 103;
			ELSE
				P34_Alarmy[429]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		103:	
			SC_P4_FunkcnyTestB.StepName:='103 - Automaticky Rezim - kontrola stavu paletky'; 
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF Paletka[i].STAV.StavPaletky = 'PRECH' THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice = 'ST_FT1,FT2' THEN
				TestovaciKus:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'TEST' AND Paletka[i].STAV.CisloTestovacejStanice <> 'ST_FT1,FT2' THEN 
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice = 'ST_FT1,FT2' THEN
				IF P4_FunkcnyTestB.STAV.Tester_ON THEN
					Paletka[i].STAV.StavPaletky:= 'OK';
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 110;
				ELSE
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 560;
				END_IF	
			ELSIF Paletka[i].STAV.StavPaletky = 'REV' AND Paletka[i].STAV.CisloRevorkovejStanice <> 'ST_FT1,FT2' THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;	
			ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 110;
			ELSIF Paletka[i].STAV.StavPaletky = 'NG' THEN	
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 560;	
			END_IF	
		
		
		//Zatvorenie Funkèného testera//
		
		110:
			SC_P4_FunkcnyTestB.StepName:='110 - Automaticky Rezim - zacentrovanie paletky';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				Centrovacku_VYSUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
		
				
			IF P4_FunkcnyTestB.IN.Centrovanie_VYSUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 113;
			END_IF
		
		
		113:
			SC_P4_FunkcnyTestB.StepName:='113 - Automaticky Rezim - vysunutie pruzenia hornych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#500ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_ZASUN:= FALSE;
				P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_VYSUN:= TRUE;
				SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
			
			IF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 115;	
			END_IF	
		
		
		115:
			SC_P4_FunkcnyTestB.StepName:='115 - Automaticky Rezim - vysunutie hornych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				HorneKontakty_VYSUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestB.IN.HorneKontakty_VYSUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 118;
			END_IF
		
		118:
			SC_P4_FunkcnyTestB.StepName:='118 - Automaticky Rezim - vysunutie spodnych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				SpodneKontakty_VYSUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestB.IN.SpodneKontakty_VYSUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 120;
			END_IF
		
		120:
			SC_P4_FunkcnyTestB.StepName:='120 - Automaticky Rezim - pritlacenie kontaktov testera';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			P4_FunkcnyTestB.OUT.KontaktyTestera_VYSUN:= TRUE;
			SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
		
			IF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				IF P4_FunkcnyTestB.CMD.RR_ZatvorTester THEN
					P4_FunkcnyTestB.CMD.RR_ZatvorTester:= FALSE;
					P4_FunkcnyTestB.CMD.RR_OtvorTester:= FALSE;
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 700;
				ELSE	
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 130;
				END_IF	
			END_IF
		
		130:
			SC_P4_FunkcnyTestB.StepName:='130 - Automaticky Rezim - spustenie testera';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#2s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
			
			IF Linka.KOM_Panatrace_OFF AND SC_P4_FunkcnyTestB.IdleTime.Q THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 140;
			ELSIF NOT Linka.KOM_Panatrace_OFF THEN		
				P4_FunkcnyTestB.STAV.Vysledok_FV_Testu:= '';
				P4_FunkcnyTestB.CMD.StartTestovania:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 133;
			END_IF
		
		133:
			SC_P4_FunkcnyTestB.StepName:='133 - Automaticky Rezim - cakam na ukoncenie HV testu';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF P4_FunkcnyTestB.STAV.TestovanieUkoncene THEN
				Paletka[i].STAV.FunkcnyTest_Ukonceny:= TRUE;
				P4_FunkcnyTestB.CMD.StartTestovania:= FALSE;
				IF Paletka[i].STAV.StavPaletky = 'TEST' THEN
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 135;
				ELSIF Paletka[i].STAV.StavPaletky = 'OK' THEN	
					IF P4_FunkcnyTestB.STAV.Vysledok_FV_Testu = 'OK' THEN
						Paletka[i].STAV.StavPaletky:= 'OK';
					ELSIF P4_FunkcnyTestB.STAV.Vysledok_FV_Testu = 'NG' THEN
						Paletka[i].STAV.StavPaletky:= 'NG';
					END_IF
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 135;
				END_IF
			END_IF	
		
		
		
		135:
			SC_P4_FunkcnyTestB.StepName:='135 - Automaticky Rezim - cakam na zrusenie signalu Funkcny test ukonceny';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
							
			IF NOT P4_FunkcnyTestB.STAV.TestovanieUkoncene THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 140;
			END_IF
	
		
		//Otvorenie Funkcneho testera//	
		
		140:
			SC_P4_FunkcnyTestB.StepName:='140 - Automaticky Rezim - zasunutie pritlacenia kontaktov testera';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#1s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			P4_FunkcnyTestB.OUT.KontaktyTestera_VYSUN:= FALSE;
			SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
		
			IF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 143;
			END_IF	
		
		
		143:
			SC_P4_FunkcnyTestB.StepName:='143 - Automaticky Rezim - zasunutie spodnych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				SpodneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestB.IN.SpodneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 145;
			END_IF
		
		
		145:
			SC_P4_FunkcnyTestB.StepName:='145 - Automaticky Rezim - zasunutie hornych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				HorneKontakty_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
		
			IF P4_FunkcnyTestB.IN.HorneKontakty_ZASUNUTE THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 148;
			END_IF
		
		
		148:
			SC_P4_FunkcnyTestB.StepName:='148 - Automaticky Rezim - zasunutie pruzenia hornych kontaktov';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#500ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_VYSUN:= FALSE;
				P4_FunkcnyTestB.OUT.OdpruzHornychKontaktov_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.IdleTime.IN:= TRUE;
			END_IF
			
			IF SC_P4_FunkcnyTestB.IdleTime.Q THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 150;
			END_IF	
		
		150:
			SC_P4_FunkcnyTestB.StepName:='150 - Automaticky Rezim - odcentrovanie paletky';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_FunkcnyTestB.Switch1 THEN
				Centrovacku_ZASUN:= TRUE;
				SC_P4_FunkcnyTestB.Switch1:= TRUE;
			END_IF
		
				
			IF P4_FunkcnyTestB.IN.Centrovanie_ZASUNUTE THEN
				IF P4_FunkcnyTestB.CMD.RR_OtvorTester THEN
					P4_FunkcnyTestB.CMD.RR_OtvorTester:= FALSE;
					P4_FunkcnyTestB.CMD.RR_ZatvorTester:= FALSE;
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 700;
				ELSE	
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 560;
				END_IF	
			END_IF
		
		
		//***************************Vyvezenie paletky**********************************************//	
		560:					
			SC_P4_FunkcnyTestB.StepName:='560 - Automaticky Rezim - cakam na vyvezenie na zdvižku za Funkcnym Testom B';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
            					
			IF P4_FunkcnyTestB.KoniecCyklu THEN
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 0;
			ELSIF NOT P4_ZdvizkaZaFunkcTestB.IN.PritomnostPaletky AND
				SC_P4_ZdvizkaZaFunkcTestB.Step = 100 AND
				NOT P4_FunkcnyTestB.STAV.PrebiehaVyvezeniePaletky AND
				P4_ZdvizkaZaFunkcTestA.STAV.PoINIT AND
				P4_ZdvizkaZaFunkcTestB.STAV.PoINIT THEN
				P4_FunkcnyTestB.OUT.ZasunStoper:= TRUE;
				P4_FunkcnyTestB.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 561;
			END_IF	
		
		
		561:
			SC_P4_FunkcnyTestB.StepName:='561 - Automaticky Rezim - ukoncenie vyvazania na zdvižku za Funkcnym Testom B';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#200ms;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#10s;
		
			SC_P4_FunkcnyTestB.AlarmTime.IN:= P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky;
			SC_P4_FunkcnyTestB.IdleTime.IN:= NOT P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky;
			            
            
			IF NOT P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN
				TestovaciKus:= FALSE;
				Paletka[i].PAR.StavPowerCP:= '';
				Paletka[i].STAV.Komunikacia_DONE:= FALSE;
				Paletka[i].STAV.OdoslanieFotiek_DONE:= FALSE;
				P4_FunkcnyTestB.OUT.ZasunStoper:= FALSE;
				SC_P4_FunkcnyTestB.ResetStep:= TRUE;
				SC_P4_FunkcnyTestB.Step:= 100;
			ELSIF SC_P4_FunkcnyTestB.AlarmTime.Q THEN
				P34_Alarmy[451]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF    
           
          
			
			
	
			
			
			
			
		
		
			//*******************************************************Manuálny režim*******************************************************************************//	
		700:
			SC_P4_FunkcnyTestB.StepName:='700 - Manualny Rezim';
			SC_P4_FunkcnyTestB.IdleTime.PT:= T#8s;
			SC_P4_FunkcnyTestB.AlarmTime.PT:= T#5s;
		
		
			//Otváranie a zatváranie testera//
			IF P4_FunkcnyTestB.CMD.RR_ZatvorTester THEN
				IF P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN 
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 110;
				ELSE
					P4_FunkcnyTestB.CMD.RR_ZatvorTester:= FALSE;
				END_IF	
			ELSIF P4_FunkcnyTestB.CMD.RR_OtvorTester THEN
				IF P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN 
					SC_P4_FunkcnyTestB.ResetStep:= TRUE;
					SC_P4_FunkcnyTestB.Step:= 140;
				ELSE
					P4_FunkcnyTestB.CMD.RR_OtvorTester:= FALSE;
				END_IF	
			END_IF	
		
		
		
		
		
		
		
		
		
		
	
	END_CASE
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

