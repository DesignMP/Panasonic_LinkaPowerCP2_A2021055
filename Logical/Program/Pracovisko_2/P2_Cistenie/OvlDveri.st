
ACTION OvlDveri: 

	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlDveri);
	
	
	CASE SC_OvlDveri.Step OF
		
		0:
			SC_OvlDveri.StepName:= '0 - Nulovanie';
			Dvere_OTVOR:= FALSE;
			Dvere_ZATVOR:= FALSE;
			P2_Cistenie.OUT.Dvere_OTVOR:= FALSE;
			P2_Cistenie.OUT.Dvere_ZATVOR:= FALSE;
								
			IF SC_P2_Cistenie.Step <> 0 THEN
				SC_OvlDveri.ResetStep:= TRUE;
				SC_OvlDveri.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlDveri.StepName:= '1 - Rozhodnutie o cinnosti';
			IF Dvere_OTVOR THEN
				SC_OvlDveri.Step:= 10;
			ELSIF Dvere_ZATVOR THEN
				SC_OvlDveri.Step:= 20;
			END_IF
	
		
		10:
			SC_OvlDveri.StepName:= '10 - Otvorenie dveri';
			SC_OvlDveri.IdleTime.PT:= T#3s;
			SC_OvlDveri.AlarmTime.PT:= T#3s;
						
			IF P2_Cistenie.Automat THEN
				SC_OvlDveri.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlDveri.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlDveri.Switch1 THEN
				P2_Cistenie.OUT.Dvere_OTVOR:= TRUE;
				SC_OvlDveri.Switch1:= TRUE;
			END_IF	
			
			IF P2_Cistenie.IN.Dvere_OTVORENE OR SC_OvlDveri.IdleTime.Q THEN
				SC_OvlDveri.ResetStep:= TRUE;
				SC_OvlDveri.Step:= 0;
			ELSIF SC_OvlDveri.AlarmTime.Q THEN
				P2_Alarmy[224]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		20:
			SC_OvlDveri.StepName:= '20 - Zatvorenie dveri';
			SC_OvlDveri.IdleTime.PT:= T#3s;
			SC_OvlDveri.AlarmTime.PT:= T#3s;
						
			IF P2_Cistenie.Automat THEN
				SC_OvlDveri.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlDveri.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlDveri.Switch1 THEN
				P2_Cistenie.OUT.Dvere_ZATVOR:= TRUE;
				SC_OvlDveri.Switch1:= TRUE;
			END_IF	
			
			IF P2_Cistenie.IN.Dvere_ZATVORENE OR SC_OvlDveri.IdleTime.Q THEN
				SC_OvlDveri.ResetStep:= TRUE;
				SC_OvlDveri.Step:= 0;
			ELSIF SC_OvlDveri.AlarmTime.Q THEN
				P2_Alarmy[223]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		
		
	END_CASE
	
	
	
	
END_ACTION
