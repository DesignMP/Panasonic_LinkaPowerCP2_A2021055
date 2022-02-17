
ACTION OvlHornychKontaktov: 

	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlHornychKontaktov);
	
	
	CASE SC_OvlHornychKontaktov.Step OF
		
		0:
			SC_OvlHornychKontaktov.StepName:= '0 - Nulovanie';
			HorneKontakty_VYSUN:= FALSE;
			HorneKontakty_ZASUN:= FALSE;
								
			IF SC_P3_HV_Test.Step <> 0 THEN
				SC_OvlHornychKontaktov.ResetStep:= TRUE;
				SC_OvlHornychKontaktov.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlHornychKontaktov.StepName:= '1 - Rozhodnutie o cinnosti';
			IF HorneKontakty_VYSUN THEN
				SC_OvlHornychKontaktov.Step:= 10;
			ELSIF HorneKontakty_ZASUN THEN
				SC_OvlHornychKontaktov.Step:= 20;
			END_IF
	
		
		10:
			SC_OvlHornychKontaktov.StepName:= '10 - Vysunutie hornych kontaktov';
			SC_OvlHornychKontaktov.IdleTime.PT:= T#3s;
			SC_OvlHornychKontaktov.AlarmTime.PT:= T#6s;
						
			IF P3_HV_Test.Automat THEN
				SC_OvlHornychKontaktov.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlHornychKontaktov.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlHornychKontaktov.Switch1 THEN
				P3_HV_Test.OUT.HorneKontakty_ZASUN:= FALSE;
				P3_HV_Test.OUT.HorneKontakty_VYSUN:= TRUE;
				SC_OvlHornychKontaktov.Switch1:= TRUE;
			END_IF	
			
			IF P3_HV_Test.IN.HorneKontakty_VYSUNUTE OR SC_OvlHornychKontaktov.IdleTime.Q THEN
				SC_OvlHornychKontaktov.ResetStep:= TRUE;
				SC_OvlHornychKontaktov.Step:= 0;
			ELSIF SC_OvlHornychKontaktov.AlarmTime.Q THEN
				P34_Alarmy[364]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		
		20:
			SC_OvlHornychKontaktov.StepName:= '20 - Zasunutie hornych kontaktov';
			SC_OvlHornychKontaktov.IdleTime.PT:= T#3s;
			SC_OvlHornychKontaktov.AlarmTime.PT:= T#6s;
						
			IF P3_HV_Test.Automat THEN
				SC_OvlHornychKontaktov.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlHornychKontaktov.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlHornychKontaktov.Switch1 THEN
				P3_HV_Test.OUT.HorneKontakty_VYSUN:= FALSE;
				P3_HV_Test.OUT.HorneKontakty_ZASUN:= TRUE;
				SC_OvlHornychKontaktov.Switch1:= TRUE;
			END_IF	
			
			IF P3_HV_Test.IN.HorneKontakty_ZASUNUTE OR SC_OvlHornychKontaktov.IdleTime.Q THEN
				SC_OvlHornychKontaktov.ResetStep:= TRUE;
				SC_OvlHornychKontaktov.Step:= 0;
			ELSIF SC_OvlHornychKontaktov.AlarmTime.Q THEN
				P34_Alarmy[365]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		
		
		
	END_CASE
	
END_ACTION
