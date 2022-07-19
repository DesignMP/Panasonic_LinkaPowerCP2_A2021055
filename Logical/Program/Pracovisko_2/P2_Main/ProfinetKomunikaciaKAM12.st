
ACTION ProfinetKomunikaciaKAM12: 
	//Control Unit CAM 9//

	//Vstupy pre kameru//
	CAM12.Profinet_PLC_OUTPUTS[0].3:= CAM12.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM12.STAV.READY:= CAM12.Profinet_PLC_INPUTS[0].0;
	CAM12.STAV.SWITCH:= CAM12.Profinet_PLC_INPUTS[0].1;
    CAM12.STAV.BUSY:= CAM12.Profinet_PLC_INPUTS[0].2;
    CAM12.STAV.Command_AKCEPTOVANY:= CAM12.Profinet_PLC_INPUTS[0].3;
    CAM12.STAV.Command_READY:= CAM12.Profinet_PLC_INPUTS[0].4;
    CAM12.STAV.Command_ERROR:= CAM12.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM12.RESULT.Paletka.Pritomn_TopCover_4F:= CAM12.Profinet_PLC_INPUTS[2].0;
	CAM12.RESULT.Paletka.Pritomn_TopCover_5F:= CAM12.Profinet_PLC_INPUTS[2].1;
	CAM12.RESULT.Paletka.Pritomn_TopCover_5H:= CAM12.Profinet_PLC_INPUTS[2].2;
	CAM12.RESULT.Paletka.Pritomn_PravyMVcase:= CAM12.Profinet_PLC_INPUTS[2].3;
	CAM12.RESULT.Paletka.Pritomn_LavyMVcase:= CAM12.Profinet_PLC_INPUTS[2].4;
	
	
	//Stav výsledky READY//
	IF EDGE(CAM12.STAV.SWITCH)THEN
		CAM12.STAV.Results_READY:= TRUE;
		CAM12_PocetFotiek:= CAM12_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM12_PocetFotiek > 50) THEN
		FTP_CAM12.CMD.VymazFotku:= TRUE;
		FTP_CAM12.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM12.STATUS.KomunikaciaUkoncena OR FTP_CAM12.STATUS.KomunikaciaError) AND FTP_CAM12.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM12.CMD.VymazFotku:= FALSE;
		FTP_CAM12.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	//Run counter kamery//
	Convert_5.IN_Byte0:= CAM12.STAV.RunCounter_Byte1;
	Convert_5.IN_Byte1:= CAM12.STAV.RunCounter_Byte0;
	
	CAM12.STAV.RunCounter:= Convert_5.OUT_UINT;
	Convert_5();
	
	
	
END_ACTION
