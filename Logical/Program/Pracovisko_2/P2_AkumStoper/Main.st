
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
			
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_AkumulacnyStoper);
	
	
	
	
	
	//Reset sekcie //
	IF P2_AkumulacnyStoper.Reset THEN
		SC_P2_AkumulacnyStoper.Step:= 0;
		P2_AkumulacnyStoper.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_AkumulacnyStoper.Step:= 0;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		SC_P2_AkumulacnyStoper.Step:= 0;
	END_IF
	
	
	
	CASE SC_P2_AkumulacnyStoper.Step OF 
	
		0:
			SC_P2_AkumulacnyStoper.StepName:='0 - Nulovanie';
			P2_AkumulacnyStoper.Automat:= FALSE;
			P2_AkumulacnyStoper.KoniecCyklu:= FALSE;
			P2_AkumulacnyStoper.Manual:= FALSE;
			P2_AkumulacnyStoper.STAV.PoINIT:= FALSE;
			P2_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_StoperMaticovacky.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			P2_AkumulacnyStoper.OUT.ZasunStoper:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P2_ZonaBunky_AKTIVNA AND
				P2_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND
				NOT P2_Pracovisko.STAV.Porucha_ST5 THEN
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 1;
			END_IF
	
		1:
			SC_P2_AkumulacnyStoper.StepName:='1 - Cakam na spustenie vyroby';
			P2_AkumulacnyStoper.KoniecCyklu:= FALSE;
			IF P2_AkumulacnyStoper.Automat THEN
				SC_P2_AkumulacnyStoper.Step:= 2;
			ELSIF P2_AkumulacnyStoper.Manual THEN
				SC_P2_AkumulacnyStoper.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		2:
			SC_P2_AkumulacnyStoper.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_AkumulacnyStoper.IdleTime.PT:= T#4s;
			SC_P2_AkumulacnyStoper.AlarmTime.PT:= T#5s;
			
									
			IF P2_Dopravniky.STAV.PoINIT THEN
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 3;
			END_IF
		
		3:
			SC_P2_AkumulacnyStoper.StepName:='3 - Inicializacia - hladanie paletky';
			SC_P2_AkumulacnyStoper.IdleTime.PT:= T#5s;
			SC_P2_AkumulacnyStoper.AlarmTime.PT:= T#5s;
			SC_P2_AkumulacnyStoper.IdleTime.IN:= TRUE;
	
			IF P2_AkumulacnyStoper.IN.PritomnostPaletky THEN
				P2_AkumulacnyStoper.STAV.PoINIT:= TRUE;
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 100;		
			ELSIF SC_P2_AkumulacnyStoper.IdleTime.Q THEN
				P2_AkumulacnyStoper.STAV.PoINIT:= TRUE;
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 100;
			END_IF
	
		
			//********************************************************Automatický režim****************************************************************************//
		100:
			SC_P2_AkumulacnyStoper.StepName:='100 - Automaticky Rezim - cakam na príchod paletky na stoper';
			SC_P2_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P2_AkumulacnyStoper.AlarmTime.PT:= T#5s;
		
                        
			SC_P2_AkumulacnyStoper.IdleTime.IN:= P2_AkumulacnyStoper.IN.PritomnostPaletky;
			
			IF P2_AkumulacnyStoper.IN.PritomnostPaletky THEN
				P2_StoperMaticovacky.STAV.PrebiehaVyvezeniePaletky:= FALSE;
			END_IF	
			
			IF P2_AkumulacnyStoper.KoniecCyklu THEN
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 0;
			ELSIF SC_P2_AkumulacnyStoper.IdleTime.Q THEN
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 101;
			END_IF
	
		
		101:
			SC_P2_AkumulacnyStoper.StepName:='101 - Automaticky Rezim - cakam na vyvezenie paletky na stoper srobovania';
			SC_P2_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P2_AkumulacnyStoper.AlarmTime.PT:= T#5s;
			
			IF P2_AkumulacnyStoper.KoniecCyklu THEN
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 0;
			ELSIF ((NOT P2_StoperSrobovania.RFID_hlava.PritomnostPaletky AND SC_P2_StoperSrobovania.Step = 100) OR (P2_StoperSrobovania.OUT.ZasunStoper AND SC_P2_StoperSrobovania.Step = 561)) AND NOT P2_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky THEN
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 105;
			END_IF
			
			
			
		105:
			SC_P2_AkumulacnyStoper.StepName:='105 - Automaticky Rezim - vyvazam paletku na stoper srobovania';
			SC_P2_AkumulacnyStoper.IdleTime.PT:= T#200ms;
			SC_P2_AkumulacnyStoper.AlarmTime.PT:= T#10s;
			
			SC_P2_AkumulacnyStoper.AlarmTime.IN:= P2_AkumulacnyStoper.IN.PritomnostPaletky;
			
			IF NOT SC_P2_AkumulacnyStoper.Switch1 THEN
				P2_AkumulacnyStoper.OUT.ZasunStoper:= TRUE;
				P2_AkumulacnyStoper.STAV.PrebiehaVyvezeniePaletky:= TRUE;
				SC_P2_AkumulacnyStoper.AlarmTime.IN:= TRUE;
				SC_P2_AkumulacnyStoper.Switch1:= TRUE;
			END_IF	
			
			IF NOT P2_AkumulacnyStoper.IN.PritomnostPaletky THEN
				P2_AkumulacnyStoper.OUT.ZasunStoper:= FALSE;
				SC_P2_AkumulacnyStoper.ResetStep:= TRUE;
				SC_P2_AkumulacnyStoper.Step:= 100;
			ELSIF SC_P2_AkumulacnyStoper.AlarmTime.Q THEN
				P2_Alarmy[299]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST3:= TRUE;	
			END_IF
			
			
				
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P2_AkumulacnyStoper.StepName:='700 - Manualny Rezim';
			SC_P2_AkumulacnyStoper.IdleTime.PT:= T#8s;
			SC_P2_AkumulacnyStoper.AlarmTime.PT:= T#5s;
		
		
		
		
		
		
		
	END_CASE	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

