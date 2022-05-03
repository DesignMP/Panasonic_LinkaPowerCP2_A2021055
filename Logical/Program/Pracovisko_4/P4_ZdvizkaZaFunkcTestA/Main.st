
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P4_ZdvizkaZaFunkcTestA);
	
	
	//Volanie podprogramov//
	OvlZdvizky;
	
	//Reset sekcie //
	IF P4_ZdvizkaZaFunkcTestA.Reset THEN
		SC_P4_ZdvizkaZaFunkcTestA.Step:= 0;
		P4_ZdvizkaZaFunkcTestA.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P4_ZdvizkaZaFunkcTestA.Step:= 0;
	ELSIF NOT P4_ZdvizkaZaFunkcTestA.Manual AND NOT Safety.STAV.P4_ZonaBunky_AKTIVNA THEN
		SC_P4_ZdvizkaZaFunkcTestA.Step:= 0;	
	END_IF	
	
	
	CASE SC_P4_ZdvizkaZaFunkcTestA.Step OF 
	
		0:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='0 - Nulovanie';
			SC_OvlZdvizky.Step:= 0;
			P4_ZdvizkaZaFunkcTestA.Automat:= FALSE;
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= FALSE;
			P4_ZdvizkaZaFunkcTestA.Manual:= FALSE;
			P4_ZdvizkaZaFunkcTestA.STAV.PoINIT:= FALSE;
			P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
			P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
						
			P4_FunkcnyTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P4_ZdvizkaZaFunkcTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P4_ZdvizkaZaFunkcTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
		
		
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P4_ZonaBunky_AKTIVNA AND
				P4_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P3_Pracovisko.STAV.Porucha_ST1 AND
				NOT P3_Pracovisko.STAV.Porucha_ST2 AND
				NOT P3_Pracovisko.STAV.Porucha_ST3 AND
				NOT P3_Pracovisko.STAV.Porucha_ST4 AND
				NOT P3_Pracovisko.STAV.Porucha_ST5 AND
				NOT P3_Pracovisko.STAV.Porucha_ST6 AND
				NOT P3_Pracovisko.STAV.Porucha_ST7 AND
				NOT P3_Pracovisko.STAV.Porucha_ST8 THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 1;
			END_IF
		
		
		1:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='1 - Cakam na spustenie vyroby';
			P4_ZdvizkaZaFunkcTestA.KoniecCyklu:= FALSE;
			IF P4_ZdvizkaZaFunkcTestA.Automat THEN
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 2;
			ELSIF P4_ZdvizkaZaFunkcTestA.Manual THEN
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializ·cia****************************************************************************//
	
		2:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
			
			
												
			IF P4_Dopravniky.STAV.PoINIT THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 5;
			END_IF	
	
		
		5:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='5 - Inicializacia - kontrola pozicie zdvizky';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
			
			IF P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_StrednaPoloha AND P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky THEN
				P4_ZdvizkaZaFunkcTestA.STAV.PoINIT:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 100;
			ELSE
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 8;
			END_IF	
		
		
		8:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='8 - Inicializacia - presun zdvizky do hornej polohy';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#5s;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
						
			IF NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSUN:= TRUE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF
		
			IF P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_HornaPoloha AND P4_ZdvizkaZaFunkcTestA.IN.TlmicPaletky_ZASUNUTY THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 10;
			END_IF	
		
		
		10:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='10 - Inicializacia - kontrola pritomnosti paletky na zdvizke za Funkcnym Testom B';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
			
			IF NOT P4_ZdvizkaZaFunkcTestB.IN.PritomnostPaletky THEN
				P4_ZdvizkaZaFunkcTestB.OUT.Zdvizku_VYSUN:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 11;
			ELSE
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 13;
			END_IF		
		
			
		11:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='11 - Inicializacia - cakam na zodvihnutie zdvizky za Funkcnym Testom B';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
			IF P4_ZdvizkaZaFunkcTestB.IN.Zdvizka_HornaPoloha THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 13;
			END_IF		
			
		
		13:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='13 - Inicializacia - spustenie priecneho dopravnika';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#7s;
				
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.IN:= P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky AND P4_ZdvizkaZaFunkcTestA.IN.PoziciaPaletky_OK;
			
			
			IF NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 THEN
				P4_Dopravniky.OUT.PriecnyDopravnik_VPRED:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.IN:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P4_ZdvizkaZaFunkcTestA.IdleTime.Q THEN
				P4_Dopravniky.OUT.PriecnyDopravnik_VPRED:= FALSE;
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 15;
			ELSIF SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.Q THEN
				P4_Dopravniky.OUT.PriecnyDopravnik_VPRED:= FALSE;
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 15;	
			END_IF	
		
		15:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='15 - Inicializacia - presun zdvizky do strednej polohy';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				P4_ZdvizkaZaFunkcTestB.OUT.Zdvizku_VYSUN:= FALSE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF
		
			IF P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_StrednaPoloha AND P4_ZdvizkaZaFunkcTestB.IN.Zdvizka_StrednaPoloha THEN
				IF P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky THEN
					P4_ZdvizkaZaFunkcTestA.STAV.PoINIT:= TRUE;
					SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
					SC_P4_ZdvizkaZaFunkcTestA.Step:= 100;
				ELSE	
					SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
					SC_P4_ZdvizkaZaFunkcTestA.Step:= 18;
				END_IF	
			END_IF	
	
		18:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='18 - Inicializacia - vysunutie tlmica paletky';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#1s;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.IN:= NOT P4_ZdvizkaZaFunkcTestA.IN.TlmicPaletky_ZASUNUTY;
			
			IF NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 THEN
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P4_ZdvizkaZaFunkcTestA.IdleTime.Q THEN
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.STAV.PoINIT:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 100;
			END_IF		
			
			
				
			
		//********************************************************Automatick˝ reûim****************************************************************************//
		
		100:  
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='100 - Automaticky Rezim - cakam na prÌchod paletky na zdvizku';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#200ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.IN:= P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky AND P4_ZdvizkaZaFunkcTestA.IN.PoziciaPaletky_OK AND P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_StrednaPoloha;	
		
			IF P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky AND P4_ZdvizkaZaFunkcTestA.IN.PoziciaPaletky_OK THEN
				P4_FunkcnyTestA.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				P4_ZdvizkaZaFunkcTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			
			IF P4_ZdvizkaZaFunkcTestA.KoniecCyklu AND NOT P4_FunkcnyTestA.Automat THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 0;
			ELSIF SC_P4_ZdvizkaZaFunkcTestA.IdleTime.Q THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 101;
			END_IF
		
		
		101:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='101 - Automaticky Rezim - cakam na vyvezenie na trat A';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#200ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
			
			IF P4_ZdvizkaZaFunkcTestA.KoniecCyklu AND NOT P4_FunkcnyTestA.Automat AND NOT P4_ZdvizkaZaFunkcTestB.Automat THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 0;
			ELSIF NOT P4_Etiketovacka.RFID_hlava.PritomnostPaletky AND SC_P4_Etiketovacka.Step = 100 AND NOT P4_ZdvizkaZaFunkcTestA.STAV.PrebiehaVyvezeniePaletky AND NOT P4_ZdvizkaZaFunkcTestB.STAV.PrebiehaVyvezeniePaletky THEN	
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 110;
			END_IF
		
		//Vyv·ûanie na traù A//	
		
		110:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='110 - Automaticky Rezim - presun zdvizky do spodnej polohy';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#200ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_ZASUN:= TRUE;
				P4_ZdvizkaZaFunkcTestA.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF	
		
			IF P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_SpodnaPoloha THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 113;
			END_IF
		
		
		113:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='113 - Automaticky Rezim - cakam na ukoncenie vyvazania na Trat A';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#500ms;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
				
						
			IF P4_Etiketovacka.RFID_hlava.PritomnostPaletky AND NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF
			
			IF P4_ZdvizkaZaFunkcTestA.IN.Zdvizka_StrednaPoloha THEN
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 130;
			END_IF
		
			//Vysunutie tlmenia paletky//	
			
			
		130:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='130 - Automaticky Rezim - vysunutie tlamena paletky';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#1s;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;	
			
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.IN:= NOT P4_ZdvizkaZaFunkcTestA.IN.TlmicPaletky_ZASUNUTY;
			
			IF NOT SC_P4_ZdvizkaZaFunkcTestA.Switch1 THEN
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Switch1:= TRUE;
			END_IF
			
			IF SC_P4_ZdvizkaZaFunkcTestA.IdleTime.Q THEN
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				SC_P4_ZdvizkaZaFunkcTestA.ResetStep:= TRUE;
				SC_P4_ZdvizkaZaFunkcTestA.Step:= 100;
			END_IF
		
		
				
		
			//*******************************************************Manu·lny reûim*******************************************************************************//
		700:
			SC_P4_ZdvizkaZaFunkcTestA.StepName:='700 - Manualny Rezim';
			SC_P4_ZdvizkaZaFunkcTestA.IdleTime.PT:= T#8s;
			SC_P4_ZdvizkaZaFunkcTestA.AlarmTime.PT:= T#5s;
		
		
	
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

