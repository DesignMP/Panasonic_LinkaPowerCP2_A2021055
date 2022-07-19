
ACTION ProfinetKomunikaciaKAM10: 
	//Control Unit CAM 7// 

	//Vstupy pre kameru//
	CAM10.Profinet_PLC_OUTPUTS[0].3:= CAM10.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM10.STAV.READY:= CAM10.Profinet_PLC_INPUTS[0].0;
	CAM10.STAV.SWITCH:= CAM10.Profinet_PLC_INPUTS[0].1;
    CAM10.STAV.BUSY:= CAM10.Profinet_PLC_INPUTS[0].2;
    CAM10.STAV.Command_AKCEPTOVANY:= CAM10.Profinet_PLC_INPUTS[0].3;
    CAM10.STAV.Command_READY:= CAM10.Profinet_PLC_INPUTS[0].4;
    CAM10.STAV.Command_ERROR:= CAM10.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM10.RESULT.Paletka.Pritomn_Busbarov_45F:= CAM10.Profinet_PLC_INPUTS[2].0;
	CAM10.RESULT.Paletka.Pritomn_Busbarov_5H:= CAM10.Profinet_PLC_INPUTS[2].1;
	CAM10.RESULT.Paletka.Pritomn_PowerCP_4F:= CAM10.Profinet_PLC_INPUTS[2].2;
	CAM10.RESULT.Paletka.Pritomn_PowerCP_5F:= CAM10.Profinet_PLC_INPUTS[2].3;
	CAM10.RESULT.Paletka.Pritomn_PowerCP_5H:= CAM10.Profinet_PLC_INPUTS[2].4;
	
	
	//Stav výsledky READY//
	IF EDGE(CAM10.STAV.SWITCH)THEN
		CAM10.STAV.Results_READY:= TRUE;
		CAM10_PocetFotiek:= CAM10_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM10_PocetFotiek > 50) THEN
		FTP_CAM10.CMD.VymazFotku:= TRUE;
		FTP_CAM10.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM10.STATUS.KomunikaciaUkoncena OR FTP_CAM10.STATUS.KomunikaciaError) AND FTP_CAM10.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM10.CMD.VymazFotku:= FALSE;
		FTP_CAM10.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	
	//Run counter kamery//
	Convert_3.IN_Byte0:= CAM10.STAV.RunCounter_Byte1;
	Convert_3.IN_Byte1:= CAM10.STAV.RunCounter_Byte0;
	
	CAM10.STAV.RunCounter:= Convert_3.OUT_UINT;
	Convert_3();
	
	
	
END_ACTION
