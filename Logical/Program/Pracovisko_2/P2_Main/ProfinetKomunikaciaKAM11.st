
ACTION ProfinetKomunikaciaKAM11: 
	
	//Control Unit CAM 8//

	//Vstupy pre kameru//
	CAM11.Profinet_PLC_OUTPUTS[0].3:= CAM11.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM11.STAV.READY:= CAM11.Profinet_PLC_INPUTS[0].0;
	CAM11.STAV.SWITCH:= CAM11.Profinet_PLC_INPUTS[0].1;
    CAM11.STAV.BUSY:= CAM11.Profinet_PLC_INPUTS[0].2;
    CAM11.STAV.Command_AKCEPTOVANY:= CAM11.Profinet_PLC_INPUTS[0].3;
    CAM11.STAV.Command_READY:= CAM11.Profinet_PLC_INPUTS[0].4;
    CAM11.STAV.Command_ERROR:= CAM11.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM11.RESULT.Paletka.Pritomn_PowerCP_4F:= CAM11.Profinet_PLC_INPUTS[2].0;
	CAM11.RESULT.Paletka.Pritomn_PowerCP_5F:= CAM11.Profinet_PLC_INPUTS[2].1;
	CAM11.RESULT.Paletka.Pritomn_PowerCP_5H:= CAM11.Profinet_PLC_INPUTS[2].2;
	CAM11.RESULT.PowerCP.Pritomn_LavyMVcase:= CAM11.Profinet_PLC_INPUTS[2].3;
	CAM11.RESULT.PowerCP.Pritomn_PravyMVcase:= CAM11.Profinet_PLC_INPUTS[2].4;
	CAM11.RESULT.PowerCP.LavyBusbar_Zvaranie_OK:= CAM11.Profinet_PLC_INPUTS[2].5;
	CAM11.RESULT.PowerCP.PravyBusbar_Zvaranie_OK:= CAM11.Profinet_PLC_INPUTS[2].6;
	CAM11.RESULT.PowerCP.Pritomn_TopCover_4F:= CAM11.Profinet_PLC_INPUTS[2].7;
	
	CAM11.RESULT.PowerCP.Pritomn_TopCover_5F:= CAM11.Profinet_PLC_INPUTS[3].0;
	CAM11.RESULT.PowerCP.Pritomn_TopCover_5H:= CAM11.Profinet_PLC_INPUTS[3].1;
	
	//Stav výsledky READY//
	IF EDGE(CAM11.STAV.SWITCH)THEN
		CAM11.STAV.Results_READY:= TRUE;
		CAM11_PocetFotiek:= CAM11_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM11_PocetFotiek > 50) THEN
		FTP_CAM11.CMD.VymazFotku:= TRUE;
		FTP_CAM11.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM11.STATUS.KomunikaciaUkoncena OR FTP_CAM11.STATUS.KomunikaciaError) AND FTP_CAM11.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM11.CMD.VymazFotku:= FALSE;
		FTP_CAM11.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	
	//Run counter kamery//
	Convert_4.IN_Byte0:= CAM11.STAV.RunCounter_Byte1;
	Convert_4.IN_Byte1:= CAM11.STAV.RunCounter_Byte0;
	
	CAM11.STAV.RunCounter:= Convert_4.OUT_UINT;
	Convert_4();
	
	
END_ACTION
