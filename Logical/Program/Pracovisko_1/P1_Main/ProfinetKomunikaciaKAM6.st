
ACTION ProfinetKomunikaciaKAM6: 
	//Control unit CAM3//

	//Vstupy pre kameru//
	CAM6.Profinet_PLC_OUTPUTS[0].3:= CAM6.CMD.Triger;
	
	//Výstupy z kamery//
	CAM6.STAV.READY:= CAM6.Profinet_PLC_INPUTS[0].0;
	CAM6.STAV.SWITCH:= CAM6.Profinet_PLC_INPUTS[0].1;
    CAM6.STAV.BUSY:= CAM6.Profinet_PLC_INPUTS[0].2;
    CAM6.STAV.Command_AKCEPTOVANY:= CAM6.Profinet_PLC_INPUTS[0].3;
    CAM6.STAV.Command_READY:= CAM6.Profinet_PLC_INPUTS[0].4;
    CAM6.STAV.Command_ERROR:= CAM6.Profinet_PLC_INPUTS[0].5;
	
	
	//Výsledky kamery//
	CAM6.RESULT.Paletka.Pritom_PowerCP_5H:= CAM6.Profinet_PLC_INPUTS[2].0;
	CAM6.RESULT.Paletka.Pritom_SpodnychBusbarov_5H:= CAM6.Profinet_PLC_INPUTS[2].1;
	CAM6.RESULT.Paletka.Pritom_PowerCP_4F:= CAM6.Profinet_PLC_INPUTS[2].2;
	CAM6.RESULT.Paletka.Pritom_PowerCP_5F:= CAM6.Profinet_PLC_INPUTS[2].3;
	CAM6.RESULT.Paletka.Pritom_LavyFoam_4F5F:= CAM6.Profinet_PLC_INPUTS[2].4;
	CAM6.RESULT.Paletka.Pritom_PravyFoam_4F5F:= CAM6.Profinet_PLC_INPUTS[2].5;
	CAM6.RESULT.Paletka.Pritom_DPS_45F:= CAM6.Profinet_PLC_INPUTS[2].6;
	CAM6.RESULT.Paletka.Pritom_SpodnyBusbar_4F:= CAM6.Profinet_PLC_INPUTS[2].7;
	
	CAM6.RESULT.Paletka.Pritom_SpodnyBusbar_5F:= CAM6.Profinet_PLC_INPUTS[3].0;
	CAM6.RESULT.PowerCP.Nepritom_LavyFoam_4F5F:= CAM6.Profinet_PLC_INPUTS[3].1;
	CAM6.RESULT.PowerCP.Nepritom_PravyFoam_4F5F:= CAM6.Profinet_PLC_INPUTS[3].2;
	CAM6.RESULT.PowerCP.Pritom_LavejSkrutkyK30:= CAM6.Profinet_PLC_INPUTS[3].3;
	CAM6.RESULT.PowerCP.Pritom_PravejSkrutkyK30:= CAM6.Profinet_PLC_INPUTS[3].4;
		
	
	
	//Stav výsledky READY//
	IF EDGE(CAM6.STAV.SWITCH)THEN
		CAM6.STAV.Results_READY:= TRUE;
		CAM6_PocetFotiek:= CAM6_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM6_PocetFotiek > 50) THEN
		FTP_CAM6.CMD.VymazFotku:= TRUE;
		FTP_CAM6.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM6.STATUS.KomunikaciaUkoncena OR FTP_CAM6.STATUS.KomunikaciaError) AND FTP_CAM6.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM6.CMD.VymazFotku:= FALSE;
		FTP_CAM6.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	//Run counter kamery//
	Convert_3.IN_Byte0:= CAM6.STAV.RunCounter_Byte1;
	Convert_3.IN_Byte1:= CAM6.STAV.RunCounter_Byte0;
	
	CAM6.STAV.RunCounter:= Convert_3.OUT_UINT;
	Convert_3();
	
	
END_ACTION
