
ACTION OvlZdvizky: 

	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlZdvizky);
	
	
	CASE SC_OvlZdvizky.Step OF
		
		0:
			SC_OvlZdvizky.StepName:= '0 - Nulovanie';
			Zdvizku_VYSUN:= FALSE;
			Zdvizku_ZASUN:= FALSE;
			Zdvizku_VYSTRED:= FALSE;
			
								
			IF SC_P4_ZdvizkaZaFunkcTestB.Step <> 0 THEN
				SC_OvlZdvizky.ResetStep:= TRUE;
				SC_OvlZdvizky.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlZdvizky.StepName:= '1 - Rozhodnutie o cinnosti';
			IF Zdvizku_VYSUN THEN
				SC_OvlZdvizky.Step:= 10;
			ELSIF Zdvizku_VYSTRED THEN
				SC_OvlZdvizky.Step:= 30;
			END_IF
	
		
		10:
			SC_OvlZdvizky.StepName:= '10 - Vysunutie zdvizky hore';
			SC_OvlZdvizky.IdleTime.PT:= T#3s;
			SC_OvlZdvizky.AlarmTime.PT:= T#6s;
						
			IF P4_ZdvizkaZaFunkcTestB.Automat THEN
				SC_OvlZdvizky.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlZdvizky.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlZdvizky.Switch1 THEN
				P4_ZdvizkaZaFunkcTestB.OUT.Zdvizku_VYSUN:= TRUE;
				SC_OvlZdvizky.Switch1:= TRUE;
			END_IF	
			
			IF P4_ZdvizkaZaFunkcTestB.IN.Zdvizka_HornaPoloha OR SC_OvlZdvizky.IdleTime.Q THEN
				SC_OvlZdvizky.ResetStep:= TRUE;
				SC_OvlZdvizky.Step:= 0;
			ELSIF SC_OvlZdvizky.AlarmTime.Q THEN
				P34_Alarmy[459]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
		
		
		
		
		30:
			SC_OvlZdvizky.StepName:= '30 - Presun zdvizky do strednej polohy';
			SC_OvlZdvizky.IdleTime.PT:= T#3s;
			SC_OvlZdvizky.AlarmTime.PT:= T#6s;
						
			IF P4_ZdvizkaZaFunkcTestB.Automat THEN
				SC_OvlZdvizky.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlZdvizky.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlZdvizky.Switch1 THEN
				P4_ZdvizkaZaFunkcTestB.OUT.Zdvizku_VYSUN:= FALSE;
				SC_OvlZdvizky.Switch1:= TRUE;
			END_IF	
			
			IF P4_ZdvizkaZaFunkcTestB.IN.Zdvizka_StrednaPoloha OR SC_OvlZdvizky.IdleTime.Q THEN
				SC_OvlZdvizky.ResetStep:= TRUE;
				SC_OvlZdvizky.Step:= 0;
			ELSIF SC_OvlZdvizky.AlarmTime.Q THEN
				P34_Alarmy[461]:= TRUE;
				P4_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF
		
		
	END_CASE
	
END_ACTION
