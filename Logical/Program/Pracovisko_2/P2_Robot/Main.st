
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	//Volanie funkcie SequenceControl//
	SequenceControl(SC:= SC_P2_Robot);
	
	//Volanie podprogramov//
	ProfinetKomunikaciaRobot;
	
	
	
	//Reset sekcie //
	IF P2_Robot.Reset THEN
		SC_P2_Robot.Step:= 0;
		P2_Robot.Reset:= FALSE;
	ELSIF NOT Safety.STAV.Linka_ZonaCS_AKTIVNA THEN
		SC_P2_Robot.Step:= 0;
	END_IF
	
	
	CASE SC_P2_Robot.Step OF 
	
		0:
			SC_P2_Robot.StepName:='0 - Nulovanie';
			P2_Robot.Automat:= FALSE;
			P2_Robot.KoniecCyklu:= FALSE;
			P2_Robot.Manual:= FALSE;
			P2_Robot.Reset:= FALSE;
			P2_Robot.STAV.PoINIT:= FALSE;
			P2_Robot.COM_OUT.Odparkovanie:= FALSE;
			P2_Robot.COM_OUT.PP_na_Main:= FALSE;
			P2_Robot.COM_OUT.Reset_CS:= FALSE;
			P2_Robot.COM_OUT.StartProgramu:= FALSE;
			P2_Robot.COM_OUT.StartProgramuMain:= FALSE;
			P2_Robot.COM_OUT.VypniMotory:= FALSE;
			P2_Robot.COM_OUT.ZapniMotory:= FALSE;
			IF P2_Robot.COM_IN.Stav_RezimAUTOMAT AND P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Robot.COM_OUT.StopProgramu:= TRUE;
			ELSE	
				P2_Robot.COM_OUT.StopProgramu:= FALSE;
			END_IF	
			IF Safety.STAV.Linka_ZonaCS_AKTIVNA AND
				P2_Pracovisko.STAV.HardwareBunky_OK AND
				NOT P2_Pracovisko.STAV.Porucha_ST2 AND 
				NOT P2_Pracovisko.STAV.Porucha_ST3 AND 
				NOT P2_Pracovisko.STAV.Porucha_ST4 AND 
				NOT P2_Pracovisko.STAV.Porucha_ST5 AND 
				NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				P2_Robot.COM_OUT.StopProgramu:= FALSE;
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 1;
			END_IF
	
		1:
			SC_P2_Robot.StepName:='1 - Cakam na spustenie vyroby';
			P2_Robot.KoniecCyklu:= FALSE;
			IF P2_Robot.Automat THEN
				SC_P2_Robot.Step:= 2;
			ELSIF P2_Robot.Manual THEN
				SC_P2_Robot.Step:= 700;
			END_IF
			
		
			//********************************************************Inicializácia****************************************************************************//	
	
		2:
			SC_P2_Robot.StepName:='2 - Inicializacia - cakam na spustenie inicializacie';
			SC_P2_Robot.IdleTime.PT:= T#500ms;
			SC_P2_Robot.AlarmTime.PT:= T#5s;
			
			SC_P2_Robot.IdleTime.IN:= TRUE;
			
			P2_Robot.COM_OUT.VypniMotory:= TRUE;
			
			IF SC_P2_Robot.IdleTime.Q AND P2_Cistenie.STAV.PoINIT THEN
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 3;
			END_IF
			
		3:
			SC_P2_Robot.StepName:='2 - Inicializacia - kontrolujem central stop robota';
			SC_P2_Robot.IdleTime.PT:= T#500ms;
			SC_P2_Robot.AlarmTime.PT:= T#5s;
	
			IF P2_Robot.COM_IN.Stav_RobotCS THEN
				P2_Robot.COM_OUT.Reset_CS:= TRUE;
			END_IF
		
			IF NOT P2_Robot.COM_IN.Stav_RobotCS THEN
				P2_Robot.COM_OUT.Reset_CS:= FALSE;
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 4;
			END_IF
		
		
		4:
			SC_P2_Robot.StepName:='4 - Inicializacia - zapinam motory robota';
			SC_P2_Robot.IdleTime.PT:= T#3s;
			SC_P2_Robot.AlarmTime.PT:= T#5s;
			SC_P2_Robot.IdleTime.IN:= TRUE;
			
			IF NOT P2_Robot.COM_IN.Stav_MotoryON THEN
				P2_Robot.COM_OUT.VypniMotory:= FALSE;
				P2_Robot.COM_OUT.ZapniMotory:= TRUE;
				SC_P2_Robot.IdleTime.IN:= TRUE;
			END_IF
			
			IF P2_Robot.COM_IN.Stav_MotoryON THEN
				P2_Robot.COM_OUT.ZapniMotory:= FALSE;
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 6;
			END_IF
			
			
		6:
			SC_P2_Robot.StepName:='6 - Inicializacia - spustam program robota od zaciatku';
			SC_P2_Robot.IdleTime.PT:= T#2s;
			SC_P2_Robot.AlarmTime.PT:= T#10s;
		
			SC_P2_Robot.IdleTime.IN:= P2_Robot.COM_IN.Stav_ProgramRUN;
			
			IF NOT SC_P2_Robot.Switch1 THEN
				P2_Robot.COM_OUT.StartProgramuMain:= TRUE;
				SC_P2_Robot.AlarmTime.IN:= TRUE;
				SC_P2_Robot.Switch1:= TRUE;
			END_IF
			
			IF SC_P2_Robot.IdleTime.Q AND P2_Robot.COM_IN.Stav_VystupyZresetovane THEN
				P2_Robot.COM_OUT.StartProgramuMain:= FALSE;
				P2_Robot.STAV.PoINIT:= TRUE;
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 100;
			ELSIF SC_P2_Robot.AlarmTime.Q THEN
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 0;
			END_IF	
			
			
		
			//********************************************************Automatický režim****************************************************************************//
				
		100:  
			SC_P2_Robot.StepName:='100 - Automaticky Rezim - cakam na ukoncenie programu robota';
			SC_P2_Robot.IdleTime.PT:= T#200ms;
			SC_P2_Robot.AlarmTime.PT:= T#5s;		
			
			
			IF P2_Robot.KoniecCyklu AND NOT P2_StoperSrobovania.Automat AND NOT P2_StoperZvarania.Automat AND P2_Robot.COM_IN.Stav_RobotOdparkovany THEN
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 0;
			ELSIF NOT P2_Robot.COM_IN.Stav_ProgramRUN THEN
				SC_P2_Robot.ResetStep:= TRUE;
				SC_P2_Robot.Step:= 0;
			END_IF	
			
   
		
		
		
			//*******************************************************Manuálny režim*******************************************************************************//	
			
		700:
			SC_P2_Robot.StepName:='700 - Manualny Rezim';
			SC_P2_Robot.IdleTime.PT:= T#8s;
			SC_P2_Robot.AlarmTime.PT:= T#5s;
		
		
		
		
	END_CASE	
		
	
	
	
	//Zrušenie signálu výmena gripra 4F5F//
	IF P2_Robot.COM_OUT.ZmenaGripra_4F5F AND P2_Robot.COM_IN.Stav_Griper4F5F_Vymeneny THEN
		P2_Robot.COM_OUT.ZmenaGripra_4F5F:= FALSE;
	END_IF
    
	//Zrušenie signálu výmena gripra 5H//
	IF P2_Robot.COM_OUT.ZmenaGripra_5H AND P2_Robot.COM_IN.Stav_Griper5H_Vymeneny THEN
		P2_Robot.COM_OUT.ZmenaGripra_5H:= FALSE;
	END_IF
    
	//Zrušenie signálu výmena gripra èistenia Power CP//
	IF P2_Robot.COM_OUT.ZmenaGripra_Cistenie AND P2_Robot.COM_IN.Stav_GriperCistenia_Vymeneny THEN
		P2_Robot.COM_OUT.ZmenaGripra_Cistenie:= FALSE;
	END_IF
	
	
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

