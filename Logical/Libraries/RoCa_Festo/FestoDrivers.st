
(* Riadenie festo driverov *)
FUNCTION_BLOCK ServoDriver
			
	TwoUINTtoREAL1.order:=1; 
	TwoUINTtoREAL2.order:=1; 
	REALtoTwoUINT1.order:=1;
	REALtoTwoUINT2.order:=1;
	REALtoTwoUINT3.order:=1;

	TwoUINTtoREAL1;
	TwoUINTtoREAL2;
	REALtoTwoUINT1;
	REALtoTwoUINT2;
	REALtoTwoUINT3;
	
	TwoUINTtoREAL1.IN1:=IN_forMapping.Status_word_or_actual_value_0;
	TwoUINTtoREAL1.IN2:=IN_forMapping.Status_word_or_actual_value_1;
	
	TwoUINTtoREAL2.IN1:=IN_forMapping.Status_word_or_actual_value_2;
	TwoUINTtoREAL2.IN2:=IN_forMapping.Status_word_or_actual_value_3;
	
	OUT.ExtendedParam0:=REALtoTwoUINT1.OUT1;
	OUT.ExtendedParam1:=REALtoTwoUINT1.OUT2;

	OUT.ExtendedParam2:=REALtoTwoUINT2.OUT1;
	OUT.ExtendedParam3:=REALtoTwoUINT2.OUT2;

	OUT.ExtendedParam4:=REALtoTwoUINT3.OUT1;
	OUT.ExtendedParam5:=REALtoTwoUINT3.OUT2;

	//INPUTS
	//status word 1
	IN.ReadyToSwitchON_Bit0:=IN_forMapping.Status_word_1.0;
	IN.ReadyToOperate_Bit1:=IN_forMapping.Status_word_1.1;
	IN.OperationEnabled_Bit2:=IN_forMapping.Status_word_1.2;
	IN.FaultPresent_Bit3:=IN_forMapping.Status_word_1.3;
	IN.CoastStopNotActivated_Bit4:=IN_forMapping.Status_word_1.4;
	IN.QuickStopNotActivated_Bit5:=IN_forMapping.Status_word_1.5;
	IN.SwitchingOnInhibited_Bit6:=IN_forMapping.Status_word_1.6;
	IN.WarningPresent_Bit7:=IN_forMapping.Status_word_1.7;
	IN.FolowingErrorWithinTol_Bit8:=IN_forMapping.Status_word_1.8;
	IN.ControlRequested_Bit9:=IN_forMapping.Status_word_1.9;
	IN.TargetPositionReached_Bit10:=IN_forMapping.Status_word_1.10;
	IN.HomePositionSet_Bit11:=IN_forMapping.Status_word_1.11;
	IN.TraversingTaskAck_Bit12:=IN_forMapping.Status_word_1.12;
	IN.DriveStopped_Bit13:=IN_forMapping.Status_word_1.13;
	IN.AxisAccelerated_Bit14:=IN_forMapping.Status_word_1.14;
	IN.AxisDeccelerated_Bit15:=IN_forMapping.Status_word_1.15;
	
	//status word 2
	IN.MoveToFixedStopActiveZSW2_Bit8:=IN_forMapping.Status_word_2.8;
	IN.PulsesEnabled_Bit11:=IN_forMapping.Status_word_2.11;

	//position status word 1
	IN.ActiveTravesringBlock_Bit0:=IN_forMapping.Position_Statusword_1.0;
	IN.ActiveTravesringBlock_Bit1:=IN_forMapping.Position_Statusword_1.1;
	IN.ActiveTravesringBlock_Bit2:=IN_forMapping.Position_Statusword_1.2;
	IN.ActiveTravesringBlock_Bit3:=IN_forMapping.Position_Statusword_1.3;
	IN.ActiveTravesringBlock_Bit4:=IN_forMapping.Position_Statusword_1.4;
	IN.ActiveTravesringBlock_Bit5:=IN_forMapping.Position_Statusword_1.5;
	IN.ActiveTravesringBlock_Bit6:=IN_forMapping.Position_Statusword_1.6;
	
	IN.NegativeLimitSwitch_Bit8:=IN_forMapping.Position_Statusword_1.8;
	IN.PositiveLimitSwitch_Bit9:=IN_forMapping.Position_Statusword_1.9;
	IN.JoggingActive_Bit10:=IN_forMapping.Position_Statusword_1.10;
	IN.RefPointAproachActive_Bit11:=IN_forMapping.Position_Statusword_1.11;
	
	IN.TraversingBlockActive_Bit13:=IN_forMapping.Position_Statusword_1.13;
	IN.MDIactive_Bit15:=IN_forMapping.Position_Statusword_1.15;

	//position status word 2
	IN.TrackingModeActive_Bit0:=IN_forMapping.Position_Statusword_2.0;
	IN.VelocityLimitingActive_Bit1:=IN_forMapping.Position_Statusword_2.1;
	IN.SetpointAvailable_Bit2:=IN_forMapping.Position_Statusword_2.2;
	
	IN.DriveMovesForward_Bit4:=IN_forMapping.Position_Statusword_2.4;
	IN.DriveMovesBackwards_Bit5:=IN_forMapping.Position_Statusword_2.5;
	IN.SoftwareLimitSwitchMinus_Bit6:=IN_forMapping.Position_Statusword_2.6;
	IN.SoftwareLimitSwitchPlus_Bit7:=IN_forMapping.Position_Statusword_2.7;
	IN.PosActValueLessCamSwitch0_Bit8:=IN_forMapping.Position_Statusword_2.8;
	IN.PosActValueLessCamSwitch1_Bit9:=IN_forMapping.Position_Statusword_2.9;
	IN.DirectOut1ViaTraversBlock_Bit10:=IN_forMapping.Position_Statusword_2.10;
	IN.DirectOut2ViaTraversBlock_Bit11:=IN_forMapping.Position_Statusword_2.11;
	IN.FixedStopReached_Bit12:=IN_forMapping.Position_Statusword_2.12;
	IN.FixedStopClampTorqReached_Bit13:=IN_forMapping.Position_Statusword_2.13;
	IN.MoveToFixedStopActive_Bit14:=IN_forMapping.Position_Statusword_2.14;
	IN.TraversingCommandActive_Bit15:=IN_forMapping.Position_Statusword_2.15;
	
	//report word
	IN.RampFunctionCompleted_Bit0:=IN_forMapping.Report_word.0;
	IN.TorqUtilLessTorqThres_Bit1:=IN_forMapping.Report_word.1;
	IN.RPMlowerThreshold_Bit2:=IN_forMapping.Report_word.2;
	IN.RPMequalThreshold_Bit3:=IN_forMapping.Report_word.3;

	IN.VariableSignalingFunction_Bit5:=IN_forMapping.Report_word.5;
	IN.MotorTempWarningInactive_Bit6:=IN_forMapping.Report_word.6;
	IN.PsTempWarningInactive_Bit7:=IN_forMapping.Report_word.7;
	IN.SpeedSetpointDeviationInTol_Bit8:=IN_forMapping.Report_word.8;
	
	IN.ControlerEnabled_Bit11:=IN_forMapping.Report_word.11;
	IN.DriveReady_Bit12:=IN_forMapping.Report_word.12;
	IN.PulsesEnabledMELDW_Bit13:=IN_forMapping.Report_word.13;

	//not bool variables
	IN.FaultCode:=IN_forMapping.Fault_Code;
	IN.Position:=IN_forMapping.Position_actual_value_A;
	IN.Speed:=IN_forMapping.Speed_actual_value_B;
	IN.WarnCode:=IN_forMapping.Warn_Code;
	
	//extended proces variables
	IN.ExtendedParam0:=IN_forMapping.Status_word_or_actual_value_0;
	IN.ExtendedParam1:=IN_forMapping.Status_word_or_actual_value_1;
	IN.ExtendedParam2:=IN_forMapping.Status_word_or_actual_value_2;
	IN.ExtendedParam3:=IN_forMapping.Status_word_or_actual_value_3;
	IN.ExtendedParam4:=IN_forMapping.Status_word_or_actual_value_4;
	IN.ExtendedParam5:=IN_forMapping.Status_word_or_actual_value_5;
	IN.ExtendedParam6:=IN_forMapping.Status_word_or_actual_value_6;
	IN.ExtendedParam7:=IN_forMapping.Status_word_or_actual_value_7;
	IN.ExtendedParam8:=IN_forMapping.Status_word_or_actual_value_8;
	IN.ExtendedParam9:=IN_forMapping.Status_word_or_actual_value_9;
	IN.ExtendedParam10:=IN_forMapping.Status_word_or_actual_value_10;
	IN.ExtendedParam11:=IN_forMapping.Status_word_or_actual_value_11;
	IN.ExtendedParam12:=IN_forMapping.Status_word_or_actual_value_12;
	IN.ExtendedParam13:=IN_forMapping.Status_word_or_actual_value_13;
	IN.ExtendedParam14:=IN_forMapping.Status_word_or_actual_value_14;
	IN.ExtendedParam15:=IN_forMapping.Status_word_or_actual_value_15;
	
	//OUTPUTS
	//control word 1
	OUT_forMapping.Control_word_1.0:=OUT.SwitchON_Bit0;
	OUT_forMapping.Control_word_1.1:=OUT.NoCoastStop_Bit1;
	OUT_forMapping.Control_word_1.2:=OUT.NoQuickStop_Bit2;
	OUT_forMapping.Control_word_1.3:=OUT.EnableOperation_Bit3;
	OUT_forMapping.Control_word_1.4:=OUT.DoNotRejectTraversingTask_Bit4;
	OUT_forMapping.Control_word_1.5:=OUT.NoIntermediateStop_Bit5;
	OUT_forMapping.Control_word_1.6:=OUT.ActivateTraversingTask_Bit6;
	OUT_forMapping.Control_word_1.7:=OUT.FaultAck_Bit7;
	OUT_forMapping.Control_word_1.8:=OUT.Jog1_Bit8;
	OUT_forMapping.Control_word_1.9:=OUT.Jog2_Bit9;
	OUT_forMapping.Control_word_1.10:=OUT.ControlByPLC_Bit10;
	OUT_forMapping.Control_word_1.11:=OUT.StartHomingProcedure_Bit11;
	OUT_forMapping.Control_word_1.12:=OUT.OpenHoldingBrake_Bit12;
	
	//control word 2
	OUT_forMapping.Control_word_2.8:=OUT.TraverseToFixedEndstop_Bit8;
	
	//position control word 1
	OUT_forMapping.Position_Controlword_1.0:=OUT.TraversingBlockSelection_Bit0;
	OUT_forMapping.Position_Controlword_1.1:=OUT.TraversingBlockSelection_Bit1;
	OUT_forMapping.Position_Controlword_1.2:=OUT.TraversingBlockSelection_Bit2;
	OUT_forMapping.Position_Controlword_1.3:=OUT.TraversingBlockSelection_Bit3;
	OUT_forMapping.Position_Controlword_1.4:=OUT.TraversingBlockSelection_Bit4;
	OUT_forMapping.Position_Controlword_1.5:=OUT.TraversingBlockSelection_Bit5;
	OUT_forMapping.Position_Controlword_1.6:=OUT.TraversingBlockSelection_Bit6;
	
	OUT_forMapping.Position_Controlword_1.8:=OUT.AbsolutePositioning_Bit8;
	OUT_forMapping.Position_Controlword_1.9:=OUT.PosModuloPositioningDir_Bit9;
	OUT_forMapping.Position_Controlword_1.10:=OUT.NegModuloPositioningDir_Bit10;
	
	OUT_forMapping.Position_Controlword_1.15:=OUT.MDIselection_Bit15;
	
	//position control word 2
	OUT_forMapping.Position_Controlword_2.5:=OUT.JoggingIncremental_Bit5;
	
	OUT_forMapping.Position_Controlword_2.10:=OUT.TouchProbeSelection_Bit10;
	OUT_forMapping.Position_Controlword_2.11:=OUT.TouchProbeEdgeSelection_Bit11;

	OUT_forMapping.Position_Controlword_2.14:=OUT.ActivateSoftLimitSwitch_Bit14;
	OUT_forMapping.Position_Controlword_2.15:=OUT.ActivateHardwLimitSwitch_Bit15;
	
	
	//extended proces variables
	OUT_forMapping.Control_word_or_setpoint_0:=OUT.ExtendedParam0;
	OUT_forMapping.Control_word_or_setpoint_1:=OUT.ExtendedParam1;
	OUT_forMapping.Control_word_or_setpoint_2:=OUT.ExtendedParam2;
	OUT_forMapping.Control_word_or_setpoint_3:=OUT.ExtendedParam3;
	OUT_forMapping.Control_word_or_setpoint_4:=OUT.ExtendedParam4;
	OUT_forMapping.Control_word_or_setpoint_5:=OUT.ExtendedParam5;
	OUT_forMapping.Control_word_or_setpoint_6:=OUT.ExtendedParam6;
	OUT_forMapping.Control_word_or_setpoint_7:=OUT.ExtendedParam7;
	OUT_forMapping.Control_word_or_setpoint_8:=OUT.ExtendedParam8;
	OUT_forMapping.Control_word_or_setpoint_9:=OUT.ExtendedParam9;
	OUT_forMapping.Control_word_or_setpoint_10:=OUT.ExtendedParam10;
	OUT_forMapping.Control_word_or_setpoint_11:=OUT.ExtendedParam11;
	OUT_forMapping.Control_word_or_setpoint_12:=OUT.ExtendedParam12;
	OUT_forMapping.Control_word_or_setpoint_13:=OUT.ExtendedParam13;
	OUT_forMapping.Control_word_or_setpoint_14:=OUT.ExtendedParam14;
	OUT_forMapping.Control_word_or_setpoint_15:=OUT.ExtendedParam15;
	
	
	//prepocet aktualnych hodnot
	Status.ActPosition:=UDINT_TO_REAL (IN_forMapping.Position_actual_value_A)/100;
	Status.ActTorque:=TwoUINTtoREAL1.Out;
	Status.ActVelocity:=TwoUINTtoREAL2.Out;
	REALtoTwoUINT1.IN:=Parameters.Torque;
	REALtoTwoUINT2.IN:=Parameters.Jog.Velocity;
	REALtoTwoUINT3.IN:=Parameters.Jog.Acc;
	OUT_forMapping.Override:=REAL_TO_UINT(Parameters.Override*163.835);
	
	//switche
	OUT.TraverseToFixedEndstop_Bit8:=Command.TorqueLimitation;
	
	//statusy
	Status.InTorque:=IN.FixedStopClampTorqReached_Bit13;
	IF IN.DriveMovesBackwards_Bit5=0 AND IN.DriveMovesForward_Bit4=0 THEN Status.StandStill:=1; ELSE Status.StandStill:=0; END_IF

	//commandy
	//pauza
	IF Step>=100 THEN
		OUT.NoIntermediateStop_Bit5:=NOT (Command.Pause);
	END_IF
	//stop
	IF Step>=100 AND (IN.DriveMovesBackwards_Bit5=1 OR IN.DriveMovesForward_Bit4=1) THEN
		OUT.NoQuickStop_Bit2:=NOT (Command.Stop);
		IF EDGEPOS ( Command.Stop=1) THEN
			Step:=0;
		END_IF		
	END_IF
	IF EDGENEG ( Command.Stop=1) THEN
		OUT.NoQuickStop_Bit2:=1;
		Step:=1;
	END_IF
	//PowerOFF
	IF Command.PowerON=0 THEN
		Step:=0;
	END_IF
	
	//Ready
	IF Step =100 OR Step=112 THEN
		IF IN.FaultPresent_Bit3=1 THEN Status.Ready:=0; ELSE Status.Ready:=1; END_IF
	ELSE
		Status.Ready:=0;
	END_IF
		
	
	
	//krokovy automat
	CASE Step OF
		0: Info:="Vypnute";
			OUT.AbsolutePositioning_Bit8:=0;
			OUT.ActivateHardwLimitSwitch_Bit15:=0;
			OUT.ActivateSoftLimitSwitch_Bit14:=0;
			OUT.ActivateTraversingTask_Bit6:=0;
			OUT.ControlByPLC_Bit10:=0;
			OUT.DoNotRejectTraversingTask_Bit4:=0;
			OUT.EnableOperation_Bit3:=0;
			OUT.FaultAck_Bit7:=0;
			OUT.Jog1_Bit8:=0;
			OUT.Jog2_Bit9:=0;
			OUT.JoggingIncremental_Bit5:=0;
			OUT.MDIselection_Bit15:=0;
			OUT.NegModuloPositioningDir_Bit10:=0;
			OUT.NoCoastStop_Bit1:=0;
			OUT.NoIntermediateStop_Bit5:=0;
			OUT.NoQuickStop_Bit2:=0;
			OUT.OpenHoldingBrake_Bit12:=0;
			OUT.PosModuloPositioningDir_Bit9:=0;
			OUT.StartHomingProcedure_Bit11:=0;
			OUT.SwitchON_Bit0:=0;
			OUT.TouchProbeEdgeSelection_Bit11:=0;
			OUT.TraverseToFixedEndstop_Bit8:=0;
			
			Status.Ready:=0;
			Status.InPosition:=0;
			
			IF Command.PowerON=1 THEN
				Step:=Step+1;
			END_IF
			
		1: Info:="Cakam na povolenie pristupu";
			OUT.ControlByPLC_Bit10:=1;
			IF IN.ControlRequested_Bit9=1 THEN
				Step:=Step+1;
			END_IF
			
		2: Info:="Cakam na zrusenie quick stop";
			OUT.NoIntermediateStop_Bit5:=1;
			OUT.NoQuickStop_Bit2:=1;		
			IF IN.QuickStopNotActivated_Bit5=1 THEN
				Step:=Step+1;
			END_IF
			
		3: Info:="Cakam na zrusenie coast stop";
			OUT.NoCoastStop_Bit1:=1;		
			IF IN.CoastStopNotActivated_Bit4=1 THEN
				Step:=Step+1;
			END_IF
			
		4: Info:="Cakam na zresetovanie chyby";
			Command.ErrReset:=1;
			IF IN.FaultCode=0 AND IN.WarnCode=0 THEN
				Command.ErrReset:=0;
				Step:=Step+1;
			END_IF
		
		5: Info:="rezerva";
			Step:=Step+1;
		
		6: Info:="Driver nie je pripraveny na spustenie";
			IF IN.ReadyToSwitchON_Bit0=1 THEN
				Step:=Step+1;
			END_IF
		
		7: Info:="Driver sa nepodarilo zapnut";
			OUT.SwitchON_Bit0:=1;
			IF IN.ReadyToOperate_Bit1=1 THEN
				Step:=Step+1;
			END_IF
		
		8: Info:="Vykonovu cast sa nepodarilo zapnut";
			OUT.EnableOperation_Bit3:=1;
			IF IN.OperationEnabled_Bit2=1 THEN
				Step:=Step+1;
			END_IF
		
		9: Info:="Nepodarilo sa aktivovat MDI";
			OUT.DoNotRejectTraversingTask_Bit4:=1;			
			OUT.MDIselection_Bit15:=1;
			IF IN.MDIactive_Bit15=1 THEN
				Step:=Step+1;
			END_IF
				
		10:Step:=90;
			
		90: Info:="Cakam na zrusenie prikazu MOVE POSITION";
			IF Command.MovePosition=0 THEN
				Step:=Step+1;
			END_IF
		
		91: Info:="Cakam na zrusenie prikazu MOVE ADITIVE";
			IF Command.MoveAdditive=0 THEN
				Step:=Step+1;
			END_IF
			
		92: Info:="Cakam na zrusenie prikazu JOG POSITIVE";
			IF Command.JogPos=0 THEN
				Step:=Step+1;
			END_IF
		
		93: Info:="Cakam na zrusenie prikazu JOG NEGATIVE";
			IF Command.JogNeg=0 THEN
				Step:=Step+1;
			END_IF
		
		94:Step:=Step+1;
		95:Step:=Step+1;
		96:Step:=Step+1;
		97:Step:=Step+1;
		98:Step:=Step+1;
		99:Step:=Step+1;		
			
		
		100:Info:="Pripraveny cakam na povel";
		
			
			OUT_forMapping.MDI_acceleration:=REAL_TO_UINT(Parameters.Acc*163.839989933671);
			OUT_forMapping.MDI_decceleration:=REAL_TO_UINT(Parameters.Dcc*163.839989933671);
			OUT_forMapping.MDI_velocity:=REAL_TO_UDINT(Parameters.Velocity*1000);
			OUT.ActivateSoftLimitSwitch_Bit14:=1;
			
			IF Command.MovePosition=1 AND IN.TraversingTaskAck_Bit12=0 THEN
				OUT.AbsolutePositioning_Bit8:=1;
				OUT_forMapping.MDI_target_position:=REAL_TO_UDINT(Parameters.Position*100);
				IF (Parameters.Position>=Status.ActPosition-0.05) AND (Parameters.Position<=Status.ActPosition+0.05) THEN
					Step:=113;
				ELSE
					Step:=110;
				END_IF
			ELSIF Command.MoveAdditive=1 THEN
				OUT.AbsolutePositioning_Bit8:=0;
				OUT_forMapping.MDI_target_position:=REAL_TO_UDINT(Parameters.Distance*100);
				Step:=120;
			ELSIF Command.JogPos=1 THEN
				Step:=130;
			ELSIF Command.JogNeg=1 THEN
				Step:=140;
			END_IF
		
			// move position
		110:Info:="Cakam na potvrdenie pohyboveho prikazu";
			OUT.ActivateTraversingTask_Bit6:=1;
			IF IN.TraversingTaskAck_Bit12=1 THEN
				Step:=Step+1;
			END_IF
			
		111:Info:="Cakam na potvrdenie pohyboveho prikazu";
			IF IN.TraversingCommandActive_Bit15=1 THEN
				Step:=Step+1;
			END_IF
			
		
		112:Info:="Cakam kym servo napolohuje";
			IF EDGEPOS (IN.TargetPositionReached_Bit10=1) THEN
				OUT.ActivateTraversingTask_Bit6:=0;
				Step:=Step+1;
			ELSIF EDGEPOS (Command.MovePosition=1) THEN			
				OUT.ActivateTraversingTask_Bit6:=0;
				Step:=114;
			END_IF
		
		113:Info:="Cakam na zrusenie poziadavky na polohovanie";
			Status.InPosition:=1;
			IF Command.MovePosition=0 THEN
				Status.InPosition:=0;
				Step:=199;
			END_IF
			
		114:Info:="Cakam kym servo prerusi ulohu";	
			IF IN.TraversingTaskAck_Bit12=0 THEN
				Step:=199;
			END_IF
						
			
			// move addition
		120:Info:="Cakam na potvrdenie pohyboveho prikazu";
			OUT.ActivateTraversingTask_Bit6:=1;
			IF IN.TraversingTaskAck_Bit12=1 THEN
				Step:=Step+1;
			END_IF
		
		121:Info:="Cakam kym servo napolohuje";
			IF IN.TargetPositionReached_Bit10=1 THEN
				OUT.ActivateTraversingTask_Bit6:=0;
				Step:=Step+1;
			END_IF
		
		122:Info:="Cakam na zrusenie poziadavky na polohovanie";
			Status.InPosition:=1;
			IF Command.MoveAdditive=0 THEN
				Status.InPosition:=0;
				Step:=199;
			END_IF
			// jog positive
		130:Info:="Jog positivnym smerom";
			IF Command.JogPos=1 THEN
				OUT.Jog1_Bit8:=1;
			ELSE
				OUT.Jog1_Bit8:=0;
				Step:=199;
			END_IF
			
		140:Info:="Jog negativnym smerom";
			IF Command.JogNeg=1 THEN
				OUT.Jog2_Bit9:=1;
			ELSE
				OUT.Jog2_Bit9:=0;
				Step:=199;
			END_IF
		199:
			Step:=100;
	END_CASE
	
	
	// chybove hlasky
	IF IN_forMapping.Fault_Code<>0 THEN
		Status.Error:=1;
	ELSE
		Status.Error:=0;
	END_IF
	CASE IN_forMapping.Fault_Code OF
		0: Status.ErrorMessage:="No error";
		36: Status.ErrorMessage:="Napajacie napatie nepritomne";
		38: Status.ErrorMessage:="Podpatie na napajani";
		73: Status.ErrorMessage:="Nespravna hodnota rychlosti/akceleracie";
		74: Status.ErrorMessage:="Nespravna hodnota akceleracie/deceleracie";
		109: Status.ErrorMessage:="Negativny softwareovy limit prekroceny";
		110: Status.ErrorMessage:="Pozitivny softwareovy limit prekroceny";
		141: Status.ErrorMessage:="Nespravne procesne data (velocity, override, acc, dcc...";
			
		ELSE
			Status.ErrorMessage:="Neznama chyba";
	END_CASE
	
	// varovania
	IF IN_forMapping.Warn_Code<>0 THEN
		Status.Warning:=1;
	ELSE
		Status.Warning:=0;
	END_IF
	CASE IN_forMapping.Warn_Code OF
		0: Status.WarningMessage:="No warning";
		37: Status.WarningMessage:="Prerusenie napajania";
		111: Status.WarningMessage:="Limit v negativnom smere";
		112: Status.WarningMessage:="Limit v pozitivnom smere";
		129: Status.WarningMessage:="Out of target range";
		364: Status.WarningMessage:="Nastavena rychlost = 0";
			
		ELSE
			Status.WarningMessage:="Nezname varovanie";
	END_CASE
	
	//reset poruch a varovani
	OUT.FaultAck_Bit7:=Command.ErrReset;
	IF Step>=100 AND IN.FaultPresent_Bit3=1 THEN		
		IF EDGEPOS ( Command.ErrReset=1) THEN
			Step:=0;
		END_IF		
	END_IF
	IF EDGENEG ( Command.ErrReset=1) THEN
		Step:=1;
	END_IF


END_FUNCTION_BLOCK
