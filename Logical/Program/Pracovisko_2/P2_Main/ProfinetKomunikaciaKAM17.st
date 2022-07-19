
ACTION ProfinetKomunikaciaKAM17: 
	//Control Unit CAM 6 //

	//Vstupy pre kameru//
	CAM17.Profinet_PLC_OUTPUTS[0].3:= CAM17.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM17.STAV.READY:= CAM17.Profinet_PLC_INPUTS[0].0;
	CAM17.STAV.SWITCH:= CAM17.Profinet_PLC_INPUTS[0].1;
    CAM17.STAV.BUSY:= CAM17.Profinet_PLC_INPUTS[0].2;
    CAM17.STAV.Command_AKCEPTOVANY:= CAM17.Profinet_PLC_INPUTS[0].3;
    CAM17.STAV.Command_READY:= CAM17.Profinet_PLC_INPUTS[0].4;
    CAM17.STAV.Command_ERROR:= CAM17.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM17.RESULT.Paletka.Pritomn_PowerCP_4F:= CAM17.Profinet_PLC_INPUTS[2].0;
	CAM17.RESULT.Paletka.Pritomn_PowerCP_5F:= CAM17.Profinet_PLC_INPUTS[2].1;
	CAM17.RESULT.Paletka.Pritomn_PowerCP_5H:= CAM17.Profinet_PLC_INPUTS[2].2;
	CAM17.RESULT.Paletka.PrazdnaPoziciaTopCoveru:= CAM17.Profinet_PLC_INPUTS[2].3;
	CAM17.RESULT.Paletka.Pritomn_TopCoveru_4F:= CAM17.Profinet_PLC_INPUTS[2].4;
	CAM17.RESULT.Paletka.Pritomn_TopCoveru_5F:= CAM17.Profinet_PLC_INPUTS[2].5;
	CAM17.RESULT.Paletka.Pritomn_TopCoveru_5H:= CAM17.Profinet_PLC_INPUTS[2].6;
	CAM17.RESULT.Paletka.Pritomn_Busbary_5H:= CAM17.Profinet_PLC_INPUTS[2].7;
	
	CAM17.RESULT.Paletka.Pritomn_Busbary_5F:= CAM17.Profinet_PLC_INPUTS[3].0;
	CAM17.RESULT.Paletka.Pritomn_Busbary_4F:= CAM17.Profinet_PLC_INPUTS[3].1;
	CAM17.RESULT.Paletka.Pritomn_LavyMVcase:= CAM17.Profinet_PLC_INPUTS[3].2;
	CAM17.RESULT.Paletka.Pritomn_PravyMVcase:= CAM17.Profinet_PLC_INPUTS[3].3;
	
	
	//Stav výsledky READY//
	IF EDGE(CAM17.STAV.SWITCH)THEN
		CAM17.STAV.Results_READY:= TRUE;
		CAM17_PocetFotiek:= CAM17_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM17_PocetFotiek > 50) THEN
		FTP_CAM17.CMD.VymazFotku:= TRUE;
		FTP_CAM17.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM17.STATUS.KomunikaciaUkoncena OR FTP_CAM17.STATUS.KomunikaciaError) AND FTP_CAM17.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM17.CMD.VymazFotku:= FALSE;
		FTP_CAM17.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	//Run counter kamery//
	Convert_6.IN_Byte0:= CAM17.STAV.RunCounter_Byte1;
	Convert_6.IN_Byte1:= CAM17.STAV.RunCounter_Byte0;
	
	CAM17.STAV.RunCounter:= Convert_6.OUT_UINT;
	Convert_6();
	
	
	
END_ACTION
