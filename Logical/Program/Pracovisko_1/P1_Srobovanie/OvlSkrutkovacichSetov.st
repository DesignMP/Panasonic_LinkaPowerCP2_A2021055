
ACTION OvlSkrutkovacichSetov: 

	
	//***********************************Skrutkovací set K30************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_K30);
	
	CASE SC_SkrutkovaciSet_K30.Step OF 
	
		0:
			SC_SkrutkovaciSet_K30.StepName:='0 - Nulovanie';
			P1_Srobovanie.SkrutSet_K30.Cmd.AutomatStart:= FALSE;
			P1_Srobovanie.SkrutSet_K30.Cmd.ManualStartHrniec:= FALSE;
			P1_Srobovanie.SkrutSet_K30.Cmd.PodajSkrutku:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutSetK30_PodajSkrutku:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutSetK30_Zasobnik_RUN:= FALSE;
			P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
			IF SC_P1_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_K30.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P1_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 10;
			ELSIF P1_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_K30.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_K30.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K30.AlarmTime.PT:= T#5s;
		
			P1_Srobovanie.SkrutSet_K30.Cmd.AutomatStart:= TRUE;
		
			IF P1_Srobovanie.CMD.PodajSkrutku_K30 THEN
				P1_Srobovanie.CMD.PodajSkrutku_K30:= FALSE;
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 13;
			END_IF	
		
		13:
			SC_SkrutkovaciSet_K30.StepName:='13 - Automaticky rezim - podanie skrutky do skrutkovacky';
			SC_SkrutkovaciSet_K30.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K30.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_K30.Switch1 THEN
				P1_Srobovanie.SkrutSet_K30.Cmd.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_K30.Switch1:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.SkrutSet_K30.Status.SkrutkaPripravena THEN
				P1_Srobovanie.STAV.SkrutkaK30_READY:= TRUE;
				P1_Srobovanie.SkrutSet_K30.Cmd.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 15;
			ELSIF P1_Srobovanie.SkrutSet_K30.Error.ErrorBit THEN
				P1_Srobovanie.SkrutSet_K30.Cmd.PodajSkrutku:= FALSE;
				P1_Alarmy[119]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF
				
		15:
			SC_SkrutkovaciSet_K30.StepName:='15 - Automaticky rezim - cakam na zrusenie stavu skrutka K30 READY';
			SC_SkrutkovaciSet_K30.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K30.AlarmTime.PT:= T#5s;	
		
			IF NOT P1_Srobovanie.STAV.SkrutkaK30_READY THEN
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 10;
			ELSIF P1_Srobovanie.Manual THEN
				P1_Srobovanie.SkrutSet_K30.Cmd.AutomatStart:= FALSE;
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 20;
			END_IF
		
		
		
		20:
			SC_SkrutkovaciSet_K30.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_K30.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_K30.AlarmTime.PT:= T#5s;
		
			//Ovládanie zásobníka//
			IF P1_Srobovanie.CMD.RR_SkrutSetK30_Zasobnik_RUN THEN
				P1_Srobovanie.SkrutSet_K30.Cmd.AutomatStart:= FALSE;
				P1_Srobovanie.SkrutSet_K30.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P1_Srobovanie.SkrutSet_K30.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			
			//Podanie skrutky//
			IF P1_Srobovanie.CMD.RR_SkrutSetK30_PodajSkrutku THEN
				P1_Srobovanie.CMD.RR_SkrutSetK30_PodajSkrutku:= FALSE;
				P1_Srobovanie.CMD.RR_SkrutSetK30_Zasobnik_RUN:= FALSE;
				P1_Srobovanie.SkrutSet_K30.Cmd.ManualStartHrniec:= FALSE;
				P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				SC_SkrutkovaciSet_K30.ResetStep:= TRUE;
				SC_SkrutkovaciSet_K30.Step:= 10;
			END_IF	
				
	END_CASE
		

	
	
	
	//***********************************Skrutkovací set M4**************************************//
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_SkrutkovaciSet_M4);
	
	CASE SC_SkrutkovaciSet_M4.Step OF 
	
		0:
			SC_SkrutkovaciSet_M4.StepName:='0 - Nulovanie';
			P1_Srobovanie.SkrutSet_M4.CMD.ENABLE:= FALSE;
			P1_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= FALSE;
			P1_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
			P1_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vstup:= FALSE;
			P1_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vystup:= FALSE;
			P1_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= FALSE;
			P1_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= FALSE;
			P1_Srobovanie.STAV.SkrutkaM4_READY:= FALSE;
			IF SC_P1_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_M4.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P1_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 10;
			ELSIF P1_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_M4.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;
		
			P1_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
		
			IF P1_Srobovanie.CMD.PodajSkrutku_M4 THEN
				P1_Srobovanie.CMD.PodajSkrutku_M4:= FALSE;
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 13;
			END_IF	
			
			
		13:
			SC_SkrutkovaciSet_M4.StepName:='13 - Automaticky rezim - podanie skrutky';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_M4.Switch1 THEN
				P1_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_M4.Switch1:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P1_Srobovanie.STAV.SkrutkaM4_READY:= TRUE;
				P1_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 15;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P1_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;		
			END_IF
			
			
		15:
			SC_SkrutkovaciSet_M4.StepName:='15 - Automaticky rezim - cakam na zrusenie stavu skrutka M4 READY';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;	
		
			IF NOT P1_Srobovanie.STAV.SkrutkaM4_READY THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 10;
			ELSIF P1_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M4.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M4.Step:= 20;
			END_IF
			
			
		20:
			SC_SkrutkovaciSet_M4.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_M4.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M4.AlarmTime.PT:= T#5s;
		
			P1_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
			P1_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;	
			
			//Ovládanie zásobníka//
			IF P1_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN THEN
				P1_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= TRUE;
			ELSE
				P1_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= FALSE;
			END_IF	
			
			
			//Ovládanie vibrolišty//
			IF P1_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN THEN
				P1_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= TRUE;
			ELSE
				P1_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= FALSE;
			END_IF	
			
			
			//Otáèanie podavaèa skrutiek//
			IF P1_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup THEN
				P1_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vstup:= TRUE;
				P1_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup:= FALSE;
			ELSIF P1_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup THEN
				P1_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vystup:= TRUE;
				P1_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup:= FALSE;
			END_IF	
			
			
			
			//Podanie skrutky//
			IF P1_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku THEN
				P1_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku:= FALSE;
				P1_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN:= FALSE;
				P1_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN:= FALSE;
				P1_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
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
			P1_Srobovanie.SkrutSet_M5.CMD.ENABLE:= FALSE;
			P1_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= FALSE;
			P1_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
			P1_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vstup:= FALSE;
			P1_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vystup:= FALSE;
			P1_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= FALSE;
			P1_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= FALSE;
			P1_Srobovanie.STAV.SkrutkaM5_READY:= FALSE;
			IF SC_P1_Srobovanie.Step <> 0 THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 1;
			END_IF	
		
			
		1:
			SC_SkrutkovaciSet_M5.StepName:='1 - Rozhodnutie o cinnosti';
			
			IF P1_Srobovanie.Automat THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			ELSIF P1_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 20;
			END_IF	
			
		10:
			SC_SkrutkovaciSet_M5.StepName:='10 - Automaticky rezim - cakam na signal podaj skrutku';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
		
			P1_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
		
			IF P1_Srobovanie.CMD.PodajSkrutku_M5 THEN
				P1_Srobovanie.CMD.PodajSkrutku_M5:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 13;
			END_IF	
			
			
		13:
			SC_SkrutkovaciSet_M5.StepName:='13 - Automaticky rezim - podanie skrutky';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
			
			IF NOT SC_SkrutkovaciSet_M5.Switch1 THEN
				P1_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
				SC_SkrutkovaciSet_M5.Switch1:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.SkrutSet_M5.STAV.SkrutkaPripravena THEN
				P1_Srobovanie.STAV.SkrutkaM5_READY:= TRUE;
				P1_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 15;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;		
			END_IF
			
			
		15:
			SC_SkrutkovaciSet_M5.StepName:='15 - Automaticky rezim - cakam na zrusenie stavu skrutka M5 READY';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;	
		
			IF NOT P1_Srobovanie.STAV.SkrutkaM5_READY THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			ELSIF P1_Srobovanie.Manual THEN
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 20;
			END_IF
			
			
		20:
			SC_SkrutkovaciSet_M5.StepName:='20 - Manualny rezim';
			SC_SkrutkovaciSet_M5.IdleTime.PT:= T#2s;
			SC_SkrutkovaciSet_M5.AlarmTime.PT:= T#5s;
		
			P1_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
			P1_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;	
			
			//Ovládanie zásobníka//
			IF P1_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN THEN
				P1_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= TRUE;
			ELSE
				P1_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= FALSE;
			END_IF	
			
			
			//Ovládanie vibrolišty//
			IF P1_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN THEN
				P1_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= TRUE;
			ELSE
				P1_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= FALSE;
			END_IF	
			
			
			//Otáèanie podavaèa skrutiek//
			IF P1_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vstup THEN
				P1_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vstup:= TRUE;
				P1_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vstup:= FALSE;
			ELSIF P1_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vystup THEN
				P1_Srobovanie.SkrutSet_M5.CMD.RR_OtocPodavac_Vystup:= TRUE;
				P1_Srobovanie.CMD.RR_SkrutSetM5_OtocPodavac_Vystup:= FALSE;
			END_IF	
			
			
			
			//Podanie skrutky//
			IF P1_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku THEN
				P1_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
				P1_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
				P1_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN:= FALSE;
				P1_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_SkrutkovaciSet_M5.ResetStep:= TRUE;
				SC_SkrutkovaciSet_M5.Step:= 10;
			END_IF
			
			
	END_CASE
	
	
	
		
	
	
	
	
	
END_ACTION
