
ACTION OvlSkrutkovacichSetov: 

		//***********************************Skrutkovací set K40************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_K40);
	
	CASE SC_SkrutkovaciSet_K40.Step OF 
	
		0:
			SC_SkrutkovaciSet_K40.StepName:='0 - Nulovanie';
			P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
			P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= FALSE;
			P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetK40_VysunBrzdu:= FALSE;
			
			P3_Srobovanie.STAV.SkrutkaK40_READY:= FALSE;
			IF SC_P3_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_K40.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P3_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 10;
			ELSIF P3_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_K40.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_K40.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K40.AlarmTime.PT:= T#5s;
		
			P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= TRUE;
		
			IF P3_Srobovanie.CMD.PodajSkrutku_K40 THEN
				P3_Srobovanie.CMD.PodajSkrutku_K40:= FALSE;
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 13;
			END_IF	
		
		13:
			SC_SkrutkovaciSet_K40.StepName:='13 - Automaticky rezim - podanie skrutky do skrutkovacky';
			SC_SkrutkovaciSet_K40.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K40.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_K40.Switch1 THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_K40.Switch1:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.SkrutSet_K40.Status.SkrutkaPripravena THEN
				P3_Srobovanie.STAV.SkrutkaK40_READY:= TRUE;
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 15;
			ELSIF P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				P34_Alarmy[328]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF
				
		15:
			SC_SkrutkovaciSet_K40.StepName:='15 - Automaticky rezim - cakam na zrusenie stavu skrutka K40 READY';
			SC_SkrutkovaciSet_K40.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K40.AlarmTime.PT:= T#5s;	
		
			IF NOT P3_Srobovanie.STAV.SkrutkaK40_READY THEN
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 10;
			ELSIF P3_Srobovanie.Manual THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 20;
			END_IF
		
		
		
		20:
			SC_SkrutkovaciSet_K40.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_K40.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K40.AlarmTime.PT:= T#5s;
		
			//Ovládanie zásobníka//
			IF P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			
			//Ovládanie brzdy//
			IF P3_Srobovanie.CMD.RR_SkrutSetK40_VysunBrzdu THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualPresunBrzdu:= TRUE;
			ELSE
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualPresunBrzdu:= FALSE;
			END_IF	
			
			
			
			
			//Podanie skrutky//
			IF P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku THEN
				P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku:= FALSE;
				P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualPresunBrzdu:= FALSE;
				P3_Srobovanie.CMD.PodajSkrutku_K40:= TRUE;
				SC_SkrutkovaciSet_K40.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K40.Step:= 10;
			END_IF	
				
	END_CASE
		
	
	//***********************************Skrutkovací set M5***************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_M5);
	
	CASE SC_SkrutkovaciSet_M5.Step OF 
	
		0:
			SC_SkrutkovaciSet_M5.StepName:='0 - Nulovanie';
			P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vstup:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vystup:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= FALSE;
			
			IF SC_P3_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_M5.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P3_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			ELSIF P3_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_M5.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
		
			P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
		
			IF P3_Srobovanie.CMD.PodajSkrutku_M5 THEN
				P3_Srobovanie.CMD.PodajSkrutku_M5:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 13;
			END_IF	
			
			
		13:
			SC_SkrutkovaciSet_M5.StepName:='13 - Automaticky rezim - podanie skrutky';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_M5.Switch1 THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_M5.Switch1:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.SkrutSet_M5.STAV.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 15;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				P34_Alarmy[327]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;		
			END_IF
			
			
		15:
			SC_SkrutkovaciSet_M5.StepName:='15 - Automaticky rezim - ukoncenie podania skrutky M5';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;	
		
			IF P3_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 20;
			ELSE
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			END_IF
			
			
		20:
			SC_SkrutkovaciSet_M5.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
		
			P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
			P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;	
			
			//Ovládanie zásobníka//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN THEN
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= TRUE;
			ELSE
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= FALSE;
			END_IF	
			
			
			//Ovládanie vibrolišty//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN THEN
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= TRUE;
			ELSE
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= FALSE;
			END_IF	
			
			
			//Otáèanie podavaèa skrutiek//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vstup THEN
				P3_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vstup:= TRUE;
				P3_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vstup:= FALSE;
			ELSIF P3_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vystup THEN
				P3_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vystup:= TRUE;
				P3_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vystup:= FALSE;
			END_IF	
			
			
			
			//Podanie skrutky//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku THEN
				P3_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
				P3_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
				P3_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN:= FALSE;
				P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;
				P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			END_IF
			
			
	END_CASE
	
	
	
END_ACTION
