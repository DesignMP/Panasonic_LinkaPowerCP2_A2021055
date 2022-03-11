
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_ZdvizkaPredLeakTestA);
	
	
	//Volanie podprogramov//
	OvlZdvizky;
	
	//Reset sekcie //
	IF P3_ZdvizkaPredLeakTestA.Reset THEN
		SC_P3_ZdvizkaPredLeakTestA.Step:= 0;
		P3_ZdvizkaPredLeakTestA.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_ZdvizkaPredLeakTestA.Step:= 0;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		SC_P3_ZdvizkaPredLeakTestA.Step:= 0;	
	END_IF	
	
	 
	CASE SC_P3_ZdvizkaPredLeakTestA.Step OF 
	
		0:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='0 - Nulovanie';
			SC_OvlZdvizky.Step:= 0;
			P3_ZdvizkaPredLeakTestA.Automat:= FALSE;
			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= FALSE;
			P3_ZdvizkaPredLeakTestA.Manual:= FALSE;
			P3_ZdvizkaPredLeakTestA.STAV.PoINIT:= FALSE;
			P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
			P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= FALSE;			
			P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA:= FALSE;
			P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
			P3_HV_Test.STAV.PrebiehaVyvezeniePaletky:= FALSE;
		
		
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
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 1;
			END_IF
		
		
		1:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='1 - Cakam na spustenie vyroby';
			P3_ZdvizkaPredLeakTestA.KoniecCyklu:= FALSE;
			IF P3_ZdvizkaPredLeakTestA.Automat THEN
				SC_P3_ZdvizkaPredLeakTestA.Step:= 2;
			ELSIF P3_ZdvizkaPredLeakTestA.Manual THEN
				SC_P3_ZdvizkaPredLeakTestA.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializ·cia****************************************************************************//
	
		2:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			
												
			IF P3_Dopravniky.STAV.PoINIT AND P3_ZdvizkaPredLeakTestB.STAV.PoINIT THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 5;
			END_IF	
	
			
				
		5:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='5 - Inicializacia - kontrola pozicie zdvizky';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky THEN
				P3_ZdvizkaPredLeakTestA.STAV.PoINIT:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 100;
			ELSIF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha AND NOT P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky THEN	
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 6;
			ELSE
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 8;
			END_IF	
	
		6:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='5 - Inicializacia - vysunutie tlmica';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 THEN
				P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.IdleTime.IN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF	
			
			IF SC_P3_ZdvizkaPredLeakTestA.IdleTime.Q THEN
				P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaPredLeakTestA.STAV.PoINIT:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 100;
			END_IF	
			
			
		8:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='8 - Inicializacia - presun zdvizky do strednej polohy';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#5s;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
		
						
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF
		
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 10;
			END_IF	
		
			
		10:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='10 - Inicializacia - hladania paletky';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#5s;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.IN:= TRUE;
			
			IF SC_P3_ZdvizkaPredLeakTestA.IdleTime.Q THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 5;
			END_IF	
			
			//********************************************************Automatick˝ reûim****************************************************************************//
		
		100:  
			SC_P3_ZdvizkaPredLeakTestA.StepName:='100 - Automaticky Rezim - cakam na prÌchod paletky na zdvizku';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#700ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
		
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.IN:= P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky;	
		
			IF P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky THEN
				P3_HV_Test.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			
			IF P3_ZdvizkaPredLeakTestA.KoniecCyklu AND NOT P3_HV_Test.Automat THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 0;
			ELSIF SC_P3_ZdvizkaPredLeakTestA.IdleTime.Q THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 101;
			END_IF
		
		
		101:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='101 - Automaticky Rezim - rozhodnutie o smere vyvazania';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			IF P3_ZdvizkaPredLeakTestA.KoniecCyklu AND NOT P3_HV_Test.Automat THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 0;
			ELSIF P3_LeakageTestA.STAV.Tester_ON AND NOT P3_LeakageTestA.RFID_hlava.PritomnostPaletky AND SC_P3_LeakageTestA.Step = 100 AND NOT P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 110;
			ELSIF NOT P3_LeakageTestA.STAV.Tester_ON AND P3_LeakageTestB.STAV.Tester_ON AND NOT P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky AND SC_P3_ZdvizkaPredLeakTestB.Step = 100 AND NOT P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 120;
			END_IF
			
			//Vyv·ûanie na traù A//		
		
		110:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='110 - Automaticky Rezim - presun zdvizky do spodnej polohy';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_ZASUN:= TRUE;
				P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratA:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF	
		
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_SpodnaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 113;
			END_IF
		
				
		113:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='113 - Automaticky Rezim - cakam na ukoncenie vyvazania na Trat A';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
				
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.IN:= NOT P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky;
			
			IF SC_P3_ZdvizkaPredLeakTestA.IdleTime.Q AND NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 130;
			END_IF
			
			
		
		
			//Vyv·ûanie na traù B//		
			
		
		120:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='120 - Automaticky Rezim - presun zdviziek do hornej polohy';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSUN:= TRUE;
				P3_ZdvizkaPredLeakTestB.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaPredLeakTestB.OUT.Zdvizku_VYSUN:= TRUE;
				P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_HornaPoloha AND P3_ZdvizkaPredLeakTestB.IN.Zdvizka_HornaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 123;
			END_IF
			
			
			
		123:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='123 - Automaticky Rezim - cakam na ukoncenie vyvazania na Trat B';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.IN:= P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky;
			
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 THEN
				P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaPredLeakTestA.IdleTime.Q THEN
				P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= FALSE;
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 125;
			END_IF
			
			
		125:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='123 - Automaticky Rezim - cakam na presun zdviziek do strednej polohy';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#1s;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				P3_ZdvizkaPredLeakTestB.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaPredLeakTestB.OUT.Zdvizku_VYSUN:= FALSE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaPredLeakTestB.IN.Zdvizka_StrednaPoloha THEN
				P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 130;
			END_IF
			
			//Vysunutie tlmenia paletky//	
			
			
		130:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='130 - Automaticky Rezim - vysunutie tlamena paletky';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#1s;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;	
			
			
			
			IF NOT SC_P3_ZdvizkaPredLeakTestA.Switch1 THEN
				P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.IdleTime.IN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaPredLeakTestA.IdleTime.Q THEN
				P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				SC_P3_ZdvizkaPredLeakTestA.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestA.Step:= 100;
			END_IF
			
			
		
			//*******************************************************Manu·lny reûim*******************************************************************************//
		700:
			SC_P3_ZdvizkaPredLeakTestA.StepName:='700 - Manualny Rezim';
			SC_P3_ZdvizkaPredLeakTestA.IdleTime.PT:= T#8s;
			SC_P3_ZdvizkaPredLeakTestA.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
	END_CASE
	
	
				END_PROGRAM

PROGRAM _EXIT
				(* Insert code here *)
	 
				END_PROGRAM

