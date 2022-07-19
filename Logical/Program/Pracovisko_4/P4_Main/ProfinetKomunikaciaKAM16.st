
ACTION ProfinetKomunikaciaKAM16: 
	//Control Unit CAM 11//

	//Vstupy pre kameru//
	CAM16.Profinet_PLC_OUTPUTS[0].3:= CAM16.CMD.Triger;
	
	
	//Výstupy z kamery//
	CAM16.STAV.READY:= CAM16.Profinet_PLC_INPUTS[0].0;
	CAM16.STAV.SWITCH:= CAM16.Profinet_PLC_INPUTS[0].1;
    CAM16.STAV.BUSY:= CAM16.Profinet_PLC_INPUTS[0].2;
    CAM16.STAV.Command_AKCEPTOVANY:= CAM16.Profinet_PLC_INPUTS[0].3;
    CAM16.STAV.Command_READY:= CAM16.Profinet_PLC_INPUTS[0].4;
    CAM16.STAV.Command_ERROR:= CAM16.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM16.RESULT.Paletka.Pritomn_PowerCP:= CAM16.Profinet_PLC_INPUTS[2].0;
	CAM16.RESULT.Paletka.Pritomn_Busbarov_4F:= CAM16.Profinet_PLC_INPUTS[2].1;
	CAM16.RESULT.Paletka.Pritomn_Busbarov_5F:= CAM16.Profinet_PLC_INPUTS[2].2;
	CAM16.RESULT.Paletka.Pritomn_Busbarov_5H:= CAM16.Profinet_PLC_INPUTS[2].3;
	CAM16.RESULT.Paletka.Pritomn_LavyMVcase:= CAM16.Profinet_PLC_INPUTS[2].4;
    CAM16.RESULT.Paletka.Pritomn_PravyMVcase:= CAM16.Profinet_PLC_INPUTS[2].5;
   
	
	//Stav výsledky READY//
	IF EDGE(CAM16.STAV.SWITCH)THEN
		CAM16.STAV.Results_READY:= TRUE;
		CAM16_PocetFotiek:= CAM16_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM16_PocetFotiek > 50) THEN
		FTP_CAM16.CMD.VymazFotku:= TRUE;
		FTP_CAM16.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM16.STATUS.KomunikaciaUkoncena OR FTP_CAM16.STATUS.KomunikaciaError) AND FTP_CAM16.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM16.CMD.VymazFotku:= FALSE;
		FTP_CAM16.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	//Run counter kamery//
	Convert_2.IN_Byte0:= CAM16.STAV.RunCounter_Byte1;
	Convert_2.IN_Byte1:= CAM16.STAV.RunCounter_Byte0;
	
	CAM16.STAV.RunCounter:= Convert_2.OUT_UINT;
	Convert_2();
	
	
	
END_ACTION
