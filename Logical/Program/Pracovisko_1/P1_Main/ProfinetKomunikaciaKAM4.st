
ACTION ProfinetKomunikaciaKAM4: 
	//Control unit CAM2//

	//Vstupy pre kameru//
	CAM4.Profinet_PLC_OUTPUTS[0].3:= CAM4.CMD.Triger;
	
	//Výstupy z kamery//
	CAM4.STAV.READY:= CAM4.Profinet_PLC_INPUTS[0].0;
	CAM4.STAV.SWITCH:= CAM4.Profinet_PLC_INPUTS[0].1;
    CAM4.STAV.BUSY:= CAM4.Profinet_PLC_INPUTS[0].2;
    CAM4.STAV.Command_AKCEPTOVANY:= CAM4.Profinet_PLC_INPUTS[0].3;
    CAM4.STAV.Command_READY:= CAM4.Profinet_PLC_INPUTS[0].4;
    CAM4.STAV.Command_ERROR:= CAM4.Profinet_PLC_INPUTS[0].5;
	
	//Výsledky kamery//
	CAM4.RESULT.Paletka.Pritomn_Pinu1_KrytDPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].0;  
	CAM4.RESULT.Paletka.Pritomn_Pinu2_KrytDPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].1;
	CAM4.RESULT.Paletka.Pritomn_Pinu3_KrytDPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].2;
	CAM4.RESULT.Paletka.Pritomn_Pinu4_KrytDPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].3;
	CAM4.RESULT.Paletka.Pritomn_Pinu5_KrytDPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].4;
	CAM4.RESULT.Paletka.Pritomn_Pinu6_KrytDPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].5;
	CAM4.RESULT.Paletka.Pritom_DPS_4F5F:= CAM4.Profinet_PLC_INPUTS[2].6;
	
	//Stav výsledky READY//
	IF EDGE(CAM4.STAV.SWITCH)THEN
		CAM4.STAV.Results_READY:= TRUE;
		CAM4_PocetFotiek:= CAM4_PocetFotiek + 1;
	END_IF
	
	//Vymazanie adresára kamery//
	IF EDGEPOS(CAM4_PocetFotiek > 50) THEN
		FTP_CAM4.CMD.VymazFotku:= TRUE;
		FTP_CAM4.STATUS.VymazanieAdresaraKamery_BUSY:= TRUE;
	END_IF
	
	IF (FTP_CAM4.STATUS.KomunikaciaUkoncena OR FTP_CAM4.STATUS.KomunikaciaError) AND FTP_CAM4.STATUS.VymazanieAdresaraKamery_BUSY THEN
		FTP_CAM4.CMD.VymazFotku:= FALSE;
		FTP_CAM4.STATUS.VymazanieAdresaraKamery_BUSY:= FALSE;
	END_IF	
	
	//Run counter kamery//
	Convert_2.IN_Byte0:= CAM4.STAV.RunCounter_Byte1;
	Convert_2.IN_Byte1:= CAM4.STAV.RunCounter_Byte0;
	
	CAM4.STAV.RunCounter:= Convert_2.OUT_UINT;
	Convert_2();
	
END_ACTION
