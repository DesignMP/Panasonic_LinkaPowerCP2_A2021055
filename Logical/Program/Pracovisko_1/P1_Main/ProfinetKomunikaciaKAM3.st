
ACTION ProfinetKomunikaciaKAM3: 

	CAM3.STAV.READY;
	
	//Vstupy pre kameru//
	CAM3.Profinet_PLC_OUTPUTS[0].0:= CAM3.CMD.Triger;
	
	//V�stupy z kamery//
	CAM3.STAV.SWITCH:= CAM3.Profinet_PLC_INPUTS[10].0;
	
	
	//V�sledky kamery//
	CAM3.RESULT.Paletka.CitanieQRkodu_DPS_OK:= CAM3.Profinet_PLC_INPUTS[0].0;
	
	//Pre��tan� QR k�d DPS//
	IF EDGE(CAM3.STAV.SWITCH) THEN
		brsstrcpy(ADR(CAM3.RESULT.Paletka.PrecitanyQRkod_DPS),ADR(CAM3.Profinet_QRkod_Znaky));    	
	END_IF
	
	//Stav v�sledky READY//
	IF EDGE(CAM3.STAV.SWITCH)THEN
		CAM3.STAV.Results_READY:= TRUE;
	END_IF
	
	END_ACTION