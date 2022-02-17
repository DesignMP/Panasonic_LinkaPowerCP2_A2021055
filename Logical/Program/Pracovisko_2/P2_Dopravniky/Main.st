
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_Dopravniky);
	
	
	//Reset sekcie //
	IF P2_Dopravniky.Reset THEN
		SC_P2_Dopravniky.Step:= 0;
		P2_Dopravniky.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_Dopravniky.Step:= 0;
	END_IF	
	
	
	CASE SC_P2_Dopravniky.Step OF 
		
		0:
			SC_P2_Dopravniky.StepName:='0 - Nulovanie';
			P2_Dopravniky.Automat:= FALSE;
			P2_Dopravniky.KoniecCyklu:= FALSE;
			P2_Dopravniky.Manual:= FALSE;
			P2_Dopravniky.STAV.PoINIT:= FALSE;
			P2_Dopravniky.OUT.DopravnikBunky_ON:= FALSE;
			P2_Dopravniky.OUT.VratnyDopravnik_ON:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND NOT P2_Pracovisko.STAV.Porucha_ST2 AND NOT P2_Pracovisko.STAV.Porucha_ST3 AND NOT P2_Pracovisko.STAV.Porucha_ST4 AND NOT P2_Pracovisko.STAV.Porucha_ST5 THEN
				SC_P2_Dopravniky.ResetStep:= TRUE;
				SC_P2_Dopravniky.Step:= 1;
			END_IF
	
		1:
			SC_P2_Dopravniky.StepName:='1 - Cakam na spustenie vyroby';
			P2_Dopravniky.KoniecCyklu:= FALSE;
			IF P2_Dopravniky.Automat THEN
				SC_P2_Dopravniky.Step:= 2;
			ELSIF P2_Dopravniky.Manual THEN
				SC_P2_Dopravniky.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
	
	
		2:
			SC_P2_Dopravniky.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_Dopravniky.IdleTime.PT:= T#1s;
			SC_P2_Dopravniky.AlarmTime.PT:= T#5s;
			
			IF P2_Pracovisko.STAV.SkrutkovackyZasunute AND P2_Robot.STAV.PoINIT THEN
				SC_P2_Dopravniky.IdleTime.IN:= TRUE;
			ELSE	
				SC_P2_Dopravniky.IdleTime.IN:= FALSE;
			END_IF
			
			
			IF SC_P2_Dopravniky.IdleTime.Q THEN
				SC_P2_Dopravniky.ResetStep:= TRUE;
				SC_P2_Dopravniky.Step:= 3;
			END_IF	
	
			
		3:
			SC_P2_Dopravniky.StepName:='3 - Inicializacia - inicializacia tlmenia stoprov';
			SC_P2_Dopravniky.IdleTime.PT:= T#1s;
			SC_P2_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			IF P2_StoperZaklTesnenia.RFID_hlava.PritomnostPaletky AND P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky AND P2_AkumulacnyStoper.IN.PritomnostPaletky AND P2_StoperSrobovania.RFID_hlava.PritomnostPaletky AND P2_StoperZvarania.RFID_hlava.PritomnostPaletky AND P2_SpodnyStoper.IN.PritomnostPaletky THEN
				SC_P2_Dopravniky.ResetStep:= TRUE;
				SC_P2_Dopravniky.Step:= 5;
			ELSE
				IF NOT P2_StoperZaklTesnenia.RFID_hlava.PritomnostPaletky THEN
					P2_StoperZaklTesnenia.OUT.ZasunStoper:= TRUE;
				END_IF	
				IF NOT P2_StoperMaticovacky.RFID_hlava.PritomnostPaletky THEN
					P2_StoperMaticovacky.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P2_AkumulacnyStoper.IN.PritomnostPaletky THEN
					P2_AkumulacnyStoper.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky THEN
					P2_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P2_StoperZvarania.RFID_hlava.PritomnostPaletky THEN
					P2_StoperZvarania.OUT.ZasunStoper:= TRUE;
				END_IF	
				IF NOT P2_SpodnyStoper.IN.PritomnostPaletky THEN
					P2_SpodnyStoper.OUT.ZasunStoper:= TRUE;
				END_IF
				SC_P2_Dopravniky.IdleTime.IN:= TRUE;
			END_IF	
			
			IF SC_P2_Dopravniky.IdleTime.Q THEN
				P2_StoperZaklTesnenia.OUT.ZasunStoper:= FALSE;
				P2_StoperMaticovacky.OUT.ZasunStoper:= FALSE;
				P2_AkumulacnyStoper.OUT.ZasunStoper:= FALSE;
				P2_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				P2_StoperZvarania.OUT.ZasunStoper:= FALSE;
				P2_SpodnyStoper.OUT.ZasunStoper:= FALSE;
				SC_P2_Dopravniky.ResetStep:= TRUE;
				SC_P2_Dopravniky.Step:= 5;
			END_IF	
			
		5:
			SC_P2_Dopravniky.StepName:='5 - Inicializacia - ukoncenie inicializacie';
			SC_P2_Dopravniky.IdleTime.PT:= T#5s;
			SC_P2_Dopravniky.AlarmTime.PT:= T#5s;
		
			P2_Dopravniky.OUT.DopravnikBunky_ON:= TRUE;
			P2_Dopravniky.OUT.VratnyDopravnik_ON:= TRUE;
			SC_P2_Dopravniky.IdleTime.IN:= TRUE;
			
			IF SC_P2_Dopravniky.IdleTime.Q THEN
				P2_Dopravniky.STAV.PoINIT:= TRUE;
				SC_P2_Dopravniky.ResetStep:= TRUE;
				SC_P2_Dopravniky.Step:= 100;
			END_IF
			
	
			
			//********************************************************Automatický režim****************************************************************************//
			
		100:  
			SC_P2_Dopravniky.StepName:='100 - Automaticky Rezim - cakam na vypnutie dopravnikou';
			SC_P2_Dopravniky.IdleTime.PT:= T#200ms;
			SC_P2_Dopravniky.AlarmTime.PT:= T#5s;			
			
			IF P2_Dopravniky.KoniecCyklu AND
				NOT P2_StoperZaklTesnenia.STAV.PrebiehaVyvezeniePaletky AND
				NOT P2_StoperMaticovacky.Automat AND
				NOT P2_AkumulacnyStoper.Automat AND
				NOT P2_StoperSrobovania.Automat AND
				NOT P2_StoperZvarania.Automat AND
				NOT P2_SpodnyStoper.Automat THEN
				SC_P2_Dopravniky.ResetStep:= TRUE;
				SC_P2_Dopravniky.Step:= 0;
			END_IF
			
			
			
			
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P2_Dopravniky.StepName:='700 - Manualny Rezim';
			SC_P2_Dopravniky.IdleTime.PT:= T#8s;
			SC_P2_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			
			
	END_CASE		
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

