
{REDUND_ERROR} FUNCTION_BLOCK UsintToUint (*Konvertovanie dvoch Usint do jednoho Uint*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_Byte0 : {REDUND_UNREPLICABLE} USINT;
		IN_Byte1 : {REDUND_UNREPLICABLE} USINT;
	END_VAR
	VAR_OUTPUT
		OUT_UINT : UINT;
	END_VAR
END_FUNCTION_BLOCK