
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_ZdvizkaZaLeakTestA);
	
	
	//Volanie podprogramov//
	OvlZdvizky;
	
	//Reset sekcie //
	IF P3_ZdvizkaZaLeakTestA.Reset THEN
		SC_P3_ZdvizkaZaLeakTestA.Step:= 0;
		P3_ZdvizkaZaLeakTestA.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_ZdvizkaZaLeakTestA.Step:= 0;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		SC_P3_ZdvizkaZaLeakTestA.Step:= 0;	
	END_IF	
	
	 
	CASE SC_P3_ZdvizkaZaLeakTestA.Step OF 
	
		0:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='0 - Nulovanie';
			SC_OvlZdvizky.Step:= 0;
			P3_ZdvizkaZaLeakTestA.Automat:= FALSE;
			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= FALSE;
			P3_ZdvizkaZaLeakTestA.Manual:= FALSE;
			P3_ZdvizkaZaLeakTestA.STAV.PoINIT:= FALSE;
			P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
			P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
			P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= FALSE;
			P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= FALSE;			
			P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA:= FALSE;
			P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
			P3_LeakageTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
		
		
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
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 1;
			END_IF
		
		
		1:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='1 - Cakam na spustenie vyroby';
			P3_ZdvizkaZaLeakTestA.KoniecCyklu:= FALSE;
			IF P3_ZdvizkaZaLeakTestA.Automat THEN
				SC_P3_ZdvizkaZaLeakTestA.Step:= 2;
			ELSIF P3_ZdvizkaZaLeakTestA.Manual THEN
				SC_P3_ZdvizkaZaLeakTestA.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializ·cia****************************************************************************//
	
		2:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
			
			
												
			IF P3_Dopravniky.STAV.PoINIT AND P3_ZdvizkaZaLeakTestB.STAV.PoINIT THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 5;
			END_IF	
	
			
			
		5:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='5 - Inicializacia - kontrola pozicie zdvizky';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
			
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky THEN
				P3_ZdvizkaZaLeakTestA.STAV.PoINIT:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 100;
			ELSE
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 8;
			END_IF	
	
	
		8:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='8 - Inicializacia - presun zdvizky do hornej polohy';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#5s;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
						
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSUN:= TRUE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
		
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_HornaPoloha AND P3_ZdvizkaZaLeakTestA.IN.TlmicPaletky_ZASUNUTY THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 10;
			END_IF	
		
		10:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='10 - Inicializacia - kontrola pritomnosti paletky na zdvizke za Leakage Testom B';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
			
			IF NOT P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky THEN
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_VYSUN:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 11;
			ELSE
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 13;
			END_IF		
		
			
		11:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='11 - Inicializacia - cakam na zodvihnutie zdvizky za Leakage Testom B';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
			IF P3_ZdvizkaZaLeakTestB.IN.Zdvizka_HornaPoloha THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 13;
			END_IF		
			
		
		13:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='13 - Inicializacia - spustenie priecneho dopravnika';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#7s;
				
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.IN:= P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky AND P3_ZdvizkaZaLeakTestA.IN.PoziciaPaletky_OK;
			
			
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 THEN
				P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= FALSE;
				P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.AlarmTime.IN:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaZaLeakTestA.IdleTime.Q THEN
				P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= FALSE;
				P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 15;
			ELSIF SC_P3_ZdvizkaZaLeakTestA.AlarmTime.Q THEN
				P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= FALSE;
				P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 15;	
			END_IF	
		
		15:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='15 - Inicializacia - presun zdvizky do strednej polohy';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_VYSUN:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
		
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaZaLeakTestB.IN.Zdvizka_StrednaPoloha THEN
				IF P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky THEN
					P3_ZdvizkaZaLeakTestA.STAV.PoINIT:= TRUE;
					SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
					SC_P3_ZdvizkaZaLeakTestA.Step:= 100;
				ELSE	
					SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
					SC_P3_ZdvizkaZaLeakTestA.Step:= 18;
				END_IF	
			END_IF	
	
		18:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='18 - Inicializacia - vysunutie tlmica paletky';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
						
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 THEN
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.IdleTime.IN:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaZaLeakTestA.IdleTime.Q THEN
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.STAV.PoINIT:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 100;
			END_IF		
			
			
		
			
			
			
			
			
			//********************************************************Automatick˝ reûim****************************************************************************//
		
		100:  
			SC_P3_ZdvizkaZaLeakTestA.StepName:='100 - Automaticky Rezim - cakam na prÌchod paletky na zdvizku';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.IN:= P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky AND (P3_ZdvizkaZaLeakTestA.IN.PoziciaPaletky_OK OR P3_ZdvizkaZaLeakTestA.IN.TlmicPaletky_ZASUNUTY) AND P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha;	
		
			IF P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky AND P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha THEN
				P3_LeakageTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				P3_ZdvizkaZaLeakTestB.STAV.PrebiehaVyvezeniePaletkyNaTratA:= FALSE;
			END_IF	
			
			IF P3_ZdvizkaZaLeakTestA.KoniecCyklu AND NOT P3_LeakageTestA.Automat THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 0;
			ELSIF SC_P3_ZdvizkaZaLeakTestA.IdleTime.Q THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 101;
			END_IF
		
		
		101:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='101 - Automaticky Rezim - rozhodnutie o smere vyvazania';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
			
			IF P3_ZdvizkaZaLeakTestA.KoniecCyklu AND NOT P3_LeakageTestA.Automat THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 0;
			ELSIF P4_FunkcnyTestA.STAV.Tester_ON AND NOT P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky AND SC_P4_FunkcnyTestA.Step = 100 AND NOT P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA AND NOT P3_ZdvizkaZaLeakTestB.STAV.PrebiehaVyvezeniePaletkyNaTratA THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 110;
			ELSIF NOT P4_FunkcnyTestA.STAV.Tester_ON AND P4_FunkcnyTestB.STAV.Tester_ON AND NOT P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky AND SC_P3_ZdvizkaZaLeakTestB.Step = 100 AND NOT P3_ZdvizkaZaLeakTestB.STAV.PrebiehaVyvezeniePaletkyNaTratA AND NOT P3_LeakageTestB.STAV.PrebiehaVyvezeniePaletky THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 120;
			ELSIF NOT P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 100;
			END_IF
		
			//Vyv·ûanie na traù A//		
		110:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='110 - Automaticky Rezim - presun zdvizky do spodnej polohy';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_ZASUN:= TRUE;
				P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF	
		
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_SpodnaPoloha THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 113;
			END_IF
	
		113:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='113 - Automaticky Rezim - cakam na ukoncenie vyvazania na Trat A';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
				
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.IN:= NOT P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky;
			
			IF SC_P3_ZdvizkaZaLeakTestA.IdleTime.Q AND NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha THEN
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 130;
			END_IF
			
		
		
		
		
		
			//Vyv·ûanie na traù B//
		120:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='120 - Automaticky Rezim - presun zdviziek do hornej polohy';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSUN:= TRUE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_VYSUN:= TRUE;
				P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_ZASUN:= TRUE;
				P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_HornaPoloha AND P3_ZdvizkaZaLeakTestB.IN.Zdvizka_HornaPoloha AND P3_ZdvizkaZaLeakTestB.IN.TlmicPaletky_ZASUNUTY THEN
				P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_ZASUN:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 123;
			END_IF
			
			
		
		123:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='123 - Automaticky Rezim - cakam na ukoncenie vyvazania na Trat B';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
			
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.IN:= P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky AND NOT P3_ZdvizkaZaLeakTestB.IN.PoziciaPaletky_OK;
			
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 THEN
				P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= FALSE;
				P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaZaLeakTestA.IdleTime.Q THEN
				P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= FALSE;
				P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 125;
			END_IF
			
		125:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='123 - Automaticky Rezim - cakam na presun zdviziek do strednej polohy';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#1s;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.Zdvizku_VYSUN:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaZaLeakTestA.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaZaLeakTestB.IN.Zdvizka_StrednaPoloha THEN
				P3_ZdvizkaZaLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 130;
			END_IF	
			
			
			
			//Vysunutie tlmenia paletky//	
			
			
		130:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='130 - Automaticky Rezim - vysunutie tlamena paletky';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#1s;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;	
			
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.IN:= NOT P3_ZdvizkaZaLeakTestA.IN.TlmicPaletky_ZASUNUTY;
			
			IF NOT SC_P3_ZdvizkaZaLeakTestA.Switch1 THEN
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaZaLeakTestA.IdleTime.Q THEN
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				SC_P3_ZdvizkaZaLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaZaLeakTestA.Step:= 100;
			END_IF
		
		
				
		
			//*******************************************************Manu·lny reûim*******************************************************************************//
		700:
			SC_P3_ZdvizkaZaLeakTestA.StepName:='700 - Manualny Rezim';
			SC_P3_ZdvizkaZaLeakTestA.IdleTime.PT:= T#8s;
			SC_P3_ZdvizkaZaLeakTestA.AlarmTime.PT:= T#5s;
		
		
		
		
		
	END_CASE
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

