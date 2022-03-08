
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_ZdvizkaPredLeakTestB);
	
	
	//Volanie podprogramov//
	OvlZdvizky;
	
	//Reset sekcie //
	IF P3_ZdvizkaPredLeakTestB.Reset THEN
		SC_P3_ZdvizkaPredLeakTestB.Step:= 0;
		P3_ZdvizkaPredLeakTestB.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_ZdvizkaPredLeakTestB.Step:= 0;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		SC_P3_ZdvizkaPredLeakTestB.Step:= 0;	
	END_IF	
	
	 
	CASE SC_P3_ZdvizkaPredLeakTestB.Step OF 
	
		0:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='0 - Nulovanie';
			SC_OvlZdvizky.Step:= 0;
			P3_ZdvizkaPredLeakTestB.Automat:= FALSE;
			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= FALSE;
			P3_ZdvizkaPredLeakTestB.Manual:= FALSE;
			P3_ZdvizkaPredLeakTestB.STAV.PoINIT:= FALSE;
									
			P3_ZdvizkaPredLeakTestB.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
			
		
		
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
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 1;
			END_IF
		
		
		1:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='1 - Cakam na spustenie vyroby';
			P3_ZdvizkaPredLeakTestB.KoniecCyklu:= FALSE;
			IF P3_ZdvizkaPredLeakTestB.Automat THEN
				SC_P3_ZdvizkaPredLeakTestB.Step:= 2;
			ELSIF P3_ZdvizkaPredLeakTestB.Manual THEN
				SC_P3_ZdvizkaPredLeakTestB.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//
	
		2:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
			
			
												
			IF P3_Dopravniky.STAV.PoINIT THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 5;
			END_IF	
	
			
		5:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='5 - Inicializacia - kontrola pozicie zdvizky';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
				
			IF P3_ZdvizkaPredLeakTestB.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky THEN
				P3_ZdvizkaPredLeakTestB.STAV.PoINIT:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 120;
			ELSE
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 8;
			END_IF	
			
			
	
		8:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='8 - Inicializacia - presun zdvizky do hornej polohy';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaPredLeakTestB.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSUN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_ZdvizkaPredLeakTestB.IN.Zdvizka_HornaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 10;
			END_IF	
			
		
		10:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='10 - Inicializacia - kontrola pritomnosti paletky na zdvizke pred Leakage Testom A';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
			
			IF NOT P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky THEN
				P3_ZdvizkaPredLeakTestA.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaPredLeakTestA.OUT.Zdvizku_VYSUN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 11;
			ELSE
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 13;
			END_IF	
		
		11:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='11 - Inicializacia - cakam na zodvihnutie zdvizky Pred Leakage Testom A';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
			
			IF P3_ZdvizkaPredLeakTestA.IN.Zdvizka_HornaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 13;
			END_IF	
			
				
		13:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='13 - Inicializacia - spustenie priecneho dopravnika';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#7s;
			
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.IN:= P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky AND P3_ZdvizkaPredLeakTestB.IN.PoziciaPaletky_OK;
			
			IF NOT SC_P3_ZdvizkaPredLeakTestB.Switch1 THEN
				P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.AlarmTime.IN:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_ZdvizkaPredLeakTestB.IdleTime.Q THEN
				P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= FALSE;
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 15;
			ELSIF SC_P3_ZdvizkaPredLeakTestB.AlarmTime.Q THEN
				P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= FALSE;
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 15;
			END_IF	
					
			
		15:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='15 - Inicializacia - presun zdvizky do strednej polohy';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaPredLeakTestB.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				P3_ZdvizkaPredLeakTestA.OUT.Zdvizku_ZASUN:= FALSE;
				P3_ZdvizkaPredLeakTestA.OUT.Zdvizku_VYSUN:= FALSE;
				SC_P3_ZdvizkaPredLeakTestB.Switch1:= TRUE;
			END_IF
		
			IF P3_ZdvizkaPredLeakTestB.IN.Zdvizka_StrednaPoloha AND P3_ZdvizkaPredLeakTestA.IN.Zdvizka_StrednaPoloha THEN
				P3_ZdvizkaPredLeakTestB.STAV.PoINIT:= TRUE;
				IF P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky THEN
					SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
					SC_P3_ZdvizkaPredLeakTestB.Step:= 120;
				ELSE	
					SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
					SC_P3_ZdvizkaPredLeakTestB.Step:= 100;
				END_IF	
			END_IF	
		
								
		
		
		//********************************************************Automatický režim****************************************************************************//
		100:  
			SC_P3_ZdvizkaPredLeakTestB.StepName:='100 - Automaticky Rezim - cakam na prichod paletky na zdvizku';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
		
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.IN:= P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky AND P3_ZdvizkaPredLeakTestB.IN.Zdvizka_StrednaPoloha;
			
			IF P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky THEN
				P3_ZdvizkaPredLeakTestA.STAV.PrebiehaVyvezeniePaletkyNaTratB:= FALSE;
			END_IF	
			
			IF P3_ZdvizkaPredLeakTestB.KoniecCyklu AND NOT P3_ZdvizkaPredLeakTestA.Automat THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 0;
			ELSIF SC_P3_ZdvizkaPredLeakTestB.IdleTime.Q THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 120;
			END_IF
	
		
		120:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='120 - Automaticky Rezim - cakam na vyvezenie na stoper Leakage Testu B';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
		
			IF P3_ZdvizkaPredLeakTestB.KoniecCyklu AND NOT P3_ZdvizkaPredLeakTestA.Automat THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 0;
			ELSIF NOT P3_LeakageTestB.RFID_hlava.PritomnostPaletky AND SC_P3_LeakageTestB.Step = 100 AND NOT P3_ZdvizkaPredLeakTestB.STAV.PrebiehaVyvezeniePaletky THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 123;
			END_IF
		
		123:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='123 - Automaticky Rezim - presun zdvizky do spodnej polohy';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#200ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
		
			IF NOT SC_P3_ZdvizkaPredLeakTestB.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_ZASUN:= TRUE;
				P3_ZdvizkaPredLeakTestB.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Switch1:= TRUE;
			END_IF	
		
			IF P3_ZdvizkaPredLeakTestB.IN.Zdvizka_SpodnaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 125;
			END_IF
		
		
		125:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='125 - Automaticky Rezim - cakam na ukoncenie vyvazania na stoper Leakage Testu B';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#500ms;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
				
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.IN:= NOT P3_ZdvizkaPredLeakTestB.IN.PritomnostPaletky;
			
			IF SC_P3_ZdvizkaPredLeakTestB.IdleTime.Q AND NOT SC_P3_ZdvizkaPredLeakTestB.Switch1 AND SC_OvlZdvizky.Step = 1 THEN
				Zdvizku_VYSTRED:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Switch1:= TRUE;
			END_IF
			
			IF P3_ZdvizkaPredLeakTestB.IN.Zdvizka_StrednaPoloha THEN
				SC_P3_ZdvizkaPredLeakTestB.ResetStep:= TRUE;
				SC_P3_ZdvizkaPredLeakTestB.Step:= 100;
			END_IF
		
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P3_ZdvizkaPredLeakTestB.StepName:='700 - Manualny Rezim';
			SC_P3_ZdvizkaPredLeakTestB.IdleTime.PT:= T#8s;
			SC_P3_ZdvizkaPredLeakTestB.AlarmTime.PT:= T#5s;
		
	
	
	END_CASE
	 
	END_PROGRAM

PROGRAM _EXIT
						(* Insert code here *)
	 
						END_PROGRAM

