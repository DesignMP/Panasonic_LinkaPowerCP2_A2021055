
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC

	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P4_Dopravniky);
	
	
	//Reset sekcie //
	IF P4_Dopravniky.Reset THEN
		SC_P4_Dopravniky.Step:= 0;
		P4_Dopravniky.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P4_Dopravniky.Step:= 0;
	END_IF	
	
	
	CASE SC_P4_Dopravniky.Step OF 
		
		0:
			SC_P4_Dopravniky.StepName:='0 - Nulovanie';
			P4_Dopravniky.Automat:= FALSE;
			P4_Dopravniky.KoniecCyklu:= FALSE;
			P4_Dopravniky.Manual:= FALSE;
			P4_Dopravniky.STAV.PoINIT:= FALSE;
			P4_Dopravniky.OUT.PrednyDopravnikBunky_ON:= FALSE;
			P4_Dopravniky.OUT.PriecnyDopravnik_VPRED:= FALSE;
			P4_Dopravniky.OUT.VratnyDopravnik_ON:= FALSE;
			P4_Dopravniky.OUT.ZadnyDopravnikBunky_ON:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P4_ZonaBunky_AKTIVNA AND
				P4_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P4_Pracovisko.STAV.Porucha_ST1 AND
				NOT P4_Pracovisko.STAV.Porucha_ST2 AND
				NOT P4_Pracovisko.STAV.Porucha_ST3 AND
				NOT P4_Pracovisko.STAV.Porucha_ST4 AND
				NOT P4_Pracovisko.STAV.Porucha_ST5 AND
				NOT P4_Pracovisko.STAV.Porucha_ST6 THEN
				SC_P4_Dopravniky.ResetStep:= TRUE;
				SC_P4_Dopravniky.Step:= 1;
			END_IF
	
		1:
			SC_P4_Dopravniky.StepName:='1 - Cakam na spustenie vyroby';
			P4_Dopravniky.KoniecCyklu:= FALSE;
			IF P4_Dopravniky.Automat THEN
				SC_P4_Dopravniky.Step:= 2;
			ELSIF P4_Dopravniky.Manual THEN
				SC_P4_Dopravniky.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
	
	
		2:
			SC_P4_Dopravniky.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P4_Dopravniky.IdleTime.PT:= T#1s;
			SC_P4_Dopravniky.AlarmTime.PT:= T#5s;
			
			IF P4_Pracovisko.STAV.FunkcnyTestA_Zasunuty AND P4_Pracovisko.STAV.FunkcnyTestB_Zasunuty THEN
				SC_P4_Dopravniky.IdleTime.IN:= TRUE;
			ELSE	
				SC_P4_Dopravniky.IdleTime.IN:= FALSE;
			END_IF
			
			
			IF SC_P4_Dopravniky.IdleTime.Q THEN
				SC_P4_Dopravniky.ResetStep:= TRUE;
				SC_P4_Dopravniky.Step:= 3;
			END_IF	
	
			
		3:
			SC_P4_Dopravniky.StepName:='3 - Inicializacia - inicializacia tlmenia stoprov';
			SC_P4_Dopravniky.IdleTime.PT:= T#1s;
			SC_P4_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			IF P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky AND
				P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky AND
				P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky AND
				P4_ZdvizkaZaFunkcTestB.IN.PritomnostPaletky AND
				P4_SpodnyStoper.IN.PritomnostPaletky AND
				P4_Etiketovacka.RFID_hlava.PritomnostPaletky THEN
				SC_P4_Dopravniky.ResetStep:= TRUE;
				SC_P4_Dopravniky.Step:= 5;
			ELSE
				IF NOT P4_FunkcnyTestA.RFID_hlava.PritomnostPaletky THEN
					P4_FunkcnyTestA.OUT.ZasunStoper:= TRUE;
				END_IF	
				IF NOT P4_FunkcnyTestB.RFID_hlava.PritomnostPaletky THEN
					P4_FunkcnyTestB.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P4_SpodnyStoper.IN.PritomnostPaletky THEN
					P4_SpodnyStoper.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P4_ZdvizkaZaFunkcTestA.IN.PritomnostPaletky THEN
					P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
					P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= TRUE;
				END_IF	
				IF NOT P4_ZdvizkaZaFunkcTestB.IN.PritomnostPaletky THEN
					P4_ZdvizkaZaFunkcTestB.OUT.TlmicPaletky_VYSUN:= TRUE;
				END_IF
				IF NOT P4_Etiketovacka.RFID_hlava.PritomnostPaletky THEN
					P4_Etiketovacka.OUT.ZasunStoper:= TRUE;
				END_IF
				SC_P4_Dopravniky.IdleTime.IN:= TRUE;
			END_IF	
			
			IF SC_P4_Dopravniky.IdleTime.Q THEN
				P4_FunkcnyTestA.OUT.ZasunStoper:= FALSE;
				P4_FunkcnyTestB.OUT.ZasunStoper:= FALSE;
				P4_SpodnyStoper.OUT.ZasunStoper:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_ZASUN:= FALSE;
				P4_ZdvizkaZaFunkcTestA.OUT.TlmicPaletky_VYSUN:= FALSE;
				P4_ZdvizkaZaFunkcTestB.OUT.TlmicPaletky_VYSUN:= FALSE;
				P4_Etiketovacka.OUT.ZasunStoper:= FALSE;
				SC_P4_Dopravniky.ResetStep:= TRUE;
				SC_P4_Dopravniky.Step:= 5;
			END_IF	
			
		5:
			SC_P4_Dopravniky.StepName:='5 - Inicializacia - ukoncenie inicializacie';
			SC_P4_Dopravniky.IdleTime.PT:= T#5s;
			SC_P4_Dopravniky.AlarmTime.PT:= T#5s;
		
			P4_Dopravniky.OUT.PrednyDopravnikBunky_ON:= TRUE;
			P4_Dopravniky.OUT.ZadnyDopravnikBunky_ON:= TRUE;
			P4_Dopravniky.OUT.VratnyDopravnik_ON:= TRUE;
			SC_P4_Dopravniky.IdleTime.IN:= TRUE;
			
			IF SC_P4_Dopravniky.IdleTime.Q THEN
				P4_Dopravniky.STAV.PoINIT:= TRUE;
				SC_P4_Dopravniky.ResetStep:= TRUE;
				SC_P4_Dopravniky.Step:= 100;
			END_IF
			
	
			
		//********************************************************Automatický režim****************************************************************************//
			
		100:  
			SC_P4_Dopravniky.StepName:='100 - Automaticky Rezim - cakam na vypnutie dopravnikou';
			SC_P4_Dopravniky.IdleTime.PT:= T#200ms;
			SC_P4_Dopravniky.AlarmTime.PT:= T#5s;			
			
			IF P4_Dopravniky.KoniecCyklu AND 
				NOT P4_FunkcnyTestA.Automat AND 
				NOT P4_FunkcnyTestB.Automat AND 
				NOT P4_ZdvizkaZaFunkcTestA.Automat AND 
				NOT P4_ZdvizkaZaFunkcTestB.Automat AND 
				NOT P4_Etiketovacka.Automat AND
				NOT P4_SpodnyStoper.Automat AND
				NOT P4_Vytah.STAV.PrebiehaVyvezeniePaletky THEN
				SC_P4_Dopravniky.ResetStep:= TRUE;
				SC_P4_Dopravniky.Step:= 0;
			END_IF
			
			
			
			
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P4_Dopravniky.StepName:='700 - Manualny Rezim';
			SC_P4_Dopravniky.IdleTime.PT:= T#8s;
			SC_P4_Dopravniky.AlarmTime.PT:= T#5s;
			
			
	
	
	
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

