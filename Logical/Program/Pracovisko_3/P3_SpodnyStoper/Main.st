
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_SpodnyStoper);
	
	
	
	
	
	//Reset sekcie //
	IF P3_SpodnyStoper.Reset THEN
		SC_P3_SpodnyStoper.Step:= 0;
		P3_SpodnyStoper.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_SpodnyStoper.Step:= 0;
	END_IF	
	

	
	CASE SC_P3_SpodnyStoper.Step OF 
	
		0:
			SC_P3_SpodnyStoper.StepName:='0 - Nulovanie';
			P3_SpodnyStoper.Automat:= FALSE;
			P3_SpodnyStoper.KoniecCyklu:= FALSE;
			P3_SpodnyStoper.Manual:= FALSE;
			P3_SpodnyStoper.STAV.PoINIT:= FALSE;
			P3_SpodnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P3_SpodnyStoper.OUT.ZasunStoper:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND Safety.STAV.P3_ZonaBunky_AKTIVNA AND P3_Pracovisko.STAV.HardwareBunky_OK THEN
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 1;
			END_IF
	
		1:
			SC_P3_SpodnyStoper.StepName:='1 - Cakam na spustenie vyroby';
			P3_SpodnyStoper.KoniecCyklu:= FALSE;
			IF P3_SpodnyStoper.Automat THEN
				SC_P3_SpodnyStoper.Step:= 2;
			ELSIF P3_SpodnyStoper.Manual THEN
				SC_P3_SpodnyStoper.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		2:
			SC_P3_SpodnyStoper.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_SpodnyStoper.IdleTime.PT:= T#4s;
			SC_P3_SpodnyStoper.AlarmTime.PT:= T#5s;
			
									
			IF P3_Dopravniky.STAV.PoINIT THEN
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 3;
			END_IF
		
		3:
			SC_P3_SpodnyStoper.StepName:='3 - Inicializacia - hladanie paletky';
			SC_P3_SpodnyStoper.IdleTime.PT:= T#5s;
			SC_P3_SpodnyStoper.AlarmTime.PT:= T#5s;
			SC_P3_SpodnyStoper.IdleTime.IN:= TRUE;
	
			IF P3_SpodnyStoper.IN.PritomnostPaletky THEN
				P3_SpodnyStoper.STAV.PoINIT:= TRUE;
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 101;		
			ELSIF SC_P3_SpodnyStoper.IdleTime.Q THEN
				P3_SpodnyStoper.STAV.PoINIT:= TRUE;
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 100;
			END_IF
	
		
			//********************************************************Automatický režim****************************************************************************//
		100:
			SC_P3_SpodnyStoper.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P3_SpodnyStoper.IdleTime.PT:= T#200ms;
			SC_P3_SpodnyStoper.AlarmTime.PT:= T#5s;
		
			SC_P3_SpodnyStoper.IdleTime.IN:= P3_SpodnyStoper.IN.PritomnostPaletky;
			
			IF P3_SpodnyStoper.KoniecCyklu THEN
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 0;
			ELSIF SC_P3_SpodnyStoper.IdleTime.Q THEN
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 101;
			END_IF
	
		
		101:
			SC_P3_SpodnyStoper.StepName:='101 - Automaticky Rezim - cakam na vyvezenie paletky na spodny stoper bunky 2';
			SC_P3_SpodnyStoper.IdleTime.PT:= T#2s;
			SC_P3_SpodnyStoper.AlarmTime.PT:= T#5s;
			
			SC_P3_SpodnyStoper.IdleTime.IN:= NOT P2_SpodnyStoper.IN.ZaplnenieDopravnika;
			
			IF P3_SpodnyStoper.KoniecCyklu THEN
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 0;
			ELSIF SC_P3_SpodnyStoper.IdleTime.Q AND P2_Dopravniky.STAV.PoINIT THEN  
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 105;
			ELSIF NOT P3_SpodnyStoper.IN.PritomnostPaletky THEN
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 100;
			END_IF
			
			
		105:
			SC_P3_SpodnyStoper.StepName:='105 - Automaticky Rezim - vyvazam paletku na spodny stoper bunky 2';
			SC_P3_SpodnyStoper.IdleTime.PT:= T#200ms;
			SC_P3_SpodnyStoper.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P3_SpodnyStoper.Switch1 THEN
				P3_SpodnyStoper.OUT.ZasunStoper:= TRUE;
				P3_SpodnyStoper.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P3_SpodnyStoper.Switch1:= TRUE;
			END_IF	
			
			IF NOT P3_SpodnyStoper.IN.PritomnostPaletky THEN
				P3_SpodnyStoper.OUT.ZasunStoper:= FALSE;
				P3_SpodnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				SC_P3_SpodnyStoper.ResetStep:= TRUE;
				SC_P3_SpodnyStoper.Step:= 100;
			END_IF
			
		
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P3_SpodnyStoper.StepName:='700 - Manualny Rezim';
			SC_P3_SpodnyStoper.IdleTime.PT:= T#8s;
			SC_P3_SpodnyStoper.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
		
	END_CASE		
	
	
	
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

