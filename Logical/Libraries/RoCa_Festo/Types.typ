
TYPE
	OutputRawStruc : 	STRUCT 
		Control_word_or_setpoint_0 : UINT;
		Control_word_or_setpoint_1 : UINT;
		Control_word_or_setpoint_2 : UINT;
		Control_word_or_setpoint_3 : UINT;
		Control_word_or_setpoint_4 : UINT;
		Control_word_or_setpoint_5 : UINT;
		Control_word_or_setpoint_6 : UINT;
		Control_word_or_setpoint_7 : UINT;
		Control_word_or_setpoint_8 : UINT;
		Control_word_or_setpoint_9 : UINT;
		Control_word_or_setpoint_10 : UINT;
		Control_word_or_setpoint_11 : UINT;
		Control_word_or_setpoint_12 : UINT;
		Control_word_or_setpoint_13 : UINT;
		Control_word_or_setpoint_14 : UINT;
		Control_word_or_setpoint_15 : UINT;
		User1 : UINT;
		MDI_decceleration : UINT;
		MDI_acceleration : UINT;
		MDI_velocity : UDINT;
		MDI_target_position : UDINT;
		Override : UINT;
		Position_Controlword_2 : UINT;
		Position_Controlword_1 : UINT;
		Control_word_2 : UINT;
		Control_word_1 : UINT;
	END_STRUCT;
	InputRawStruc : 	STRUCT 
		Status_word_or_actual_value_0 : UINT;
		Status_word_or_actual_value_1 : UINT;
		Status_word_or_actual_value_2 : UINT;
		Status_word_or_actual_value_3 : UINT;
		Status_word_or_actual_value_4 : UINT;
		Status_word_or_actual_value_5 : UINT;
		Status_word_or_actual_value_6 : UINT;
		Status_word_or_actual_value_7 : UINT;
		Status_word_or_actual_value_8 : UINT;
		Status_word_or_actual_value_9 : UINT;
		Status_word_or_actual_value_10 : UINT;
		Status_word_or_actual_value_11 : UINT;
		Status_word_or_actual_value_12 : UINT;
		Status_word_or_actual_value_13 : UINT;
		Status_word_or_actual_value_14 : UINT;
		Status_word_or_actual_value_15 : UINT;
		User : UINT;
		Warn_Code : UINT;
		Fault_Code : UINT;
		Speed_actual_value_B : UDINT;
		Position_actual_value_A : UDINT;
		Report_word : UINT;
		Position_Statusword_2 : UINT;
		Position_Statusword_1 : UINT;
		Status_word_2 : UINT;
		Status_word_1 : UINT;
	END_STRUCT;
	OutputStruc : 	STRUCT 
		ExtendedParam0 : UINT;
		ExtendedParam1 : UINT;
		ExtendedParam2 : UINT;
		ExtendedParam3 : UINT;
		ExtendedParam4 : UINT;
		ExtendedParam5 : UINT;
		ExtendedParam6 : UINT;
		ExtendedParam7 : UINT;
		ExtendedParam8 : UINT;
		ExtendedParam9 : UINT;
		ExtendedParam10 : UINT;
		ExtendedParam11 : UINT;
		ExtendedParam12 : UINT;
		ExtendedParam13 : UINT;
		ExtendedParam14 : UINT;
		ExtendedParam15 : UINT;
		user : UINT;
		TraverseToFixedEndstop_Bit8 : BOOL;
		ActivateHardwLimitSwitch_Bit15 : BOOL;
		ActivateSoftLimitSwitch_Bit14 : BOOL;
		TouchProbeEdgeSelection_Bit11 : BOOL;
		TouchProbeSelection_Bit10 : BOOL;
		JoggingIncremental_Bit5 : BOOL;
		MDIselection_Bit15 : BOOL;
		NegModuloPositioningDir_Bit10 : BOOL;
		PosModuloPositioningDir_Bit9 : BOOL;
		AbsolutePositioning_Bit8 : BOOL;
		TraversingBlockSelection_Bit0 : BOOL;
		TraversingBlockSelection_Bit1 : BOOL;
		TraversingBlockSelection_Bit2 : BOOL;
		TraversingBlockSelection_Bit3 : BOOL;
		TraversingBlockSelection_Bit4 : BOOL;
		TraversingBlockSelection_Bit5 : BOOL;
		TraversingBlockSelection_Bit6 : BOOL;
		OpenHoldingBrake_Bit12 : BOOL;
		StartHomingProcedure_Bit11 : BOOL;
		ControlByPLC_Bit10 : BOOL;
		Jog2_Bit9 : BOOL;
		Jog1_Bit8 : BOOL;
		FaultAck_Bit7 : BOOL;
		ActivateTraversingTask_Bit6 : BOOL;
		NoIntermediateStop_Bit5 : BOOL;
		DoNotRejectTraversingTask_Bit4 : BOOL;
		EnableOperation_Bit3 : BOOL;
		NoQuickStop_Bit2 : BOOL;
		NoCoastStop_Bit1 : BOOL;
		SwitchON_Bit0 : BOOL;
	END_STRUCT;
	InputStruc : 	STRUCT 
		ExtendedParam0 : UINT;
		ExtendedParam1 : UINT;
		ExtendedParam2 : UINT;
		ExtendedParam3 : UINT;
		ExtendedParam4 : UINT;
		ExtendedParam5 : UINT;
		ExtendedParam6 : UINT;
		ExtendedParam7 : UINT;
		ExtendedParam8 : UINT;
		ExtendedParam9 : UINT;
		ExtendedParam10 : UINT;
		ExtendedParam11 : UINT;
		ExtendedParam12 : UINT;
		ExtendedParam13 : UINT;
		ExtendedParam14 : UINT;
		ExtendedParam15 : UINT;
		User : UINT;
		WarnCode : UINT;
		FaultCode : UINT;
		Speed : UDINT;
		Position : UDINT;
		PulsesEnabledMELDW_Bit13 : BOOL;
		DriveReady_Bit12 : BOOL;
		ControlerEnabled_Bit11 : BOOL;
		SpeedSetpointDeviationInTol_Bit8 : BOOL;
		PsTempWarningInactive_Bit7 : BOOL;
		MotorTempWarningInactive_Bit6 : BOOL;
		VariableSignalingFunction_Bit5 : BOOL;
		RPMequalThreshold_Bit3 : BOOL;
		RPMlowerThreshold_Bit2 : BOOL;
		TorqUtilLessTorqThres_Bit1 : BOOL;
		RampFunctionCompleted_Bit0 : BOOL;
		PulsesEnabled_Bit11 : BOOL;
		MoveToFixedStopActiveZSW2_Bit8 : BOOL;
		TraversingCommandActive_Bit15 : BOOL;
		MoveToFixedStopActive_Bit14 : BOOL;
		FixedStopClampTorqReached_Bit13 : BOOL;
		FixedStopReached_Bit12 : BOOL;
		DirectOut2ViaTraversBlock_Bit11 : BOOL;
		DirectOut1ViaTraversBlock_Bit10 : BOOL;
		PosActValueLessCamSwitch1_Bit9 : BOOL;
		PosActValueLessCamSwitch0_Bit8 : BOOL;
		SoftwareLimitSwitchPlus_Bit7 : BOOL;
		SoftwareLimitSwitchMinus_Bit6 : BOOL;
		DriveMovesBackwards_Bit5 : BOOL;
		DriveMovesForward_Bit4 : BOOL;
		SetpointAvailable_Bit2 : BOOL;
		VelocityLimitingActive_Bit1 : BOOL;
		TrackingModeActive_Bit0 : BOOL;
		MDIactive_Bit15 : BOOL;
		TraversingBlockActive_Bit13 : BOOL;
		RefPointAproachActive_Bit11 : BOOL;
		JoggingActive_Bit10 : BOOL;
		PositiveLimitSwitch_Bit9 : BOOL;
		NegativeLimitSwitch_Bit8 : BOOL;
		ActiveTravesringBlock_Bit0 : BOOL;
		ActiveTravesringBlock_Bit1 : BOOL;
		ActiveTravesringBlock_Bit2 : BOOL;
		ActiveTravesringBlock_Bit3 : BOOL;
		ActiveTravesringBlock_Bit4 : BOOL;
		ActiveTravesringBlock_Bit5 : BOOL;
		ActiveTravesringBlock_Bit6 : BOOL;
		AxisDeccelerated_Bit15 : BOOL;
		AxisAccelerated_Bit14 : BOOL;
		DriveStopped_Bit13 : BOOL;
		TraversingTaskAck_Bit12 : BOOL;
		HomePositionSet_Bit11 : BOOL;
		TargetPositionReached_Bit10 : BOOL;
		ControlRequested_Bit9 : BOOL;
		FolowingErrorWithinTol_Bit8 : BOOL;
		WarningPresent_Bit7 : BOOL;
		SwitchingOnInhibited_Bit6 : BOOL;
		QuickStopNotActivated_Bit5 : BOOL;
		CoastStopNotActivated_Bit4 : BOOL;
		FaultPresent_Bit3 : BOOL;
		OperationEnabled_Bit2 : BOOL;
		ReadyToOperate_Bit1 : BOOL;
		ReadyToSwitchON_Bit0 : BOOL;
	END_STRUCT;
	FestoServoDriverStruc : 	STRUCT 
		OUT_forMapping : OutputRawStruc;
		IN_forMapping : InputRawStruc;
		OUT : OutputStruc;
		IN : InputStruc;
		Step : USINT;
		Info : WSTRING[80];
		Status : StatusStruc;
		Command : CommandStruc;
		Parameters : ParamStruc;
	END_STRUCT;
	ParamStruc : 	STRUCT 
		Torque : REAL; (*Nm*)
		Distance : REAL; (*vzdialenost pre move additive [mm]*)
		Position : REAL; (*pozicia pre move position [mm]*)
		Override : REAL; (*0-200%*)
		Velocity : REAL; (*m/s*)
		Dcc : REAL; (*m/s2*)
		Acc : REAL; (*m/s2*)
		Jog : JogStruc;
	END_STRUCT;
	CommandStruc : 	STRUCT 
		PowerON : BOOL;
		ErrReset : BOOL;
		JogNeg : BOOL;
		JogPos : BOOL;
		MoveAdditive : BOOL;
		MovePosition : BOOL;
		TorqueLimitation : BOOL; (*1-orezava moment na nastaveny v parametroch*)
		Stop : BOOL;
		Pause : BOOL;
	END_STRUCT;
	StatusStruc : 	STRUCT 
		WarningMessage : WSTRING[80];
		ErrorMessage : WSTRING[80];
		InTorque : BOOL;
		InPosition2 : BOOL;
		InPosition : BOOL;
		StandStill : BOOL;
		Warning : BOOL;
		Error : BOOL;
		Ready : BOOL;
		ActTorque : REAL; (*Nm*)
		ActVelocity : REAL; (*mm/s*)
		ActPosition : REAL; (*mm*)
	END_STRUCT;
	JogStruc : 	STRUCT 
		Acc : REAL;
		Velocity : REAL;
	END_STRUCT;
	LinearScaling_InternalStruc : 	STRUCT 
		ScaleFactor : REAL;
		Offset : REAL;
	END_STRUCT;
	LinearScaling_SettingStruc : 	STRUCT 
		InputLowerLimit : REAL; (*Minimum ktore vie vstup dosiahnut*)
		InputUpperLimit : REAL; (*Maximum ktore vie vstup dosiahnut*)
		OutputLowerLimit : REAL; (*Minimum ktore ma vystup ukazovat*)
		OutputUpperLimit : REAL; (*Maximum ktore ma vystup ukazovat*)
	END_STRUCT;
END_TYPE
