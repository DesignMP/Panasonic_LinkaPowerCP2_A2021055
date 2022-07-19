
ACTION ProfinetKomunikaciaKAM2: 
	//Control unit CAM1//

	//Vstupy pre kameru//
	CAM2.Profinet_PLC_OUTPUTS[0].3:= CAM2.CMD.Triger;
	
	//Výstupy z kamery//
	CAM2.STAV.READY:= CAM2.Profinet_PLC_INPUTS[0].0;
	CAM2.STAV.SWITCH:= CAM2.Profinet_PLC_INPUTS[0].1;
    CAM2.STAV.BUSY:= CAM2.Profinet_PLC_INPUTS[0].2;
    CAM2.STAV.Command_AKCEPTOVANY:= CAM2.Profinet_PLC_INPUTS[0].3;
    CAM2.STAV.Command_READY:= CAM2.Profinet_PLC_INPUTS[0].4;
    CAM2.STAV.Command_ERROR:= CAM2.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM2.RESULT.Paletka.Pritom_PowerCP_4F:= CAM2.Profinet_PLC_INPUTS[2].0;
	CAM2.RESULT.Paletka.Pritom_PowerCP_5F:= CAM2.Profinet_PLC_INPUTS[2].1;
	CAM2.RESULT.Paletka.Pritom_PowerCP_5H:= CAM2.Profinet_PLC_INPUTS[2].2;
	CAM2.RESULT.Paletka.Pritomn_Skeletonu_5H:= CAM2.Profinet_PLC_INPUTS[2].3;
	CAM2.RESULT.Paletka.Pritomn_Skeletonu_4F5F:= CAM2.Profinet_PLC_INPUTS[2].4;
	CAM2.RESULT.Paletka.Pritom_Busbarov_Spodne_5H:= CAM2.Profinet_PLC_INPUTS[2].5;
	CAM2.RESULT.Paletka.Pritom_Foamu_Lavy_4F5F:= CAM2.Profinet_PLC_INPUTS[2].6;
	CAM2.RESULT.Paletka.Pritom_Foamu_Pravy_4F5F:= CAM2.Profinet_PLC_INPUTS[2].7;
	CAM2.RESULT.Paletka.Pritom_Busbaru_Spodny_4F:= CAM2.Profinet_PLC_INPUTS[3].0;
	CAM2.RESULT.Paletka.Pritom_Busbaru_Spodny_5F:= CAM2.Profinet_PLC_INPUTS[3].1;
	CAM2.RESULT.Paletka.Pritom_DPS_4F5F:= CAM2.Profinet_PLC_INPUTS[3].2;
	
	
	
	//Stav výsledky READY//
	IF EDGE(CAM2.STAV.SWITCH)THEN
		CAM2.STAV.Results_READY:= TRUE;
		CAM2_PocetFotiek:= CAM2_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM2_PocetFotiek > 50) THEN
		FTP_CAM2.CMD.VymazFotku:= TRUE;
		FTP_CAM2.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM2.STATUS.KomunikaciaUkoncena OR FTP_CAM2.STATUS.KomunikaciaError) AND FTP_CAM2.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM2.CMD.VymazFotku:= FALSE;
		FTP_CAM2.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	
	//Run counter kamery//
	Convert_1.IN_Byte0:= CAM2.STAV.RunCounter_Byte1;
	Convert_1.IN_Byte1:= CAM2.STAV.RunCounter_Byte0;
	
	CAM2.STAV.RunCounter:= Convert_1.OUT_UINT;
	Convert_1();
	
END_ACTION
