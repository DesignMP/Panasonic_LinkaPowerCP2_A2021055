
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P1_SpodnyStoper);
	
	
	
	
	
	//Reset sekcie //
	IF P1_SpodnyStoper.Reset THEN
		SC_P1_SpodnyStoper.Step:= 0;
		P1_SpodnyStoper.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P1_SpodnyStoper.Step:= 0;
	END_IF	
	

	
	CASE SC_P1_SpodnyStoper.Step OF 
	
		0:
			SC_P1_SpodnyStoper.StepName:='0 - Nulovanie';
			P1_SpodnyStoper.Automat:= FALSE;
			P1_SpodnyStoper.KoniecCyklu:= FALSE;
			P1_SpodnyStoper.Manual:= FALSE;
			P1_SpodnyStoper.STAV.PoINIT:= FALSE;
			P1_SpodnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P1_SpodnyStoper.OUT.ZasunStoper:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 1;
			END_IF
	
		1:
			SC_P1_SpodnyStoper.StepName:='1 - Cakam na spustenie vyroby';
			P1_SpodnyStoper.KoniecCyklu:= FALSE;
			IF P1_SpodnyStoper.Automat THEN
				SC_P1_SpodnyStoper.Step:= 2;
			ELSIF P1_SpodnyStoper.Manual THEN
				SC_P1_SpodnyStoper.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		2:
			SC_P1_SpodnyStoper.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#4s;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#5s;
			
									
			IF P1_Dopravniky.STAV.PoINIT THEN
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 3;
			END_IF
		
		3:
			SC_P1_SpodnyStoper.StepName:='3 - Inicializacia - hladanie paletky';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#5s;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#5s;
			SC_P1_SpodnyStoper.IdleTime.IN:= TRUE;
	
			IF P1_SpodnyStoper.IN.PritomnostPaletky THEN
				P1_SpodnyStoper.STAV.PoINIT:= TRUE;
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 101;		
			ELSIF SC_P1_SpodnyStoper.IdleTime.Q THEN
				P1_SpodnyStoper.STAV.PoINIT:= TRUE;
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 100;
			END_IF
	
		
			//********************************************************Automatický režim****************************************************************************//
		100:
			SC_P1_SpodnyStoper.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#5s;
		
			SC_P1_SpodnyStoper.IdleTime.IN:= P1_SpodnyStoper.IN.PritomnostPaletky;
			
			IF P1_SpodnyStoper.KoniecCyklu AND NOT P1_Vytah.Automat THEN
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 0;
			ELSIF SC_P1_SpodnyStoper.IdleTime.Q THEN
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 101;
			END_IF
	
		
		101:
			SC_P1_SpodnyStoper.StepName:='101 - Automaticky Rezim - cakam na vyvezenie paletky na dopravnik vytahu';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#5s;
			
			IF P1_SpodnyStoper.KoniecCyklu AND NOT P1_Vytah.Automat THEN
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 0;
			ELSIF SC_P1_Vytah.Step = 105 AND NOT P1_Vytah.RFID_hlava.PritomnostPaletky THEN  
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 105;
			ELSIF NOT P1_SpodnyStoper.IN.PritomnostPaletky THEN
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 100;
			END_IF
			
			
		105:
			SC_P1_SpodnyStoper.StepName:='105 - Automaticky Rezim - vyvazam paletku na dopravnik vytahu';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#10s;
			
			SC_P1_SpodnyStoper.AlarmTime.IN:= P1_SpodnyStoper.IN.PritomnostPaletky;
			
			IF NOT SC_P1_SpodnyStoper.Switch1 THEN
				P1_SpodnyStoper.OUT.ZasunStoper:= TRUE;
				P1_SpodnyStoper.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P1_SpodnyStoper.Switch1:= TRUE;
			END_IF	
			
			IF NOT P1_SpodnyStoper.IN.PritomnostPaletky THEN
				P1_SpodnyStoper.OUT.ZasunStoper:= FALSE;
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 108;
			ELSIF SC_P1_SpodnyStoper.AlarmTime.Q THEN
				P1_Alarmy[163]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST1:= TRUE;
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 0;
			END_IF
		
			
		108:
			SC_P1_SpodnyStoper.StepName:='108 - Automaticky Rezim - cakam na prichod paletky na dopravnik vytahu';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#10s;
			
			IF P1_Vytah.RFID_hlava.PritomnostPaletky THEN
				P1_SpodnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				SC_P1_SpodnyStoper.ResetStep:= TRUE;
				SC_P1_SpodnyStoper.Step:= 100;
			END_IF	
			
			
			
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P1_SpodnyStoper.StepName:='700 - Manualny Rezim';
			SC_P1_SpodnyStoper.IdleTime.PT:= T#8s;
			SC_P1_SpodnyStoper.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
		
	END_CASE		
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

