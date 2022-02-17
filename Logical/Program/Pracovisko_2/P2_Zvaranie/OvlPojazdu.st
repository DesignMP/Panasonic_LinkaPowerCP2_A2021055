
ACTION OvlPojazdu: 

	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlPojazdu);
	
	
	CASE SC_OvlPojazdu.Step OF
		
		0:
			SC_OvlPojazdu.StepName:= '0 - Nulovanie';
			PresunVPRAVO:= FALSE;
			PresunVLAVO:= FALSE;
			P2_Zvaranie.OUT.PresunZvaranie_VPRAVO:= FALSE;
			P2_Zvaranie.OUT.PresunZvarania_VLAVO:= FALSE;
								
			IF SC_P2_Zvaranie.Step <> 0 THEN
				SC_OvlPojazdu.ResetStep:= TRUE;
				SC_OvlPojazdu.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlPojazdu.StepName:= '1 - Rozhodnutie o cinnosti';
			IF PresunVPRAVO THEN
				SC_OvlPojazdu.Step:= 10;
			ELSIF PresunVLAVO THEN
				SC_OvlPojazdu.Step:= 20;
			END_IF
	
		
		10:
			SC_OvlPojazdu.StepName:= '10 - Presunutie zvaracky vpravo';
			SC_OvlPojazdu.IdleTime.PT:= T#3s;
			SC_OvlPojazdu.AlarmTime.PT:= T#3s;
						
			IF P2_Zvaranie.Automat THEN
				SC_OvlPojazdu.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlPojazdu.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlPojazdu.Switch1 THEN
				P2_Zvaranie.OUT.PresunZvaranie_VPRAVO:= TRUE;
				SC_OvlPojazdu.Switch1:= TRUE;
			END_IF	
			
			IF P2_Zvaranie.IN.ZvaraniePresunute_VPRAVO OR SC_OvlPojazdu.IdleTime.Q THEN
				SC_OvlPojazdu.ResetStep:= TRUE;
				SC_OvlPojazdu.Step:= 0;
			ELSIF SC_OvlPojazdu.AlarmTime.Q THEN
				P2_Alarmy[221]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		20:
			SC_OvlPojazdu.StepName:= '20 - Presunutie zvaracky vlavo';
			SC_OvlPojazdu.IdleTime.PT:= T#3s;
			SC_OvlPojazdu.AlarmTime.PT:= T#3s;
						
			IF P2_Zvaranie.Automat THEN
				SC_OvlPojazdu.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlPojazdu.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlPojazdu.Switch1 THEN
				P2_Zvaranie.OUT.PresunZvarania_VLAVO:= TRUE;
				SC_OvlPojazdu.Switch1:= TRUE;
			END_IF	
			
			IF P2_Zvaranie.IN.ZvaraniePresunute_VLAVO OR SC_OvlPojazdu.IdleTime.Q THEN
				SC_OvlPojazdu.ResetStep:= TRUE;
				SC_OvlPojazdu.Step:= 0;
			ELSIF SC_OvlPojazdu.AlarmTime.Q THEN
				P2_Alarmy[221]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		
		
	END_CASE
	
	
END_ACTION
