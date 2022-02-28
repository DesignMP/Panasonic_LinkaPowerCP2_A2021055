/* Automation Studio generated header file */
/* Do not edit ! */
/* RoCa_Festo 1.00.0 */

#ifndef _ROCA_FESTO_
#define _ROCA_FESTO_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _RoCa_Festo_VERSION
#define _RoCa_Festo_VERSION 1.00.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct OutputRawStruc
{	unsigned short Control_word_or_setpoint_0;
	unsigned short Control_word_or_setpoint_1;
	unsigned short Control_word_or_setpoint_2;
	unsigned short Control_word_or_setpoint_3;
	unsigned short Control_word_or_setpoint_4;
	unsigned short Control_word_or_setpoint_5;
	unsigned short Control_word_or_setpoint_6;
	unsigned short Control_word_or_setpoint_7;
	unsigned short Control_word_or_setpoint_8;
	unsigned short Control_word_or_setpoint_9;
	unsigned short Control_word_or_setpoint_10;
	unsigned short Control_word_or_setpoint_11;
	unsigned short Control_word_or_setpoint_12;
	unsigned short Control_word_or_setpoint_13;
	unsigned short Control_word_or_setpoint_14;
	unsigned short Control_word_or_setpoint_15;
	unsigned short User1;
	unsigned short MDI_decceleration;
	unsigned short MDI_acceleration;
	unsigned long MDI_velocity;
	unsigned long MDI_target_position;
	unsigned short Override;
	unsigned short Position_Controlword_2;
	unsigned short Position_Controlword_1;
	unsigned short Control_word_2;
	unsigned short Control_word_1;
} OutputRawStruc;

typedef struct InputRawStruc
{	unsigned short Status_word_or_actual_value_0;
	unsigned short Status_word_or_actual_value_1;
	unsigned short Status_word_or_actual_value_2;
	unsigned short Status_word_or_actual_value_3;
	unsigned short Status_word_or_actual_value_4;
	unsigned short Status_word_or_actual_value_5;
	unsigned short Status_word_or_actual_value_6;
	unsigned short Status_word_or_actual_value_7;
	unsigned short Status_word_or_actual_value_8;
	unsigned short Status_word_or_actual_value_9;
	unsigned short Status_word_or_actual_value_10;
	unsigned short Status_word_or_actual_value_11;
	unsigned short Status_word_or_actual_value_12;
	unsigned short Status_word_or_actual_value_13;
	unsigned short Status_word_or_actual_value_14;
	unsigned short Status_word_or_actual_value_15;
	unsigned short User;
	unsigned short Warn_Code;
	unsigned short Fault_Code;
	unsigned long Speed_actual_value_B;
	unsigned long Position_actual_value_A;
	unsigned short Report_word;
	unsigned short Position_Statusword_2;
	unsigned short Position_Statusword_1;
	unsigned short Status_word_2;
	unsigned short Status_word_1;
} InputRawStruc;

typedef struct OutputStruc
{	unsigned short ExtendedParam0;
	unsigned short ExtendedParam1;
	unsigned short ExtendedParam2;
	unsigned short ExtendedParam3;
	unsigned short ExtendedParam4;
	unsigned short ExtendedParam5;
	unsigned short ExtendedParam6;
	unsigned short ExtendedParam7;
	unsigned short ExtendedParam8;
	unsigned short ExtendedParam9;
	unsigned short ExtendedParam10;
	unsigned short ExtendedParam11;
	unsigned short ExtendedParam12;
	unsigned short ExtendedParam13;
	unsigned short ExtendedParam14;
	unsigned short ExtendedParam15;
	unsigned short user;
	plcbit TraverseToFixedEndstop_Bit8;
	plcbit ActivateHardwLimitSwitch_Bit15;
	plcbit ActivateSoftLimitSwitch_Bit14;
	plcbit TouchProbeEdgeSelection_Bit11;
	plcbit TouchProbeSelection_Bit10;
	plcbit JoggingIncremental_Bit5;
	plcbit MDIselection_Bit15;
	plcbit NegModuloPositioningDir_Bit10;
	plcbit PosModuloPositioningDir_Bit9;
	plcbit AbsolutePositioning_Bit8;
	plcbit TraversingBlockSelection_Bit0;
	plcbit TraversingBlockSelection_Bit1;
	plcbit TraversingBlockSelection_Bit2;
	plcbit TraversingBlockSelection_Bit3;
	plcbit TraversingBlockSelection_Bit4;
	plcbit TraversingBlockSelection_Bit5;
	plcbit TraversingBlockSelection_Bit6;
	plcbit OpenHoldingBrake_Bit12;
	plcbit StartHomingProcedure_Bit11;
	plcbit ControlByPLC_Bit10;
	plcbit Jog2_Bit9;
	plcbit Jog1_Bit8;
	plcbit FaultAck_Bit7;
	plcbit ActivateTraversingTask_Bit6;
	plcbit NoIntermediateStop_Bit5;
	plcbit DoNotRejectTraversingTask_Bit4;
	plcbit EnableOperation_Bit3;
	plcbit NoQuickStop_Bit2;
	plcbit NoCoastStop_Bit1;
	plcbit SwitchON_Bit0;
} OutputStruc;

