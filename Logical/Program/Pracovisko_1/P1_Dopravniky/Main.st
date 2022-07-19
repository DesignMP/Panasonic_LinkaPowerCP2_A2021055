
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P1_Dopravniky);
	
	
	//Reset sekcie //
	IF P1_Dopravniky.Reset THEN
		SC_P1_Dopravniky.Step:= 0;
		P1_Dopravniky.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P1_Dopravniky.Step:= 0;
	END_IF	
	
	
	CASE SC_P1_Dopravniky.Step OF 
		
		0:
			SC_P1_Dopravniky.StepName:='0 - Nulovanie';
			P1_Dopravniky.Automat:= FALSE;
			P1_Dopravniky.KoniecCyklu:= FALSE;
			P1_Dopravniky.Manual:= FALSE;
			P1_Dopravniky.STAV.PoINIT:= FALSE;
			P1_Dopravniky.OUT.DopravnikBunky_ON:= FALSE;
			P1_Dopravniky.OUT.VratnyDopravnik_ON:= FALSE;
			
						
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND NOT P1_Pracovisko.STAV.PORUCHA AND P1_Pracovisko.STAV.HardwareBunky_OK THEN
				SC_P1_Dopravniky.ResetStep:= TRUE;
				SC_P1_Dopravniky.Step:= 1;
			END_IF
	
		1:
			SC_P1_Dopravniky.StepName:='1 - Cakam na spustenie vyroby';
			P1_Dopravniky.KoniecCyklu:= FALSE;
			IF P1_Dopravniky.Automat THEN
				SC_P1_Dopravniky.Step:= 2;
			ELSIF P1_Dopravniky.Manual THEN
				SC_P1_Dopravniky.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
	
	
		2:
			SC_P1_Dopravniky.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P1_Dopravniky.IdleTime.PT:= T#1s;
			SC_P1_Dopravniky.AlarmTime.PT:= T#5s;
			
			IF P1_Pracovisko.STAV.SkrutkovackyZasunute AND P1_Robot.STAV.PoINIT THEN
				SC_P1_Dopravniky.IdleTime.IN:= TRUE;
			ELSE	
				SC_P1_Dopravniky.IdleTime.IN:= FALSE;
			END_IF
			
			
			IF SC_P1_Dopravniky.IdleTime.Q THEN
				SC_P1_Dopravniky.ResetStep:= TRUE;
				SC_P1_Dopravniky.Step:= 3;
			END_IF	
	
			
		3:
			SC_P1_Dopravniky.StepName:='3 - Inicializacia - inicializacia tlmenia stoprov';
			SC_P1_Dopravniky.IdleTime.PT:= T#1s;
			SC_P1_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			IF P1_StoperSrobovania.RFID_hlava.PritomnostPaletky AND
				P1_AkumulacnyStoper.IN.PritomnostPaletky AND
				P1_SpodnyStoper.IN.PritomnostPaletky THEN
				SC_P1_Dopravniky.ResetStep:= TRUE;
				SC_P1_Dopravniky.Step:= 5;
			ELSE
				IF NOT P1_StoperSrobovania.RFID_hlava.PritomnostPaletky AND P1_StoperSrobovania.IN.Centrovanie_ZASUNUTE THEN
					P1_StoperSrobovania.OUT.ZasunStoper:= TRUE;
				END_IF	
				IF NOT P1_AkumulacnyStoper.IN.PritomnostPaletky THEN
					P1_AkumulacnyStoper.OUT.ZasunStoper:= TRUE;
				END_IF
				IF NOT P1_SpodnyStoper.IN.PritomnostPaletky THEN
					P1_SpodnyStoper.OUT.ZasunStoper:= TRUE;
				END_IF
				SC_P1_Dopravniky.IdleTime.IN:= TRUE;
			END_IF	
			
			IF SC_P1_Dopravniky.IdleTime.Q THEN
				P1_StoperSrobovania.OUT.ZasunStoper:= FALSE;
				P1_AkumulacnyStoper.OUT.ZasunStoper:= FALSE;
				P1_SpodnyStoper.OUT.ZasunStoper:= FALSE;
				SC_P1_Dopravniky.ResetStep:= TRUE;
				SC_P1_Dopravniky.Step:= 5;
			END_IF	
			
		5:
			SC_P2_Dopravniky.StepName:='5 - Inicializacia - ukoncenie inicializacie';
			SC_P2_Dopravniky.IdleTime.PT:= T#5s;
			SC_P2_Dopravniky.AlarmTime.PT:= T#5s;
		
			P1_Dopravniky.OUT.DopravnikBunky_ON:= TRUE;
			P1_Dopravniky.OUT.VratnyDopravnik_ON:= TRUE;
			SC_P1_Dopravniky.IdleTime.IN:= TRUE;
			
			IF SC_P1_Dopravniky.IdleTime.Q THEN
				P1_Dopravniky.STAV.PoINIT:= TRUE;
				SC_P1_Dopravniky.ResetStep:= TRUE;
				SC_P1_Dopravniky.Step:= 100;
			END_IF
			
	
			
			//********************************************************Automatický režim****************************************************************************//
			
		100:  
			SC_P1_Dopravniky.StepName:='100 - Automaticky Rezim - cakam na vypnutie dopravnikou';
			SC_P1_Dopravniky.IdleTime.PT:= T#200ms;
			SC_P1_Dopravniky.AlarmTime.PT:= T#5s;			
			
			IF P1_Dopravniky.KoniecCyklu AND
				NOT P1_Vytah.STAV.PrebiehaVyvezeniePaletky AND
				NOT P1_StoperSrobovania.Automat AND
				NOT P1_AkumulacnyStoper.Automat AND
				NOT P1_SpodnyStoper.Automat THEN
				SC_P1_Dopravniky.ResetStep:= TRUE;
				SC_P1_Dopravniky.Step:= 0;
			END_IF
			
			
			
			
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P1_Dopravniky.StepName:='700 - Manualny Rezim';
			SC_P1_Dopravniky.IdleTime.PT:= T#8s;
			SC_P1_Dopravniky.AlarmTime.PT:= T#5s;
			
			
			
			
	END_CASE		
	
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

