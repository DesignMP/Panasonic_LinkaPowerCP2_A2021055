
{REDUND_ERROR} FUNCTION_BLOCK BannerIOlink (*Banner na IO linku*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Mapping_IN : {REDUND_UNREPLICABLE} ARRAY[0..15] OF USINT;
		IN : {REDUND_UNREPLICABLE} Banner_IN_typ;
	END_VAR
	VAR_OUTPUT
		Mapping_OUT : ARRAY[0..15] OF USINT;
		OUT : Banner_OUT_typ;
	END_VAR
	VAR
		Step : USINT;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK
