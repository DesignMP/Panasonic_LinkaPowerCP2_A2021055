
{REDUND_OK} FUNCTION_BLOCK ServoDriver (*Riadenie festo driverov*) (*$GROUP=User,$CAT=Motion,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_forMapping : InputRawStruc;
		IN : InputStruc;
		Command : CommandStruc;
		Parameters : ParamStruc;
	END_VAR
	VAR_OUTPUT
		OUT_forMapping : OutputRawStruc;
		OUT : OutputStruc;
		Step : USINT;
		Info : WSTRING[80];
		Status : StatusStruc;
	END_VAR
	VAR
		TwoUINTtoREAL1 : twoUINTtoREAL;
		TwoUINTtoREAL2 : twoUINTtoREAL;
		TwoUINTtoREAL3 : twoUINTtoREAL;
		REALtoTwoUINT1 : REALtoTwoUINT;
		REALtoTwoUINT2 : REALtoTwoUINT;
		REALtoTwoUINT3 : REALtoTwoUINT;
		zzEdge00000 : {REDUND_UNREPLICABLE} BOOL;
		zzEdge00001 : {REDUND_UNREPLICABLE} BOOL;
		zzEdge00002 : {REDUND_UNREPLICABLE} BOOL;
		zzEdge00003 : {REDUND_UNREPLICABLE} BOOL;
		zzEdge00004 : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK twoUINTtoREAL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=Conversion,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN1 : UINT; (*Vstupna premenna cislo 1*)
		IN2 : UINT; (*Vstupna premenna cislo 2*)
		order : BOOL; (*Poradie 0=IN1 first, 1=IN2 first*)
	END_VAR
	VAR_OUTPUT
		Out : REAL; (*Výstup vo formate REAL*)
	END_VAR
	VAR
		NxtADR : UDINT;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK REALtoTwoUINT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=Conversion,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN : REAL; (*Vstup vo formate REAL*)
		order : BOOL; (*poradie vystupov 0=OUT1 first, 1=OUT2first*)
	END_VAR
	VAR_OUTPUT
		OUT1 : UINT; (*Vystup vo formate UINT*)
		OUT2 : UINT; (*Vystup vo formate UINT*)
	END_VAR
	VAR
		NxtADR : UDINT;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK Linear_scaling (*Linearne skalovanie*) (*$GROUP=ROCA,$CAT=Mathematics,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Input : REAL; (*Vstup na preskalovanie*)
		Setting : LinearScaling_SettingStruc; (*Nastavenia*)
	END_VAR
	VAR_OUTPUT
		Output : REAL; (*Preskalovany vystup*)
		Info : STRING[80];
	END_VAR
	VAR
		Internal : LinearScaling_InternalStruc; (*Interne hodnoty pre prepocty*)
	END_VAR
END_FUNCTION_BLOCK
