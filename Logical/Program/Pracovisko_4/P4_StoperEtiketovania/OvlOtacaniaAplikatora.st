
ACTION OvlOtacaniaAplikatora: 

	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlOtacaniaAplikatora);
	
	
	CASE SC_OvlOtacaniaAplikatora.Step OF
		
		0:
			SC_OvlOtacaniaAplikatora.StepName:= '0 - Nulovanie';
			OtocAplikator_VPRED:= FALSE;
			OtocAplikator_VZAD:= FALSE;
								
			IF SC_P4_Etiketovacka.Step <> 0 THEN
				SC_OvlOtacaniaAplikatora.ResetStep:= TRUE;
				SC_OvlOtacaniaAplikatora.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlOtacaniaAplikatora.StepName:= '1 - Rozhodnutie o cinnosti';
			IF OtocAplikator_VPRED THEN
				SC_OvlOtacaniaAplikatora.Step:= 10;
			ELSIF OtocAplikator_VZAD THEN
				SC_OvlOtacaniaAplikatora.Step:= 20;
			END_IF
	
		
		10:
			SC_OvlOtacaniaAplikatora.StepName:= '10 - Otocenie aplikatora vpred';
			SC_OvlOtacaniaAplikatora.IdleTime.PT:= T#3s;
			SC_OvlOtacaniaAplikatora.AlarmTime.PT:= T#6s;
						
			IF P4_Etiketovacka.Automat THEN
				SC_OvlOtacaniaAplikatora.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlOtacaniaAplikatora.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlOtacaniaAplikatora.Switch1 THEN
				P4_Etiketovacka.OUT.Aplikator_OtocVZAD:= FALSE;
                P4_Etiketovacka.OUT.Aplikator_OtocVPRED:= TRUE;
				SC_OvlOtacaniaAplikatora.Switch1:= TRUE;
			END_IF	
			
			IF P4_Etiketovacka.IN.Aplikator_OtocenyVPRED OR SC_OvlOtacaniaAplikatora.IdleTime.Q THEN
				SC_OvlOtacaniaAplikatora.ResetStep:= TRUE;
				SC_OvlOtacaniaAplikatora.Step:= 0;
			ELSIF SC_OvlOtacaniaAplikatora.AlarmTime.Q THEN
				P34_Alarmy[462]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		20:
			SC_OvlOtacaniaAplikatora.StepName:= '20 - Otocenie aplikatora vzad';
			SC_OvlOtacaniaAplikatora.IdleTime.PT:= T#3s;
			SC_OvlOtacaniaAplikatora.AlarmTime.PT:= T#6s;
						
			IF P4_Etiketovacka.Automat THEN
				SC_OvlOtacaniaAplikatora.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlOtacaniaAplikatora.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlOtacaniaAplikatora.Switch1 THEN
				P4_Etiketovacka.OUT.Aplikator_OtocVPRED:= FALSE;
                P4_Etiketovacka.OUT.Aplikator_OtocVZAD:= TRUE;
				SC_OvlOtacaniaAplikatora.Switch1:= TRUE;
			END_IF	
			
			IF P4_Etiketovacka.IN.Aplikator_OtocenyVZAD OR SC_OvlOtacaniaAplikatora.IdleTime.Q THEN
				SC_OvlOtacaniaAplikatora.ResetStep:= TRUE;
				SC_OvlOtacaniaAplikatora.Step:= 0;
			ELSIF SC_OvlOtacaniaAplikatora.AlarmTime.Q THEN
				P34_Alarmy[463]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST5:= TRUE;
			END_IF
		
		
		
		
	END_CASE
	
END_ACTION
