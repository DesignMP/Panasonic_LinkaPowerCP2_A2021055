
ACTION ProfinetKomunikaciaKAM14: 
	//Smart kamera//

	CAM14.STAV.READY:= P4_Pracovisko.IN.SmartKamera14_KomOK;
	
	//Vstupy pre kameru//
	CAM14.Profinet_PLC_OUTPUTS[0].0:= CAM14.CMD.Triger;
	
	//Výstupy z kamery//
	CAM14.STAV.SWITCH:= CAM14.Profinet_PLC_INPUTS[12].0;
	
	
	//Výsledky kamery//
	CAM14.RESULT.PowerCP.CitanieQRkodu_PowerCP_OK:= CAM14.Profinet_PLC_INPUTS[0].0;
	
	//Preèítaný QR kód DPS//
	IF EDGE(CAM14.STAV.SWITCH) THEN
		brsstrcpy(ADR(CAM14.RESULT.PowerCP.PrecitanyQRkod_PowerCP),ADR(CAM14.Profinet_QRkod_Znaky));    	
	END_IF
	
	//Stav výsledky READY//
	IF EDGE(CAM14.STAV.SWITCH)THEN
		CAM14.STAV.Results_READY:= TRUE;
	END_IF
	
	//Run counter kamery//
	Convert_0.IN_Byte0:= CAM14.STAV.RunCounter_Byte1;
	Convert_0.IN_Byte1:= CAM14.STAV.RunCounter_Byte0;
	
	CAM14.STAV.RunCounter:= Convert_0.OUT_UINT;
	Convert_0();
	
END_ACTION
