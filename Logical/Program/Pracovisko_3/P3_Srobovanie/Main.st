
PROGRAM _INIT
	
	//Init parametre serva manipulátora Os Y//
	P3_Srobovanie.ServoManipulOsY.Parameters.Override:= 100;
	P3_Srobovanie.PAR.ManipulOsY_JoggRychlost:= 5;	
	P3_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
	P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
	
	//Init parametre serva zdvihu skrutkovacky M4//
	P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Override:= 100;
	P3_Srobovanie.PAR.ManipulOsZ_M5_JoggRychlost:= 5;
	P3_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= TRUE;
	P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
	
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie podprogramov a knižníc//
	AtlasCopcoKomunikacia;	
	OvlSkrutkovacichSetov;
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P3_Srobovanie);
	
	
	//Enable serv//
	IF Safety.STAV.P3_ZonaBunky_AKTIVNA AND NOT P3_Srobovanie.ServoManipulOsY.Command.ErrReset THEN
		P3_Srobovanie.ServoManipulOsY.Command.PowerON:= TRUE;
	ELSE
		P3_Srobovanie.ServoManipulOsY.Command.PowerON:= FALSE;
	END_IF	
	
	IF Safety.STAV.P3_ZonaBunky_AKTIVNA AND NOT P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset THEN
		P3_Srobovanie.ServoManipulOsZ_M5.Command.PowerON:= TRUE;
	ELSE
		P3_Srobovanie.ServoManipulOsZ_M5.Command.PowerON:= FALSE;
	END_IF	
	
	

	
	
	//Reset poruchy serv//
	IF EDGEPOS(Safety.STAV.P3_ZonaBunky_AKTIVNA)THEN
		P3_Srobovanie.ServoManipulOsY.Command.ErrReset:= TRUE;
		P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= TRUE;
	END_IF	
	
	CasResetServo_1.IN:= P3_Srobovanie.ServoManipulOsY.Command.ErrReset;
	IF CasResetServo_1.Q AND NOT P3_Srobovanie.ServoManipulOsY.Status.Error THEN
		P3_Srobovanie.ServoManipulOsY.Command.ErrReset:= FALSE;
	END_IF
	
	CasResetServo_2.IN:= P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset;
	IF CasResetServo_2.Q AND NOT P3_Srobovanie.ServoManipulOsZ_M5.Status.Error THEN
		P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= FALSE;
	END_IF
	
	
	CasResetServo_1.PT:= T#500ms;
	CasResetServo_1();
	
	CasResetServo_2.PT:= T#500ms;
	CasResetServo_2();
	
	
	
	//Reset poruchy skrutkovacích setov//	
	IF P3_Srobovanie.SkrutSet_M5.CMD.ResetPoruchy AND NOT P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
		P3_Srobovanie.SkrutSet_M5.CMD.ResetPoruchy:= FALSE;
	END_IF	
	

	//Reset sekcie //
	IF P3_Srobovanie.Reset THEN
		SC_P3_Srobovanie.Step:= 0;
		P3_Srobovanie.ServoManipulOsY.Command.ErrReset:= TRUE;
		P3_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= TRUE;
		P3_Srobovanie.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P3_Srobovanie.Step:= 0;
	END_IF	
	
	
	CASE SC_P3_Srobovanie.Step OF 
		
		0:
			SC_P3_Srobovanie.StepName:='0 - Nulovanie';
			P3_Srobovanie.Automat:= FALSE;
			P3_Srobovanie.KoniecCyklu:= FALSE;
			P3_Srobovanie.Manual:= FALSE;
			P3_Srobovanie.STAV.PoINIT:= FALSE;
			
			SC_SkrutkovaciSet_K40.Step:= 0;
			SC_SkrutkovaciSet_M5.Step:= 0;
			
			
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
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsY.Command.Stop:= TRUE;
			END_IF	
			P3_Srobovanie.ServoManipulOsZ_M5.Command.JogNeg:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.JogPos:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.MoveAdditive:= FALSE;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
			IF NOT P3_Srobovanie.ServoManipulOsZ_M5.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= TRUE;
			END_IF	
						
			
			
			P3_Srobovanie.CMD.RR_Manipulator_OsY_VPRED:= FALSE;
			P3_Srobovanie.CMD.RR_Manipulator_OsY_VZAD:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_DOLE:= FALSE;
			P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_HORE:= FALSE;
			
			
			P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON:= FALSE;
			P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_OFF:= FALSE;
			P3_Srobovanie.CMD.RR_CistenieSkrutkovackyK40:= FALSE;
			P3_Srobovanie.CMD.PodajSkrutku_K40:= FALSE;
			P3_Srobovanie.CMD.PodajSkrutku_M5:= FALSE;
			
			P3_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			P3_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
			P3_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora:= 1;
			P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY:= FALSE;
		
			
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
				P3_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P3_Pracovisko.STAV.Porucha_ST1 AND
				NOT P3_Pracovisko.STAV.Porucha_ST2 AND
				NOT P3_Pracovisko.STAV.Porucha_ST3 AND
				NOT P3_Pracovisko.STAV.Porucha_ST4 AND
				NOT P3_Pracovisko.STAV.Porucha_ST5 AND
				NOT P3_Pracovisko.STAV.Porucha_ST6 AND
				NOT P3_Pracovisko.STAV.Porucha_ST7 AND
				NOT P3_Pracovisko.STAV.Porucha_ST8 AND
				(P3_Srobovanie.ServoManipulOsY.Status.Ready AND P3_Srobovanie.ServoManipulOsY.Status.StandStill) AND
				(P3_Srobovanie.ServoManipulOsZ_M5.Status.Ready AND P3_Srobovanie.ServoManipulOsZ_M5.Status.StandStill) THEN
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
			
						
						
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Acc;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Dcc;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= P34_RemPremenne.P3_ManipSrob_OsY_Acc;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= P34_RemPremenne.P3_ManipSrob_OsY_Dcc;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
		
			SC_P3_Srobovanie.ResetStep:= TRUE;
			SC_P3_Srobovanie.Step:= 3;
		
			
		3:
			SC_P3_Srobovanie.StepName:='3 - Inicializacia - zasunutie skrutkovacky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
			
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
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
					
			
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
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
			
            			
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 55; //mm
			
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
			SC_P3_Srobovanie.IdleTime.PT:= T#1s;
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
				P3_Srobovanie.STAV.SkrutkaK40_READY:= FALSE;
				P3_Srobovanie.CMD.PodajSkrutku_K40:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P3_Srobovanie.STAV.SkrutkaK40_READY THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 25;
			ELSIF P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P34_Alarmy[328]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
	
	
		
		25:
			SC_P3_Srobovanie.StepName:='25 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 155; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsY.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 26;
			END_IF	
			
		
			
			
			
		26:
			SC_P3_Srobovanie.StepName:='26 - Inicializacia - vysuvam skrutkovac M5 a vypinam prisavanie skrutky,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#1s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 106;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 28;
			END_IF	
				
					
			
		28:
			SC_P3_Srobovanie.StepName:='28 - Inicializacia - otretie skrutkovacky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 168; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition AND NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 29;
			END_IF	
				
			
		29:
			SC_P3_Srobovanie.StepName:='29 - Inicializacia - cakam na zrusenie signalu polohovanie ukoncene';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 30;
			END_IF	
	
		30:
			SC_P3_Srobovanie.StepName:='30 - Inicializacia - zasuvam skrutkovac M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe AND NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 40;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P34_Alarmy[327]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF	
		
		
		40:
			SC_P3_Srobovanie.StepName:='40 - Automaticky Rezim - Inicializacia, napolohovanie skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
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
	
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Acc;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Dcc;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= P34_RemPremenne.P3_ManipSrob_OsY_Acc;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= P34_RemPremenne.P3_ManipSrob_OsY_Dcc;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			
			
			
			
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
			
						
			IF NOT P3_Srobovanie.Manual THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			END_IF
			
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
			
			IF P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 114;
			ELSE
				P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 113;
			END_IF	
		
			
		113:
			SC_P3_Srobovanie.StepName:='113 - Automaticky Rezim - model 45F, cakam na podanie skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 112;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN	
				P34_Alarmy[327]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
			
			
			
		114:
			SC_P3_Srobovanie.StepName:='114 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= P34_RemPremenne.P3_Srob_PozZ_OdobratSkrutkyM5;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
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
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
				ELSE	
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 116;
				END_IF	
			END_IF	
		
			
		116:
			SC_P3_Srobovanie.StepName:='116 - Automaticky Rezim - model 45F,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
			SC_P3_Srobovanie.ResetStep:= TRUE;
			SC_P3_Srobovanie.Step:= 120;
	
			
			
			
		120:
			SC_P3_Srobovanie.StepName:='120 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania skrutky K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.Manual THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			END_IF
			
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
			SC_P3_Srobovanie.StepName:='123 - Automaticky Rezim - model 45F, kontrola skrutkovacky a skrutky K40 v skrutkovacke';
			SC_P3_Srobovanie.IdleTime.PT:= T#10s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
            
			IF P3_Srobovanie.STAV.SkrutkaK40_READY AND P3_Srobovanie.Skrutkovacka_K40.Stav_READY_to_START THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 125;
			ELSIF NOT P3_Srobovanie.Skrutkovacka_K40.Stav_READY_to_START THEN
				P34_Alarmy[344]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			ELSIF NOT P3_Srobovanie.STAV.SkrutkaK40_READY AND SC_P3_Srobovanie.IdleTime.Q THEN
				IF PocetCisteniSkrutkovacky < 5 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 120;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 600;
				ELSE
					P34_Alarmy[328]:= TRUE;
					P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
				END_IF	
			END_IF	
			
			
		125:
			SC_P3_Srobovanie.StepName:='125 - Automaticky Rezim - model 45F, kontrola skrutky M5 v skrutkovacke';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 126;
			ELSE
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 110;
			END_IF	
		
			
			
		126:
			SC_P3_Srobovanie.StepName:='126 - Automaticky Rezim - model 45F, vysunutie skrutkovacky K40 a M5 na poziciu pred skrutkovanim';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;	
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 80;
			
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= TRUE;
				P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= TRUE;
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				P3_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 127;
			END_IF
			
			
			
			
			
		
		127:
			SC_P3_Srobovanie.StepName:='127 - Automaticky Rezim - model 45F, prepnutie vysunutie skrutkovacky M5 na momentovy pohyb';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			
			SC_P3_Srobovanie.AlarmTime.IN:= P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN AND (P3_Srobovanie.PAR.Skrutkov_K40_RoundHodnotaREAL < 5);
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_Srob45F_Rychl_SkrutkyM5/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P34_RemPremenne.P3_Srob45F_Mom_SkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF P3_Srobovanie.PAR.Skrutkov_K40_RoundHodnotaREAL > 5  THEN
				SkrutkovanieK40_Ukoncene:= FALSE;
				SkrutkovanieM5_Ukoncene:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 129;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				P34_Alarmy[342]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 0;	
			END_IF	
		
			
		
		
		129:
			SC_P3_Srobovanie.StepName:='129 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#30s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF EDGEPOS(P3_Srobovanie.Skrutkovacka_K40.Stav_UtahovanieUkoncene) THEN
				P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= FALSE;
				CasSrobovania_1:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.PAR.Skrutkov_K40_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaK40:= REAL_TO_STRING(CasSrobovania_1/1000);
				SkrutkovanieK40_Ukoncene:= TRUE;
			END_IF
			IF EDGEPOS(P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene) THEN
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
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
				CasSrobovania_1:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaK40:= REAL_TO_STRING(P3_Srobovanie.PAR.Skrutkov_K40_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaK40:= REAL_TO_STRING(CasSrobovania_1/1000);
				CasSrobovania_2:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition);
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(CasSrobovania_2/1000);
				IF NOT P3_Srobovanie.Skrutkovacka_K40.Stav_UtahovanieUkoncene THEN
					P34_Alarmy[346]:= TRUE;
				END_IF
				IF NOT P3_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
					P34_Alarmy[347]:= TRUE;
				END_IF
				P3_Srobovanie.Skrutkovacka_K40.START_Utahovania:= FALSE;
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 130;	
			END_IF            
			
		
		
		130:
			SC_P3_Srobovanie.StepName:='130 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M5 a K40 a vypnutie prisavania skrutky';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 AND SC_P3_Srobovanie.IdleTime.Q THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacku_K40_VYSUN:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_K40_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P3_Srobovanie.IN.Skrutkovacka_K40_ZASUNUTA THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.STAV.SkrutkaK40_READY:= FALSE;
				P3_Srobovanie.CMD.PodajSkrutku_K40:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 135;
			END_IF	
		
		
			
		
		135:
			SC_P3_Srobovanie.StepName:='135 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania skrutky K40 a M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaK40:= 'NG';
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'NG';
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 136;
			ELSIF P3_Srobovanie.Skrutkovacka_K40.Stav_VysledokUtahovania_OK AND P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaK40:= 'OK';
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'OK';
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 136;
			ELSE
				IF P3_Srobovanie.Skrutkovacka_K40.Stav_VysledokUtahovania_NG THEN
					P3_Srobovanie.STAV.Vysledok_SrobovaniaK40:= 'NG';
				ELSE
					P3_Srobovanie.STAV.Vysledok_SrobovaniaK40:= 'OK';
				END_IF	
				IF P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
					P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'NG';
				ELSE
					P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'OK';
				END_IF	
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 136;          
			END_IF	
		
		
			
		136:
			SC_P3_Srobovanie.StepName:='136 - Automaticky Rezim - model 45F, napolohovanie skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
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
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
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
			
			IF P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 204;
			ELSE
				P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 203;
			END_IF	
			
		
		203:
			SC_P3_Srobovanie.StepName:='203 - Automaticky Rezim - model 5H, cakam na podanie skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 202;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN	
				P34_Alarmy[327]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			END_IF	
			
			
			
			
			
		204:
			SC_P3_Srobovanie.StepName:='204 - Automaticky Rezim - model 5H,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= P34_RemPremenne.P3_Srob_PozZ_OdobratSkrutkyM5;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P3_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 205;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P34_Alarmy[327]:= TRUE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 205;
			END_IF
		
			
		205:
			SC_P3_Srobovanie.StepName:='205 - Automaticky Rezim - model 5H,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
				ELSE	
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 206;
				END_IF	
			END_IF	
		
			
		206:
			SC_P3_Srobovanie.StepName:='206 - Automaticky Rezim - model 5H,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
			SC_P3_Srobovanie.ResetStep:= TRUE;
			SC_P3_Srobovanie.Step:= 210;
		
			
			
			
		210:
			SC_P3_Srobovanie.StepName:='210 - Automaticky Rezim - model 5H, napolohovanie na poziciu skrutkovania skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			
			IF NOT P3_Srobovanie.Manual THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			END_IF
			
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
			SC_P3_Srobovanie.StepName:='212 - Automaticky Rezim - model 5H, kontrola skrutkovacky a skrutky M5 v skrutkovacke';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK AND P3_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 213;
			ELSIF NOT P3_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				P34_Alarmy[345]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;
			ELSIF NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 200;
			END_IF	
		
			
		213:
			SC_P3_Srobovanie.StepName:='213 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;	
			
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 80;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				P3_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 214;
			END_IF
			
			
			
			
		
		214:
			SC_P3_Srobovanie.StepName:='214 - Automaticky Rezim - model 5H, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P3_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_Srob5H_Rychl_SkrutkyM5/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P34_RemPremenne.P3_Srob5H_Mom_SkrutkyM5;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InTorque) THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 215;
			END_IF	
			
			
			
			
				
		215:
			SC_P3_Srobovanie.StepName:='215 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
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
				SC_P3_Srobovanie.Step:= 216;
			ELSIF SC_P3_Srobovanie.AlarmTime.Q THEN    
				P34_Alarmy[347]:= TRUE;
				CasSrobovania_1:= TIME_TO_REAL(SC_P3_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(P3_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P3_SkrutkaM5:= REAL_TO_STRING(CasSrobovania_1/1000);
				P3_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 216;
			END_IF
			
		
				
		216:
			SC_P3_Srobovanie.StepName:='216 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			SC_P3_Srobovanie.IdleTime.IN:= TRUE;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 AND SC_P3_Srobovanie.IdleTime.Q THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 217;
			END_IF	
		
			
				
		217:
			SC_P3_Srobovanie.StepName:='217 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania strednej skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P3_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'NG';
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 218; 
			ELSIF P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'OK';
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 218;
			ELSIF P3_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P3_Srobovanie.STAV.Vysledok_SrobovaniaM5:= 'NG';
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 218;          
			END_IF
		
			
		218:	
			SC_P3_Srobovanie.StepName:='218 - Automaticky Rezim - model 5H, napolohovanie skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P3_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= P34_RemPremenne.P3_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P3_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 220;
			END_IF	
			
			
			
			
			
			
			
		
		220:
			SC_P3_Srobovanie.StepName:='220 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj skrutku M5';
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
			
									
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000; // m/s
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 280; //mm
				
		
			
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
								
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000; // m/s
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
		
			P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY:= TRUE;
			P3_Srobovanie.STAV.SkrutkaK40_READY:= FALSE;
			
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 501;
			END_IF	
			
		501:
			SC_P3_Srobovanie.StepName:='501 - Automaticky Rezim - cistenie skrutkovacky K40,presun na poziciu zahodenia skrutky';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.Manual THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			END_IF
          			
			
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 55; //mm
			
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
			SC_P3_Srobovanie.IdleTime.PT:= T#1s;
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
				IF P3_Srobovanie.Manual THEN
					P3_Srobovanie.CMD.RR_SkrutSetK40_PodajSkrutku:= TRUE;
				ELSE	
					P3_Srobovanie.CMD.PodajSkrutku_K40:= TRUE;
				END_IF	
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P3_Srobovanie.STAV.SkrutkaK40_READY THEN
				P3_Srobovanie.STAV.CistenieSkrutkovackyK40_BUSY:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= FazaNavratu;
			ELSIF P3_Srobovanie.SkrutSet_K40.Error.ErrorBit THEN
				P34_Alarmy[328]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF	
		
			
		
			
			//Èistenie skrutkovaèky M5//
		520:
			SC_P3_Srobovanie.StepName:='520 - Automaticky Rezim - cistenie skrutkovacky M5,kontrola zrusenia stavu serva v pozicii';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 521;
			END_IF	
		
		521:	
			SC_P3_Srobovanie.StepName:='521 - Automaticky Rezim - cistenie skrutkovacky M5,presun manipulatora na poziciu zahodenia skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P3_Srobovanie.Manual THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			END_IF			
			
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 155; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 523;
			END_IF	
			
		
			
			
			
		523:
			SC_P3_Srobovanie.StepName:='523 - Automaticky Rezim - cistenie skrutkovacky M5,vysuvam skrutkovac M5 a vypinam prisavanie skrutky,priprava skrutky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#1s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
					
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 106;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P3_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF EDGEPOS(P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 525;
			END_IF	
				
					
			
		525:
			SC_P3_Srobovanie.StepName:='525 - Automaticky Rezim - cistenie skrutkovacky M5,otretie skrutkovacky M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
			
						
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsY_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 168; //mm
			
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P3_Srobovanie.ServoManipulOsY.Status.InPosition AND NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= 528;
			END_IF	
				
			
			
			
			
	
		528:
			SC_P3_Srobovanie.StepName:='528 - Automaticky Rezim - cistenie skrutkovacky M5, zasuvam skrutkovac M5';
			SC_P3_Srobovanie.IdleTime.PT:= T#2s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#30s;
			
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P34_RemPremenne.P3_ManipSrob_OsZ_M5_Rychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P3_Srobovanie.Switch1 THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P3_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P3_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P3_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe AND NOT P3_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P3_Srobovanie.ResetStep:= TRUE;
				SC_P3_Srobovanie.Step:= FazaNavratu;
			ELSIF P3_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P34_Alarmy[327]:= TRUE;
				P3_Pracovisko.STAV.Porucha_ST1:= TRUE;	
			END_IF	
			
			
			
			
			
			
			
			
				
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P3_Srobovanie.StepName:='700 - Manualny Rezim';
			SC_P3_Srobovanie.IdleTime.PT:= T#8s;
			SC_P3_Srobovanie.AlarmTime.PT:= T#5s;
		
			//Ovládanie manipulátora os Y//
			P3_Srobovanie.ServoManipulOsY.Parameters.Acc:= 1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 1;
			P3_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P3_Srobovanie.PAR.ManipulOsY_JoggRychlost/1000;
			P3_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
			P3_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1;
			
			IF P3_Srobovanie.CMD.RR_Manipulator_OsY_VPRED AND NOT P3_Srobovanie.ServoManipulOsY.Command.Stop AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 320;
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			ELSIF P3_Srobovanie.CMD.RR_Manipulator_OsY_VZAD AND NOT P3_Srobovanie.ServoManipulOsY.Command.Stop AND P3_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P3_Srobovanie.ServoManipulOsY.Parameters.Position:= 0;
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			ELSE
				P3_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P3_Srobovanie.ServoManipulOsY.Command.Stop:= TRUE;
			END_IF	
					
			IF P3_Srobovanie.ServoManipulOsY.Command.Stop AND P3_Srobovanie.ServoManipulOsY.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsY.Command.Stop:= FALSE;
			END_IF	
			
	
			//Ovládanie vysunutia skrutkovaèky M5//
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 1;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P3_Srobovanie.PAR.ManipulOsZ_M5_JoggRychlost/1000;
			P3_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= TRUE;
			P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1;
			
			IF P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_DOLE AND NOT P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
			ELSIF P3_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_HORE AND NOT P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
			ELSE
				P3_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= TRUE;
			END_IF	
					
			IF P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop AND P3_Srobovanie.ServoManipulOsZ_M5.Status.StandStill THEN
				P3_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= FALSE;
			END_IF	
				
            
					
			       
		
		
		   
        
				
			//Prisávanie skrutky M5//
			IF P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON THEN
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON:= FALSE;
			ELSIF P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_OFF THEN
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P3_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P3_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_OFF:= FALSE;
			END_IF    
			
		
			
			
			
		
			//Èistenie skrutkovaèky K40//
			IF P3_Srobovanie.CMD.RR_CistenieSkrutkovackyK40 THEN
				IF P3_Pracovisko.STAV.SkrutkovackyZasunute AND Safety.STAV.P3_ZonaBunky_AKTIVNA THEN
					FazaNavratu:= 700;
					SC_P3_Srobovanie.ResetStep:= TRUE;
					SC_P3_Srobovanie.Step:= 500;
				END_IF
				P3_Srobovanie.CMD.RR_CistenieSkrutkovackyK40:= FALSE;
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

