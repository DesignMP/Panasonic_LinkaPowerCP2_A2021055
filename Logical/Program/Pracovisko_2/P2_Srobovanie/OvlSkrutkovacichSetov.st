
ACTION OvlSkrutkovacichSetov: 

//***********************************Skrutkovací set M6************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_M6);
	
	CASE SC_SkrutkovaciSet_M6.Step OF 
	
		0:
			SC_SkrutkovaciSet_M6.StepName:='0 - Nulovanie';
			P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
			P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= FALSE;
			P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM6_PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM6_VysunBrzdu:= FALSE;
			P2_Srobovanie.SkrutSet_M6.Cmd.ManualPresunBrzdu:= FALSE;
			P2_Srobovanie.STAV.SkrutkaM6_READY:= FALSE;
			IF SC_P2_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_M6.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P2_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 10;
			ELSIF P2_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_M6.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_M6.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M6.AlarmTime.PT:= T#5s;
		
			P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= TRUE;
		
			IF P2_Srobovanie.CMD.PodajSkrutku_M6 THEN
				P2_Srobovanie.CMD.PodajSkrutku_M6:= FALSE;
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 13;
			END_IF	
		
		13:
			SC_SkrutkovaciSet_M6.StepName:='13 - Automaticky rezim - podanie skrutky do skrutkovacky';
			SC_SkrutkovaciSet_M6.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M6.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_M6.Switch1 THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_M6.Switch1:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena THEN
				P2_Srobovanie.STAV.SkrutkaM6_READY:= TRUE;
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 15;
			ELSIF P2_Srobovanie.SkrutSet_M6.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
				P2_Alarmy[239]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;	
			END_IF
				
		15:
			SC_SkrutkovaciSet_M6.StepName:='15 - Automaticky rezim - cakam na zrusenie stavu skrutka M6 READY';
			SC_SkrutkovaciSet_M6.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M6.AlarmTime.PT:= T#5s;	
		
			IF NOT P2_Srobovanie.STAV.SkrutkaM6_READY THEN
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 10;
			ELSIF P2_Srobovanie.Manual THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 20;
			END_IF
		
		
		
		20:
			SC_SkrutkovaciSet_M6.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_M6.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M6.AlarmTime.PT:= T#5s;
		
			//Ovládanie zásobníka//
			IF P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			//Ovládanie brzdy//
			IF P2_Srobovanie.CMD.RR_SkrutSetM6_VysunBrzdu THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualPresunBrzdu:= TRUE;
			ELSE
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualPresunBrzdu:= FALSE;
			END_IF	
			
			
			
			
			//Podanie skrutky//
			IF P2_Srobovanie.CMD.RR_SkrutSetM6_PodajSkrutku THEN
				P2_Srobovanie.CMD.RR_SkrutSetM6_PodajSkrutku:= FALSE;
				P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualPresunBrzdu:= FALSE;
				P2_Srobovanie.CMD.PodajSkrutku_M6:= TRUE;
				SC_SkrutkovaciSet_M6.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M6.Step:= 10;
			END_IF	
				
	END_CASE
		

	
	
	
	//***********************************Skrutkovací set M4**************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_M4);
	
	CASE SC_SkrutkovaciSet_M4.Step OF 
	
		0:
			SC_SkrutkovaciSet_M4.StepName:='0 - Nulovanie';
			P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= FALSE;
			P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= FALSE;
			P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
			P2_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vstup:= FALSE;
			P2_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vystup:= FALSE;
			P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= FALSE;
			P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= FALSE;
			
			IF SC_P2_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_M4.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P2_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 10;
			ELSIF P2_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_M4.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;
		
			P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
		
			IF P2_Srobovanie.CMD.PodajSkrutku_M4 THEN
				P2_Srobovanie.CMD.PodajSkrutku_M4:= FALSE;
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 13;
			END_IF	
			
			
		13:
			SC_SkrutkovaciSet_M4.StepName:='13 - Automaticky rezim - podanie skrutky';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_M4.Switch1 THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_M4.Switch1:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 15;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;		
			END_IF
			
			
		15:
			SC_SkrutkovaciSet_M4.StepName:='15 - Automaticky rezim - ukoncenie podania skrutkz M4';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;	
		
			IF P2_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 20;
			ELSE
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 10;
			END_IF
			
			
		20:
			SC_SkrutkovaciSet_M4.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;
		
			P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
			P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;	
			
			//Ovládanie zásobníka//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN THEN
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= TRUE;
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= FALSE;
			END_IF	
			
			
			//Ovládanie vibrolišty//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN THEN
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= TRUE;
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= FALSE;
			END_IF	
			
			
			//Otáèanie podavaèa skrutiek//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup THEN
				P2_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vstup:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup:= FALSE;
			ELSIF P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup THEN
				P2_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vystup:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup:= FALSE;
			END_IF	
			
			
			
			//Podanie skrutky//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku THEN
				P2_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku:= FALSE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN:= FALSE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN:= FALSE;
				P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P2_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 10;
			END_IF
			
			
	END_CASE
	
	
	
		
	
	//***********************************Skrutkovací set M5***************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_M5);
	
	CASE SC_SkrutkovaciSet_M5.Step OF 
	
		0:
			SC_SkrutkovaciSet_M5.StepName:='0 - Nulovanie';
			P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
			P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= FALSE;
			P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM5_VysunBrzdu:= FALSE;
			P2_Srobovanie.SkrutSet_M5.Cmd.ManualPresunBrzdu:= FALSE;
			P2_Srobovanie.STAV.SkrutkaM5_READY:= FALSE;
			
			IF SC_P2_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_M5.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P2_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			ELSIF P2_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_M5.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
		
			P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= TRUE;
		
			IF P2_Srobovanie.CMD.PodajSkrutku_M5 THEN
				P2_Srobovanie.CMD.PodajSkrutku_M5:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 13;
			END_IF	
		
		13:
			SC_SkrutkovaciSet_M5.StepName:='13 - Automaticky rezim - podanie skrutky do skrutkovacky';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_M5.Switch1 THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_M5.Switch1:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena THEN
				P2_Srobovanie.STAV.SkrutkaM5_READY:= TRUE;
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 15;
			ELSIF P2_Srobovanie.SkrutSet_M5.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
				P2_Alarmy[238]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;	
			END_IF
				
		15:
			SC_SkrutkovaciSet_M5.StepName:='15 - Automaticky rezim - cakam na zrusenie stavu skrutka M5 READY';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;	
		
			IF NOT P2_Srobovanie.STAV.SkrutkaM5_READY THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			ELSIF P2_Srobovanie.Manual THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 20;
			END_IF
		
		
		
		20:
			SC_SkrutkovaciSet_M5.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
		
			//Ovládanie zásobníka//
			IF P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			
			//Ovládanie brzdy//
			IF P2_Srobovanie.CMD.RR_SkrutSetM5_VysunBrzdu THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualPresunBrzdu:= TRUE;
			ELSE
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualPresunBrzdu:= FALSE;
			END_IF	
			
			
			
			//Podanie skrutky//
			IF P2_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku THEN
				P2_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
				P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualPresunBrzdu:= FALSE;
				P2_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			END_IF	
				
	END_CASE
	
END_ACTION
