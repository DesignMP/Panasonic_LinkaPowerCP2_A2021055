
ACTION ProfinetKomunikaciaKAM9: 

	CAM9.STAV.READY;
	
	//Vstupy pre kameru//
	CAM9.Profinet_PLC_OUTPUTS[0].0:= CAM9.CMD.Triger;
	
	//V�stupy z kamery//
	CAM9.STAV.SWITCH:= CAM9.Profinet_PLC_INPUTS[10].0;
	
	
	//V�sledky kamery//
	CAM9.RESULT.PowerCP.NepritomMatice:= CAM9.Profinet_PLC_INPUTS[0].0;
	CAM9.RESULT.PowerCP.PritomnBusbaru_5H:= CAM9.Profinet_PLC_INPUTS[0].1;

	//Stav v�sledky READY//
	IF EDGE(CAM9.STAV.SWITCH)THEN
		CAM9.STAV.Results_READY:= TRUE;
	END_IF
	
	
	
END_ACTION