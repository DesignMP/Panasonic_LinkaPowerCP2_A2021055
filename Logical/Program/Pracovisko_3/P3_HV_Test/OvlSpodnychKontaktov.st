
ACTION OvlSpodnychKontaktov: 

	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlSpodnychKontaktov);
	
	
	CASE SC_OvlSpodnychKontaktov.Step OF
		
		0:
			SC_OvlSpodnychKontaktov.StepName:= '0 - Nulovanie';
			SpodneKontakty_VYSUN:= FALSE;
			SpodneKontakty_ZASUN:= FALSE;
								
			IF SC_P3_HV_Test.Step <> 0 THEN
				SC_OvlSpodnychKontaktov.ResetStep:= TRUE;
				SC_OvlSpodnychKontaktov.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlSpodnychKontaktov.StepName:= '1 - Rozhodnutie o cinnosti';
			IF SpodneKontakty_VYSUN THEN
				SC_OvlSpodnychKontaktov.Step:= 10;
			ELSIF SpodneKontakty_ZASUN THEN
				SC_OvlSpodnychKontaktov.Step:= 20;
			END_IF
	
		
		10:
			SC_OvlSpodnychKontaktov.StepName:= '10 - Vysunutie spodnych kontaktov';
			SC_OvlSpodnychKontaktov.IdleTime.PT:= T#3s;
			SC_OvlSpodnychKontaktov.AlarmTime.PT:= T#6s;
						
			IF P3_HV_Test.Automat THEN
				SC_OvlSpodnychKontaktov.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlSpodnychKontaktov.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlSpodnychKontaktov.Switch1 THEN
				P3_HV_Test.OUT.SpodneKontakty_ZASUN:= FALSE;
                P3_HV_Test.OUT.SpodneKontakty_VYSUN:= TRUE;
				SC_OvlSpodnychKontaktov.Switch1:= TRUE;
			END_IF	
			
			IF P3_HV_Test.IN.SpodneKontakty_VYSUNUTE OR SC_OvlSpodnychKontaktov.IdleTime.Q THEN
				SC_OvlSpodnychKontaktov.ResetStep:= TRUE;
				SC_OvlSpodnychKontaktov.Step:= 0;
			ELSIF SC_OvlSpodnychKontaktov.AlarmTime.Q THEN
				P34_Alarmy[362]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		
		20:
			SC_OvlSpodnychKontaktov.StepName:= '20 - Zasunutie spodnych kontaktov';
			SC_OvlSpodnychKontaktov.IdleTime.PT:= T#3s;
			SC_OvlSpodnychKontaktov.AlarmTime.PT:= T#6s;
						
			IF P3_HV_Test.Automat THEN
				SC_OvlSpodnychKontaktov.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlSpodnychKontaktov.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlSpodnychKontaktov.Switch1 THEN
				P3_HV_Test.OUT.SpodneKontakty_VYSUN:= FALSE;
                P3_HV_Test.OUT.SpodneKontakty_ZASUN:= TRUE;
				SC_OvlSpodnychKontaktov.Switch1:= TRUE;
			END_IF	
			
			IF P3_HV_Test.IN.SpodneKontakty_ZASUNUTE OR SC_OvlSpodnychKontaktov.IdleTime.Q THEN
				SC_OvlSpodnychKontaktov.ResetStep:= TRUE;
				SC_OvlSpodnychKontaktov.Step:= 0;
			ELSIF SC_OvlSpodnychKontaktov.AlarmTime.Q THEN
				P34_Alarmy[363]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
		
		
		
		
	END_CASE
	
END_ACTION
