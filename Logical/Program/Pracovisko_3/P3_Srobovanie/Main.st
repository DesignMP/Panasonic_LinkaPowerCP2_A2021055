
PROGRAM _INIT
	
	//Init parametre serva manipulátora Os Y//
	P3_Srobovanie.ServoManipulOsY.Parameters.Override:= 100;
	P3_Srobovanie.PAR.ManipulOsY_JoggRychlost:= 0.1;	
	
	
	//Init parametre serva zdvihu skrutkovacky M4//
	P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Override:= 100;
	P3_Srobovanie.PAR.ManipulOsZ_M5_JoggRychlost:= 0.1;
	
		 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie podprogramov a knižníc//
	P3_Srobovanie.ServoManipulOsY();
	P3_Srobovanie.ServoManipulOsZ_M5();
		
	
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_Srobovanie);
	
	
	//Enable serv//
	IF Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		P3_Srobovanie.ServoManipulOsY.Command.PowerON:= TRUE;
		P3_Srobovanie.ServoManipulOsZ_M5.Command.PowerON:= TRUE;
	ELSE
		P3_Srobovanie.ServoManipulOsY.Command.PowerON:= FALSE;
		P3_Srobovanie.ServoManipulOsZ_M5.Command.PowerON:= FALSE;
	END_IF	
	
	//Reset poruchy serv//
	IF P3_Srobovanie.ServoManipulOsY.Command.ErrReset AND NOT P3_Srobovanie.ServoManipulOsY.Status.Error THEN
		P3_Srobovanie.ServoManipulOsY.Command.ErrReset:= FALSE;
	END_IF
	
	IF P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset AND NOT P3_Srobovanie.ServoManipulOsZ_M5.Status.Error THEN
		P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= FALSE;
	END_IF
	
	
	
	//Reset poruchy skrutkovacích setov//	
	IF P3_Srobovanie.SkrutSet_M5.CMD.ResetPoruchy AND NOT P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
		P3_Srobovanie.SkrutSet_M5.CMD.ResetPoruchy:= FALSE;
	END_IF	
	

	//Reset sekcie //
	IF P3_Srobovanie.Reset THEN
		SC_P3_Srobovanie.Step:= 0;
		P3_Srobovanie.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_Srobovanie.Step:= 0;
	ELSIF NOT Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
		SC_P3_Srobovanie.Step:= 0;
	END_IF	
	
	
	CASE SC_P3_Srobovanie.Step OF 
		
		0:
			SC_P3_Srobovanie.StepName:='0 - Nulovanie';
			P3_Srobovanie.Automat:= FALSE;
			P3_Srobovanie.KoniecCyklu:= FALSE;
			P3_Srobovanie.Manual:= FALSE;
			P3_Srobovanie.STAV.PoINIT:= FALSE;
			
			P3_Srobovanie.OUT.Skrutkovacka_M5_Odvzdusn_ON:= FALSE;
			IF NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN 
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
			END_IF	
			P3_Srobovanie.OUT.Skrutkovacka_K40_Odvzdusn_ON:= FALSE;
			P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= FALSE;
			P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= FALSE;
					
			P3_Srobovanie.ServoManipulOsY.Command.JogNeg:= FALSE;
			P3_Srobovanie.ServoManipulOsY.Command.JogPos:= FALSE;
			P3_Srobovanie.ServoManipulOsY.Command.MoveAdditive:= FALSE;
			P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
			P3_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= FALSE;
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsY.Command.Stop:= TRUE;
			END_IF	
			P3_Srobovanie.ServoManipulOsZ_M5.Command.JogNeg:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.JogPos:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.MoveAdditive:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= FALSE;
			IF NOT P3_Srobovanie.ServoManipulOsZ_M5.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= TRUE;
			END_IF	
						
			
			P3_Srobovanie.CMD.RR_SkrutkovackuK40_VYSUN:= FALSE;
			P3_Srobovanie.CMD.RR_Manipulator_OsY_VPRED:= FALSE;
			P3_Srobovanie.CMD.RR_Manipulator_OsY_VZAD:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_DOLE:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_HORE:= FALSE;
			
			P3_Srobovanie.CMD.RR_PrisavanieSkrutkyK40_ON:= FALSE;
			P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON:= FALSE;
			P3_Srobovanie.CMD.RR_CistenieSkrutkovackyK40:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN:= FALSE;			
			P3_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
			P3_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
			P3_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora:= 1;
			
			P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= FALSE;
			P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= FALSE;
			P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
			P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
			P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= FALSE;
			
			P3_Srobovanie.Skrutkovacka_M5.RESET_Poruchy:= FALSE;
			P3_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
			P3_Srobovanie.Skrutkovacka_M5.START_Skrutkovania:= FALSE;
			P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;			
			P3_Srobovanie.Skrutkovacka_K40.RESET_Poruchy:= FALSE;
			P3_Srobovanie.Skrutkovacka_K40.RESET_Vysledkov:= FALSE;
			P3_Srobovanie.Skrutkovacka_K40.START_Skrutkovania:= FALSE;
			P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= FALSE;
			
							
			P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= FALSE;
			
			FazaNavratu:= 0;
			CasSrobovania_1:= 0;
			CasSrobovania_2:= 0;
			PocetCisteniSkrutkovacky:= 0;
									
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P3_ZonaBunky_AKTIVNA AND
				NOT P3_Pracovisko.STAV.Porucha_ST1 AND
				NOT P3_Pracovisko.STAV.Porucha_ST2 AND
				NOT P3_Pracovisko.STAV.Porucha_ST3 AND
				NOT P3_Pracovisko.STAV.Porucha_ST4 AND
				NOT P3_Pracovisko.STAV.Porucha_ST5 AND
				NOT P3_Pracovisko.STAV.Porucha_ST6 AND
				NOT P3_Pracovisko.STAV.Porucha_ST7 AND
				NOT P3_Pracovisko.STAV.Porucha_ST8 AND
				P3_Srobovanie.ServoManipulOsY.Status.Ready AND P3_Srobovanie.ServoManipulOsY.Status.StandStill AND
				P3_Srobovanie.ServoManipulOsZ_M5.Status.Ready AND P3_Srobovanie.ServoManipulOsZ_M5.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsY.Command.Stop:= FALSE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 1;
			END_IF
	
		1:
			SC_P3_Srobovanie.StepName:='1 - Cakam na spustenie vyroby';
			P3_Srobovanie.KoniecCyklu:= FALSE;
			IF P3_Srobovanie.Automat THEN
				SC_P3_Srobovanie.Step:= 2;
			ELSIF P3_Srobovanie.Manual THEN
				SC_P3_Srobovanie.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		
		2:
			SC_P3_Srobovanie.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
			P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= TRUE;
						
			P3_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= TRUE;
		
		
			SC_P3_Srobovanie.ResetStep:= TRUE;
			SC_P3_Srobovanie.Step:= 3;
		
			
		3:
			SC_P3_Srobovanie.StepName:='3 - Inicializacia - zasunutie skrutkovacky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 5;
			END_IF	
			
			
		5:
			SC_P3_Srobovanie.StepName:='5 - Inicializacia - presun manipulatora do vychodiskovej pozicie k motoru';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
					
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 0;
		
				
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsY.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 10;
			END_IF		
		
				
			
			
		10:
			SC_P3_Srobovanie.StepName:='10 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 82; //mm
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsY.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 15;
			END_IF	
	
	
		15:
			SC_P3_Srobovanie.StepName:='15 - Inicializacia - vysunutie skrutkovacky K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= TRUE;
				SC_P3_Srobovanie.IdleTime.IN:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_Srobovanie.IdleTime.Q THEN
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= FALSE;
				SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P3_Srobovanie.AlarmTime.Q THEN
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 18;
			END_IF	
		
		
		18:
			SC_P3_Srobovanie.StepName:='18 - Inicializacia - nabitie skrutky do skrutkovacky K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Srobovanie.IN.Skrutkovacka_K40_ZASUNUTA THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P3_Srobovanie.SkrutSet_K40.Status.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 25;
			ELSIF P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				P34_Alarmy[328]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
	
	
		
		25:
			SC_P3_Srobovanie.StepName:='25 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 163; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 28;
			END_IF	
			
		
			
		28:
			SC_P3_Srobovanie.StepName:='28 - Inicializacia - vysuvam skrutkovac M5 a vypinam prisavanie skrutky,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			END_IF	
				
			IF SC_P3_Srobovanie.IdleTime.Q AND P3_Srobovanie.SkrutSet_M5.STAV.SkrutkaPripravena AND NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 30;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				P34_Alarmy[327]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF
			
	
		30:
			SC_P3_Srobovanie.StepName:='30 - Inicializacia - zasuvam skrutkovac M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 40;
			END_IF	
		
		
		40:
			SC_P3_Srobovanie.StepName:='40 - Inicializacia - presun manipulatora do vychodiskovej pozicie k motoru';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 0;
		
				
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 42;
			END_IF	
			
		
		42:
			SC_P3_Srobovanie.StepName:='42 - Inicializacia - cakam na zrusenie stavu serva v pozicii';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
		
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.STAV.PoINIT:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 100;
			END_IF	
		
		
			//********************************************************Automatický režim****************************************************************************//
		100:  
			SC_P3_Srobovanie.StepName:='100 - Automaticky Rezim - cakam na spustenie cinnosti';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;			
	
			IF P3_Srobovanie.KoniecCyklu AND NOT P3_StoperSrobovania.Automat THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 0;
			ELSIF P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 110;
			ELSIF P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 200;
			ELSIF P3_Srobovanie.COM_IN.PresunManipulatora_VPRED THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 400;
			ELSIF P3_Srobovanie.COM_IN.PresunManipulatora_VZAD THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 420;	
			END_IF	
		
		
			//**********************************************************************Model 45F*******************************************************************************************//	
			//Zaskrutkovanie skrutky K40 a M5//	
		
		110:
			SC_P3_Srobovanie.StepName:='110 - Automaticky Rezim - model 45F, napolohovanie skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 700;
				ELSE
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 112;
				END_IF	
			END_IF	
		
	
		112:
			SC_P3_Srobovanie.StepName:='112 - Automaticky Rezim - model 45F, kontrola skrutky M5 na vystupe podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P3_Srobovanie.SkrutSet_M5.STAV.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 113;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				P34_Alarmy[327]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;		
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 135;
			ELSE
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
			END_IF	
			
					
			
		113:
			SC_P3_Srobovanie.StepName:='113 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_Srob_Rychl_OdobratSkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P34_RemPremenne.P3_Srob_Mom_OdobratSkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InTorque AND P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition > 10 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 115;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P34_Alarmy[327]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 115;
			END_IF
		
			
		115:
			SC_P3_Srobovanie.StepName:='115 - Automaticky Rezim - model 45F,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 135;
				ELSE	
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 116;
				END_IF	
			END_IF	
		
			
		116:
			SC_P3_Srobovanie.StepName:='116 - Automaticky Rezim - model 45F,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
				SC_P3_Srobovanie.IdleTime.IN:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
						
			IF SC_P3_Srobovanie.IdleTime.Q THEN	
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 120;
			END_IF
			
			
			
		120:
			SC_P3_Srobovanie.StepName:='120 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania skrutky K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost; // m/s
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob45F_PozY_Skrutkovania; //mm
			
			
			
			IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 135;
			ELSIF P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 700;
				ELSE	
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 121;
				END_IF	
			END_IF	
		
		
		121:
			SC_P3_Srobovanie.StepName:='121 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania skrutkovaciek';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.Skrutkovacka_K40.RESET_Vysledkov:= TRUE;
				P3_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P3_Srobovanie.Skrutkovacka_K40.Stav_VysledokUtahovania_NG AND
				NOT P3_Srobovanie.Skrutkovacka_K40.Stav_VysledokUtahovania_OK AND
				NOT P3_Srobovanie.Skrutkovacka_K40.Stav_UtahovanieUkoncene AND
				NOT P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND
				NOT P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND
				NOT P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P3_Srobovanie.Skrutkovacka_K40.RESET_Vysledkov:= FALSE;
				P3_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 123;
			END_IF	
		
		
		123:
			SC_P3_Srobovanie.StepName:='123 - Automaticky Rezim - model 45F, kontrola skrutky K40 v skrutkovacke';
			SC_P3_Srobovanie.IdleTime.PT:= T#5s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
            
			IF P3_Srobovanie.SkrutSet_K40.Status.SkrutkaPripravena AND P3_Srobovanie.Skrutkovacka_K40.Stav_READY_to_START THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 125;
			ELSIF P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P34_Alarmy[328]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 135; 
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				IF NOT P3_Srobovanie.Skrutkovacka_K40.Stav_READY_to_START THEN
					P34_Alarmy[344]:= TRUE;
					P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 135; 
				ELSIF NOT P3_Srobovanie.SkrutSet_K40.Status.SkrutkaPripravena THEN
					FazaNavratu:= 120;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 600;
				END_IF	
			END_IF	
			
			
		125:
			SC_P3_Srobovanie.StepName:='125 - Automaticky Rezim - model 45F, kontrola skrutky M5 v skrutkovacke';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 127;
			ELSE
				IF PocetCisteniSkrutkovacky < 3 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 110;
				ELSE
					P34_Alarmy[327]:= TRUE;
					P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 135;
				END_IF	
			END_IF	
			
			
		
		127:
			SC_P3_Srobovanie.StepName:='127 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M5 a K40 a spustenie skrutkovania';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			
			SC_P3_Srobovanie.AlarmTime.IN:= P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN AND (P3_Srobovanie.PAR.Skrutkov_K40_AktualHodnVysunutia < 1);
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_Srob45F_Rychl_SkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P34_RemPremenne.P3_Srob45F_Mom_SkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= TRUE;
				P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InTorque AND P3_Srobovanie.PAR.Skrutkov_K40_AktualHodnVysunutia > 2  THEN
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				SkrutkovanieK40_Ukoncene:= FALSE;
				SkrutkovanieM5_Ukoncene:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 129;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				P34_Alarmy[342]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 130;	
			END_IF	
		
		
		129:
			SC_P3_Srobovanie.StepName:='129 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#30s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF EDGEPOS(P3_Srobovanie.Skrutkovacka_K40.Stav_UtahovanieUkoncene) THEN
				P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= FALSE;
				CasSrobovania_1:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40:= UINT_TO_STRING(P3_Srobovanie.PAR.Skrutkov_K40_AktualHodnVysunutia);
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaK40:= REAL_TO_STRING(CasSrobovania_1/1000);
				SkrutkovanieK40_Ukoncene:= TRUE;
			END_IF
			IF EDGEPOS(P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene) THEN
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				CasSrobovania_2:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition);
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(CasSrobovania_2/1000);
				SkrutkovanieM5_Ukoncene:= TRUE;
			END_IF    
            
			IF SkrutkovanieK40_Ukoncene AND SkrutkovanieM5_Ukoncene THEN
				SkrutkovanieK40_Ukoncene:= FALSE;
				SkrutkovanieM5_Ukoncene:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 130;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				IF NOT P3_Srobovanie.Skrutkovacka_K40.Stav_UtahovanieUkoncene THEN
					P34_Alarmy[346]:= TRUE;
				END_IF
				IF NOT P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
					P34_Alarmy[347]:= TRUE;
				END_IF
				P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= FALSE;
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 130;	
			END_IF            
			
		
		
		130:
			SC_P3_Srobovanie.StepName:='130 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M5 a K40 a vypnutie prisavania skrutky';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P3_Srobovanie.IN.Skrutkovacka_K40_ZASUNUTA THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 135;
				ELSE
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 132;
				END_IF	
			END_IF	
		
		
		132:
			SC_P3_Srobovanie.StepName:='132 - Automaticky Rezim - model 45F, signal podaj skrutku K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= TRUE;
				SC_P3_Srobovanie.IdleTime.IN:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_Srobovanie.IdleTime.Q THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 135;
			END_IF
		
		
		135:
			SC_P3_Srobovanie.StepName:='135 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania skrutky K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 138;
			ELSIF P3_Srobovanie.Skrutkovacka_K40.Stav_VysledokUtahovania_OK AND P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 138;
			ELSIF P3_Srobovanie.Skrutkovacka_K40.Stav_VysledokUtahovania_NG OR P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 138;          
			END_IF	
		
		
		
		
		138:
			SC_P3_Srobovanie.StepName:='138 - Automaticky Rezim - model 45F, cakam na zrusenie signalu zaskrutkuj skrutku K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.COM_IN.Model45F_ZaskrutkujSkrutky THEN
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 100;
			END_IF	
		
		
			//*******************************************Model 5H zašrobuj skrutku**************************************************//      
			//Skrutkovanie skrutky M5//      
       
		200:
			SC_P3_Srobovanie.StepName:='200 - Automaticky Rezim - model 5H, napolohovanie skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 202;
			END_IF	
		
		
	
		202:
			SC_P3_Srobovanie.StepName:='202 - Automaticky Rezim - model 5H, kontrola skrutky M5 na vystupe podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P3_Srobovanie.SkrutSet_M5.STAV.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 203;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				P34_Alarmy[327]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;		
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 216;
			ELSE
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
			END_IF	
			
					
			
		203:
			SC_P3_Srobovanie.StepName:='203 - Automaticky Rezim - model 5H,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_Srob_Rychl_OdobratSkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P34_RemPremenne.P3_Srob_Mom_OdobratSkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InTorque AND P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition > 10 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 205;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P34_Alarmy[327]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 216;
			END_IF
		
			
		205:
			SC_P3_Srobovanie.StepName:='205 - Automaticky Rezim - model 5H,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 216; 
				ELSE	
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 206;
				END_IF	
			END_IF	
		
			
		206:
			SC_P3_Srobovanie.StepName:='206 - Automaticky Rezim - model 5H,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
				SC_P3_Srobovanie.IdleTime.IN:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
						
			IF SC_P3_Srobovanie.IdleTime.Q THEN	
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 210;
			END_IF
			
			
			
		210:
			SC_P3_Srobovanie.StepName:='210 - Automaticky Rezim - model 5H, napolohovanie na poziciu skrutkovania skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost; // m/s
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob5H_PozY_Skrutkovania; //mm
			
			
			
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 700;
				ELSE	
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 211;
				END_IF	
			END_IF	
		
		
		211:
			SC_P3_Srobovanie.StepName:='211 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND NOT P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND NOT P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P3_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 212;
			END_IF	
		
		
		212:
			SC_P3_Srobovanie.StepName:='212 - Automaticky Rezim - model 5H, kontrola skrutky M5 v skrutkovacke';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 213;
			ELSE
				IF PocetCisteniSkrutkovacky < 3 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 200;
				ELSE
					P34_Alarmy[327]:= TRUE;
					P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 216;
				END_IF	
			END_IF	
		
		
		213:
			SC_P3_Srobovanie.StepName:='213 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5 a spustenie skrutkovania';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_Srob5H_Rychl_SkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P34_RemPremenne.P3_Srob5H_Mom_SkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InTorque) THEN
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 214;
			END_IF	
			
		
				
		214:
			SC_P3_Srobovanie.StepName:='214 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#30s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				CasSrobovania_1:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(CasSrobovania_1/1000);
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 215;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN    
				P34_Alarmy[347]:= TRUE;
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 215;
			END_IF
			
		
				
		215:
			SC_P3_Srobovanie.StepName:='215 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 216;
			END_IF	
		
			
				
		216:
			SC_P3_Srobovanie.StepName:='216 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania strednej skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 218; 
			ELSIF P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 218;
			ELSIF P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P3_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 218;          
			END_IF
		
		
		218:
			SC_P3_Srobovanie.StepName:='218 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj skrutku M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.COM_IN.Model5H_ZaskrutkujSkrutky THEN
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 100;
			END_IF
		
		
		
		
		//******************************Presun manipulátora do pozície VPRED*******************************//	
		
		400:
			SC_P3_Srobovanie.StepName:='400 - Automaticky Rezim - napolohovanie manipulatora na prednu poziciu ';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
									
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost; // m/s
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 320; //mm
				
		
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 402;
			END_IF	
				
		
		402:
			SC_P3_Srobovanie.StepName:='402 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora vpred';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.COM_IN.PresunManipulatora_VPRED THEN
				P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 100;
			END_IF	
		
			//******************************Presun manipulátora do pozície VZAD*********************************//	
		
		420:
			SC_P3_Srobovanie.StepName:='420 - Automaticky Rezim - napolohovanie manipulatora na zadnu poziciu ';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
								
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost; // m/s
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 0; //mm
				
		
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 422;
			END_IF	
				
		
		422:
			SC_P3_Srobovanie.StepName:='422 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora vzad';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.COM_IN.PresunManipulatora_VZAD THEN
				P3_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 100;
			END_IF	
		
		
		
		//*********************************************************Èistenie skrutkovaèiek*****************************************************************************//			
			
		//Èistenie skrutkovaèky K40//
		500:
			SC_P3_Srobovanie.StepName:='500 - Automaticky Rezim - cistenie skrutkovacky K40,kontrola zrusenia stavu serva v pozicii';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 501;
			END_IF	
			
		501:
			SC_P3_Srobovanie.StepName:='501 - Automaticky Rezim - cistenie skrutkovacky K40,presun na poziciu zahodenia skrutky';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
          			
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 82; //mm
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 502;
			END_IF	
			
		502:
			SC_P3_Srobovanie.StepName:='502 - Automaticky Rezim - cistenie skrutkovacky K40,vysunutie skrutkovacky K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= TRUE;
				SC_P3_Srobovanie.IdleTime.IN:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P3_Srobovanie.IdleTime.Q THEN
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= FALSE;
				SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P3_Srobovanie.AlarmTime.Q THEN
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 505;
			END_IF	
		
		505:
			SC_P3_Srobovanie.StepName:='505 - Automaticky Rezim - cistenie skrutkovacky K40,nabitie skrutky do skrutkovacky K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Srobovanie.IN.Skrutkovacka_K40_ZASUNUTA THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P3_Srobovanie.SkrutSet_K40.Status.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				PocetCisteniSkrutkovacky:= 0;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= FazaNavratu;
			ELSIF P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
				IF PocetCisteniSkrutkovacky > 3 THEN
					P34_Alarmy[328]:= TRUE;
					P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= FazaNavratu;
				ELSE
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 508;
				END_IF	
			END_IF	
		
		
		508:
			SC_P3_Srobovanie.StepName:='508 - Automaticky Rezim - cistenie skrutkovacky K40,resetovanie skrutkovacieho setu K40';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
		
			P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
		
			IF P3_Srobovanie.KoniecCyklu THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 0;
			ELSIF NOT P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= TRUE;
				PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 502;
			END_IF	
		
		
				
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P3_Srobovanie.StepName:='700 - Manualny Rezim';
			SC_P3_Srobovanie.IdleTime.PT:= T#8s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
			//Parametre serv pre jogging//
			P3_Srobovanie.ServoManipulOsY.Parameters.Jog.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Jog.Velocity:= P3_Srobovanie.PAR.ManipulOsY_JoggRychlost;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Jog.Acc:= 0.1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Jog.Velocity:= P3_Srobovanie.PAR.ManipulOsZ_M5_JoggRychlost;
			P3_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= TRUE;
			
	
			//Ovládanie vysunutia skrutkovaèky M5//
			IF P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_DOLE AND P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition < 100 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.JogNeg:= FALSE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.JogPos:= TRUE;
			ELSIF P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_HORE AND P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition > 5 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.JogPos:= FALSE;	
				P3_Srobovanie.ServoManipulOsZ_M5.Command.JogNeg:= TRUE;
			ELSE
				P3_Srobovanie.ServoManipulOsZ_M5.Command.JogNeg:= FALSE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.JogPos:= FALSE;
			END_IF	
				
            
					
			       
			//Ovládanie vysunutia skrutkovaèky K40//
			P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= P3_Srobovanie.CMD.RR_SkrutkovackuK40_VYSUN;
		
		   
        
				
			//Prisávanie skrutky M5//
			IF P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON THEN
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
			ELSE
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
			END_IF    
			
			
			//***************Skrutkovací set K40*********************//
			//Ovládanie zásobníka//
			IF P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			//Podanie skrutky//
			IF P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku THEN
				P3_Srobovanie.CMD.RR_SkrutSetK40_Zasobnik_RUN:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.ManualStartHrniec:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= TRUE;
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= TRUE;
				P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku:= FALSE;
			END_IF	
				
			IF P3_Srobovanie.SkrutSet_K40.Status.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_K40.Cmd.AutomatStart:= FALSE;
				P3_Srobovanie.SkrutSet_K40.Cmd.PodajSkrutku:= FALSE;
			END_IF	
			
					
			
			//*******************Skrutkovací set M5**************************//
			//Ovládanie zásobníka//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN THEN
				P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= TRUE;
			ELSE
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniZasobnik:= FALSE;
			END_IF	
			
			
			
			
			//Ovládanie vibrolišty//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN THEN
				P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= TRUE;
			ELSE
				P3_Srobovanie.SkrutSet_M5.CMD.RR_ZapniVibrolistu:= FALSE;
			END_IF	
			
			
			//Podanie skrutky//
			IF P3_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku THEN
				P3_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
				P3_Srobovanie.CMD.RR_SkrutSetM5_Vibrolista_RUN:= FALSE;
				P3_Srobovanie.SkrutSet_M5.CMD.ENABLE:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.RucnyRezim:= TRUE;
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= TRUE;
				P3_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
			END_IF
			
			IF P3_Srobovanie.SkrutSet_M5.STAV.SkrutkaPripravena THEN
				P3_Srobovanie.SkrutSet_M5.CMD.PodajSkrutku:= FALSE;
			END_IF	
			
			
		
			
			
        
			//**********************Polohovanie na pozície skrutiek*****************************//
			IF P3_Srobovanie.CMD.RR_PolohujManipulator THEN 
				IF P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
					IF P3_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 0 THEN  //Skrutkovanie K40 a M5 - 45F
						P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P3_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P3_Srobovanie.ResetStep:= TRUE;
						SC_P3_Srobovanie.Step:= 120;
					ELSIF P3_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 1 THEN  //Skrutkovanie M5 - 5H
						P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P3_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P3_Srobovanie.ResetStep:= TRUE;
						SC_P3_Srobovanie.Step:= 210;    
					ELSIF P3_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 2 THEN  //Pozicia odobratia skrutky M5
						P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P3_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P3_Srobovanie.ResetStep:= TRUE;
						SC_P3_Srobovanie.Step:= 110;
					END_IF	
				END_IF	
				P3_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			END_IF		
		
		
		
		
		
		
		
		
		
	
	END_CASE
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

