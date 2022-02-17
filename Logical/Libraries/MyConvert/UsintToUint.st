
(* Konvertovanie dvoch Usint do jednoho Uint *)
FUNCTION_BLOCK UsintToUint
	
	OUT_UINT.0:= IN_Byte0.0;
	OUT_UINT.1:= IN_Byte0.1;
	OUT_UINT.2:= IN_Byte0.2;
	OUT_UINT.3:= IN_Byte0.3;
	OUT_UINT.4:= IN_Byte0.4;
	OUT_UINT.5:= IN_Byte0.5;
	OUT_UINT.6:= IN_Byte0.6;
	OUT_UINT.7:= IN_Byte0.7;
	OUT_UINT.8:= IN_Byte1.0;
	OUT_UINT.9:= IN_Byte1.1;
	OUT_UINT.10:= IN_Byte1.2;
	OUT_UINT.11:= IN_Byte1.3;
	OUT_UINT.12:= IN_Byte1.4;
	OUT_UINT.13:= IN_Byte1.5;
	OUT_UINT.14:= IN_Byte1.6;
	OUT_UINT.15:= IN_Byte1.7;
	
END_FUNCTION_BLOCK
