
PROGRAM _INIT
	
	//Init parametre serva manipulátora Os X//
	P2_Srobovanie.ServoManipulOsX.Parameters.Override:= 100;
	P2_Srobovanie.PAR.ManipulOsX_JoggRychlost:= 0.1;
	P2_Srobovanie.ServoManipulOsX.Command.TorqueLimitation:= TRUE;
	P2_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1.0;
	
	//Init parametre serva manipulátora Os Y//
	P2_Srobovanie.ServoManipulOsY.Parameters.Override:= 100;
	P2_Srobovanie.PAR.ManipulOsY_JoggRychlost:= 0.1;	
	P2_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
	P2_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
	
	//Init parametre serva zdvihu skrutkovacky M4//
	P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Override:= 100;
	P2_Srobovanie.PAR.ManipulOsZ_M4_JoggRychlost:= 0.1;
	P2_Srobovanie.ServoManipulOsZ_M4.Command.TorqueLimitation:= TRUE;
	P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
	
	
	
		
	
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Volanie podprogramov//
	AtlasCopcoKomunikacia;	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_Srobovanie);
	
	
	//Enable serv//
	IF Safety.STAV.P2_ZonaBunky_AKTIVNA AND NOT P2_Srobovanie.ServoManipulOsX.Command.ErrReset AND P2_Pracovisko.IN.ServoManipulatorOsX_KomOK THEN
		P2_Srobovanie.ServoManipulOsX.Command.PowerON:= TRUE;
	ELSE
		P2_Srobovanie.ServoManipulOsX.Command.PowerON:= FALSE;
	END_IF
	
	IF Safety.STAV.P2_ZonaBunky_AKTIVNA AND NOT P2_Srobovanie.ServoManipulOsY.Command.ErrReset AND P2_Pracovisko.IN.ServoManipulatorOsY_KomOK THEN
		P2_Srobovanie.ServoManipulOsY.Command.PowerON:= TRUE;
	ELSE
		P2_Srobovanie.ServoManipulOsY.Command.PowerON:= FALSE;
	END_IF
	
	IF Safety.STAV.P2_ZonaBunky_AKTIVNA AND NOT P2_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset AND P2_Pracovisko.IN.ServoManipulatorOsZ_M4_KomOK THEN
		P2_Srobovanie.ServoManipulOsZ_M4.Command.PowerON:= TRUE;
	ELSE
		P2_Srobovanie.ServoManipulOsZ_M4.Command.PowerON:= FALSE;
	END_IF	
	
	
	//Reset poruchy serv//
	IF P2_Srobovanie.ServoManipulOsX.Command.ErrReset AND NOT P2_Srobovanie.ServoManipulOsX.Status.Error THEN
		P2_Srobovanie.ServoManipulOsX.Command.ErrReset:= FALSE;
	END_IF
	
	IF P2_Srobovanie.ServoManipulOsY.Command.ErrReset AND NOT P2_Srobovanie.ServoManipulOsY.Status.Error THEN
		P2_Srobovanie.ServoManipulOsY.Command.ErrReset:= FALSE;
	END_IF
	
	IF P2_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset AND NOT P2_Srobovanie.ServoManipulOsZ_M4.Status.Error THEN
		P2_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset:= FALSE;
	END_IF
	
	
	
	//Reset poruchy skrutkovacích setov//	
	IF P2_Srobovanie.SkrutSet_M4.CMD.ResetPoruchy AND NOT P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
		P2_Srobovanie.SkrutSet_M4.CMD.ResetPoruchy:= FALSE;
	END_IF	
	

	//Reset sekcie //
	IF P2_Srobovanie.Reset THEN
		SC_P2_Srobovanie.Step:= 0;
		P2_Srobovanie.ServoManipulOsX.Command.ErrReset:= TRUE;
		P2_Srobovanie.ServoManipulOsY.Command.ErrReset:= TRUE;
		P2_Srobovanie.ServoManipulOsZ_M4.Command.ErrReset:= TRUE;
		P2_Srobovanie.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_Srobovanie.Step:= 0;
	ELSIF NOT Safety.STAV.P2_ZonaBunky_AKTIVNA THEN
		SC_P2_Srobovanie.Step:= 0;
	END_IF	
	
	
	CASE SC_P2_Srobovanie.Step OF 
		
		0:
			SC_P2_Srobovanie.StepName:='0 - Nulovanie';
			P2_Srobovanie.Automat:= FALSE;
			P2_Srobovanie.KoniecCyklu:= FALSE;
			P2_Srobovanie.Manual:= FALSE;
			P2_Srobovanie.STAV.PoINIT:= FALSE;
			
			P2_Srobovanie.OUT.Skrutkovacka_M4_Odvzdusn_ON:= FALSE;
			IF NOT P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN 
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
			END_IF	
			P2_Srobovanie.OUT.Skrutkovacka_M5_Odvzdusn_ON:= FALSE;
			P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
			P2_Srobovanie.OUT.Skrutkovacka_M6_Odvzdusn_ON:= FALSE;
			P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= FALSE;
			P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= FALSE;
			P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Command.JogNeg:= FALSE;
			P2_Srobovanie.ServoManipulOsX.Command.JogPos:= FALSE;
			P2_Srobovanie.ServoManipulOsX.Command.MoveAdditive:= FALSE;
			P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
			IF NOT P2_Srobovanie.ServoManipulOsX.Status.StandStill THEN
				P2_Srobovanie.ServoManipulOsX.Command.Stop:= TRUE;
			END_IF	
			P2_Srobovanie.ServoManipulOsY.Command.JogNeg:= FALSE;
			P2_Srobovanie.ServoManipulOsY.Command.JogPos:= FALSE;
			P2_Srobovanie.ServoManipulOsY.Command.MoveAdditive:= FALSE;
			P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
			IF NOT P2_Srobovanie.ServoManipulOsY.Status.StandStill THEN
				P2_Srobovanie.ServoManipulOsY.Command.Stop:= TRUE;
			END_IF	
			P2_Srobovanie.ServoManipulOsZ_M4.Command.JogNeg:= FALSE;
			P2_Srobovanie.ServoManipulOsZ_M4.Command.JogPos:= FALSE;
			P2_Srobovanie.ServoManipulOsZ_M4.Command.MoveAdditive:= FALSE;
			P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
			IF NOT P2_Srobovanie.ServoManipulOsZ_M4.Status.StandStill THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.Stop:= TRUE;
			END_IF	
						
			
			P2_Srobovanie.CMD.RR_SkrutkovackuM6_VYSUN:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutkovackuM5_VYSUN:= FALSE;
			P2_Srobovanie.CMD.RR_Manipulator_OsX_VLAVO:= FALSE;
			P2_Srobovanie.CMD.RR_Manipulator_OsX_VPRAVO:= FALSE;
			P2_Srobovanie.CMD.RR_Manipulator_OsY_VPRED:= FALSE;
			P2_Srobovanie.CMD.RR_Manipulator_OsY_VZAD:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_DOLE:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_HORE:= FALSE;
			
			P2_Srobovanie.CMD.RR_PrisavanieSkrutkyM6_ON:= FALSE;
			P2_Srobovanie.CMD.RR_PrisavanieSkrutkyM5_ON:= FALSE;
			P2_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_ON:= FALSE;
			P2_Srobovanie.CMD.RR_CistenieSkrutkovackyM5:= FALSE;
			P2_Srobovanie.CMD.RR_CistenieSkrutkovackyM6:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM6_PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN:= FALSE;	
			P2_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup:= FALSE;
			P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup:= FALSE;
			P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
			P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora:= 1;
			
			P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= FALSE;
			P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
			P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
			P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= FALSE;
			P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
			P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
			P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= FALSE;
			
			P2_Srobovanie.Skrutkovacka_M6.RESET_Poruchy:= FALSE;
			P2_Srobovanie.Skrutkovacka_M6.RESET_Vysledkov:= FALSE;
			P2_Srobovanie.Skrutkovacka_M6.START_Skrutkovania:= FALSE;
			P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;			
			P2_Srobovanie.Skrutkovacka_M4.RESET_Poruchy:= FALSE;
			P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
			P2_Srobovanie.Skrutkovacka_M4.START_Skrutkovania:= FALSE;
			P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
			P2_Srobovanie.Skrutkovacka_M5.RESET_Poruchy:= FALSE;
			P2_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
			P2_Srobovanie.Skrutkovacka_M5.START_Skrutkovania:= FALSE;
			P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;			
						
			P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
			P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
			P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= FALSE;
			P2_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
			
			FazaNavratu:= 0;
			CasSrobovania:= 0;
			PocetCisteniSkrutkovacky:= 0;
									
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				Safety.STAV.P2_ZonaBunky_AKTIVNA AND
				P2_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND
				NOT P2_Pracovisko.STAV.Porucha_ST5 AND
				P2_Srobovanie.ServoManipulOsX.Status.Ready AND P2_Srobovanie.ServoManipulOsX.Status.StandStill AND
				P2_Srobovanie.ServoManipulOsY.Status.Ready AND P2_Srobovanie.ServoManipulOsY.Status.StandStill AND
				P2_Srobovanie.ServoManipulOsZ_M4.Status.Ready AND P2_Srobovanie.ServoManipulOsZ_M4.Status.StandStill THEN
				P2_Srobovanie.ServoManipulOsX.Command.Stop:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.Stop:= FALSE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.Stop:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 1;
			END_IF
	
		1:
			SC_P2_Srobovanie.StepName:='1 - Cakam na spustenie vyroby';
			P2_Srobovanie.KoniecCyklu:= FALSE;
			IF P2_Srobovanie.Automat THEN
				SC_P2_Srobovanie.Step:= 2;
			ELSIF P2_Srobovanie.Manual THEN
				SC_P2_Srobovanie.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
		
		2:
			SC_P2_Srobovanie.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
			P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= TRUE;
			P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= TRUE;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Acc:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Acc;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Dcc:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Dcc;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsX.Parameters.Acc:= P2_RemPremenne.P2_ManipSrob_OsX_Acc;
			P2_Srobovanie.ServoManipulOsX.Parameters.Dcc:= P2_RemPremenne.P2_ManipSrob_OsX_Dcc;
			P2_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsY.Parameters.Acc:= P2_RemPremenne.P2_ManipSrob_OsY_Acc;
			P2_Srobovanie.ServoManipulOsY.Parameters.Dcc:= P2_RemPremenne.P2_ManipSrob_OsY_Dcc;
			P2_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
			
			
			
			
		
			IF P2_Robot.COM_IN.Stav_RobotBezpPozicia_Srobovanie AND P2_Robot.STAV.PoINIT THEN
				P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 3;
			END_IF
		
		
		3:
			SC_P2_Srobovanie.StepName:='3 - Inicializacia - zasunutie skrutkovacky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 5;
			END_IF
		
		
		5:
			SC_P2_Srobovanie.StepName:='5 - Inicializacia - presun manipulatora do vychodiskovej pozicie k motoru';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 12.5;
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 4.5;
		
				
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 6;
			END_IF	
			
		
		6:
			SC_P2_Srobovanie.StepName:='6 - Inicializacia - cakam na zrusenie stavu serva v pozicii';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
		
			IF NOT P2_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 20;
			END_IF	
		
		20:
			SC_P2_Srobovanie.StepName:='20 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 35; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 85; //mm
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 22;
			END_IF	
			
		22:
			SC_P2_Srobovanie.StepName:='22 - Inicializacia - vysunutie skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#1s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P2_Srobovanie.IdleTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 25;
			END_IF	
		
		25:
			SC_P2_Srobovanie.StepName:='25 - Inicializacia - nabitie skrutky do skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M5_ZASUNUTA THEN
				IF Linka.PAR.ZvolenyModel = '5H' THEN
					IF NOT SC_P2_Srobovanie.Switch1 THEN
						P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= TRUE;
						SC_P2_Srobovanie.Switch1:= TRUE;
					END_IF	
				ELSE
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 28;
				END_IF	
			END_IF
			
			
			IF P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 28;
			ELSIF P2_Srobovanie.SkrutSet_M5.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
				P2_Alarmy[238]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF	
		
		28:
			SC_P2_Srobovanie.StepName:='28 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 23; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 30;
			END_IF	
			
		
			
		30:
			SC_P2_Srobovanie.StepName:='30 - Inicializacia - vysuvam skrutkovac M4 a vypinam prisavanie skrutky,priprava skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
					
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 99;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 31;
			END_IF	
				
			
	
			
		31:
			SC_P2_Srobovanie.StepName:='31 - Inicializacia - otretie skrutkovacky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 5; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 32;
			END_IF	
			
			
			
			
			
			
			
	
		32:
			SC_P2_Srobovanie.StepName:='32 - Inicializacia - zasuvam skrutkovac M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
				
			
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena AND NOT P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 40;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;	
			END_IF
			
			
			
			
			
		
		40:
			SC_P2_Srobovanie.StepName:='40 - Inicializacia - presun manipulatora na poziciu zahodenia skrutky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 35; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 5; //mm
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 42;
			END_IF	
			
		42:
			SC_P2_Srobovanie.StepName:='42 - Inicializacia - vysunutie skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#1s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P2_Srobovanie.IdleTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 45;
			END_IF	
		
		45:
			SC_P2_Srobovanie.StepName:='45 - Inicializacia - nabitie skrutky do skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Srobovanie.IN.Skrutkovacka_M6_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 60;
			ELSIF P2_Srobovanie.SkrutSet_M6.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
				P2_Alarmy[239]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
			END_IF	
	
			
					
			
		60:
			SC_P2_Srobovanie.StepName:='60 - Inicializacia - presun manipulatora do vychodiskovej pozicie k motoru';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 12.5;
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 0;
		
				
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 62;
			END_IF	
			
		
		62:
			SC_P2_Srobovanie.StepName:='62 - Inicializacia - cakam na zrusenie stavu serva v pozicii';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
		
			IF NOT P2_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.STAV.PoINIT:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
		
			//********************************************************Automatický režim****************************************************************************//
		
		
		100:  
			SC_P2_Srobovanie.StepName:='100 - Automaticky Rezim - cakam na spustenie cinnosti';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;			
	
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= TRUE;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Acc:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Acc;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Dcc:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Dcc;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsX.Parameters.Acc:= P2_RemPremenne.P2_ManipSrob_OsX_Acc;
			P2_Srobovanie.ServoManipulOsX.Parameters.Dcc:= P2_RemPremenne.P2_ManipSrob_OsX_Dcc;
			P2_Srobovanie.ServoManipulOsX.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsY.Parameters.Acc:= P2_RemPremenne.P2_ManipSrob_OsY_Acc;
			P2_Srobovanie.ServoManipulOsY.Parameters.Dcc:= P2_RemPremenne.P2_ManipSrob_OsY_Dcc;
			P2_Srobovanie.ServoManipulOsY.Parameters.Torque:= 1.0;
				
			
			
			
			IF P2_Srobovanie.KoniecCyklu AND NOT P2_StoperSrobovania.Automat THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 0;
			ELSIF P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM6 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 110;
			ELSIF P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM6 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 130;
			ELSIF P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM4 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 150;
			ELSIF P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM4 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 170;
			ELSIF P2_Srobovanie.COM_IN.Model5H_ZaskrutkujLavuM5 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 200;
			ELSIF P2_Srobovanie.COM_IN.Model5H_ZaskrutkujPravuM5 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 220;
			ELSIF P2_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednuM4 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 240;
			ELSIF P2_Srobovanie.COM_IN.PresunManipulatora_VPRED THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 400;
			ELSIF P2_Srobovanie.COM_IN.PresunManipulatora_VZAD THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 420;
			ELSIF P2_Srobovanie.COM_IN.OdoberSkrutku_M4 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 440;	
			END_IF	
			
				
			//**********************************************************************Model 45F*******************************************************************************************//	
			//Zaskrutkovanie lavej skrutky M6//	
		
		110:
			SC_P2_Srobovanie.StepName:='110 - Automaticky Rezim - model 45F, napolohovanie prednej skrutkovacky M6 na poziciu lavej skrutky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
									
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			
									
			IF Linka.PAR.ZvolenyModel = '4F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_LavejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_LavejSkrutkyM6; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '4F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_LavejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_LavejSkrutkyM6; //mm
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_LavejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_LavejSkrutkyM6; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '5F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN	
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_LavejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_LavejSkrutkyM6; //mm
			END_IF	
			
			
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 125;
			ELSIF P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 113;
				END_IF	
			END_IF	
		
		
		113:
			SC_P2_Srobovanie.StepName:='113 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M6.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M6.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M6.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 115;
			END_IF	
		
		115:
			SC_P2_Srobovanie.StepName:='115 - Automaticky Rezim - model 45F, kontrola skrutky M6 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#5s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
            
			IF P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena AND P2_Srobovanie.Skrutkovacka_M6.Stav_READY_to_START THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 118;
			ELSIF P2_Srobovanie.SkrutSet_M6.Error.ErrorBit THEN
				P2_Alarmy[239]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 125;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				IF NOT P2_Srobovanie.Skrutkovacka_M6.Stav_READY_to_START THEN
					P2_Alarmy[277]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 125;
				ELSIF NOT P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena THEN
					P2_Alarmy[239]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 125;
				END_IF	
			END_IF	
		
		
		118:
			SC_P2_Srobovanie.StepName:='118 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			SC_P2_Srobovanie.AlarmTime.IN:= (P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia < 5);
            
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= TRUE;
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P2_Srobovanie.Skrutkovacka_M6.Stav_UtahovanieUkoncene AND P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia > 10 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 120;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[270]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 123;
			END_IF	
			
		120:
			SC_P2_Srobovanie.StepName:='120 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
                        
			IF P2_Srobovanie.Skrutkovacka_M6.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM6:= UINT_TO_STRING(P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia);
				Reports.Skrutkovacky.CasSkrutkovania.P2_LavaSkrutkaM6:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 123;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[274]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 123; 
			END_IF
		
		
		123:
			SC_P2_Srobovanie.StepName:='123 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M6 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.IN.Skrutkovacka_M6_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 125;
			END_IF
		
			
		125:
			SC_P2_Srobovanie.StepName:='125 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania lavej skrutky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 128;
			ELSIF P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 128;
			ELSIF P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 128;          
			END_IF	
		
		
		
		
		128:
			SC_P2_Srobovanie.StepName:='128 - Automaticky Rezim - model 45F, cakam na zrusenie signalu zaskrutkuj lavu skrutku M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM6 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
		
	
			//Zaskrutkovanie pravej skrutky M6//		
		
		130:
			SC_P2_Srobovanie.StepName:='130 - Automaticky Rezim - model 45F, napolohovanie prednej skrutkovacky M6 na poziciu pravej skrutky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
									
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			
									
			IF Linka.PAR.ZvolenyModel = '4F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_PravejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_PravejSkrutkyM6; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '4F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_PravejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_PravejSkrutkyM6; //mm
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_PravejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_PravejSkrutkyM6; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '5F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN	
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_PravejSkrutkyM6; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_PravejSkrutkyM6; //mm
			END_IF	
			
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 145;
			ELSIF P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 133;
				END_IF	
			END_IF	
		
		
		133:
			SC_P2_Srobovanie.StepName:='133 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M6.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M6.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M6.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 135;
			END_IF	
		
		135:
			SC_P2_Srobovanie.StepName:='135 - Automaticky Rezim - model 45F, kontrola skrutky M6 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#5s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
            
			IF P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena AND P2_Srobovanie.Skrutkovacka_M6.Stav_READY_to_START THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 138;
			ELSIF P2_Srobovanie.SkrutSet_M6.Error.ErrorBit THEN
				P2_Alarmy[239]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 145;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				IF NOT P2_Srobovanie.Skrutkovacka_M6.Stav_READY_to_START THEN
					P2_Alarmy[277]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 145;
				ELSIF NOT P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena THEN
					P2_Alarmy[239]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 145;
				END_IF	
			END_IF	
		
		
		138:
			SC_P2_Srobovanie.StepName:='138 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			SC_P2_Srobovanie.AlarmTime.IN:= (P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia < 5);
            
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= TRUE;
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P2_Srobovanie.Skrutkovacka_M6.Stav_UtahovanieUkoncene AND P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia > 10 THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 140;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[270]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 143;
			END_IF	
			
		140:
			SC_P2_Srobovanie.StepName:='140 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
                        
			IF P2_Srobovanie.Skrutkovacka_M6.Stav_UtahovanieUkoncene AND NOT P2_Robot.COM_IN.Stav_BusbaryUvolnene THEN
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM6:= UINT_TO_STRING(P2_Srobovanie.PAR.Skrutkov_M6_AktualHodnVysunutia);
				Reports.Skrutkovacky.CasSkrutkovania.P2_PravaSkrutkaM6:= REAL_TO_STRING(CasSrobovania/1000);
				IF P2_Robot.STAV.PoINIT THEN
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 142;
				ELSE
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 143;
				END_IF	
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[274]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M6.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				IF P2_Robot.COM_IN.Stav_ProgramRUN THEN
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 142;
				ELSE
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 143;
				END_IF	
			END_IF
		
		142:
			SC_P2_Srobovanie.StepName:='142 - Automaticky Rezim - model 45F, uvolnenie busbarov';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
            
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Robot.COM_OUT.UvolniBusbary:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
            
			IF P2_Robot.COM_IN.Stav_BusbaryUvolnene THEN
				P2_Robot.COM_OUT.UvolniBusbary:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 143;
			END_IF
			
			
			
		
		143:
			SC_P2_Srobovanie.StepName:='143 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M6 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.IN.Skrutkovacka_M6_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 145;
			END_IF
		
		
	
		145:
			SC_P2_Srobovanie.StepName:='145 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania pravej skrutky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 148;
			ELSIF P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 148;
			ELSIF P2_Srobovanie.Skrutkovacka_M6.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 148;          
			END_IF	
		
		
		
		
		148:
			SC_P2_Srobovanie.StepName:='148 - Automaticky Rezim - model 45F, cakam na zrusenie signalu zaskrutkuj pravu skrutku M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM6 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
		
			//Zaskrutkovanie lavej skrutky M4//		
		
		150:
			SC_P2_Srobovanie.StepName:='150 - Automaticky Rezim - model 45F, kontrola pritomnosti skrutky M4 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 160;
			ELSE
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 151;
			END_IF		
			
			
			
			
		151:
			SC_P2_Srobovanie.StepName:='151 - Automaticky Rezim - model 45F, napolohovanie lavej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob_PozX_OdobratSkrutkyM4; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 152;
			END_IF	
		
		
	
		152:
			SC_P2_Srobovanie.StepName:='152 - Automaticky Rezim - model 45F, kontrola skrutky M4 na vystupe podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 153;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 167;		
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
			END_IF	
			
					
			
		153:
			SC_P2_Srobovanie.StepName:='153 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P2_RemPremenne.P2_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 155;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 155;
			END_IF
		
			
		155:
			SC_P2_Srobovanie.StepName:='155 - Automaticky Rezim - model 45F,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 167;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 156;
				END_IF	
			END_IF	
		
			
		156:
			SC_P2_Srobovanie.StepName:='156 - Automaticky Rezim - model 45F,priprava skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
						
			IF SC_P2_Srobovanie.IdleTime.Q THEN	
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 160;
			END_IF
			
			
			
		160:
			SC_P2_Srobovanie.StepName:='160 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania lavej skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
								
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			
			IF Linka.PAR.ZvolenyModel = '4F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_LavejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_LavejSkrutkyM4; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '4F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_LavejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_LavejSkrutkyM4; //mm
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_LavejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_LavejSkrutkyM4; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '5F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN	
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_LavejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_LavejSkrutkyM4; //mm
			END_IF	
				
			
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 161;
				END_IF	
			END_IF	
			
			
			
		161:
			SC_P2_Srobovanie.StepName:='161 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 162;
			END_IF	
	
			
		162:
			SC_P2_Srobovanie.StepName:='162 - Automaticky Rezim - model 45F, kontrola skrutky M4 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 163;
			ELSE
				IF PocetCisteniSkrutkovacky < 3 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 150;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 520;
				ELSE
					P2_Alarmy[237]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 167;
				END_IF	
			END_IF	
			
		
				
			
		163:
			SC_P2_Srobovanie.StepName:='163 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M4 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 98;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 164;
			END_IF
			
			
			
		164:
			SC_P2_Srobovanie.StepName:='164 - Automaticky Rezim - model 45F, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_Srob45F_Rychl_LavejSkrutkyM4/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= P2_RemPremenne.P2_Srob45F_Mom_LavejSkrutkyM4;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 150;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InTorque THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 165;
			END_IF		
			
			
			
				
		165:
			SC_P2_Srobovanie.StepName:='165 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P2_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P2_LavaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 166;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN    
				P2_Alarmy[272]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 166;
			END_IF
			
		
				
		166:
			SC_P2_Srobovanie.StepName:='166 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M4 a vypnutie prisavania skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 167;
			END_IF	
		
			
				
		167:
			SC_P2_Srobovanie.StepName:='167 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania lavej skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 168; 
			ELSIF P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 168;
			ELSIF P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 168;          
			END_IF
		
		
		168:
			SC_P2_Srobovanie.StepName:='168 - Automaticky Rezim - model 4F, cakam na zrusenie signalu zaskrutkuj lavu skrutku M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model45F_ZaskrutkujLavuM4 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF
		
		
			//Zaskrutkovanie pravej skrutky M4//
		
		170:
			SC_P2_Srobovanie.StepName:='170 - Automaticky Rezim - model 45F, kontrola pritomnosti skrutky M4 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 180;
			ELSE
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 171;
			END_IF	
				
		
			
			
		171:
			SC_P2_Srobovanie.StepName:='171 - Automaticky Rezim - model 45F, napolohovanie lavej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob_PozX_OdobratSkrutkyM4; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 172;
			END_IF	
		
	
		172:
			SC_P2_Srobovanie.StepName:='172 - Automaticky Rezim - model 45F, kontrola skrutky M4 na vystupe podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 173;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 187;
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
			END_IF	
			
					
			
		173:
			SC_P2_Srobovanie.StepName:='173 - Automaticky Rezim - model 45F,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P2_RemPremenne.P2_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 175;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 175;
			END_IF
		
			
		175:
			SC_P2_Srobovanie.StepName:='175 - Automaticky Rezim - model 45F,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 187;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 176;
				END_IF	
			END_IF	
		
			
		176:
			SC_P2_Srobovanie.StepName:='156 - Automaticky Rezim - model 45F,priprava skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
						
			IF SC_P2_Srobovanie.IdleTime.Q THEN	
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 180;
			END_IF
			
			
			
		180:
			SC_P2_Srobovanie.StepName:='180 - Automaticky Rezim - model 45F, napolohovanie na poziciu skrutkovania pravej skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
						
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			
			IF Linka.PAR.ZvolenyModel = '4F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_PravejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_PravejSkrutkyM4; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '4F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozX_PravejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob4F_PozY_PravejSkrutkyM4; //mm
			ELSIF Linka.PAR.ZvolenyModel = '5F' AND NOT P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_PravejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_PravejSkrutkyM4; //mm
			ELSIF P2_Srobovanie.PAR.RR_TypModelu = '5F' AND P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN	
				P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozX_PravejSkrutkyM4; //mm
				P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5F_PozY_PravejSkrutkyM4; //mm
			END_IF	
				
			
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 181;
				END_IF	
			END_IF	
			
			
			
		181:
			SC_P2_Srobovanie.StepName:='181 - Automaticky Rezim - model 45F, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 182;
			END_IF	
	
			
		182:
			SC_P2_Srobovanie.StepName:='182 - Automaticky Rezim - model 45F, kontrola skrutky M4 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 183;
			ELSE
				IF PocetCisteniSkrutkovacky < 3 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 170;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 520;
				ELSE
					P2_Alarmy[237]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 187;
				END_IF	
			END_IF	
			
			
					
				
		183:
			SC_P2_Srobovanie.StepName:='183 - Automaticky Rezim - model 45F, vysunutie skrutkovacky M4 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 98;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 184;
			END_IF
			
			
			
		184:
			SC_P2_Srobovanie.StepName:='184 - Automaticky Rezim - model 45F, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_Srob45F_Rychl_PravejSkrutkyM4/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= P2_RemPremenne.P2_Srob45F_Mom_PravejSkrutkyM4;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 150;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InTorque) THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 185;
			END_IF		
				
			
			
		
				
		185:
			SC_P2_Srobovanie.StepName:='185 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P2_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P2_PravaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 186;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN    
				P2_Alarmy[272]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 186;
			END_IF
			
		
				
		186:
			SC_P2_Srobovanie.StepName:='186 - Automaticky Rezim - model 45F, zasunutie skrutkovacky M4 a vypnutie prisavania skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 187;
			END_IF	
		
			
				
		187:
			SC_P2_Srobovanie.StepName:='187 - Automaticky Rezim - model 45F, kontrola vysledkov skrutkovania pravej skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 188; 
			ELSIF P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 188;
			ELSIF P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 188;          
			END_IF
		
		
		188:
			SC_P2_Srobovanie.StepName:='188 - Automaticky Rezim - model 4F, cakam na zrusenie signalu zaskrutkuj pravu skrutku M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model45F_ZaskrutkujPravuM4 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF
		
		
			//**********************************************************************Model 5H*******************************************************************************************//	
			
			//Zaskrutkovanie lavej skrutky M5//	
		
		200:
			SC_P2_Srobovanie.StepName:='200 - Automaticky Rezim - model 5H, napolohovanie zadnej skrutkovacky M5 na poziciu lavej skrutky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5H_PozX_LavejSkrutkyM5; //mm	
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5H_PozY_LavejSkrutkyM5; //mm						
				
			
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 215;
			ELSIF P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 203;
				END_IF	
			END_IF	
		
		
		203:
			SC_P2_Srobovanie.StepName:='203 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 205;
			END_IF	
		
		205:
			SC_P2_Srobovanie.StepName:='205 - Automaticky Rezim - model 5H, kontrola skrutky M5 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#5s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
            
			IF P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena AND P2_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 208;
			ELSIF P2_Srobovanie.SkrutSet_M5.Error.ErrorBit THEN
				P2_Alarmy[238]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 215;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				IF NOT P2_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
					P2_Alarmy[276]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 215;
				ELSIF NOT P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena THEN
					P2_Alarmy[238]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 215;
				END_IF	
			END_IF	
		
		
		208:
			SC_P2_Srobovanie.StepName:='208 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			
			SC_P2_Srobovanie.AlarmTime.IN:= (P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia < 5);
            
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= TRUE;
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P2_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene (*AND P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia > 10*) THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 210;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[269]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 210;
			END_IF	
			
		210:
			SC_P2_Srobovanie.StepName:='120 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
                        
			IF P2_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_LavaSkrutkaM5:= UINT_TO_STRING(P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia);
				Reports.Skrutkovacky.CasSkrutkovania.P2_LavaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 213;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[273]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 213; 
			END_IF
		
		
		213:
			SC_P2_Srobovanie.StepName:='213 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#3s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.IN.Skrutkovacka_M5_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 215;
			END_IF
		
	
		
		215:
			SC_P2_Srobovanie.StepName:='215 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania lavej skrutky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 218;
			ELSIF P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 218;
			ELSIF P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 218;          
			END_IF	
		
		
		
		
		218:
			SC_P2_Srobovanie.StepName:='218 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj lavu skrutku M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model5H_ZaskrutkujLavuM5 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
		
			//Zaskrutkovanie pravej skrutky M5//	
		
		220:
			SC_P2_Srobovanie.StepName:='200 - Automaticky Rezim - model 5H, napolohovanie zadnej skrutkovacky M5 na poziciu pravej skrutky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5H_PozX_PravejSkrutkyM5; //mm	
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5H_PozY_PravejSkrutkyM5; //mm						
				
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 235;
			ELSIF P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 223;
				END_IF	
			END_IF	
		
		
		223:
			SC_P2_Srobovanie.StepName:='223 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M5.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 225;
			END_IF	
		
		225:
			SC_P2_Srobovanie.StepName:='225 - Automaticky Rezim - model 5H, kontrola skrutky M5 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#5s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#3M;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
            
			IF P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena AND P2_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 228;
			ELSIF P2_Srobovanie.SkrutSet_M5.Error.ErrorBit THEN
				P2_Alarmy[238]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 235;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				IF NOT P2_Srobovanie.Skrutkovacka_M5.Stav_READY_to_START THEN
					P2_Alarmy[276]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 235;
				ELSIF NOT P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena THEN
					P2_Alarmy[238]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 235;
				END_IF	
			END_IF	
		
		
		228:
			SC_P2_Srobovanie.StepName:='228 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			SC_P2_Srobovanie.AlarmTime.IN:= (P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia < 5);
            
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= TRUE;
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			
			IF NOT P2_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene (*AND P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia > 10*) THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 230;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[269]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 233;
			END_IF	
			
		230:
			SC_P2_Srobovanie.StepName:='230 - Automaticky Rezim - model 5H, cakam na ukoncenie skrutkovania skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
                        
			IF P2_Srobovanie.Skrutkovacka_M5.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_PravaSkrutkaM5:= UINT_TO_STRING(P2_Srobovanie.PAR.Skrutkov_M5_AktualHodnVysunutia);
				Reports.Skrutkovacky.CasSkrutkovania.P2_PravaSkrutkaM5:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 232;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Alarmy[273]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M5.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 232; 
			END_IF
		
			
		232:
			SC_P2_Srobovanie.StepName:='232 - Automaticky Rezim - model 5H, uvolnenie busbarov';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
            
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Robot.COM_OUT.UvolniBusbary:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
            
			IF P2_Robot.COM_IN.Stav_BusbaryUvolnene THEN
				P2_Robot.COM_OUT.UvolniBusbary:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 233;
			END_IF    	
			
			
			
		
		233:
			SC_P2_Srobovanie.StepName:='233 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M5 a vypnutie prisavania skrutky, podanie novej skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.IN.Skrutkovacka_M5_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 235;
			END_IF
		
			
		235:
			SC_P2_Srobovanie.StepName:='235 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania pravej skrutky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 238;
			ELSIF P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 238;
			ELSIF P2_Srobovanie.Skrutkovacka_M5.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 238;          
			END_IF	
		
		
		
		
		238:
			SC_P2_Srobovanie.StepName:='238 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj pravu skrutku M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model5H_ZaskrutkujPravuM5 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
		
		
		
			//Zaskrutkovanie strednej skrutky M4//	
		240:
			SC_P2_Srobovanie.StepName:='240 - Automaticky Rezim - model 5H, kontrola pritomnosti skrutky M4 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 250;
			ELSE
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 257;
			END_IF	
			
			
			
			
			
		241:
			SC_P2_Srobovanie.StepName:='241 - Automaticky Rezim - model 5H, napolohovanie lavej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob_PozX_OdobratSkrutkyM4; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 242;
			END_IF	
		
	
		242:
			SC_P2_Srobovanie.StepName:='242 - Automaticky Rezim - model 5H, kontrola skrutky M4 na vystupe podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 243;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 257;
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
			END_IF	
			
					
			
		243:
			SC_P2_Srobovanie.StepName:='243 - Automaticky Rezim - model 5H,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P2_RemPremenne.P2_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 245;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 245;
			END_IF
		
			
		245:
			SC_P2_Srobovanie.StepName:='245 - Automaticky Rezim - model 5H,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 257;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 246;
				END_IF	
			END_IF	
		
			
		246:
			SC_P2_Srobovanie.StepName:='246 - Automaticky Rezim - model 5H,priprava skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
					
						
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
						
			IF SC_P2_Srobovanie.IdleTime.Q THEN	
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 250;
			END_IF
			
			
			
		250:
			SC_P2_Srobovanie.StepName:='160 - Automaticky Rezim - model 5H, napolohovanie na poziciu skrutkovania strednej skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob5H_PozX_SkrutkyM4; //mm	
			
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob5H_PozY_SkrutkyM4; //mm	
				
					
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 251;
				END_IF	
			END_IF	
			
			
			
		251:
			SC_P2_Srobovanie.StepName:='251 - Automaticky Rezim - model 5H, vymazanie vysledkov srobovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF NOT P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG AND NOT P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK AND NOT P2_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M4.RESET_Vysledkov:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 252;
			END_IF	
	
		252:
			SC_P2_Srobovanie.StepName:='252 - Automaticky Rezim - model 5H, kontrola skrutky M4 v skrutkovacke';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 253;
			ELSE
				IF PocetCisteniSkrutkovacky < 3 THEN
					PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
					FazaNavratu:= 240;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 520;
				ELSE
					P2_Alarmy[237]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 257;
				END_IF	
			END_IF	
			
				
			
		253:
			SC_P2_Srobovanie.StepName:='253 - Automaticky Rezim - model 5H, vysunutie skrutkovacky M4 na poziciu pred skrutkovanim a spustenie skrutkovania';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 70;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 254;
			END_IF
			
			
			
		254:
			SC_P2_Srobovanie.StepName:='254 - Automaticky Rezim - model 5H, prepnutie vysunutie skrutkovacky M4 na momentovy pohyb';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_Srob5H_Rychl_SkrutkyM4/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= P2_RemPremenne.P2_Srob5H_Mom_SkrutkyM4;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 100;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
									
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InTorque) THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 255;
			END_IF			
			
					
			
		
				
		255:
			SC_P2_Srobovanie.StepName:='255 - Automaticky Rezim - model 45F, cakam na ukoncenie skrutkovania skrutkovacky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#30s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.IdleTime.IN:= TRUE;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
						
						
			IF P2_Srobovanie.Skrutkovacka_M4.Stav_UtahovanieUkoncene THEN
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				CasSrobovania:= TIME_TO_REAL(SC_P2_Srobovanie.IdleTime.ET);
				Reports.Skrutkovacky.VyskaSkrutkovania.P2_StrednaSkrutkaM4:= REAL_TO_STRING(P2_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition); 
				Reports.Skrutkovacky.CasSkrutkovania.P2_StrednaSkrutkaM4:= REAL_TO_STRING(CasSrobovania/1000);
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 256;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN    
				P2_Alarmy[272]:= TRUE;
				P2_Srobovanie.Skrutkovacka_M4.START_Utahovania:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 256;
			END_IF
			
		
				
		256:
			SC_P2_Srobovanie.StepName:='256 - Automaticky Rezim - model 5H, zasunutie skrutkovacky M4 a vypnutie prisavania skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Torque:= 1.0;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 257;
			END_IF	
		
			
				
		257:
			SC_P2_Srobovanie.StepName:='257 - Automaticky Rezim - model 5H, kontrola vysledkov skrutkovania strednej skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 258; 
			ELSIF P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_OK THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'OK';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 258;
			ELSIF P2_Srobovanie.Skrutkovacka_M4.Stav_VysledokUtahovania_NG THEN
				P2_Srobovanie.STAV.Vysledok_Srobovania:= 'NG';
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 258;          
			END_IF
		
		
		258:
			SC_P2_Srobovanie.StepName:='258 - Automaticky Rezim - model 5H, cakam na zrusenie signalu zaskrutkuj strednu skrutku M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.Model5H_ZaskrutkujStrednuM4 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF
		
		
		
		
			//Presun manipulátora do pozície VPRED//	
		
		400:
			SC_P2_Srobovanie.StepName:='400 - Automaticky Rezim - napolohovanie manipulatora na prednu poziciu ';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 12.5; //mm
						
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 375; //mm
				
		
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF P2_Srobovanie.ServoManipulOsY.Status.ActPosition > 280 THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
			END_IF	
			
			
			
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 402;
			END_IF	
				
		
		402:
			SC_P2_Srobovanie.StepName:='402 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora vpred';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.PresunManipulatora_VPRED THEN
				P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
			//Presun manipulátora do pozície VZAD//	
		
		420:
			SC_P2_Srobovanie.StepName:='420 - Automaticky Rezim - napolohovanie manipulatora na zadnu poziciu ';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 12.5; //mm
						
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; // m/s
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 4.5; //mm
				
		
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 422;
			END_IF	
				
		
		422:
			SC_P2_Srobovanie.StepName:='422 - Automaticky Rezim - cakam na zrusenie signalu presun manipulatora vzad';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			IF NOT P2_Srobovanie.COM_IN.PresunManipulatora_VZAD THEN
				P2_Srobovanie.COM_OUT.Stav_PresunManipulUkonceny:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF	
		
	
			
			//Odobratie skrutky M4//
		440:
			SC_P2_Srobovanie.StepName:='440 - Automaticky Rezim - odobratie skrtuky M4, napolohovanie zadnej skrutkovacky M4 na poziciu odobratia skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
					
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000; //mm/s
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= P2_RemPremenne.P2_Srob_PozX_OdobratSkrutkyM4; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000; //mm/s
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= P2_RemPremenne.P2_Srob_PozY_OdobratSkrutkyM4; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				P2_Srobovanie.STAV.ManipulatorNadPodavacmi:= TRUE;
				IF P2_Srobovanie.STAV.RR_Polohovanie_BUSY THEN
					P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= FALSE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 700;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 442;
				END_IF	
			END_IF	
		
	
		442:
			SC_P2_Srobovanie.StepName:='442 - Automaticky Rezim - odobratie skrutky M4, kontrola skrutky M4 na vystupe podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			
			IF P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 450;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 445;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;		
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
			END_IF	
			
					
			
		445:
			SC_P2_Srobovanie.StepName:='445 - Automaticky Rezim - odobratie skrutky M4,vysunutie skrutkovacky pre odobratie skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#10s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= P2_RemPremenne.P2_Srob_PozZ_OdobratSkrutkyM4;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF	
				
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 448;
			ELSIF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				P2_Alarmy[237]:= TRUE;
				P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 448;
			END_IF
		
			
		448:
			SC_P2_Srobovanie.StepName:='448 - Automaticky Rezim - odobratie skrutky M4,zasunutie skrutkovacky po odobrati skrutky M4 z podavaca';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF EDGEPOS(P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition) THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				IF P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania THEN
					P2_Pracovisko.STAV.Porucha_ST4:= TRUE;
				ELSE	
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 450;
				END_IF	
			END_IF	
		
		
			
		450:
			SC_P2_Srobovanie.StepName:='450 - Automaticky Rezim - odobratie skrutky M4,priprava skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#500ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
					
				
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
						
			IF SC_P2_Srobovanie.IdleTime.Q THEN	
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 455;
			END_IF
			
			
			
		455:
			SC_P2_Srobovanie.StepName:='455 - Automaticky Rezim - odobratie skrutky M4, cakam na zrusenie signalu odober skrutku M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#200ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= TRUE;
			
			IF NOT P2_Srobovanie.COM_IN.OdoberSkrutku_M4 THEN
				P2_Srobovanie.COM_OUT.Stav_SkrutkovanieUkoncene:= FALSE;
				P2_Srobovanie.STAV.ManipulatorNadPodavacmi:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 100;
			END_IF			
			
			
			
			
			
			
			
			
			
			
			
		
			//*********************************************************Èistenie skrutkovaèiek*****************************************************************************//			
			
			//Èistenie skrutkovaèky M5//
		500:
			SC_P2_Srobovanie.StepName:='500 - Automaticky Rezim - cistenie skrutkovacky M5,kontrola zrusenia stavu serva v pozicii';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P2_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 501;
			END_IF	
			
		501:
			SC_P2_Srobovanie.StepName:='501 - Automaticky Rezim - cistenie skrutkovacky M5,presun na poziciu zahodenia skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 35; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 85; //mm
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 502;
			END_IF	
			
		502:
			SC_P2_Srobovanie.StepName:='502 - Automaticky Rezim - cistenie skrutkovacky M5,vysunutie skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#1s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P2_Srobovanie.IdleTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacka_M5_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 505;
			END_IF	
		
		505:
			SC_P2_Srobovanie.StepName:='505 - Automaticky Rezim - cistenie skrutkovacky M5,nabitie skrutky do skrutkovacky M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Srobovanie.IN.Skrutkovacka_M5_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= FazaNavratu;
			ELSIF P2_Srobovanie.SkrutSet_M5.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
				IF PocetCisteniSkrutkovacky > 3 THEN
					P2_Alarmy[238]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= FazaNavratu;
				ELSE
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 508;
				END_IF	
			END_IF	
		
		
		508:
			SC_P2_Srobovanie.StepName:='508 - Automaticky Rezim - cistenie skrutkovacky M5,resetovanie skrutkovacieho setu M5';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
		
			P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
		
			IF P2_Srobovanie.KoniecCyklu THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 0;
			ELSIF NOT P2_Srobovanie.SkrutSet_M5.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= TRUE;
				PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 502;
			END_IF	
		
		
			
		
		
		
		
			//Èistenie skrutkovaèky M4//
		520:
			SC_P2_Srobovanie.StepName:='520 - Automaticky Rezim - cistenie skrutkovacky M4,kontrola zrusenia stavu serva v pozicii';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P2_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 521;
			END_IF	
		
		
		
		521:	
			SC_P2_Srobovanie.StepName:='521 - Automaticky Rezim - cistenie skrutkovacky M4,presun manipulatora na poziciu zahodenia skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 23; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 523;
			END_IF	
			
		
			
		523:
			SC_P2_Srobovanie.StepName:='523 - Automaticky Rezim - cistenie skrutkovacky M4, vysuvam skrutkovac M4 a vypinam prisavanie skrutky,priprava skrutky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
					
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 99;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
					
						
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 525;
			END_IF	
				
		525:
			SC_P2_Srobovanie.StepName:='525 - Automaticky Rezim - cistenie skrutkovacky M4, otretie skrutkovacky M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 5; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 150; //mm
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 528;
			END_IF	
			
			
			
	
		528:
			SC_P2_Srobovanie.StepName:='528 - Automaticky Rezim - cistenie skrutkovacky M4, zasuvam skrutkovac M4';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsZ_M4_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Position:= 0;
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
		
			IF P2_Srobovanie.ServoManipulOsZ_M4.Status.InPosition AND P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena AND NOT P2_Srobovanie.IN.Skrutkovacka_M4_Vakum_OK THEN	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.MovePosition:= FALSE;
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= FazaNavratu;
			ELSIF P2_Srobovanie.SkrutSet_M4.STAV.ERROR THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
				P2_Alarmy[237]:= TRUE;
				P2_Pracovisko.STAV.Porucha_ST4:= TRUE;		
			END_IF	
				
			
			
			
			
			
		
		
		
		
		
			//Èistenie skrutkovaèky M6//
		600:
			SC_P2_Srobovanie.StepName:='600 - Automaticky Rezim - cistenie skrutkovacky M6,kontrola zrusenia stavu serva v pozicii';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			IF NOT P2_Srobovanie.ServoManipulOsX.Status.InPosition AND NOT P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 601;
			END_IF	
			
		601:
			SC_P2_Srobovanie.StepName:='601 - Automaticky Rezim - cistenie skrutkovacky M6,presun na poziciu zahodenia skrutky';
			SC_P2_Srobovanie.IdleTime.PT:= T#300ms;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
			
            			
			P2_Robot.COM_OUT.ManipSrobovania_BezpecnaPozicia:= FALSE;
			
			P2_Srobovanie.ServoManipulOsX.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsX_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsX.Parameters.Position:= 35; //mm
			
			P2_Srobovanie.ServoManipulOsY.Parameters.Velocity:= P2_RemPremenne.P2_ManipSrob_OsY_Rychlost/1000;
			P2_Srobovanie.ServoManipulOsY.Parameters.Position:= 5; //mm
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= TRUE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
				
			IF P2_Srobovanie.ServoManipulOsX.Status.InPosition AND P2_Srobovanie.ServoManipulOsY.Status.InPosition THEN
				P2_Srobovanie.ServoManipulOsX.Command.MovePosition:= FALSE;
				P2_Srobovanie.ServoManipulOsY.Command.MovePosition:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 602;
			END_IF	
			
		602:
			SC_P2_Srobovanie.StepName:='602 - Automaticky Rezim - cistenie skrutkovacky M6,vysunutie skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#1s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#2s;
			
			
			IF NOT SC_P2_Srobovanie.Switch1 THEN
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= TRUE;
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= TRUE;
				SC_P2_Srobovanie.IdleTime.IN:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF
			
			IF SC_P2_Srobovanie.IdleTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacka_M6_Prisavanie_ON:= FALSE;
				SC_P2_Srobovanie.AlarmTime.IN:= TRUE;
			END_IF
	
			IF SC_P2_Srobovanie.AlarmTime.Q THEN
				P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= FALSE;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 605;
			END_IF	
		
		605:
			SC_P2_Srobovanie.StepName:='605 - Automaticky Rezim - cistenie skrutkovacky M6,nabitie skrutky do skrutkovacky M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
			
			IF NOT SC_P2_Srobovanie.Switch1 AND P2_Srobovanie.IN.Skrutkovacka_M6_ZASUNUTA THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= TRUE;
				SC_P2_Srobovanie.Switch1:= TRUE;
			END_IF	
			
			IF P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena THEN
				PocetCisteniSkrutkovacky:= 0;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= FazaNavratu;
			ELSIF P2_Srobovanie.SkrutSet_M6.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
				IF PocetCisteniSkrutkovacky > 3 THEN
					P2_Alarmy[239]:= TRUE;
					P2_Srobovanie.COM_OUT.Stav_PoruchaSkrutkovania:= TRUE;
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= FazaNavratu;
				ELSE
					SC_P2_Srobovanie.ResetStep:= TRUE;
					SC_P2_Srobovanie.Step:= 608;
				END_IF	
			END_IF	
		
		
		608:
			SC_P2_Srobovanie.StepName:='608 - Automaticky Rezim - cistenie skrutkovacky M6,resetovanie skrutkovacieho setu M6';
			SC_P2_Srobovanie.IdleTime.PT:= T#2s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#30s;
		
			P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
		
			IF P2_Srobovanie.KoniecCyklu THEN
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 0;
			ELSIF NOT P2_Srobovanie.SkrutSet_M6.Error.ErrorBit THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= TRUE;
				PocetCisteniSkrutkovacky:= PocetCisteniSkrutkovacky + 1;
				SC_P2_Srobovanie.ResetStep:= TRUE;
				SC_P2_Srobovanie.Step:= 602;
			END_IF	
		
			
		
			
			
			
			
		
		
			//*******************************************************Manuálny režim*******************************************************************************//
		700:
			SC_P2_Srobovanie.StepName:='700 - Manualny Rezim';
			SC_P2_Srobovanie.IdleTime.PT:= T#8s;
			SC_P2_Srobovanie.AlarmTime.PT:= T#5s;
		
			//Parametre serv pre jogging//
			P2_Srobovanie.ServoManipulOsX.Parameters.Jog.Acc:= 1;
			P2_Srobovanie.ServoManipulOsX.Parameters.Jog.Velocity:= P2_Srobovanie.PAR.ManipulOsX_JoggRychlost;
			P2_Srobovanie.ServoManipulOsY.Parameters.Jog.Acc:= 1;
			P2_Srobovanie.ServoManipulOsY.Parameters.Jog.Velocity:= P2_Srobovanie.PAR.ManipulOsY_JoggRychlost;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Jog.Acc:= 1;
			P2_Srobovanie.ServoManipulOsZ_M4.Parameters.Jog.Velocity:= P2_Srobovanie.PAR.ManipulOsZ_M4_JoggRychlost;
			P2_Srobovanie.ServoManipulOsX.Command.TorqueLimitation:= TRUE;
			P2_Srobovanie.ServoManipulOsY.Command.TorqueLimitation:= TRUE;
			P2_Srobovanie.ServoManipulOsZ_M4.Command.TorqueLimitation:= TRUE;
			
	
			//Ovládanie vysunutia skrutkovaèky M4//
			IF P2_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_DOLE AND P2_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition < 100 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.JogNeg:= FALSE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.JogPos:= TRUE;
			ELSIF P2_Srobovanie.CMD.RR_SkrutkovackaM4_OsZ_HORE AND P2_Srobovanie.ServoManipulOsZ_M4.Status.ActPosition > 5 THEN
				P2_Srobovanie.ServoManipulOsZ_M4.Command.JogPos:= FALSE;	
				P2_Srobovanie.ServoManipulOsZ_M4.Command.JogNeg:= TRUE;
			ELSE
				P2_Srobovanie.ServoManipulOsZ_M4.Command.JogNeg:= FALSE;
				P2_Srobovanie.ServoManipulOsZ_M4.Command.JogPos:= FALSE;
			END_IF	
				
            
					
			       
			//Ovládanie vysunutia skrutkovaèky M5//
			P2_Srobovanie.OUT.Skrutkovacku_M5_VYSUN:= P2_Srobovanie.CMD.RR_SkrutkovackuM5_VYSUN;
		
		
			//Ovládanie vysunutia skrutkovaèky M6//
			P2_Srobovanie.OUT.Skrutkovacku_M6_VYSUN:= P2_Srobovanie.CMD.RR_SkrutkovackuM6_VYSUN;
			      
        
				
			//Prisávanie skrutky M4//
			IF P2_Srobovanie.CMD.RR_PrisavanieSkrutkyM4_ON THEN
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= TRUE;
			ELSE
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_ON:= FALSE;
				P2_Srobovanie.OUT.Skrutkovacka_M4_Prisavanie_OFF:= TRUE;
			END_IF    
			
			
			//***************Skrutkovací set M5*********************//
			//Ovládanie zásobníka//
			IF P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			//Podanie skrutky//
			IF P2_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku THEN
				P2_Srobovanie.CMD.RR_SkrutSetM5_Zasobnik_RUN:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.ManualStartHrniec:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= TRUE;
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM5_PodajSkrutku:= FALSE;
			END_IF	
				
			IF P2_Srobovanie.SkrutSet_M5.Status.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M5.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M5.Cmd.PodajSkrutku:= FALSE;
			END_IF	
			
			
			//***************Skrutkovací set M6*********************//
			//Ovládanie zásobníka//
			IF P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= TRUE;
			ELSE	
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= FALSE;
			END_IF
			
			//Podanie skrutky//
			IF P2_Srobovanie.CMD.RR_SkrutSetM6_PodajSkrutku THEN
				P2_Srobovanie.CMD.RR_SkrutSetM6_Zasobnik_RUN:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.ManualStartHrniec:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= TRUE;
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM6_PodajSkrutku:= FALSE;
			END_IF	
				
			IF P2_Srobovanie.SkrutSet_M6.Status.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M6.Cmd.AutomatStart:= FALSE;
				P2_Srobovanie.SkrutSet_M6.Cmd.PodajSkrutku:= FALSE;
			END_IF	
			
				
			
			
			
			//*******************Skrutkovací set M4**************************//
			//Ovládanie zásobníka//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN THEN
				P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= TRUE;
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniZasobnik:= FALSE;
			END_IF	
			
			
			
			
			//Ovládanie vibrolišty//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN THEN
				P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= TRUE;
			ELSE
				P2_Srobovanie.SkrutSet_M4.CMD.RR_ZapniVibrolistu:= FALSE;
			END_IF	
			
			
			//Podanie skrutky//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku THEN
				P2_Srobovanie.CMD.RR_SkrutSetM4_Zasobnik_RUN:= FALSE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_Vibrolista_RUN:= FALSE;
				P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_PodajSkrutku:= FALSE;
			END_IF
			
			IF P2_Srobovanie.SkrutSet_M4.STAV.SkrutkaPripravena THEN
				P2_Srobovanie.SkrutSet_M4.CMD.PodajSkrutku:= FALSE;
			END_IF	
			
			
			//Otáèanie podavaèa skrutiek//
			IF P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup THEN
				P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vstup:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vstup:= FALSE;
			ELSIF P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup THEN
				P2_Srobovanie.SkrutSet_M4.CMD.ENABLE:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RucnyRezim:= TRUE;
				P2_Srobovanie.SkrutSet_M4.CMD.RR_OtocPodavac_Vystup:= TRUE;
				P2_Srobovanie.CMD.RR_SkrutSetM4_OtocPodavac_Vystup:= FALSE;
			END_IF	
		
			
			
        
			//**********************Polohovanie na pozície skrutiek*****************************//
			IF P2_Srobovanie.CMD.RR_PolohujManipulator THEN 
				IF P2_Pracovisko.STAV.SkrutkovackyZasunute THEN
					IF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 0 THEN  //Lavá M6 - 4F
						P2_Srobovanie.PAR.RR_TypModelu:= '4F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 110;
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 1 THEN  //Pravá M6 - 4F
						P2_Srobovanie.PAR.RR_TypModelu:= '4F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 130;    
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 2 THEN  //Lavá M4 - 4F
						P2_Srobovanie.PAR.RR_TypModelu:= '4F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 160; 
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 3 THEN  //Pravá M4 - 4F
						P2_Srobovanie.PAR.RR_TypModelu:= '4F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 180;  
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 4 THEN  //Lavá M6 - 5F
						P2_Srobovanie.PAR.RR_TypModelu:= '5F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 110;  
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 5 THEN  //Pravá M6 - 5F
						P2_Srobovanie.PAR.RR_TypModelu:= '5F';
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 130; 
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 6 THEN  //Lavá M4 - 5F
						P2_Srobovanie.PAR.RR_TypModelu:= '5F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 160; 
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 7 THEN  //Pravá M5 - 5F
						P2_Srobovanie.PAR.RR_TypModelu:= '5F';
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 180;
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 8 THEN  //Lavá M5 - 5H
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 200;
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 9 THEN  //Pravá M5 - 5H
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 220;
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 10 THEN  //Stredná M4 - 5H
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 250;
					ELSIF P2_Srobovanie.PAR.RR_IndexPolohovaniaManipulatora = 11 THEN  //Pozicia odobratia skrutky M4
						P2_Srobovanie.STAV.RR_Polohovanie_BUSY:= TRUE;
						P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
						SC_P2_Srobovanie.ResetStep:= TRUE;
						SC_P2_Srobovanie.Step:= 440;
					END_IF	
				END_IF	
				P2_Srobovanie.CMD.RR_PolohujManipulator:= FALSE;
			END_IF		
		
		
		
		
		
	END_CASE
	 
				END_PROGRAM

PROGRAM _EXIT
				(* Insert code here *)
	 
				END_PROGRAM

