
ACTION ProfinetKomunikaciaKAM7: 
	//Control unit CAM5//

	
		
	//Vstupy pre kameru//
	CAM7.Profinet_PLC_OUTPUTS[0].3:= CAM7.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM7.STAV.READY:= CAM7.Profinet_PLC_INPUTS[0].0;
	CAM7.STAV.SWITCH:= CAM7.Profinet_PLC_INPUTS[0].1;
    CAM7.STAV.BUSY:= CAM7.Profinet_PLC_INPUTS[0].2;
    CAM7.STAV.Command_AKCEPTOVANY:= CAM7.Profinet_PLC_INPUTS[0].3;
    CAM7.STAV.Command_READY:= CAM7.Profinet_PLC_INPUTS[0].4;
    CAM7.STAV.Command_ERROR:= CAM7.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM7.RESULT.CitanieQRkodu_Filtra5H_OK:= CAM7.Profinet_PLC_INPUTS[2].0;
	
		
	//Preèítaný QR kód fitra 5H//
	IF EDGE(CAM7.STAV.SWITCH) THEN
		brsstrcpy(ADR(CAM7.RESULT.PrecitanyQRkod_Filtra5H),ADR(CAM7.Profinet_QRkod_Znaky));    	
	END_IF
	
	//Stav výsledky READY//
	IF EDGE(CAM7.STAV.SWITCH)THEN
		CAM7.STAV.Results_READY:= TRUE;
	END_IF
	
	//Run counter kamery//
	Convert_0.IN_Byte0:= CAM7.STAV.RunCounter_Byte1;
	Convert_0.IN_Byte1:= CAM7.STAV.RunCounter_Byte0;
	
	CAM7.STAV.RunCounter:= Convert_0.OUT_UINT;
	Convert_0();
	
	
	
END_ACTION
