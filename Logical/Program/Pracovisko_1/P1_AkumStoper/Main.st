
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
			
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P1_AkumulacnyStoper);
	
	
	
	
	
	//Reset sekcie //
	IF P1_AkumulacnyStoper.Reset THEN
		SC_P1_AkumulacnyStoper.Step:= 0;
		P1_AkumulacnyStoper.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P1_AkumulacnyStoper.Step:= 0;
	END_IF
	
	
	
	CASE SC_P1_AkumulacnyStoper.Step OF 
	
		0:
			SC_P1_AkumulacnyStoper.StepName:='0 - Nulovanie';
			P1_AkumulacnyStoper.Automat:= FALSE;
			P1_AkumulacnyStoper.KoniecCyklu:= FALSE;
			P1_AkumulacnyStoper.Manual:= FALSE;
			P1_AkumulacnyStoper.STAV.PoINIT:= FALSE;
			P1_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P1_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P1_AkumulacnyStoper.OUT.ZasunStoper:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND Safety.STAV.P1_ZonaBunky_AKTIVNA AND P1_Pracovisko.STAV.HardwareBunky_OK AND NOT P1_Pracovisko.STAV.Porucha_ST2 AND NOT P1_Pracovisko.STAV.Porucha_ST3 THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 1;
			END_IF
	
		1:
			SC_P1_AkumulacnyStoper.StepName:='1 - Cakam na spustenie vyroby';
			P1_AkumulacnyStoper.KoniecCyklu:= FALSE;
			IF P1_AkumulacnyStoper.Automat THEN
				SC_P1_AkumulacnyStoper.Step:= 2;
			ELSIF P1_AkumulacnyStoper.Manual THEN
				SC_P1_AkumulacnyStoper.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		2:
			SC_P1_AkumulacnyStoper.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#4s;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#5s;
			
									
			IF P1_Dopravniky.STAV.PoINIT THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 3;
			END_IF
		
		3:
			SC_P1_AkumulacnyStoper.StepName:='3 - Inicializacia - hladanie paletky';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#5s;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#5s;
			SC_P1_AkumulacnyStoper.IdleTime.IN:= TRUE;
	
			IF P1_AkumulacnyStoper.IN.PritomnostPaletky THEN
				P1_AkumulacnyStoper.STAV.PoINIT:= TRUE;
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 100;		
			ELSIF SC_P1_AkumulacnyStoper.IdleTime.Q THEN
				P1_AkumulacnyStoper.STAV.PoINIT:= TRUE;
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 100;
			END_IF
	
		
			//********************************************************Automatický režim****************************************************************************//
		100:
			SC_P1_AkumulacnyStoper.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#5s;
		
                        
			SC_P1_AkumulacnyStoper.IdleTime.IN:= P1_AkumulacnyStoper.IN.PritomnostPaletky;
			
			IF P1_AkumulacnyStoper.IN.PritomnostPaletky THEN
				P1_StoperSrobovania.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			
			IF P1_AkumulacnyStoper.KoniecCyklu THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 0;
			ELSIF SC_P1_AkumulacnyStoper.IdleTime.Q THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 101;
			END_IF
	
		
		101:
			SC_P1_AkumulacnyStoper.StepName:='101 - Automaticky Rezim - cakam na vyvezenie paletky na stoper zakladania tesnenia';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#5s;
			
			IF P1_AkumulacnyStoper.KoniecCyklu THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 0;
			ELSIF SC_P2_StoperZaklTesnenia.Step = 100 AND NOT P2_StoperZaklTesnenia.RFID_hlava.PritomnostPaletky AND P2_ZakladacTesnenia.ServoPojazduZakladaca.Status.ActPosition < 10 AND NOT P1_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 105;
			ELSIF NOT P1_AkumulacnyStoper.IN.PritomnostPaletky THEN
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 100;
			END_IF
			
			
		105:
			SC_P1_AkumulacnyStoper.StepName:='105 - Automaticky Rezim - vyvazam paletku na stoper zakladania tesnenia';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#10s;
			
			SC_P1_AkumulacnyStoper.AlarmTime.IN:= P1_AkumulacnyStoper.IN.PritomnostPaletky;
			
			IF NOT SC_P1_AkumulacnyStoper.Switch1 THEN
				P1_AkumulacnyStoper.OUT.ZasunStoper:= TRUE;
				P1_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P1_AkumulacnyStoper.Switch1:= TRUE;
			END_IF	
			
			IF NOT P1_AkumulacnyStoper.IN.PritomnostPaletky THEN
				P1_AkumulacnyStoper.OUT.ZasunStoper:= FALSE;
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 108;
			ELSIF SC_P1_AkumulacnyStoper.AlarmTime.Q THEN
				P1_Alarmy[162]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST3:= TRUE;	
			END_IF
			
				
		108:
			SC_P1_AkumulacnyStoper.StepName:='108 - Automaticky Rezim - cakam na prichod paletky na stoper zakladania tesnenia';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#10s;
			
			IF P2_StoperZaklTesnenia.RFID_hlava.PritomnostPaletky THEN
				P1_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
				SC_P1_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P1_AkumulacnyStoper.Step:= 100;
			END_IF	
			
			
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P1_AkumulacnyStoper.StepName:='700 - Manualny Rezim';
			SC_P1_AkumulacnyStoper.IdleTime.PT:= T#8s;
			SC_P1_AkumulacnyStoper.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
		
	END_CASE	
	
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

