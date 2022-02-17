
{REDUND_ERROR} FUNCTION_BLOCK PickAndPlace (*Skrutkovací set Pig and Place*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		CMD : PickAndPlace_CMD_typ;
		IN : {REDUND_UNREPLICABLE} PickAndPlace_IN_typ;
	END_VAR
	VAR_OUTPUT
		OUT : PickAndPlace_OUT_typ;
		STAV : PickAndPlace_STAV_typ;
	END_VAR
	VAR
		Internal : PickAndPlace_Internal_typ;
		Step : USINT;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MaticaSet (*Skrutkovací set maticovaèky*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		CMD : MaticaSet_CMD_typ;
		IN : {REDUND_UNREPLICABLE} MaticaSet_IN_typ;
	END_VAR
	VAR_OUTPUT
		OUT : MaticaSet_OUT_typ;
		STAV : MaticaSet_STAV_typ;
	END_VAR
	VAR
		Internal : MaticaSet_Internal_typ;
		Step : USINT;
	END_VAR
END_FUNCTION_BLOCK