typedef struct InputStruc
{	unsigned short ExtendedParam0;
	unsigned short ExtendedParam1;
	unsigned short ExtendedParam2;
	unsigned short ExtendedParam3;
	unsigned short ExtendedParam4;
	unsigned short ExtendedParam5;
	unsigned short ExtendedParam6;
	unsigned short ExtendedParam7;
	unsigned short ExtendedParam8;
	unsigned short ExtendedParam9;
	unsigned short ExtendedParam10;
	unsigned short ExtendedParam11;
	unsigned short ExtendedParam12;
	unsigned short ExtendedParam13;
	unsigned short ExtendedParam14;
	unsigned short ExtendedParam15;
	unsigned short User;
	unsigned short WarnCode;
	unsigned short FaultCode;
	unsigned long Speed;
	unsigned long Position;
	plcbit PulsesEnabledMELDW_Bit13;
	plcbit DriveReady_Bit12;
	plcbit ControlerEnabled_Bit11;
	plcbit SpeedSetpointDeviationInTol_Bit8;
	plcbit PsTempWarningInactive_Bit7;
	plcbit MotorTempWarningInactive_Bit6;
	plcbit VariableSignalingFunction_Bit5;
	plcbit RPMequalThreshold_Bit3;
	plcbit RPMlowerThreshold_Bit2;
	plcbit TorqUtilLessTorqThres_Bit1;
	plcbit RampFunctionCompleted_Bit0;
	plcbit PulsesEnabled_Bit11;
	plcbit MoveToFixedStopActiveZSW2_Bit8;
	plcbit TraversingCommandActive_Bit15;
	plcbit MoveToFixedStopActive_Bit14;
	plcbit FixedStopClampTorqReached_Bit13;
	plcbit FixedStopReached_Bit12;
	plcbit DirectOut2ViaTraversBlock_Bit11;
	plcbit DirectOut1ViaTraversBlock_Bit10;
	plcbit PosActValueLessCamSwitch1_Bit9;
	plcbit PosActValueLessCamSwitch0_Bit8;
	plcbit SoftwareLimitSwitchPlus_Bit7;
	plcbit SoftwareLimitSwitchMinus_Bit6;
	plcbit DriveMovesBackwards_Bit5;
	plcbit DriveMovesForward_Bit4;
	plcbit SetpointAvailable_Bit2;
	plcbit VelocityLimitingActive_Bit1;
	plcbit TrackingModeActive_Bit0;
	plcbit MDIactive_Bit15;
	plcbit TraversingBlockActive_Bit13;
	plcbit RefPointAproachActive_Bit11;
	plcbit JoggingActive_Bit10;
	plcbit PositiveLimitSwitch_Bit9;
	plcbit NegativeLimitSwitch_Bit8;
	plcbit ActiveTravesringBlock_Bit0;
	plcbit ActiveTravesringBlock_Bit1;
	plcbit ActiveTravesringBlock_Bit2;
	plcbit ActiveTravesringBlock_Bit3;
	plcbit ActiveTravesringBlock_Bit4;
	plcbit ActiveTravesringBlock_Bit5;
	plcbit ActiveTravesringBlock_Bit6;
	plcbit AxisDeccelerated_Bit15;
	plcbit AxisAccelerated_Bit14;
	plcbit DriveStopped_Bit13;
	plcbit TraversingTaskAck_Bit12;
	plcbit HomePositionSet_Bit11;
	plcbit TargetPositionReached_Bit10;
	plcbit ControlRequested_Bit9;
	plcbit FolowingErrorWithinTol_Bit8;
	plcbit WarningPresent_Bit7;
	plcbit SwitchingOnInhibited_Bit6;
	plcbit QuickStopNotActivated_Bit5;
	plcbit CoastStopNotActivated_Bit4;
	plcbit FaultPresent_Bit3;
	plcbit OperationEnabled_Bit2;
	plcbit ReadyToOperate_Bit1;
	plcbit ReadyToSwitchON_Bit0;
} InputStruc;

