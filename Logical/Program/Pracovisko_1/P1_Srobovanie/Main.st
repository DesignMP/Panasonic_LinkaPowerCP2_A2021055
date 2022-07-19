
PROGRAM _INIT
	
	//Init parametre serva manipulátora Os X//
	P1_Srobovanie.ServoManipulOsX.Parameters.Override:= 100;
	P1_Srobovanie.PAR.ManipulOsX_JoggRychlost:= 5;
	P1_Srobovanie.ServoManipulOsX.Command.TorqueLimitation:= TRUE;
	P1_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1.0;
	
	//Init parametre serva manipulátora Os Y//
	P1_Srobovanie.ServoManipulOsY.Parameters.Override:= 100;
	P1_Srobovanie.PAR.ManipulOsY_JoggRychlost:= 5;	
	P1_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
	P1_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
	
	//Init parametre serva zdvihu skrutkovacky M4//
	P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Override:= 100;
	P1_Srobovanie.PAR.ManipulOsZ_M4_JoggRychlost:= 5;
	P1_Srobovanie.ServoManipulOsZ_M4.Command.TorqueLimitation:= TRUE;
	P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
	
	//Init parametre serva zdvihu skrutkovacky M5//
	P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Override:= 100;
	P1_Srobovanie.PAR.ManipulOsZ_M5_JoggRychlost:= 5;
	P1_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= TRUE;
	P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
	
	
	
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie podprogramov//
	AtlasCopcoKomunikacia;
	OvlSkrutkovacichSetov;
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P1_Srobovanie);
	
	
	//Enable serv//
	IF Safety.STAV.P1_ZonaBunky_AKTIVNA AND NOT P1_Srobovanie.ServoManipulOsX.Command.ErrReset THEN
		P1_Srobovanie.ServoManipulOsX.Command.PowerON:= TRUE;
	ELSE
		P1_Srobovanie.ServoManipulOsX.Command.PowerON:= FALSE;
	END_IF
	
	IF Safety.STAV.P1_ZonaBunky_AKTIVNA AND NOT P1_Srobovanie.ServoManipulOsY.Command.ErrReset THEN
		P1_Srobovanie.ServoManipulOsY.Command.PowerON:= TRUE;
	ELSE
		P1_Srobovanie.ServoManipulOsY.Command.PowerON:= FALSE;
	END_IF
	
	IF Safety.STAV.P1_ZonaBunky_AKTIVNA AND NOT P1_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset THEN
		P1_Srobovanie.ServoManipulOsZ_M4.Command.PowerON:= TRUE;
	ELSE
		P1_Srobovanie.ServoManipulOsZ_M4.Command.PowerON:= FALSE;
	END_IF
	
	IF Safety.STAV.P1_ZonaBunky_AKTIVNA AND NOT P1_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset THEN
		P1_Srobovanie.ServoManipulOsZ_M5.Command.PowerON:= TRUE;
	ELSE
		P1_Srobovanie.ServoManipulOsZ_M5.Command.PowerON:= FALSE;
	END_IF	

	
	
	
	
	//Reset poruchy serv//
	IF EDGEPOS(Safety.STAV.P1_ZonaBunky_AKTIVNA) THEN
		P1_Srobovanie.ServoManipulOsX.Command.ErrReset:= TRUE;
		P1_Srobovanie.ServoManipulOsY.Command.ErrReset:= TRUE;
		P1_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset:= TRUE;
		P1_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= TRUE;
	END_IF
	
	
	
	CasResetServo_1.IN:= P1_Srobovanie.ServoManipulOsX.Command.ErrReset;
	IF CasResetServo_1.Q AND NOT P1_Srobovanie.ServoManipulOsX.Status.Error THEN
		P1_Srobovanie.ServoManipulOsX.Command.ErrReset:= FALSE;
	END_IF	
		
	CasResetServo_2.IN:= P1_Srobovanie.ServoManipulOsY.Command.ErrReset;	
	IF CasResetServo_2.Q AND NOT P1_Srobovanie.ServoManipulOsY.Status.Error THEN
		P1_Srobovanie.ServoManipulOsY.Command.ErrReset:= FALSE;
	END_IF	
	
	CasResetServo_3.IN:= P1_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset;
	IF CasResetServo_3.Q AND NOT P1_Srobovanie.ServoManipulOsZ_M4.Status.Error THEN
		P1_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset:= FALSE;
	END_IF	
	
	CasResetServo_4.IN:= P1_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset;
	IF CasResetServo_4.Q AND NOT P1_Srobovanie.ServoManipulOsZ_M5.Status.Error THEN
		P1_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= FALSE;
	END_IF	
	
		
	//Reset poruchy skrutkovacích setov//	
	
	IF P1_Srobovanie.SkrutSet_M4.CMD.ResetPoruchy AND NOT P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
		P1_Srobovanie.SkrutSet_M4.CMD.ResetPoruchy:= FALSE;
	END_IF	
	
	IF P1_Srobovanie.SkrutSet_M5.CMD.ResetPoruchy AND NOT P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
		P1_Srobovanie.SkrutSet_M5.CMD.ResetPoruchy:= FALSE;
	END_IF	
	
	
	CasResetServo_1.PT:= T#500ms;
	CasResetServo_1();
	
	CasResetServo_2.PT:= T#500ms;
	CasResetServo_2();
	
	CasResetServo_3.PT:= T#500ms;
	CasResetServo_3();
	
	CasResetServo_4.PT:= T#500ms;
	CasResetServo_4();
	
	//Reset sekcie //
	IF P1_Srobovanie.Reset THEN
		SC_P1_Srobovanie.Step:= 0;
		P1_Srobovanie.ServoManipulOsX.Command.ErrReset:= TRUE;
		P1_Srobovanie.ServoManipulOsY.Command.ErrReset:= TRUE;
		P1_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset:= TRUE;
		P1_Srobovanie.ServoManipulOsZ_M5.Command.ErrReset:= TRUE;
		P1_Srobovanie.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P1_Srobovanie.Step:= 0;
	END_IF	
	
		
	
	
	CASE SC_P1_Srobovanie.Step OF 
		
		0:
			SC_P1_Srobovanie.StepName:='0 - Nulovanie';
			P1_Srobovanie.Automat:= FALSE;
			P1_Srobovanie.KoniecCyklu:= FALSE;
			P1_Srobovanie.Manual:= FALSE;
			P1_Srobovanie.STAV.PoINIT:= FALSE;
			
			SC_SkrutkovaciSet_K30.Step:= 0;
			SC_SkrutkovaciSet_M4.Step:= 0;
			SC_SkrutkovaciSet_M5.Step:= 0;
			
			P1_Srobovanie.OUT.Skrutkovacka_K30_Odvzdusn_ON:= FALSE;
			P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
			P1_Srobovanie.OUT.Skrutkovacka_M4_Odvzdusn_ON:= FALSE;
			IF NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN 
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
			END_IF	
			P1_Srobovanie.OUT.Skrutkovacka_M5_Odvzdusn_ON:= FALSE;
			IF NOT P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN 
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
			END_IF	
			P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
			P1_Srobovanie.ServoManipulOsX.Command.JogNeg:= FALSE;
			P1_Srobovanie.ServoManipulOsX.Command.JogPos:= FALSE;
			P1_Srobovanie.ServoManipulOsX.Command.MoveAdditive:= FALSE;
			P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
			P1_Srobovanie.ServoManipulOsX.Command.Pause:= FALSE;
			IF NOT P1_Srobovanie.ServoManipulOsX.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsX.Command.Stop:= TRUE;
			END_IF	
			P1_Srobovanie.ServoManipulOsY.Command.JogNeg:= FALSE;
			P1_Srobovanie.ServoManipulOsY.Command.JogPos:= FALSE;
			P1_Srobovanie.ServoManipulOsY.Command.MoveAdditive:= FALSE;
			P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
			P1_Srobovanie.ServoManipulOsY.Command.Pause:= FALSE;
			IF NOT P1_Srobovanie.ServoManipulOsY.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsY.Command.Stop:= TRUE;
			END_IF	
			P1_Srobovanie.ServoManipulOsZ_M4.Command.JogNeg:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M4.Command.JogPos:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M4.Command.MoveAdditive:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M4.Command.Pause:= FALSE;
			IF NOT P1_Srobovanie.ServoManipulOsZ_M4.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop:= TRUE;
			END_IF	
			P1_Srobovanie.ServoManipulOsZ_M5.Command.JogNeg:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M5.Command.JogPos:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M5.Command.MoveAdditive:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
			P1_Srobovanie.ServoManipulOsZ_M5.Command.Pause:= FALSE;
			IF NOT P1_Srobovanie.ServoManipulOsZ_M5.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= TRUE;
			END_IF	
			
			
			
			P1_Srobovanie.CMD.RR_Manipulator_OsX_VLAVO:= FALSE;
			P1_Srobovanie.CMD.RR_Manipulator_OsX_VPRAVO:= FALSE;
			P1_Srobovanie.CMD.RR_Manipulator_OsY_VPRED:= FALSE;
			P1_Srobovanie.CMD.RR_Manipulator_OsY_VZAD:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_DOLE:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_HORE:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_DOLE:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_HORE:= FALSE;
			P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_ON:= FALSE;
			P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_OFF:= FALSE;
			P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON:= FALSE;
			P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_OFF:= FALSE;
			
			P1_Srobovanie.CMD.RR_CistenieSkrutkovackyK30:= FALSE;
			P1_Srobovanie.CMD.PodajSkrutku_K30:= FALSE;
			P1_Srobovanie.CMD.PodajSkrutku_M4:= FALSE;
			P1_Srobovanie.CMD.PodajSkrutku_M5:= FALSE;
			P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			P1_Srobovanie.CMD.RR_SkrutSetK30_VysunBrzdu:= FALSE;
						
			P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
			P1_Srobovanie.STAV.CistenieSkrutkovackyK30_BUSY:= FALSE;
			P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora:= 1;
			
						
			P1_Srobovanie.Skrutkovacka_K30.RESET_Poruchy:= FALSE;
			P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= FALSE;
			P1_Srobovanie.Skrutkovacka_K30.START_Skrutkovania:= FALSE;
			P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;			
			P1_Srobovanie.Skrutkovacka_M4.RESET_Poruchy:= FALSE;
			P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
			P1_Srobovanie.Skrutkovacka_M4.START_Skrutkovania:= FALSE;
			P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
			P1_Srobovanie.Skrutkovacka_M5.RESET_Poruchy:= FALSE;
			P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
			P1_Srobovanie.Skrutkovacka_M5.START_Skrutkovania:= FALSE;
			P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;			
			P1_Robot.COM_OUT.UvolniBusbary:= FALSE;
			
			P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= FALSE;
			P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
			FazaNavratu:= 0;
			CasSrobovania:= 0;
			PocetCisteniSkrutkovacky:= 0;
									
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P1_ZonaBunky_AKTIVNA AND
				NOT P1_Pracovisko.STAV.Porucha_ST2 AND
				NOT P1_Pracovisko.STAV.Porucha_ST3 AND
				P1_Pracovisko.STAV.HardwareBunky_OK AND
				(P1_Srobovanie.ServoManipulOsX.Status.Ready AND P1_Srobovanie.ServoManipulOsX.Status.StandStill) AND
				(P1_Srobovanie.ServoManipulOsY.Status.Ready AND P1_Srobovanie.ServoManipulOsY.Status.StandStill) AND
				(P1_Srobovanie.ServoManipulOsZ_M4.Status.Ready AND P1_Srobovanie.ServoManipulOsZ_M4.Status.StandStill) AND
				(P1_Srobovanie.ServoManipulOsZ_M5.Status.Ready AND P1_Srobovanie.ServoManipulOsZ_M5.Status.StandStill) THEN
				P1_Srobovanie.ServoManipulOsX.Command.Stop:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.Stop:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 1;
			END_IF
	
		1:
			SC_P1_Srobovanie.StepName:='1 - Cakam na spustenie vyroby';
			P1_Srobovanie.KoniecCyklu:= FALSE;
			IF P1_Srobovanie.Automat THEN
				SC_P1_Srobovanie.Step:= 2;
			ELSIF P1_Srobovanie.Manual THEN
				SC_P1_Srobovanie.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		
	
		2:
			SC_P1_Srobovanie.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
						
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Acc;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Dcc;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Acc;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Dcc;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsX.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsXY_Acc;
			P1_Srobovanie.ServoManipulOsX.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsXY_Dcc;
			P1_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsY.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsXY_Acc;
			P1_Srobovanie.ServoManipulOsY.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsXY_Dcc;
			P1_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			
			IF P1_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie AND P1_Robot.STAV.PoINIT THEN
				P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 3;
			END_IF
	
		3:
			SC_P1_Srobovanie.StepName:='3 - Inicializacia - zasunutie skrutkovaciek M4 a M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
			
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
					
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 5;
			END_IF
		
			
		5:
			SC_P1_Srobovanie.StepName:='5 - Inicializacia - presun manipulatora do vychodiskovej pozicie k motoru';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 25;
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 0;
		
				
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 6;
			END_IF	
			
		6:
			SC_P1_Srobovanie.StepName:='6 - Inicializacia - cakam na zrusenie stavu serva v pozicii';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
		
			IF NOT P1_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 20;
			END_IF	
		
	
		20:
			SC_P1_Srobovanie.StepName:='20 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 12; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 23;
			END_IF	
			
		
			
		23:
			SC_P1_Srobovanie.StepName:='23 - Inicializacia - vysuvam skrutkovac M4 a vypinam prisavanie skrutky,priprava skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 105;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 25;
			END_IF	
	
			
		25:
			SC_P1_Srobovanie.StepName:='25 - Inicializacia - otretie skrutkovacky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition AND NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 28;
			END_IF	
			
		
			
		
	
		28:
			SC_P1_Srobovanie.StepName:='28 - Inicializacia - zasuvam skrutkovac M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe AND NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 30;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;		
			END_IF	
			
				
			
			
			
		30:
			SC_P1_Srobovanie.StepName:='30 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 15; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 67; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 32;
			END_IF	
			
		32:
			SC_P1_Srobovanie.StepName:='32 - Inicializacia - vysuvam skrutkovac M5 a vypinam prisavanie skrutky,priprava skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 106;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 33;
			END_IF	
				
			
			
			
		33:
			SC_P1_Srobovanie.StepName:='33 - Inicializacia - otretie skrutkovacky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 67; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition AND NOT P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 35;
			END_IF		
			
			
			
			
			
			
		35:
			SC_P1_Srobovanie.StepName:='35 - Inicializacia - zasuvam skrutkovac M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe AND NOT P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 40;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;		
			END_IF	
		
				
					
			
		
		40:
			SC_P1_Srobovanie.StepName:='40 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 3; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 42;
			END_IF	
			
		42:
			SC_P1_Srobovanie.StepName:='42 - Inicializacia - vysunutie skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= TRUE;
				SC_P1_Srobovanie.IdleTime.IN:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P1_Srobovanie.IdleTime.Q THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 45;
			END_IF	
		
		45:
			SC_P1_Srobovanie.StepName:='45 - Inicializacia - nabitie skrutky do skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA THEN
				P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
				P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P1_Srobovanie.STAV.SkrutkaK30_READY THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 50;
			ELSIF P1_Srobovanie.SkrutSet_K30.Error.ErrorBit THEN
				P1_Alarmy[119]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF	
			
			
		50:
			SC_P1_Srobovanie.StepName:='50 - Inicializacia - presun manipulatora do vychodiskovej pozicie k motoru';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 25; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 0; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 52;
			END_IF	
            
		52:
			SC_P1_Srobovanie.StepName:='52 - Inicializacia - cakam na zrusenie stavu serva v pozicii';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
		
			IF NOT P1_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.STAV.PoINIT:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
            
	
			//********************************************************Automatický režim****************************************************************************//
	
		100:  
			SC_P1_Srobovanie.StepName:='100 - Automaticky Rezim - cakam na spustenie cinnosti';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;			
	
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Acc;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Dcc;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Acc;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Dcc;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsX.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsXY_Acc;
			P1_Srobovanie.ServoManipulOsX.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsXY_Dcc;
			P1_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsY.Parameters.Acc:= P1_RemPremenne.P1_ManipSrob_OsXY_Acc;
			P1_Srobovanie.ServoManipulOsY.Parameters.Dcc:= P1_RemPremenne.P1_ManipSrob_OsXY_Dcc;
			P1_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
					
			
			
			IF P1_Srobovanie.KoniecCyklu AND NOT P1_StoperSrobovania.Automat THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 0;
			ELSIF P1_Srobovanie.COM_IN.Model45F_ZaskrutkujLavu_K30 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 110;
			ELSIF P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPravu_K30 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 130;
			ELSIF P1_Srobovanie.COM_IN.Model45F_ZaskrutkujZadnu_M4 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 150;
			ELSIF P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPrednu_M4 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 170;
			ELSIF P1_Srobovanie.COM_IN.Model45F_ZaskrutkujDPS_M4 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 190;
			ELSIF P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_K30 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 210;
			ELSIF P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_K30 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 230;
			ELSIF P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_M5 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 250;
			ELSIF P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_M5 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 270;
			ELSIF P1_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednu_M5 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 290;
			ELSIF P1_Srobovanie.COM_IN.PresunManipulatora_VPRED THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 400;
			ELSIF P1_Srobovanie.COM_IN.PresunManipulatora_VZAD THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 420;
			ELSIF P1_Srobovanie.COM_IN.OdoberSkrutku_M4 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 440;
			ELSIF P1_Srobovanie.COM_IN.OdoberSkrutku_M5 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 460;	
			END_IF	
			
		
			//**********************************************************************Model 45F*******************************************************************************************//	
			//Zaskrutkovanie lavej skrutky K30//		
		110:	
			SC_P1_Srobovanie.StepName:='110 - Automaticky Rezim - model 45F, napolohovanie prednej skrutkovacky K30 na poziciu lavej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF	
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob45F_PozX_LavejSkrutkyK30; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob45F_PozY_LavejSkrutkyK30; //mm
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 125;
			ELSIF P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					(*P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;*)
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 113;//128
				END_IF	
			END_IF	
			
			
						
		113:
			SC_P1_Srobovanie.StepName:='113 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND NOT TEST THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 115;
			END_IF	
	
		115:
			SC_P1_Srobovanie.StepName:='115 - Automaticky Rezim - model 45F, kontrola skrutkovacky a skrutky K30 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10M;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
            
			IF P1_Srobovanie.STAV.SkrutkaK30_READY AND P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 118;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				P1_Alarmy[149]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.STAV.SkrutkaK30_READY AND SC_P1_Srobovanie.IdleTime.Q THEN
				IF PocetCisteniSkrutkovacky < 5 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 110;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 500;
				ELSE
					P1_Alarmy[119]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				END_IF	
			END_IF	
			
			
			
			
		118:
			SC_P1_Srobovanie.StepName:='118 - Automaticky Rezim - model 45F, vysunutie skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			SC_P1_Srobovanie.AlarmTime.IN:= (P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL < 5);
            
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= TRUE;
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL > 10 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 120;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[142]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 0;
			END_IF	
			
		120:
			SC_P1_Srobovanie.StepName:='120 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#20s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
            SC_P1_Srobovanie.IdleTime.IN:= P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene;
            
            
			IF P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND SC_P1_Srobovanie.IdleTime.Q THEN
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 123;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Alarmy[146]:= TRUE;
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 123; 
			END_IF
				
		123:
			SC_P1_Srobovanie.StepName:='123 - Automaticky Rezim - model 45F, zasunutie skrutkovacky K30 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA THEN
				P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
				P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 125;
			END_IF
		
			
				
				
		125:
			SC_P1_Srobovanie.StepName:='125 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania lavej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 128;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 128;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 128;          
			END_IF	
				
			
		128:
			SC_P1_Srobovanie.StepName:='128 - Automaticky Rezim - model 45F, cakam na zrusenie signalu zaskrutkuj lavu skrutku K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model45F_ZaskrutkujLavu_K30 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
		
	
			//Zaskrutkovanie pravej skrutky K30//		
		130:	
			SC_P1_Srobovanie.StepName:='130 - Automaticky Rezim - model 45F, napolohovanie prednej skrutkovacky K30 na poziciu pravej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
		
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob45F_PozX_PravejSkrutkyK30; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob45F_PozY_PravejSkrutkyK30; //mm
			
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 145;
			ELSIF P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					(*P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;*)
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 133;//148
				END_IF	
			END_IF	
			
			
						
		133:
			SC_P1_Srobovanie.StepName:='133 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND NOT TEST THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 135;
			END_IF	
	
		135:
			SC_P1_Srobovanie.StepName:='135 - Automaticky Rezim - model 45F, kontrola skrutkovacky a skrutky K30 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10M;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
            
			IF P1_Srobovanie.STAV.SkrutkaK30_READY AND P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 138;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				P1_Alarmy[149]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.STAV.SkrutkaK30_READY AND SC_P1_Srobovanie.IdleTime.Q THEN
				IF PocetCisteniSkrutkovacky < 5 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 130;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 500;
				ELSE
					P1_Alarmy[119]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				END_IF	
			END_IF	
			
			
					
			
			
			
		138:
			SC_P1_Srobovanie.StepName:='138 - Automaticky Rezim - model 45F, vysunutie skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			SC_P1_Srobovanie.AlarmTime.IN:= (P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL < 5);
            
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= TRUE;
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL > 10 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 140;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[142]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 0;
			END_IF	
			
		140:
			SC_P1_Srobovanie.StepName:='140 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#20s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
            
            
            
			IF P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 143;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[146]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 143; 
			END_IF
				
		143:
			SC_P1_Srobovanie.StepName:='143 - Automaticky Rezim - model 45F, zasunutie skrutkovacky K30 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA THEN
				P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
				P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 145;
			END_IF
		
			
				
				
		145:
			SC_P1_Srobovanie.StepName:='145 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania pravej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 148;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 148;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 148;          
			END_IF	
				
			
		148:
			SC_P1_Srobovanie.StepName:='148 - Automaticky Rezim - model 45F, cakam na zrusenie signalu zaskrutkuj pravu skrutku K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPravu_K30 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
		
			//Zaskrutkovanie zadnej skrutky M4//		
		
		150:
			SC_P1_Srobovanie.StepName:='150 - Automaticky Rezim - model 45F, kontrola pritomnosti skrutky M4 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 160;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 151;
			END_IF	
			
			
			
			
			
		151:
			SC_P1_Srobovanie.StepName:='151 - Automaticky Rezim - model 45F, napolohovanie zadnej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
						
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM4; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 152;
			END_IF	
		
	
		152:
			SC_P1_Srobovanie.StepName:='152 - Automaticky Rezim - model 45F, kontrola skrutky M4 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 154;
			ELSE
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 153;
			END_IF	
			
		153:
			SC_P1_Srobovanie.StepName:='153 - Automaticky Rezim - model 45F, cakam na podanie skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 152;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN	
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF	
			
			
			
		154:
			SC_P1_Srobovanie.StepName:='154 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 155;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P1_Alarmy[121]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 155;
			END_IF
		
			
		155:
			SC_P1_Srobovanie.StepName:='155 - Automaticky Rezim - model 45F,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 156;
				END_IF	
			END_IF	
		
			
		156:
			SC_P1_Srobovanie.StepName:='156 - Automaticky Rezim - model 45F,priprava skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
			P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 160;
	
			
			
			
		160:
			SC_P1_Srobovanie.StepName:='160 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania zadnej skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			IF Linka.PAR.ZvolenyModel = '4F' AND NOT P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozX_ZadnejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozY_ZadnejSkrutkyM4; //mm
			ELSIF P1_Srobovanie.PAR.RR_TypModelu = '4F' AND P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozX_ZadnejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozY_ZadnejSkrutkyM4; //mm
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozX_ZadnejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozY_ZadnejSkrutkyM4; //mm
			ELSIF P1_Srobovanie.PAR.RR_TypModelu = '5F' AND P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN	
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozX_ZadnejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozY_ZadnejSkrutkyM4; //mm
			END_IF	
				
			
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 161;
				END_IF	
			END_IF	
			
			
			
		161:
			SC_P1_Srobovanie.StepName:='161 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 162;
			END_IF	
	
		
		162:
			SC_P1_Srobovanie.StepName:='162 - Automaticky Rezim - model 45F, kontrola skrutkovacky a skrutky M4 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK AND P1_Srobovanie.Skrutkovacka_M4.Stav_READY_to_START THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 163;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_M4.Stav_READY_to_START THEN
				P1_Alarmy[138]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 151;
			END_IF		
		
			
		163:
			SC_P1_Srobovanie.StepName:='163 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M4 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 75;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 164;
			END_IF
			
			
			
		164:
			SC_P1_Srobovanie.StepName:='164 - Automaticky Rezim - model 45F, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_Srob45F_Rychl_ZadnejSkrutkyM4/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= P1_RemPremenne.P1_Srob45F_Mom_ZadnejSkrutkyM4;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 150;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InTorque) THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 165;
			END_IF	
			
		
				
		165:
			SC_P1_Srobovanie.StepName:='165 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P1_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 166;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN    
				P1_Alarmy[148]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_ZadnaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 166;
			END_IF
			
		
				
		166:
			SC_P1_Srobovanie.StepName:='166 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M4 a vypnutie prisavania skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 167;
			END_IF	
		
			
				
		167:
			SC_P1_Srobovanie.StepName:='167 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania zadnej skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 168; 
			ELSIF P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 168;
			ELSIF P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 168;          
			END_IF
		
		
		168:
			SC_P1_Srobovanie.StepName:='168 - Automaticky Rezim - model 4F, cakam na zrusenie signalu zaskrutkuj zadnu skrutku M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model45F_ZaskrutkujZadnu_M4 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
			
		
			//Zaskrutkovanie prednej skrutky M4//	
		170:
			SC_P1_Srobovanie.StepName:='170 - Automaticky Rezim - model 45F, kontrola pritomnosti skrutky M4 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 180;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 171;
			END_IF	
			
			
			
			
			
		171:
			SC_P1_Srobovanie.StepName:='171 - Automaticky Rezim - model 45F, napolohovanie zadnej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM4; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute AND P1_Srobovanie.ServoManipulOsX.Status.Ready AND P1_Srobovanie.ServoManipulOsY.Status.Ready THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 172;
			END_IF	
	
		172:
			SC_P1_Srobovanie.StepName:='172 - Automaticky Rezim - model 45F, kontrola skrutky M4 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 174;
			ELSE
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 173;
			END_IF	
		
				
		173:
			SC_P1_Srobovanie.StepName:='173 - Automaticky Rezim - model 45F, cakam na podanie skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 172;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN	
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE; 	
			END_IF	
				
			
			
					
			
		174:
			SC_P1_Srobovanie.StepName:='174 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 175;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P1_Alarmy[121]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 175;
			END_IF
		
			
		175:
			SC_P1_Srobovanie.StepName:='175 - Automaticky Rezim - model 45F,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1  THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 176;
				END_IF	
			END_IF	
		
			
		176:
			SC_P1_Srobovanie.StepName:='176 - Automaticky Rezim - model 45F,priprava skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
			P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 180;
		
			
			
			
		180:
			SC_P1_Srobovanie.StepName:='180 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania prednej skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			IF Linka.PAR.ZvolenyModel = '4F' AND NOT P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozX_PrednejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozY_PrednejSkrutkyM4; //mm
			ELSIF P1_Srobovanie.PAR.RR_TypModelu = '4F' AND P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozX_PrednejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob4F_PozY_PrednejSkrutkyM4; //mm
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozX_PrednejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozY_PrednejSkrutkyM4; //mm
			ELSIF P1_Srobovanie.PAR.RR_TypModelu = '5F' AND P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN	
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozX_PrednejSkrutkyM4; //mm
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5F_PozY_PrednejSkrutkyM4; //mm
			END_IF	
				
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 181;
				END_IF	
			END_IF	
			
			
			
		181:
			SC_P1_Srobovanie.StepName:='181 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 182;
			END_IF	
	
		182:
			SC_P1_Srobovanie.StepName:='182 - Automaticky Rezim - model 45F, kontrola skrutkovacky a skrutky M4 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
				
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK AND P1_Srobovanie.Skrutkovacka_M4.Stav_READY_to_START THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 183;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_M4.Stav_READY_to_START THEN
				P1_Alarmy[138]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 171;
			END_IF		
		
			
			
			
			
			
			
			
		183:
			SC_P1_Srobovanie.StepName:='183 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M4 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 75;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 184;
			END_IF
			
			
			
		184:
			SC_P1_Srobovanie.StepName:='184 - Automaticky Rezim - model 45F, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_Srob45F_Rychl_PredneSkrutkyM4/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= P1_RemPremenne.P1_Srob45F_Mom_PrednejSkrutkyM4;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 150;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InTorque) THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 185;
			END_IF	
				
		
				
		185:
			SC_P1_Srobovanie.StepName:='185 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P1_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PrednaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_PrednaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 186;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN    
				P1_Alarmy[148]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PrednaSkrutkaM4:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_PrednaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 186;
			END_IF
			
		
				
		186:
			SC_P1_Srobovanie.StepName:='186 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M4 a vypnutie prisavania skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 187;
			END_IF	
		
			
				
		187:
			SC_P1_Srobovanie.StepName:='187 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania prednej skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 188; 
			ELSIF P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 188;
			ELSIF P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 188;          
			END_IF
		
		
		188:
			SC_P1_Srobovanie.StepName:='188 - Automaticky Rezim - model 4F, cakam na zrusenie signalu zaskrutkuj prednu skrutku M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model45F_ZaskrutkujPrednu_M4 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF			
		
		
			//Zaskrutkovanie strednej skrutky M4 pre DPS//	
		
		190:
			SC_P1_Srobovanie.StepName:='190 - Automaticky Rezim - model 45F, kontrola pritomnosti skrutky M4 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 200;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 191;
			END_IF	
			
			
			
			
		191:
			SC_P1_Srobovanie.StepName:='191 - Automaticky Rezim - model 45F, napolohovanie zadnej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM4; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 192;
			END_IF	
	
		192:
			SC_P1_Srobovanie.StepName:='192 - Automaticky Rezim - model 45F, kontrola skrutky M4 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 194;
			ELSE
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 193;
			END_IF	
			
			
		
				
		193:
			SC_P1_Srobovanie.StepName:='193 - Automaticky Rezim - model 45F, cakam na podanie skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 192;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN	
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE; 		
			END_IF	
				
		
			
		
			
				
			
			
		194:
			SC_P1_Srobovanie.StepName:='194 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 195;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P1_Alarmy[121]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 195;
			END_IF
		
			
		195:
			SC_P1_Srobovanie.StepName:='195 - Automaticky Rezim - model 45F,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1  THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE; 	
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 196;
				END_IF	
			END_IF	
		
			
		196:
			SC_P1_Srobovanie.StepName:='196 - Automaticky Rezim - model 45F,priprava skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
			P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 200;
					
			
			
		200:
			SC_P1_Srobovanie.StepName:='200 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania strednej skrutky M4 pre DPS';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob45F_PozX_SkrutkyDPS_M4; //mm			
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob45F_PozY_SkrutkyDPS_M4; //mm			
				
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 201;
				END_IF	
			END_IF	
			
			
			
		201:
			SC_P1_Srobovanie.StepName:='201 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 202;
			END_IF	
	
		
		202:
			SC_P1_Srobovanie.StepName:='202 - Automaticky Rezim - model 45F, kontrola skrutkovacky a skrutky M4 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK AND P1_Srobovanie.Skrutkovacka_M4.Stav_READY_to_START THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 203;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_M4.Stav_READY_to_START THEN
				P1_Alarmy[138]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 191;
			END_IF		
		
			
			
		
			
			
		203:
			SC_P1_Srobovanie.StepName:='203 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M4 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 75;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 204;
			END_IF
			
			
			
		204:
			SC_P1_Srobovanie.StepName:='204 - Automaticky Rezim - model 45F, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_Srob45F_Rychl_SkrutkyDPS_M4/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= P1_RemPremenne.P1_Srob45F_Mom_SkrutkyDPS_M4;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 150;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InTorque) THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 205;
			END_IF	
				
			
			
	
			
			
				
		205:
			SC_P1_Srobovanie.StepName:='205 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P1_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_SkrutkaDPS_M4:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_SkrutkaDPS_M4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 206;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN    
				P1_Alarmy[148]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_SkrutkaDPS_M4:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_SkrutkaDPS_M4:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 206;
			END_IF
			
		
				
		206:
			SC_P1_Srobovanie.StepName:='206 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M4 a vypnutie prisavania skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 207;
			END_IF	
		
			
				
		207:
			SC_P1_Srobovanie.StepName:='207 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania strednej skrutky M4 pre DPS';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 208; 
			ELSIF P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 208;
			ELSIF P1_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 208;          
			END_IF
		
		
		208:
			SC_P1_Srobovanie.StepName:='208 - Automaticky Rezim - model 4F, cakam na zrusenie signalu zaskrutkuj strednu skrutku M4 pre DPS';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model45F_ZaskrutkujDPS_M4 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
			//**********************************************************************Model 5H*******************************************************************************************//	
			//Zaskrutkovanie lavej skrutky K30//	
		210:
			SC_P1_Srobovanie.StepName:='210 - Automaticky Rezim - model 5H, napolohovanie prednej skrutkovacky K30 na poziciu lavej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozX_LavejSkrutkyK30; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozY_LavejSkrutkyK30; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					(*P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;*)
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 213;//228
				END_IF	
			END_IF	
			
			
						
		213:
			SC_P1_Srobovanie.StepName:='213 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND NOT TEST THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 215;
			END_IF	
	
		215:
			SC_P1_Srobovanie.StepName:='215 - Automaticky Rezim - model 5H, kontrola skrutkovacky a skrutky K30 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
            
			IF P1_Srobovanie.STAV.SkrutkaK30_READY AND P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 218;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				P1_Alarmy[149]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.STAV.SkrutkaK30_READY AND SC_P1_Srobovanie.IdleTime.Q THEN
				IF PocetCisteniSkrutkovacky < 5 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;	
					FazaNavratu:= 210;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 500;
				ELSE
					P1_Alarmy[119]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				END_IF	
			END_IF	
			
		
			
		
			
			
			
			
		218:
			SC_P1_Srobovanie.StepName:='218 - Automaticky Rezim - model 5H, vysunutie skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			SC_P1_Srobovanie.AlarmTime.IN:= (P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL < 5);
            
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= TRUE;
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL > 10 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 220;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[142]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 0;
			END_IF	
			
		220:
			SC_P1_Srobovanie.StepName:='220 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
            
            
            
			IF P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 223;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[146]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 223; 
			END_IF
				
		223:
			SC_P1_Srobovanie.StepName:='223 - Automaticky Rezim - model 5H, zasunutie skrutkovacky K30 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA THEN
				P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
				P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 225;
			END_IF
		
			
	
			
			
				
		225:
			SC_P1_Srobovanie.StepName:='225 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania lavej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
				
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 228;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 228;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 228;          
			END_IF	
				
			
		228:
			SC_P1_Srobovanie.StepName:='228 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj lavu skrutku K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_K30 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
		
		
			//Zaskrutkovanie pravej skrutky K30//		
		230:	
			SC_P1_Srobovanie.StepName:='230 - Automaticky Rezim - model 5H, napolohovanie prednej skrutkovacky K30 na poziciu pravej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozX_PravejSkrutkyK30; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozY_PravejSkrutkyK30; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					(*P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;*)
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 233;//248
				END_IF	
			END_IF	
			
			
						
		233:
			SC_P1_Srobovanie.StepName:='233 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND NOT TEST THEN
				P1_Srobovanie.Skrutkovacka_K30.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 235;
			END_IF	
	
		235:
			SC_P1_Srobovanie.StepName:='235 - Automaticky Rezim - model 5H, kontrola skrutkovacky a skrutky K30 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
            
			IF P1_Srobovanie.STAV.SkrutkaK30_READY AND P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 238;
			ELSIF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_READY_to_START THEN
				P1_Alarmy[149]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			ELSIF NOT P1_Srobovanie.STAV.SkrutkaK30_READY AND SC_P1_Srobovanie.IdleTime.Q THEN
				IF PocetCisteniSkrutkovacky < 5 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 230;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 500;
				ELSE
					P1_Alarmy[119]:= TRUE;
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				END_IF	
			END_IF	
			
		
	
			
			
			
			
		238:
			SC_P1_Srobovanie.StepName:='238 - Automaticky Rezim - model 5H, vysunutie skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			SC_P1_Srobovanie.AlarmTime.IN:= (P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL < 5);
            
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= TRUE;
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene AND P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL > 10 THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 240;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[142]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 0;
			END_IF	
			
		240:
			SC_P1_Srobovanie.StepName:='240 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
            
            
            
			IF P1_Srobovanie.Skrutkovacka_K30.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 243;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Alarmy[146]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(P1_Srobovanie.PAR.Skrutkov_K30_RoundHodnotaREAL);
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaK30:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_K30.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 243; 
			END_IF
				
		243:
			SC_P1_Srobovanie.StepName:='143 - Automaticky Rezim - model 5H, zasunutie skrutkovacky K30 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA THEN
				P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
				P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 245;
			END_IF
		
				
				
		245:
			SC_P1_Srobovanie.StepName:='145 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania pravej skrutky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 248;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 248;
			ELSIF P1_Srobovanie.Skrutkovacka_K30.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 248;          
			END_IF	
				
			
		248:
			SC_P1_Srobovanie.StepName:='148 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj pravu skrutku K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_K30 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
		
			//Zaskrutkovanie lavej skrutky M5//	
		250:
			SC_P1_Srobovanie.StepName:='250 - Automaticky Rezim - model 5H, kontrola pritomnosti skrutky M5 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 260;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 251;
			END_IF	
		
		251:
			SC_P1_Srobovanie.StepName:='251 - Automaticky Rezim - model 5H, napolohovanie strednej skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM5; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 252;
			END_IF	
	
		252:
			SC_P1_Srobovanie.StepName:='252 - Automaticky Rezim - model 5H, kontrola skrutky M5 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 254;
			ELSE
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 253;
			END_IF	
		
			
			
					
			
				
		253:
			SC_P1_Srobovanie.StepName:='253 - Automaticky Rezim - model 5H, cakam na podanie skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 252;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF		
			
	
			
			
			
			
			
			
			
		254:
			SC_P1_Srobovanie.StepName:='254 - Automaticky Rezim - model 5H,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM5;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 255;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P1_Alarmy[120]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 255;
			END_IF
		
			
		255:
			SC_P1_Srobovanie.StepName:='255 - Automaticky Rezim - model 5H,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 256;
				END_IF	
			END_IF	
		
			
			
			
			
		256:
			SC_P1_Srobovanie.StepName:='256 - Automaticky Rezim - model 5H,priprava skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
			P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 260;
		
			
			
			
		260:
			SC_P1_Srobovanie.StepName:='260 - Automaticky Rezim - model 5H, napolohovanie na poziciu skrutkovania lavej skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
						
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozX_LavejSkrutkyM5; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozY_LavejSkrutkyM5; //mm
				
		
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 261;
				END_IF	
			END_IF	
			
			
			
		261:
			SC_P1_Srobovanie.StepName:='261 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 262;
			END_IF	
	
		
		262:
			SC_P1_Srobovanie.StepName:='262 - Automaticky Rezim - model 5H, prepnutie programu a kontrola skrutkovacky';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M5.CisloZadanehoProgramu:= 2;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.Skrutkovacka_M5.Stav_CisloAktualnehoProgramu = 2 AND P1_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 263;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				P1_Alarmy[150]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
			
		263:
			SC_P1_Srobovanie.StepName:='263 - Automaticky Rezim - model 5H, kontrola skrutky M5 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 264;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 251;
			END_IF		

			
		264:
			SC_P1_Srobovanie.StepName:='264 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 85;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 265;
			END_IF
			
			
			
		265:
			SC_P1_Srobovanie.StepName:='265 - Automaticky Rezim - model 5H, prepnutie vysunutie skrutkovacky M5 na momentovy pohyb';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_Srob5H_Rychl_LavejSkrutkyM5/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P1_RemPremenne.P1_Srob5H_Mom_LavejSkrutkyM5;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 150;
			
			IF NOT SC_P1_Srobovanie.Switch1  THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InTorque) THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 266;
			END_IF		
			
			
			
				
		266:
			SC_P1_Srobovanie.StepName:='266 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 267;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN    
				P1_Alarmy[147]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_LavaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_LavaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 267;
			END_IF
			
		
				
		267:
			SC_P1_Srobovanie.StepName:='267 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 268;
			END_IF	
		
			
				
		268:
			SC_P1_Srobovanie.StepName:='268 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania lavej skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 269; 
			ELSIF P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 269;
			ELSIF P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 269;          
			END_IF
		
		
		269:
			SC_P1_Srobovanie.StepName:='269 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj lavu skrutku M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model5H_ZaskrutkujLavu_M5 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
			//Zaskrutkovanie pravej skrutky M5//	
		270:
			SC_P1_Srobovanie.StepName:='270 - Automaticky Rezim - model 5H, kontrola pritomnosti skrutky M5 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 280;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 271;
			END_IF	
		
		
		
		271:
			SC_P1_Srobovanie.StepName:='271 - Automaticky Rezim - model 5H, napolohovanie strednej skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM5; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 272;
			END_IF	
	
		272:
			SC_P1_Srobovanie.StepName:='272 - Automaticky Rezim - model 5H, kontrola skrutky M5 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 274;
			ELSE
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 273;
			END_IF	
			
	
				
		273:
			SC_P1_Srobovanie.StepName:='273 - Automaticky Rezim - model 5H, cakam na podanie skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 272;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF		
			
			
				
			
			
		274:
			SC_P1_Srobovanie.StepName:='274 - Automaticky Rezim - model 5H,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM5;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 275;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P1_Alarmy[120]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 275;
			END_IF
		
			
		275:
			SC_P1_Srobovanie.StepName:='275 - Automaticky Rezim - model 5H,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 276;
				END_IF	
			END_IF	
		
			
			
			
		276:
			SC_P1_Srobovanie.StepName:='276 - Automaticky Rezim - model 5H,priprava skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 280;
						
			
			
		280:
			SC_P1_Srobovanie.StepName:='280 - Automaticky Rezim - model 5H, napolohovanie na poziciu skrutkovania pravej skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozX_PravejSkrutkyM5; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozY_PravejSkrutkyM5; //mm
				
		
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 281;
				END_IF	
			END_IF	
			
			
			
		281:
			SC_P1_Srobovanie.StepName:='281 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 282;
			END_IF	
	
		
		282:
			SC_P1_Srobovanie.StepName:='282 - Automaticky Rezim - model 5H, prepnutie programu a kontrola skrutkovacky';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M5.CisloZadanehoProgramu:= 2;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.Skrutkovacka_M5.Stav_CisloAktualnehoProgramu = 2 AND P1_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 283;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				P1_Alarmy[150]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
			
		283:
			SC_P1_Srobovanie.StepName:='283 - Automaticky Rezim - model 5H, kontrola skrutky M5 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 284;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 271;
			END_IF			
	
			
			
		284:
			SC_P1_Srobovanie.StepName:='284 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 85;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 285;
			END_IF
			
			
			
		285:
			SC_P1_Srobovanie.StepName:='285 - Automaticky Rezim - model 5H, prepnutie vysunutie skrutkovacky M5 na momentovy pohyb';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_Srob5H_Rychl_PravejSkrutkyM5/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P1_RemPremenne.P1_Srob5H_Mom_PravejSkrutkyM5;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 150;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InTorque) THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 286;
			END_IF			
			
				
				
		286:
			SC_P1_Srobovanie.StepName:='286 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 287;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN    
				P1_Alarmy[147]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_PravaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_PravaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 287;
			END_IF
			
		
				
		287:
			SC_P1_Srobovanie.StepName:='287 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 288;
			END_IF	
		
			
				
		288:
			SC_P1_Srobovanie.StepName:='288 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania pravej skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 289; 
			ELSIF P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 289;
			ELSIF P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 289;          
			END_IF
		
		
		289:
			SC_P1_Srobovanie.StepName:='289 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj pravu skrutku M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model5H_ZaskrutkujPravu_M5 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF		
		
		
		
			//Zaskrutkovanie strednej skrutky M5//		
		
		290:
			SC_P1_Srobovanie.StepName:='290 - Automaticky Rezim - model 5H, kontrola pritomnosti skrutky M5 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 300;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 291;
			END_IF		
			
			
			
			
		291:
			SC_P1_Srobovanie.StepName:='291 - Automaticky Rezim - model 5H, napolohovanie strednej skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM5; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute AND P1_Srobovanie.ServoManipulOsX.Status.Ready AND P1_Srobovanie.ServoManipulOsY.Status.Ready THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 292;
			END_IF	
	
		292:
			SC_P1_Srobovanie.StepName:='292 - Automaticky Rezim - model 5H, kontrola skrutky M5 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 294;
			ELSE
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 293;
			END_IF	
		
			
			
		293:
			SC_P1_Srobovanie.StepName:='293 - Automaticky Rezim - model 5H, cakam na podanie skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 292;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF		
			
					
			
		294:
			SC_P1_Srobovanie.StepName:='294 - Automaticky Rezim - model 5H,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM5;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 295;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P1_Alarmy[120]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 295;
			END_IF
		
			
		295:
			SC_P1_Srobovanie.StepName:='295 - Automaticky Rezim - model 5H,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 296;
				END_IF	
			END_IF	
		
			
			
			
		296:
			SC_P1_Srobovanie.StepName:='296 - Automaticky Rezim - model 5H,priprava skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 300;
		
			
			
			
		300:
			SC_P1_Srobovanie.StepName:='300 - Automaticky Rezim - model 5H, napolohovanie na poziciu skrutkovania strednej skrutky M5 ';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozX_StrednejSkrutkyM5; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob5H_PozY_StrednejSkrutkyM5; //mm
				
		
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 301;
				END_IF	
			END_IF	
			
			
			
		301:
			SC_P1_Srobovanie.StepName:='301 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 302;
			END_IF	
	
		
		302:
			SC_P1_Srobovanie.StepName:='302 - Automaticky Rezim - model 5H, prepnutie programu a kontrola skrutkovacky';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.Skrutkovacka_M5.CisloZadanehoProgramu:= 1;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P1_Srobovanie.Skrutkovacka_M5.Stav_CisloAktualnehoProgramu = 1 AND P1_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 303;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q AND NOT P1_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				P1_Alarmy[150]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
			END_IF
			
		303:
			SC_P1_Srobovanie.StepName:='303 - Automaticky Rezim - model 5H, kontrola skrutky M5 v skrutkovacke';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 304;
			ELSE
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 291;
			END_IF			
			
		
			
		304:
			SC_P1_Srobovanie.StepName:='304 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 85;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				P1_StoperSrobovania.STAV.VyrobaZacala:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 305;
			END_IF
			
			
			
		305:
			SC_P1_Srobovanie.StepName:='305 - Automaticky Rezim - model 5H, prepnutie vysunutie skrutkovacky M5 na momentovy pohyb';
			SC_P1_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_Srob5H_Rychl_StredneSkrutkyM5/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= P1_RemPremenne.P1_Srob5H_Mom_StrednejSkrutkyM5;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 150;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InTorque) THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 306;
			END_IF		
			
	
		
				
		306:
			SC_P1_Srobovanie.StepName:='306 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#30s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#15s;
			SC_P1_Srobovanie.IdleTime.IN:= TRUE;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P1_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_StrednaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_StrednaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 307;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN    
				P1_Alarmy[147]:= TRUE;
				CasSrobovania:= TIME_TO_REAL(SC_P1_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P1_StrednaSkrutkaM5:= REAL_TO_STRING(P1_Srobovanie.ServoManipulOsZ_M5.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P1_StrednaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				P1_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 307;
			END_IF
			
		
				
		307:
			SC_P1_Srobovanie.StepName:='307 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1.0;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 308;
			END_IF	
		
			
				
		308:
			SC_P1_Srobovanie.StepName:='308 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania strednej skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 309; 
			ELSIF P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 309;
			ELSIF P1_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P1_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 309;          
			END_IF
		
		
		309:
			SC_P1_Srobovanie.StepName:='309 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj strednu skrutku M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednu_M5 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
		
			//Presun manipulátora do pozície VPRED//	
		
		400:
			SC_P1_Srobovanie.StepName:='400 - Automaticky Rezim - napolohovanie manipulatora na prednu poziciu ';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 24; //mm
						
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 320; //mm
				
		
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 402;
			END_IF	
				
		
		402:
			SC_P1_Srobovanie.StepName:='402 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora vpred';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.PresunManipulatora_VPRED THEN
				P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
			//Presun manipulátora do pozície VZAD//	
		
		420:
			SC_P1_Srobovanie.StepName:='420 - Automaticky Rezim - napolohovanie manipulatora na zadnu poziciu ';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 24; //mm
						
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 0; //mm
				
		
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 422;
			END_IF	
				
		
		422:
			SC_P1_Srobovanie.StepName:='422 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora vzad';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P1_Srobovanie.COM_IN.PresunManipulatora_VZAD THEN
				P1_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF	
		
		
			
			
			//Odobratie skrutky M4//
		440:
			SC_P1_Srobovanie.StepName:='440 - Automaticky Rezim - odobratie skrtuky M4, napolohovanie zadnej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM4; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 442;
				END_IF	
			END_IF	
		
	
		442:
			SC_P1_Srobovanie.StepName:='442 - Automaticky Rezim - odobratie skrutky M4, kontrola skrutky M4 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			
			IF P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 450;
			ELSIF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 447;
			ELSIF NOT P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 445;
			END_IF	
			
			
			
			
		445:
			SC_P1_Srobovanie.StepName:='445 - Automaticky Rezim - odobratie skrutky M4, cakam na podanie skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 442;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN	
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF		
			
	
			
			
			
		447:
			SC_P1_Srobovanie.StepName:='447 - Automaticky Rezim - odobratie skrutky M4,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 448;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P1_Alarmy[121]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;	
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 448;
			END_IF
		
			
		448:
			SC_P1_Srobovanie.StepName:='448 - Automaticky Rezim - odobratie skrutky M4,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 450;
				END_IF	
			END_IF	
		
		
			
		450:
			SC_P1_Srobovanie.StepName:='450 - Automaticky Rezim - odobratie skrutky M4,priprava skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
				
			P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 455;
					
			
			
		455:
			SC_P1_Srobovanie.StepName:='455 - Automaticky Rezim - odobratie skrutky M4, cakam na zrusenie signalu odober skrutku M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
			
			IF NOT P1_Srobovanie.COM_IN.OdoberSkrutku_M4 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF		
			
	
					
			//Odobratie skrutky M5//
		460:
			SC_P1_Srobovanie.StepName:='460 - Automaticky Rezim - odobratie skrutky M5, napolohovanie strednej skrutkovacky M5 na poziciu odobratia skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= P1_RemPremenne.P1_Srob_PozX_OdobratSkrutkyM5; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= P1_RemPremenne.P1_Srob_PozY_OdobratSkrutkyM5; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				IF P1_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 700;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 462;
				END_IF	
			END_IF	
	
		462:
			SC_P1_Srobovanie.StepName:='462 - Automaticky Rezim - odobratie skrutky M5, kontrola skrutky M5 na vystupe podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 470;
			ELSIF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 465;
			ELSIF NOT P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 464;
			END_IF	
			
	
			
		
			
		464:
			SC_P1_Srobovanie.StepName:='464 - Automaticky Rezim - model 5H, cakam na podanie skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			IF P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 462;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;		
			END_IF		
			
			
			
			
			
			
		465:
			SC_P1_Srobovanie.StepName:='465 - Automaticky Rezim - odobratie skrutky M5,vysunutie skrutkovacky pre odobratie skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#10s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= P1_RemPremenne.P1_Srob_PozZ_OdobratSkrutkyM5;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 468;
			ELSIF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P1_Alarmy[120]:= TRUE;
				P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 468;
			END_IF
		
			
		468:
			SC_P1_Srobovanie.StepName:='468 - Automaticky Rezim - odobratie skrutky M5,zasunutie skrutkovacky po odobrati skrutky M5 z podavaca';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				IF P1_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P1_Pracovisko.STAV.Porucha_ST2:= TRUE;
				ELSE	
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 470;
				END_IF	
			END_IF	
		
			
		470:
			SC_P1_Srobovanie.StepName:='470 - Automaticky Rezim - odobratie skrutky M5,priprava skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
			SC_P1_Srobovanie.ResetStep:= TRUE;
			SC_P1_Srobovanie.Step:= 473;
				
			
			
				
		473:
			SC_P1_Srobovanie.StepName:='473 - Automaticky Rezim - odobratie skrutky M5, cakam na zrusenie signalu odober skrutku M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
			
			IF NOT P1_Srobovanie.COM_IN.OdoberSkrutku_M5 THEN
				P1_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				P1_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 100;
			END_IF			
			
			
			
			
			
			
			
			
			
		
			//*********************************************************Èistenie skrutkovaèiek*****************************************************************************//			
			
			
			//Èistenie skrutkovaèky K30//
		500:
			SC_P1_Srobovanie.StepName:='500 - Automaticky Rezim - cistenie skrutkovacky K30,kontrola zrusenia stavu serva v pozicii';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
			P1_Srobovanie.STAV.CistenieSkrutkovackyK30_BUSY:= TRUE;
			P1_Srobovanie.STAV.SkrutkaK30_READY:= FALSE;
			
			IF NOT P1_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 501;
			END_IF	
			
		501:
			SC_P1_Srobovanie.StepName:='501 - Automaticky Rezim - cistenie skrutkovacky K30,presun na poziciu zahodenia skrutky';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 3; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 502;
			END_IF	
			
		502:
			SC_P1_Srobovanie.StepName:='502 - Automaticky Rezim - cistenie skrutkovacky K30,vysunutie skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= TRUE;
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= TRUE;
				SC_P1_Srobovanie.IdleTime.IN:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P1_Srobovanie.IdleTime.Q THEN
				P1_Srobovanie.OUT.Skrutkovacka_K30_Prisavanie_ON:= FALSE;
				SC_P1_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P1_Srobovanie.AlarmTime.Q THEN
				P1_Srobovanie.OUT.Skrutkovacku_K30_VYSUN:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 505;
			END_IF	
		
		505:
			SC_P1_Srobovanie.StepName:='505 - Automaticky Rezim - cistenie skrutkovacky K30,nabitie skrutky do skrutkovacky K30';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Srobovanie.IN.Skrutkovacka_K30_ZASUNUTA THEN
				IF P1_Srobovanie.Manual THEN
					P1_Srobovanie.CMD.RR_SkrutSetK30_PodajSkrutku:= TRUE;
				ELSE
					P1_Srobovanie.CMD.PodajSkrutku_K30:= TRUE;
				END_IF	
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P1_Srobovanie.STAV.SkrutkaK30_READY THEN
				P1_Srobovanie.STAV.CistenieSkrutkovackyK30_BUSY:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= FazaNavratu;
			ELSIF P1_Srobovanie.SkrutSet_K30.Error.ErrorBit THEN
				P1_Alarmy[119]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF	
		
			
			
			//Èistenie skrutkovaèky M4//
		520:
			SC_P1_Srobovanie.StepName:='520 - Automaticky Rezim - cistenie skrutkovacky M4,kontrola zrusenia stavu serva v pozicii';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P1_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 521;
			END_IF	
		
		
		521:	
			SC_P1_Srobovanie.StepName:='521 - Automaticky Rezim - cistenie skrutkovacky M4,presun manipulatora na poziciu zahodenia skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 12; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 523;
			END_IF	
			
		
			
		523:
			SC_P1_Srobovanie.StepName:='523 - Automaticky Rezim - cistenie skrutkovacky M4, vysuvam skrutkovac M4 a vypinam prisavanie skrutky,priprava skrutky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
					
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 105;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P1_Srobovanie.CMD.PodajSkrutku_M4:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF EDGEPOS(P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 525;
			END_IF	
				
		525:
			SC_P1_Srobovanie.StepName:='525 - Automaticky Rezim - cistenie skrutkovacky M4, otretie skrutkovacky M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition AND NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK  THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 528;
			END_IF	
			
			
			
	
		528:
			SC_P1_Srobovanie.StepName:='528 - Automaticky Rezim - cistenie skrutkovacky M4, zasuvam skrutkovac M4';
			SC_P1_Srobovanie.IdleTime.PT:= T#2s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#30s;
			
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M4_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P1_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P1_Srobovanie.SkrutSet_M4.IN.Podavac_SkrutkaNaVystupe AND NOT P1_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= FazaNavratu;
			ELSIF P1_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P1_Alarmy[121]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;		
			END_IF	
			
		
	
			
			
			
				
			
			
			//Èistenie skrutkovaèky M5//
		
		540:
			SC_P1_Srobovanie.StepName:='540 - Automaticky Rezim - cistenie skrutkovacky M5,kontrola zrusenia stavu serva v pozicii';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P1_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 541;
			END_IF		
			
			
			
		541:
			SC_P1_Srobovanie.StepName:='541 - Automaticky Rezim - cistenie skrutkovacky M5, presun manipulatora na poziciu zahodenia skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			IF NOT P1_Srobovanie.Manual THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000; // m/s
				P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000; // m/s
			END_IF
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 15; //mm
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 67; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 543;
			END_IF	
			
		543:
			SC_P1_Srobovanie.StepName:='543 - Automaticky Rezim - cistenie skrutkovacky M5, vysuvam skrutkovac M5 a vypinam prisavanie skrutky,priprava skrutky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 106;
			
			IF NOT SC_P1_Srobovanie.Switch1 AND P1_Srobovanie.ServoManipulOsZ_M5.Status.Ready THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				P1_Srobovanie.CMD.PodajSkrutku_M5:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 544;
			END_IF	
				
			
			
			
		544:
			SC_P1_Srobovanie.StepName:='544 - Automaticky Rezim - cistenie skrutkovacky M5, otretie skrutkovacky M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#1s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsX_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0; //mm
			
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsY_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 67; //mm
			
			IF NOT SC_P1_Srobovanie.Switch1 THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P1_Srobovanie.ServoManipulOsX.Status.InPosition AND P1_Srobovanie.ServoManipulOsY.Status.InPosition AND NOT P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= 545;
			END_IF	
			
			
			
			
			
		545:
			SC_P1_Srobovanie.StepName:='545 - Automaticky Rezim - cistenie skrutkovacky M5, zasuvam skrutkovac M5';
			SC_P1_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
			
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_RemPremenne.P1_ManipSrob_OsZ_M5_Rychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
			
			IF NOT SC_P1_Srobovanie.Switch1  THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
				SC_P1_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P1_Srobovanie.ServoManipulOsZ_M5.Status.InPosition AND P1_Srobovanie.SkrutSet_M5.IN.Podavac_SkrutkaNaVystupe AND NOT P1_Srobovanie.IN.Skrutkovacka_M5_Vakum_OK THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				SC_P1_Srobovanie.ResetStep:= TRUE;
				SC_P1_Srobovanie.Step:= FazaNavratu;
			ELSIF P1_Srobovanie.SkrutSet_M5.STAV.ERROR THEN
				P1_Alarmy[120]:= TRUE;
				P1_Pracovisko.STAV.Porucha_ST2:= TRUE;	
			END_IF	
			
			
			
			
			
			
			
			
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P1_Srobovanie.StepName:='700 - Manualny Rezim';
			SC_P1_Srobovanie.IdleTime.PT:= T#8s;
			SC_P1_Srobovanie.AlarmTime.PT:= T#5s;
		
			
			
			
				
			//Ovládanie manipulátora os X//
			P1_Srobovanie.ServoManipulOsX.Parameters.Acc:= 1;
			P1_Srobovanie.ServoManipulOsX.Parameters.Dcc:= 1;
			P1_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P1_Srobovanie.PAR.ManipulOsX_JoggRychlost/1000;
			P1_Srobovanie.ServoManipulOsX.Command.TorqueLimitation:= TRUE;
			P1_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1;
			
			IF P1_Srobovanie.CMD.RR_Manipulator_OsX_VPRAVO AND NOT P1_Srobovanie.ServoManipulOsX.Command.Stop AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 45;
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
			ELSIF P1_Srobovanie.CMD.RR_Manipulator_OsX_VLAVO AND NOT P1_Srobovanie.ServoManipulOsX.Command.Stop AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsX.Parameters.Position:= 0;
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
			ELSE
				P1_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsX.Command.Stop:= TRUE;
			END_IF	
					
			IF P1_Srobovanie.ServoManipulOsX.Command.Stop AND P1_Srobovanie.ServoManipulOsX.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsX.Command.Stop:= FALSE;
			END_IF	
			
			
			//Ovládanie manipulátora os Y//
			P1_Srobovanie.ServoManipulOsY.Parameters.Acc:= 1;
			P1_Srobovanie.ServoManipulOsY.Parameters.Dcc:= 1;
			P1_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P1_Srobovanie.PAR.ManipulOsY_JoggRychlost/1000;
			P1_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
			P1_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1;
			
			IF P1_Srobovanie.CMD.RR_Manipulator_OsY_VPRED AND NOT P1_Srobovanie.ServoManipulOsY.Command.Stop AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 328;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			ELSIF P1_Srobovanie.CMD.RR_Manipulator_OsY_VZAD AND NOT P1_Srobovanie.ServoManipulOsY.Command.Stop AND P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P1_Srobovanie.ServoManipulOsY.Parameters.Position:= 0;
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			ELSE
				P1_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsY.Command.Stop:= TRUE;
			END_IF	
					
			IF P1_Srobovanie.ServoManipulOsY.Command.Stop AND P1_Srobovanie.ServoManipulOsY.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsY.Command.Stop:= FALSE;
			END_IF		
			
			
			
			
			//Ovládanie vysunutia skrutkovaèky M4//
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Acc:= 1;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Dcc:= 1;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P1_Srobovanie.PAR.ManipulOsZ_M4_JoggRychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M4.Command.TorqueLimitation:= TRUE;
			P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1;
			
			IF P1_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_DOLE AND NOT P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 100;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
			ELSIF P1_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_HORE AND NOT P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
			ELSE
				P1_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop:= TRUE;
			END_IF	
					
			IF P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop AND P1_Srobovanie.ServoManipulOsZ_M4.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsZ_M4.Command.Stop:= FALSE;
			END_IF	
			
		
	
				
            
			//Ovládanie vysunutia skrutkovaèky M5//
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Acc:= 1;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Dcc:= 1;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Velocity:= P1_Srobovanie.PAR.ManipulOsZ_M5_JoggRychlost/1000;
			P1_Srobovanie.ServoManipulOsZ_M5.Command.TorqueLimitation:= TRUE;
			P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Torque:= 1;
			
			IF P1_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_DOLE AND NOT P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 100;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
			ELSIF P1_Srobovanie.CMD.RR_SkrutkovackaM5_OsZ_HORE AND NOT P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Parameters.Position:= 0;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= TRUE;
			ELSE
				P1_Srobovanie.ServoManipulOsZ_M5.Command.MovePosition:= FALSE;
				P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= TRUE;
			END_IF	
					
			IF P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop AND P1_Srobovanie.ServoManipulOsZ_M5.Status.StandStill THEN
				P1_Srobovanie.ServoManipulOsZ_M5.Command.Stop:= FALSE;
			END_IF	
			
			       
						      
        
			//Prisávanie skrutky M5//
			IF P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON THEN
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON:= FALSE;
			ELSIF P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_OFF THEN
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_OFF:= TRUE;
				P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_OFF:= FALSE;
			END_IF    
		
			
			//Prisávanie skrutky M4//
			IF P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_ON THEN
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_ON:= FALSE;
			ELSIF P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_OFF THEN
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P1_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P1_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_OFF:= FALSE;
			END_IF    
			
			
			//Èistenie skrutkovaèky K30//
			IF P1_Srobovanie.CMD.RR_CistenieSkrutkovackyK30 THEN
				IF P1_Pracovisko.STAV.SkrutkovackyZasunute AND Safety.STAV.P1_ZonaBunky_AKTIVNA THEN
					FazaNavratu:= 700;
					SC_P1_Srobovanie.ResetStep:= TRUE;
					SC_P1_Srobovanie.Step:= 500;
				END_IF
				P1_Srobovanie.CMD.RR_CistenieSkrutkovackyK30:= FALSE;
			END_IF	
			
			
				
			
        
			//**********************Polohovanie na pozície skrutiek*****************************//
			IF P1_Srobovanie.CMD.RR_PolohujManipulator THEN 
				IF P1_Pracovisko.STAV.SkrutkovackyZasunute THEN
					IF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 0 THEN  //Lavá K30 - 45F
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 110;
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 1 THEN  //Pravá K30 - 45F
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 130;    
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 2 THEN  //Zadná M4 - 4F
						P1_Srobovanie.PAR.RR_TypModelu:= '4F';
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 160; 
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 3 THEN  //Predná M4 - 4F
						P1_Srobovanie.PAR.RR_TypModelu:= '4F';
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 180;  
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 4 THEN  //Stredná M4 - 45F
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 200;  
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 5 THEN  //Zadná M4 - 5F
						P1_Srobovanie.PAR.RR_TypModelu:= '5F';
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 160; 
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 6 THEN  //Predná M4 - 5F
						P1_Srobovanie.PAR.RR_TypModelu:= '5F';
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 180; 
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 7 THEN  //Lavá K30 - 5H
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 210;
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 8 THEN  //Pravá K30 - 5H
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 230;
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 9 THEN  //Lavá M5 - 5H
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 260;
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 10 THEN  //Pravá M5 - 5H
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 280;
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 11 THEN  //Stredna M5 - 5H
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 300;	
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 12 THEN  //Pozicia odobratia skrutky M4
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 440;
					ELSIF P1_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 13 THEN  //Pozicia odobratia skrutky M5
						P1_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P1_Srobovanie.ResetStep:= TRUE;
						SC_P1_Srobovanie.Step:= 460;
					END_IF	
				END_IF	
				P1_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			END_IF	
					
		
		                    
	
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

