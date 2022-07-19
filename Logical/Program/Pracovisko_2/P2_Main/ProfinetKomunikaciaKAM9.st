
ACTION ProfinetKomunikaciaKAM9: 
	//Smart kamera//

	CAM9.STAV.READY:= P2_Pracovisko.IN.SmartKamera9_KomOK;
	
	//Vstupy pre kameru//
	CAM9.Profinet_PLC_OUTPUTS[0].0:= CAM9.CMD.Triger;
	
	//Výstupy z kamery//
	CAM9.STAV.SWITCH:= CAM9.Profinet_PLC_INPUTS[12].0;
	
	
	//Výsledky kamery//
	CAM9.RESULT.PowerCP.PritomMatice:= CAM9.Profinet_PLC_INPUTS[0].0;
	CAM9.RESULT.PowerCP.PritomnBusbaru_5H:= CAM9.Profinet_PLC_INPUTS[0].1;

	//Stav výsledky READY//
	IF EDGE(CAM9.STAV.SWITCH)THEN
		CAM9.STAV.Results_READY:= TRUE;
		CAM9_PocetFotiek:= CAM9_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM9_PocetFotiek > 50) THEN
		FTP_CAM9.CMD.VymazFotku:= TRUE;
		FTP_CAM9.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM9.STATUS.KomunikaciaUkoncena OR FTP_CAM9.STATUS.KomunikaciaError) AND FTP_CAM9.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM9.CMD.VymazFotku:= FALSE;
		FTP_CAM9.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	
	//Run counter kamery//
	Convert_2.IN_Byte0:= CAM9.STAV.RunCounter_Byte1;
	Convert_2.IN_Byte1:= CAM9.STAV.RunCounter_Byte0;
	
	CAM9.STAV.RunCounter:= Convert_2.OUT_UINT;
	Convert_2();
	
	
	
	
END_ACTION