typedef struct StatusStruc
{	plcwstring WarningMessage[81];
	plcwstring ErrorMessage[81];
	plcbit InTorque;
	plcbit InPosition2;
	plcbit InPosition;
	plcbit StandStill;
	plcbit Warning;
	plcbit Error;
	plcbit Ready;
	float ActTorque;
	float ActVelocity;
	float ActPosition;
} StatusStruc;

typedef struct CommandStruc
{	plcbit PowerON;
	plcbit ErrReset;
	plcbit JogNeg;
	plcbit JogPos;
	plcbit MoveAdditive;
	plcbit MovePosition;
	plcbit TorqueLimitation;
	plcbit Stop;
	plcbit Pause;
} CommandStruc;

typedef struct JogStruc
{	float Acc;
	float Velocity;
} JogStruc;

typedef struct ParamStruc
{	float Torque;
	float Distance;
	float Position;
	float Override;
	float Velocity;
	float Dcc;
	float Acc;
	struct JogStruc Jog;
} ParamStruc;

typedef struct FestoServoDriverStruc
{	struct OutputRawStruc OUT_forMapping;
	struct InputRawStruc IN_forMapping;
	struct OutputStruc OUT;
	struct InputStruc IN;
	unsigned char Step;
	plcwstring Info[81];
	struct StatusStruc Status;
	struct CommandStruc Command;
	struct ParamStruc Parameters;
} FestoServoDriverStruc;

typedef struct LinearScaling_InternalStruc
{	float ScaleFactor;
	float Offset;
} LinearScaling_InternalStruc;

typedef struct LinearScaling_SettingStruc
{	float InputLowerLimit;
	float InputUpperLimit;
	float OutputLowerLimit;
	float OutputUpperLimit;
} LinearScaling_SettingStruc;

typedef struct twoUINTtoREAL
{
	/* VAR_INPUT (analog) */
	unsigned short IN1;
	unsigned short IN2;
	/* VAR_OUTPUT (analog) */
	float Out;
	/* VAR (analog) */
	unsigned long NxtADR;
	/* VAR_INPUT (digital) */
	plcbit order;
} twoUINTtoREAL_typ;

typedef struct REALtoTwoUINT
{
	/* VAR_INPUT (analog) */
	float IN;
	/* VAR_OUTPUT (analog) */
	unsigned short OUT1;
	unsigned short OUT2;
	/* VAR (analog) */
	unsigned long NxtADR;
	/* VAR_INPUT (digital) */
	plcbit order;
} REALtoTwoUINT_typ;

typedef struct ServoDriver
{
	/* VAR_INPUT (analog) */
	struct InputRawStruc IN_forMapping;
	struct InputStruc IN;
	struct CommandStruc Command;
	struct ParamStruc Parameters;
	/* VAR_OUTPUT (analog) */
	struct OutputRawStruc OUT_forMapping;
	struct OutputStruc OUT;
	unsigned char Step;
	plcwstring Info[81];
	struct StatusStruc Status;
	/* VAR (analog) */
	struct twoUINTtoREAL TwoUINTtoREAL1;
	struct twoUINTtoREAL TwoUINTtoREAL2;
	struct twoUINTtoREAL TwoUINTtoREAL3;
	struct REALtoTwoUINT REALtoTwoUINT1;
	struct REALtoTwoUINT REALtoTwoUINT2;
	struct REALtoTwoUINT REALtoTwoUINT3;
	/* VAR (digital) */
	plcbit zzEdge00000;
	plcbit zzEdge00001;
	plcbit zzEdge00002;
	plcbit zzEdge00003;
	plcbit zzEdge00004;
	plcbit zzEdge00005;
} ServoDriver_typ;

typedef struct Linear_scaling
{
	/* VAR_INPUT (analog) */
	float Input;
	struct LinearScaling_SettingStruc Setting;
	/* VAR_OUTPUT (analog) */
	float Output;
	plcstring Info[81];
	/* VAR (analog) */
	struct LinearScaling_InternalStruc Internal;
} Linear_scaling_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void ServoDriver(struct ServoDriver* inst);
_BUR_PUBLIC void twoUINTtoREAL(struct twoUINTtoREAL* inst);
_BUR_PUBLIC void REALtoTwoUINT(struct REALtoTwoUINT* inst);
_BUR_PUBLIC void Linear_scaling(struct Linear_scaling* inst);


#ifdef __cplusplus
};
#endif
#endif /* _ROCA_FESTO_ */

