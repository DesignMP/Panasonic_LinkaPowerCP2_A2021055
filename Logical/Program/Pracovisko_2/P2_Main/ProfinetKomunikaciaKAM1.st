
ACTION ProfinetKomunikaciaKAM1: 
	//Control unit CAM4//

	
	//Vstupy pre kameru//
	CAM1.Profinet_PLC_OUTPUTS[0].3:= CAM1.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM1.STAV.READY:= CAM1.Profinet_PLC_INPUTS[0].0;
	CAM1.STAV.SWITCH:= CAM1.Profinet_PLC_INPUTS[0].1;
	CAM1.STAV.BUSY:= CAM1.Profinet_PLC_INPUTS[0].2;
	CAM1.STAV.Command_AKCEPTOVANY:= CAM1.Profinet_PLC_INPUTS[0].3;
	CAM1.STAV.Command_READY:= CAM1.Profinet_PLC_INPUTS[0].4;
	CAM1.STAV.Command_ERROR:= CAM1.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM1.RESULT.ZalozenieTesnenia_OK:= CAM1.Profinet_PLC_INPUTS[2].0;
	CAM1.RESULT.NepritomnostTesnenia:= CAM1.Profinet_PLC_INPUTS[2].1;
	
	
	///Stav výsledky READY//
	IF EDGE(CAM1.STAV.SWITCH)THEN
		CAM1.STAV.Results_READY:= TRUE;
		CAM1_PocetFotiek:= CAM1_PocetFotiek + 1;
	END_IF 

	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM1_PocetFotiek > 50) THEN
		FTP_CAM1.CMD.VymazFotku:= TRUE;
		FTP_CAM1.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM1.STATUS.KomunikaciaUkoncena OR FTP_CAM1.STATUS.KomunikaciaError) AND FTP_CAM1.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM1.CMD.VymazFotku:= FALSE;
		FTP_CAM1.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	
	//Run counter kamery//
	Convert_7.IN_Byte0:= CAM1.STAV.RunCounter_Byte1;
	Convert_7.IN_Byte1:= CAM1.STAV.RunCounter_Byte0;
	
	CAM1.STAV.RunCounter:= Convert_7.OUT_UINT;
	Convert_7();
	
	
END_ACTION
