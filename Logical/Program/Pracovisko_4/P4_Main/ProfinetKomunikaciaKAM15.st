
ACTION ProfinetKomunikaciaKAM15: 
	//Control Unit CAM 10//

	//Vstupy pre kameru//
	CAM15.Profinet_PLC_OUTPUTS[0].3:= CAM15.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM15.STAV.READY:= CAM15.Profinet_PLC_INPUTS[0].0;
	CAM15.STAV.SWITCH:= CAM15.Profinet_PLC_INPUTS[0].1;
    CAM15.STAV.BUSY:= CAM15.Profinet_PLC_INPUTS[0].2;
    CAM15.STAV.Command_AKCEPTOVANY:= CAM15.Profinet_PLC_INPUTS[0].3;
    CAM15.STAV.Command_READY:= CAM15.Profinet_PLC_INPUTS[0].4;
    CAM15.STAV.Command_ERROR:= CAM15.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	
	
	//Výsledky kamery//
	CAM15.RESULT.Pritomn_Etikety:= CAM15.Profinet_PLC_INPUTS[2].0;
	CAM15.RESULT.Pritomn_LogoBMV:= CAM15.Profinet_PLC_INPUTS[2].1;
	CAM15.RESULT.Pritomn_LogoPanasonic:= CAM15.Profinet_PLC_INPUTS[2].2;
	CAM15.RESULT.CitanieQRkodu_Etikety_OK:= CAM15.Profinet_PLC_INPUTS[2].3;
	
	
	
	
	
	
	
	//Stav výsledky READY//
	IF EDGE(CAM15.STAV.SWITCH)THEN
		CAM15.STAV.Results_READY:= TRUE;
		brsstrcpy(ADR(CAM15.RESULT.PrecitanyQRkod_Etikety),ADR(CAM15.Profinet_QRkod_Znaky));   
		CAM15_PocetFotiek:= CAM15_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM15_PocetFotiek > 50) THEN
		FTP_CAM15.CMD.VymazFotku:= TRUE;
		FTP_CAM15.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM15.STATUS.KomunikaciaUkoncena OR FTP_CAM15.STATUS.KomunikaciaError) AND FTP_CAM15.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM15.CMD.VymazFotku:= FALSE;
		FTP_CAM15.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	
	//Run counter kamery//
	Convert_1.IN_Byte0:= CAM15.STAV.RunCounter_Byte1;
	Convert_1.IN_Byte1:= CAM15.STAV.RunCounter_Byte0;
	
	CAM15.STAV.RunCounter:= Convert_1.OUT_UINT;
	Convert_1();
	
	
END_ACTION
