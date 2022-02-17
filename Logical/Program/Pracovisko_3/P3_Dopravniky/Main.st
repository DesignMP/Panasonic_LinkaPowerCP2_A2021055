
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_Dopravniky);
	
	
	//Reset sekcie //
	IF P3_Dopravniky.Reset THEN
		SC_P3_Dopravniky.Step:= 0;
		P3_Dopravniky.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_Dopravniky.Step:= 0;
	END_IF	
	
	
	CASE SC_P3_Dopravniky.Step OF 
		
		0:
			SC_P3_Dopravniky.StepName:='0 - Nulovanie';
			P3_Dopravniky.Automat:= FALSE;
			P3_Dopravniky.KoniecCyklu:= FALSE;
			P3_Dopravniky.Manual:= FALSE;
			P3_Dopravniky.STAV.PoINIT:= FALSE;
			P3_Dopravniky.OUT.PrednyDopravnikBunky_ON:= FALSE;
			P3_Dopravniky.OUT.PriecnyDopravnik1_VPRED:= FALSE;
			P3_Dopravniky.OUT.PriecnyDopravnik2_VPRED:= FALSE;
			P3_Dopravniky.OUT.PriecnyDopravnik2_VZAD:= FALSE;
			P3_Dopravniky.OUT.VratnyDopravnik_ON:= FALSE;
			P3_Dopravniky.OUT.ZadnyDopravnikBunky_ON:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P3_ZonaBunky_AKTIVNA AND
				NOT P3_Pracovisko.STAV.Porucha_ST1 AND
				NOT P3_Pracovisko.STAV.Porucha_ST2 AND
				NOT P3_Pracovisko.STAV.Porucha_ST3 AND
				NOT P3_Pracovisko.STAV.Porucha_ST4 AND
				NOT P3_Pracovisko.STAV.Porucha_ST5 AND
				NOT P3_Pracovisko.STAV.Porucha_ST6 AND
				NOT P3_Pracovisko.STAV.Porucha_ST7 AND
				NOT P3_Pracovisko.STAV.Porucha_ST8 THEN
				SC_P3_Dopravniky.ResetStep:= TRUE;
				SC_P3_Dopravniky.Step:= 1;
			END_IF
	
		1:
			SC_P3_Dopravniky.StepName:='1 - Cakam na spustenie vyroby';
			P3_Dopravniky.KoniecCyklu:= FALSE;
			IF P3_Dopravniky.Automat THEN
				SC_P3_Dopravniky.Step:= 2;
			ELSIF P3_Dopravniky.Manual THEN
				SC_P3_Dopravniky.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
	
	
		2:
			SC_P3_Dopravniky.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_Dopravniky.IdleTime.PT:= T#1s;
			SC_P3_Dopravniky.AlarmTime.PT:= T#5s;
			
			IF P3_Pracovisko.STAV.SkrutkovackyZasunute AND P3_Pracovisko.STAV.HVtest_Zasunuty AND P3_Pracovisko.STAV.LeakageTestA_Zasunuty AND P3_Pracovisko.STAV.LeakageTestB_Zasunuty THEN
				SC_P3_Dopravniky.IdleTime.IN:= TRUE;
			ELSE	
				SC_P3_Dopravniky.IdleTime.IN:= FALSE;
			END_IF
			
			
			IF SC_P3_Dopravniky.IdleTime.Q THEN
				SC_P3_Dopravniky.ResetStep:= TRUE;
				SC_P3_Dopravniky.Step:= 3;
			END_IF	
	
			
		3:
			SC_P3_Dopravniky.StepName:='3 - Inicializacia - inicializacia tlmenia stoprov';
			SC_P3_Dopravniky.IdleTime.PT:= T#1s;
			SC_P3_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			IF P3_StoperSrobovania.RFID_hlava.PritomnostPaletky AND
				P3_HV_Test.RFID_hlava.PritomnostPaletky AND
				P3_LeakageTestA.RFID_hlava.PritomnostPaletky AND
				P3_LeakageTestB.RFID_hlava.PritomnostPaletky AND
				P3_SpodnyStoper.IN.PritomnostPaletky AND
				P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky AND
				P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky AND
				P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky THEN
				SC_P3_Dopravniky.ResetStep:= TRUE;
				SC_P3_Dopravniky.Step:= 5;
			ELSE
				IF NOT P3_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
					P3_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				END_IF	
				IF NOT P3_HV_Test.RFID_hlava.PritomnostPaletky THEN
					P3_HV_Test.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P3_LeakageTestA.RFID_hlava.PritomnostPaletky THEN
					P3_LeakageTestA.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P3_LeakageTestB.RFID_hlava.PritomnostPaletky THEN
					P3_LeakageTestB.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P3_SpodnyStoper.IN.PritomnostPaletky THEN
					P3_SpodnyStoper.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P3_ZdvizkaPredLeakTestA.IN.PritomnostPaletky THEN
					P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				END_IF	
				IF NOT P3_ZdvizkaZaLeakTestA.IN.PritomnostPaletky THEN
					P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
					P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				END_IF
				IF NOT P3_ZdvizkaZaLeakTestB.IN.PritomnostPaletky THEN
					P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_ZASUN:= FALSE;
					P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_VYSUN:= TRUE;
				END_IF
				SC_P3_Dopravniky.IdleTime.IN:= TRUE;
			END_IF	
			
			IF SC_P3_Dopravniky.IdleTime.Q THEN
				P3_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				P3_HV_Test.OUT.ZasunStoper:= FALSE;
				P3_LeakageTestA.OUT.ZasunStoper:= FALSE;
				P3_LeakageTestB.OUT.ZasunStoper:= FALSE;
				P3_SpodnyStoper.OUT.ZasunStoper:= FALSE;
				P3_ZdvizkaPredLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaZaLeakTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P3_ZdvizkaZaLeakTestB.OUT.TlmicPaletky_VYSUN:= FALSE;
				SC_P3_Dopravniky.ResetStep:= TRUE;
				SC_P3_Dopravniky.Step:= 5;
			END_IF	
			
		5:
			SC_P3_Dopravniky.StepName:='5 - Inicializacia - ukoncenie inicializacie';
			SC_P3_Dopravniky.IdleTime.PT:= T#5s;
			SC_P3_Dopravniky.AlarmTime.PT:= T#5s;
		
			P3_Dopravniky.OUT.PrednyDopravnikBunky_ON:= TRUE;
			P3_Dopravniky.OUT.ZadnyDopravnikBunky_ON:= TRUE;
			P3_Dopravniky.OUT.VratnyDopravnik_ON:= TRUE;
			SC_P2_Dopravniky.IdleTime.IN:= TRUE;
			
			IF SC_P3_Dopravniky.IdleTime.Q THEN
				P3_Dopravniky.STAV.PoINIT:= TRUE;
				SC_P3_Dopravniky.ResetStep:= TRUE;
				SC_P3_Dopravniky.Step:= 100;
			END_IF
			
	
			
			//********************************************************Automatický režim****************************************************************************//
			
		100:  
			SC_P3_Dopravniky.StepName:='100 - Automaticky Rezim - cakam na vypnutie dopravnikou';
			SC_P3_Dopravniky.IdleTime.PT:= T#200ms;
			SC_P3_Dopravniky.AlarmTime.PT:= T#5s;			
			
			IF P3_Dopravniky.KoniecCyklu AND 
				NOT P3_StoperSrobovania.Automat AND 
				NOT P3_HV_Test.Automat AND 
				NOT P3_LeakageTestA.Automat AND 
				NOT P3_LeakageTestB.Automat AND 
				NOT P3_ZdvizkaPredLeakTestA.Automat AND
				NOT P3_ZdvizkaPredLeakTestB.Automat AND
				NOT P3_ZdvizkaZaLeakTestB.Automat AND
				NOT P3_SpodnyStoper.Automat THEN
				SC_P3_Dopravniky.ResetStep:= TRUE;
				SC_P3_Dopravniky.Step:= 0;
			END_IF
			
			
			
			
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P3_Dopravniky.StepName:='700 - Manualny Rezim';
			SC_P3_Dopravniky.IdleTime.PT:= T#8s;
			SC_P3_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			
			
	END_CASE		
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

