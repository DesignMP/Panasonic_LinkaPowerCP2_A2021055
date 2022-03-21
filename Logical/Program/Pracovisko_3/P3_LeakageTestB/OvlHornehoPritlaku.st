
ACTION OvlHornehoPritlaku: 

		
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_OvlHornehoPritlaku);
	
	
	CASE SC_OvlHornehoPritlaku.Step OF
		
		0:
			SC_OvlHornehoPritlaku.StepName:= '0 - Nulovanie';
			HornyPritlak_VYSUN:= FALSE;
			HornyPritlak_ZASUN:= FALSE;
			
			
			IF SC_P3_LeakageTestB.Step <> 0 THEN
				SC_OvlHornehoPritlaku.ResetStep:= TRUE;
				SC_OvlHornehoPritlaku.Step:= 1;
			END_IF	
	
	
		1:
			SC_OvlHornehoPritlaku.StepName:= '1 - Rozhodnutie o cinnosti';
			IF HornyPritlak_VYSUN THEN
				SC_OvlHornehoPritlaku.Step:= 10;
			ELSIF HornyPritlak_ZASUN THEN
				SC_OvlHornehoPritlaku.Step:= 20;
			END_IF
	
		
		10:
			SC_OvlHornehoPritlaku.StepName:= '10 - Vysunutie horneho pritlaku';
			SC_OvlHornehoPritlaku.IdleTime.PT:= T#3s;
			SC_OvlHornehoPritlaku.AlarmTime.PT:= T#6s;
						
			IF P3_LeakageTestB.Automat THEN
				SC_OvlHornehoPritlaku.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlHornehoPritlaku.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlHornehoPritlaku.Switch1 THEN
				P3_LeakageTestB.OUT.PneuZamokZvonu_ODOMKNI:= TRUE;
				P3_LeakageTestB.OUT.HornyPritlak_ZASUN:= FALSE;
				P3_LeakageTestB.OUT.HornyPritlak_VYSUN:= TRUE;
				SC_OvlHornehoPritlaku.Switch1:= TRUE;
			END_IF	
			
			IF P3_LeakageTestB.IN.HornyPritlak_VYSUNUTY OR SC_OvlHornehoPritlaku.IdleTime.Q THEN
				SC_OvlHornehoPritlaku.ResetStep:= TRUE;
				SC_OvlHornehoPritlaku.Step:= 0;
			ELSIF SC_OvlHornehoPritlaku.AlarmTime.Q THEN
				P34_Alarmy[308]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF
		
		
		20:
			SC_OvlHornehoPritlaku.StepName:= '20 - Zasunutie horneho pritlaku';
			SC_OvlHornehoPritlaku.IdleTime.PT:= T#3s;
			SC_OvlHornehoPritlaku.AlarmTime.PT:= T#6s;
						
			IF P3_LeakageTestB.Automat THEN
				SC_OvlHornehoPritlaku.AlarmTime.IN:= TRUE;
			ELSE
				SC_OvlHornehoPritlaku.IdleTime.IN:= TRUE;
			END_IF	
			
			IF NOT SC_OvlHornehoPritlaku.Switch1 THEN
				P3_LeakageTestB.OUT.PneuZamokZvonu_ODOMKNI:= TRUE;
				P3_LeakageTestB.OUT.HornyPritlak_VYSUN:= FALSE;
				P3_LeakageTestB.OUT.HornyPritlak_ZASUN:= TRUE;
				SC_OvlHornehoPritlaku.Switch1:= TRUE;
			END_IF	
			
			IF P3_LeakageTestB.IN.HornyPritlak_ZASUNUTY OR SC_OvlHornehoPritlaku.IdleTime.Q THEN
				SC_OvlHornehoPritlaku.ResetStep:= TRUE;
				SC_OvlHornehoPritlaku.Step:= 0;
			ELSIF SC_OvlHornehoPritlaku.AlarmTime.Q THEN
				P34_Alarmy[309]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST6:= TRUE;
			END_IF
		
		
		
		
	END_CASE
	
	
	
	
END_ACTION
