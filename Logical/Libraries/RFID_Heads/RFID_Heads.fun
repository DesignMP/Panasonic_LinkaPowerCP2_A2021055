
{REDUND_ERROR} FUNCTION_BLOCK SickHeads (*RFID hlavy SICK*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		CitaciuHlavu_VYPNI : BOOL;
		PrecitajChipRFID : BOOL;
		ZapisNaChipRFID : BOOL;
		ZadaneCisloPaletky : USINT;
		Mapping_IN : ARRAY[0..7] OF USINT;
	END_VAR
	VAR_OUTPUT
		PritomnostPaletky : BOOL;
		Stav_CitaciaHlava_ON : BOOL;
		Stav_CitanieZapis_OK : BOOL;
		Stav_CitanieZapis_NG : BOOL;
		PrecitaneCisloPaletky : USINT;
		Mapping_OUT : ARRAY[0..7] OF USINT;
	END_VAR
	VAR
		Step : USINT;
	END_VAR
END_FUNCTION_BLOCK
